import ClockKit
import WatchConnectivity

struct SummarizedAppState {
    let kicksCount: Int
}

class ComplicationController: NSObject, CLKComplicationDataSource, WCSessionDelegate {
    private var appState: SummarizedAppState?

    override init() {
        super.init()
        WCSession.default.delegate = self
        WCSession.default.activate()
    }

    // MARK: - WCSessionDelegate

    func session(_ session: WCSession, didFinish userInfoTransfer: WCSessionUserInfoTransfer, error: Error?) {
        guard let count = userInfoTransfer.userInfo["kicksCount"] as? Int else {
            return
        }
        appState = SummarizedAppState(kicksCount: count)
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        debugPrint("Session activated: \(activationState), error: \(String(describing: error))")
    }
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward, .backward])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        let text: String
        if let count = appState?.kicksCount {
            text = "\(count)"
        } else {
            text = "--"
        }
        guard let template: CLKComplicationTemplate = {
            switch(complication.family) {
            case .modularSmall:
                let template = CLKComplicationTemplateModularSmallSimpleText()
                template.textProvider = CLKSimpleTextProvider(text: text)
                return template
            case .modularLarge:
                let template = CLKComplicationTemplateModularLargeStandardBody()
                template.headerTextProvider = CLKSimpleTextProvider(text: text)
                return template
            case .circularSmall:
                let template = CLKComplicationTemplateCircularSmallSimpleText()
                template.textProvider = CLKSimpleTextProvider(text: text)
                return template
            case .utilitarianSmall:
                let template = CLKComplicationTemplateUtilitarianSmallFlat()
                template.textProvider = CLKSimpleTextProvider(text: text)
                return template
            case .utilitarianSmallFlat:
                let template = CLKComplicationTemplateUtilitarianSmallFlat()
                template.textProvider = CLKSimpleTextProvider(text: text)
                return template
            case .utilitarianLarge:
                let template = CLKComplicationTemplateUtilitarianLargeFlat()
                template.textProvider = CLKSimpleTextProvider(text: text)
                return template
            case .extraLarge:
                let template = CLKComplicationTemplateExtraLargeSimpleText()
                template.textProvider = CLKSimpleTextProvider(text: text)
                return template
            case .graphicBezel:
                let template = CLKComplicationTemplateGraphicBezelCircularText()
                template.textProvider = CLKSimpleTextProvider(text: text)
                return template
            case .graphicCorner:
                let template = CLKComplicationTemplateGraphicCornerStackText()
                template.innerTextProvider = CLKSimpleTextProvider(text: text)
                template.outerTextProvider = CLKSimpleTextProvider(text: "")
                return template
            case .graphicCircular:
                let template = CLKComplicationTemplateGraphicCircularClosedGaugeText()
                template.centerTextProvider = CLKSimpleTextProvider(text: text)
                template.gaugeProvider = CLKSimpleGaugeProvider(style: .ring, gaugeColor: .white, fillFraction: 1)
                return template
            case .graphicRectangular:
                let template = CLKComplicationTemplateGraphicRectangularStandardBody()
                template.headerTextProvider = CLKTextProvider(format: text)
                return template
            default:
                return nil
            }
            }() else {
                return handler(nil)
        }
        handler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template))
    }

    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        handler(nil)
    }
    
}
