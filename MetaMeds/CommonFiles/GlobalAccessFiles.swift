//
//  GlobalAccessFiles.swift
//  BikeTaxi
//
//  Created by Kumar on 03/06/19.
//  Copyright © 2019 Kumar. All rights reserved.
//

import Foundation
import UIKit

struct ApplyShadowView
{
    static func setCardView(view : UIView,cornerRadius:CGFloat,setColor:UIColor,shadowRadius:CGFloat,Shadowopacity:Float)
    {
        view.layer.cornerRadius = cornerRadius
        view.layer.borderColor  =  setColor.cgColor
        view.layer.borderWidth = 1.0
        view.layer.shadowOpacity = Shadowopacity
        view.layer.shadowColor =  UIColor.lightGray.cgColor
        view.layer.shadowRadius = shadowRadius
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.masksToBounds = false
    }
}

extension Double {
  func string(maximumFractionDigits: Int = 2) -> String {
    let s = String(format: "%.\(maximumFractionDigits)f", self)
    var offset = -maximumFractionDigits - 1
    for i in stride(from: 0, to: -maximumFractionDigits, by: -1) {
      if s[s.index(s.endIndex, offsetBy: i - 1)] != "0" {
        offset = i
        break
      }
    }
    return String(s[..<s.index(s.endIndex, offsetBy: offset)])
  }
}

extension Int {
    func format(f: String) -> String {
        return String(format: "%\(f)d", self)
    }
}

extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}

func Toast(message:String, view : UIView)
{
    var style = ToastStyle()
    style.messageColor = .white
    style.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    view.makeToast(message, duration: 3.0, position: .bottom, style: style)
    ToastManager.shared.isTapToDismissEnabled = true
    ToastManager.shared.isQueueEnabled = false
}
extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension UIView {
    func applyGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.init(named: "StartColor")!.cgColor,UIColor.init(named: "EndColor")!.cgColor]
        // your colors go here
        gradient.locations = [0.0, 1.0]
        gradient.frame = self.bounds
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        self.layer.insertSublayer(gradient, at: 0)
    }
    func removeGradient()
    {
        let gradient = CAGradientLayer()
        gradient.removeFromSuperlayer()
    }
}

struct AppTheme
{
    func AppColor () -> UIColor
    {
        return #colorLiteral(red: 0.5013008118, green: 0.6540361047, blue: 0.3353273869, alpha: 1)
    }
    
    func YellowColor () -> UIColor
    {
        return #colorLiteral(red: 0.9606381059, green: 0.7363989949, blue: 0.3107376993, alpha: 1)
    }
}

func CallNumber(phoneNumber:String) {
    
    if let phoneCallURL = URL(string: "telprompt://\(phoneNumber)") {
        
        let application:UIApplication = UIApplication.shared
        if (application.canOpenURL(phoneCallURL)) {
            if #available(iOS 10.0, *) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
                application.openURL(phoneCallURL as URL)
                
            }
        }
    }
}

extension UINavigationController {
  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
      popToViewController(vc, animated: animated)
    }
  }
}

extension Data
{
    var formatMimeType: String
    {
        let array = [UInt8](self)
        let ext: String
        switch (array[0]) {
        case 0xFF:
            ext = "jpg"
        case 0x89:
            ext = "png"
        case 0x47:
            ext = "gif"
        case 0x25, 0x50, 0x44, 0x46:
            ext = "pdf"
        case 0x49, 0x4D :
            ext = "tiff"
        default:
            ext = "mp4"
        }
        return ext
    }
}

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

extension String
{
    func trimString() -> String
    {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

extension String {
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
}
extension String
{
  func safelyLimitedTo(length n: Int)->String {
    if (self.count <= n) {
      return self
    }
    return String( Array(self).prefix(upTo: n) )
  }
}
private var __maxLengths = [UITextField: Int]()
extension UITextField {
  @IBInspectable var maxLength: Int {
    get {
      guard let l = __maxLengths[self] else {
        return 150 // (global default-limit. or just, Int.max)
      }
      return l
    }
    set {
      __maxLengths[self] = newValue
      addTarget(self, action: #selector(fix), for: .editingChanged)
    }
  }
  @objc func fix(textField: UITextField) {
    let t = textField.text
    textField.text = t?.safelyLimitedTo(length: maxLength)
  }
}


extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
extension NSMutableAttributedString {
    func setFontFace(font: UIFont, color: UIColor? = nil) {
        beginEditing()
        self.enumerateAttribute(
            .font,
            in: NSRange(location: 0, length: self.length)
        ) { (value, range, stop) in

            if let f = value as? UIFont,
              let newFontDescriptor = f.fontDescriptor
                .withFamily(font.familyName)
                .withSymbolicTraits(f.fontDescriptor.symbolicTraits) {

                let newFont = UIFont(
                    descriptor: newFontDescriptor,
                    size: font.pointSize
                )
                removeAttribute(.font, range: range)
                addAttribute(.font, value: newFont, range: range)
                if let color = color {
                    removeAttribute(
                        .foregroundColor,
                        range: range
                    )
                    addAttribute(
                        .foregroundColor,
                        value: color,
                        range: range
                    )
                }
            }
        }
        endEditing()
    }
}

class PaddingLabel: UILabel
{
    @IBInspectable var topInset: CGFloat = 10
    @IBInspectable var bottomInset: CGFloat = 10
    @IBInspectable var leftInset: CGFloat = 10
    @IBInspectable var rightInset: CGFloat = 10
    
    override public func drawText(in rect: CGRect)
    {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override public var intrinsicContentSize: CGSize
    {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}

extension UIView
{
    func activityStartAnimating(activityColor: UIColor, backgroundColor: UIColor)
    {
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        backgroundView.backgroundColor = backgroundColor
        backgroundView.tag = 475647
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: self.bounds.width/2, y: self.bounds.height/2, width: 100, height: 100))
        activityIndicator.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        activityIndicator.center = self.center
        activityIndicator.hidesWhenStopped = true
        if #available(iOS 13.0, *) {
            activityIndicator.style = UIActivityIndicatorView.Style.large
        } else {
            // Fallback on earlier versions
        }
        activityIndicator.color = activityColor
        activityIndicator.startAnimating()
        self.isUserInteractionEnabled = false
        backgroundView.addSubview(activityIndicator)
        self.addSubview(backgroundView)
    }
    func activityStopAnimating()
    {
        if let background = viewWithTag(475647)
        {
            background.removeFromSuperview()
        }
        self.isUserInteractionEnabled = true
    }
}

extension String
{
    var digits: String
    {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
}

extension UIApplication
{
    static func topViewController(base: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(base: selected)
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        return base
    }
}

extension UIImage
{
    func maskWithColor(color: UIColor) -> UIImage?
    {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
}

extension UILabel {
    func highlight(text: String?, font: UIFont? = nil, color: UIColor? = nil) {
        guard let fullText = self.text, let target = text else {
            return
        }

        let attribText = NSMutableAttributedString(string: fullText)
        let range: NSRange = attribText.mutableString.range(of: target, options: .caseInsensitive)
        
        var attributes: [NSAttributedString.Key: Any] = [:]
        if let font = font {
            attributes[.font] = font
        }
        if let color = color {
            attributes[.backgroundColor] = color
        }
        attribText.addAttributes(attributes, range: range)
        self.attributedText = attribText
    }
}

public protocol ChangableFont: AnyObject {
    var rangedAttributes: [RangedAttributes] { get }
    func getText() -> String?
    func set(text: String?)
    func getAttributedText() -> NSAttributedString?
    func set(attributedText: NSAttributedString?)
    func getFont() -> UIFont?
    func changeFont(ofText text: String, with font: UIFont)
    func changeFont(inRange range: NSRange, with font: UIFont)
    func changeTextColor(ofText text: String, with color: UIColor)
    func changeTextColor(inRange range: NSRange, with color: UIColor)
    func resetFontChanges()
}

public struct RangedAttributes {

    public let attributes: [NSAttributedString.Key: Any]
    public let range: NSRange

    public init(_ attributes: [NSAttributedString.Key: Any], inRange range: NSRange) {
        self.attributes = attributes
        self.range = range
    }
}

extension UILabel: ChangableFont {

    public func getText() -> String? {
        return text
    }

    public func set(text: String?) {
        self.text = text
    }

    public func getAttributedText() -> NSAttributedString? {
        return attributedText
    }

    public func set(attributedText: NSAttributedString?) {
        self.attributedText = attributedText
    }

    public func getFont() -> UIFont? {
        return font
    }
}

extension UITextField: ChangableFont {

    public func getText() -> String? {
        return text
    }

    public func set(text: String?) {
        self.text = text
    }

    public func getAttributedText() -> NSAttributedString? {
        return attributedText
    }

    public func set(attributedText: NSAttributedString?) {
        self.attributedText = attributedText
    }

    public func getFont() -> UIFont? {
        return font
    }
}

extension UITextView: ChangableFont {

    public func getText() -> String? {
        return text
    }

    public func set(text: String?) {
        self.text = text
    }

    public func getAttributedText() -> NSAttributedString? {
        return attributedText
    }

    public func set(attributedText: NSAttributedString?) {
        self.attributedText = attributedText
    }

    public func getFont() -> UIFont? {
        return font
    }
}

public extension ChangableFont {

    var rangedAttributes: [RangedAttributes] {
        guard let attributedText = getAttributedText() else {
            return []
        }
        var rangedAttributes: [RangedAttributes] = []
        let fullRange = NSRange(
            location: 0,
            length: attributedText.string.count
        )
        attributedText.enumerateAttributes(
            in: fullRange,
            options: []
        ) { (attributes, range, stop) in
            guard range != fullRange, !attributes.isEmpty else { return }
            rangedAttributes.append(RangedAttributes(attributes, inRange: range))
        }
        return rangedAttributes
    }

    func changeFont(ofText text: String, with font: UIFont) {
        guard let range = (self.getAttributedText()?.string ?? self.getText())?.range(ofText: text) else { return }
        changeFont(inRange: range, with: font)
    }

    func changeFont(inRange range: NSRange, with font: UIFont) {
        add(attributes: [.font: font], inRange: range)
    }

    func changeTextColor(ofText text: String, with color: UIColor) {
        guard let range = (self.getAttributedText()?.string ?? self.getText())?.range(ofText: text) else { return }
        changeTextColor(inRange: range, with: color)
    }

    func changeTextColor(inRange range: NSRange, with color: UIColor) {
        add(attributes: [.foregroundColor: color], inRange: range)
    }

    private func add(attributes: [NSAttributedString.Key: Any], inRange range: NSRange) {
        guard !attributes.isEmpty else { return }

        var rangedAttributes: [RangedAttributes] = self.rangedAttributes

        var attributedString: NSMutableAttributedString

        if let attributedText = getAttributedText() {
            attributedString = NSMutableAttributedString(attributedString: attributedText)
        } else if let text = getText() {
            attributedString = NSMutableAttributedString(string: text)
        } else {
            return
        }

        rangedAttributes.append(RangedAttributes(attributes, inRange: range))

        rangedAttributes.forEach { (rangedAttributes) in
            attributedString.addAttributes(
                rangedAttributes.attributes,
                range: rangedAttributes.range
            )
        }

        set(attributedText: attributedString)
    }

    func resetFontChanges() {
        guard let text = getText() else { return }
        set(attributedText: NSMutableAttributedString(string: text))
    }
}

public extension String {

    func range(ofText text: String) -> NSRange {
        let fullText = self
        let range = (fullText as NSString).range(of: text)
        return range
    }
}
extension UIImageView {

   func setRounded() {
      let radius = CGRectGetWidth(self.frame) / 2
      self.layer.cornerRadius = radius
      self.layer.masksToBounds = true
   }
}
