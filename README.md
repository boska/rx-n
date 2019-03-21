![](http://wallpapers-best.com/uploads/posts/2015-10/15_star_wars.jpg)

## rx-n

Boska is a padawan of Rx. 

rx-n is a series of RxSwift projects generated during the job interviews
 
RxSwift is one of the ways that try to solve async problem differs from UIKit or PromiseKit, rx-n series shows how dangerous to use a powerful tool before master it.
Again, thanks to job interviews and it just a code challenge, no one hurts don't worry.


if you looking for quality example for RxSwift
[RxSwiftExamples](https://github.com/DroidsOnRoids/RxSwiftExamples)
is another great repo

![](https://i.imgur.com/nhBP5jJ.png)

## rx-00

The source code of rx-00 is not worth your time to move on but rx-00 get roasted on r/iOSProgramming

so at least it gains a piece of advice from masters, gg wp rx-00

[informative comment](https://www.reddit.com/r/iOSProgramming/comments/apqwji/i_got_rejected_from_an_interview_seek_for/egbllpr)

`Exposing Subjects - this for me is a massive red flag that someone doesn't know about how Rx works, or cares to match the Rx style.`

😱

so it's time to improve 😀

💪

## rx-01

rx-01 contains two UITableView with two depenent paged api call represent a two-layer menu of car manufactures and models of them

although, it has some progress on some aspect, but it still has rooms to improve

#### Cons
- There's still a confusing code between viewmodels
- Naming still too verbose
- Dependencies
- MVC way on navigation
- No test on Observables and Subjects

#### Pros
- Properly handle UIScrollView contentOffset into load more signal and handle in viewmodel
- Learn why **Driver** is a important traits in UI Binding


```ManufacturerListViewModel.swift
import RxSwift
import RxCocoa

extension Reactive where Base == ManufacturerListViewModel {
  var items: Driver<[Manufacturer]> {
    return base.manufacturers.asDriver(onErrorJustReturn: [])
  }
  var title: Observable<String> {
    return Observable.just("Manufacturers")
  }
}

struct ManufacturerListViewModel: ReactiveCompatible {
  let loadNextPage: AnyObserver<()>
  fileprivate let manufacturers: Observable<[Manufacturer]>

  init(autoService: AutoService = AutoService.shared) {
    let _loadNextPage = PublishSubject<Void>()
    self.loadNextPage = _loadNextPage.asObserver()
    manufacturers = _loadNextPage.throttle(0.5, scheduler: MainScheduler.instance)
      //map void event into index
      .enumerated()
      //flap map into api service
      .flatMap {
        autoService.getManufacturers(on: $0.index)  
      }.catchError { error in
        //handle error here sent to some subject? I really not sure yet
        return Observable.empty()
      //sorting
      }.map {
        $0.sorted(by: { $0.name <= $1.name })
      }
      //scan concat result
      .scan([], accumulator: { $0 + $1 })

  }
}
```

##rx-02

A Rx style weather app with OpenWeather API

TBD