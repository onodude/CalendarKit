import CalendarKit

final class ExampleNotificationController: UIViewController {
  lazy var timelineContainer: TimelineContainer = {
    let timeline = TimelineView()
    timeline.frame.size.height = timeline.fullHeight
    let container = TimelineContainer(timeline)
    container.contentSize = timeline.frame.size
    container.addSubview(timeline)
    container.isUserInteractionEnabled = false
    return container
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .lightGray
    view.addSubview(timelineContainer)
    timelineContainer.timeline.date = Date()
    
    let start = Date()
    let end = Calendar.current.date(byAdding: .hour, value: 1, to: start)!
    let event = Event()
    
    event.startDate = start
    event.endDate = end

    let info = ["Compliance report"]
    event.text = info.reduce("", {$0 + $1 + "\n"})
    event.color = .red
    timelineContainer.timeline.layoutAttributes = [EventLayoutAttributes(event)]
    timelineContainer.scrollTo(hour24: 20)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    let size = CGSize(width: view.bounds.width, height: 140)
    let origin = CGPoint(x: 0, y: view.bounds.height/2)
    timelineContainer.frame = CGRect(origin: origin, size: size)
    timelineContainer.scrollTo(hour24: Float(max(Date().hour - 1, 0)))
    
    timelineContainer.layer.cornerRadius = 25
  }
}
