//
//  A4YTextField.swift
//  AllianzPrime
//
//  Created by Arnon Keereena on 2/24/17.
//  Copyright © 2017 AMOS Thailand. All rights reserved.
//

import UIKit

open class UnderlineTextField: UITextField {
  
  @IBInspectable var isPlaceholderEnable: Bool = true
  @IBInspectable var underlineWidth: CGFloat = 1
  @IBInspectable var underlineInactiveColor: UIColor = .lightGray
  @IBInspectable var underlineActiveColor: UIColor = .orange
  @IBInspectable var underlineHasValueColor: UIColor = .green
  @IBInspectable var underlineErrorColor: UIColor = .red
  @IBInspectable var placeholderActiveColor: UIColor = .white
  @IBInspectable var placeholderInactiveColor: UIColor = UIColor.black.withAlphaComponent(0.1)
  @IBInspectable var textFocusColor: UIColor = .white
  @IBInspectable var textBlurColor: UIColor = .white
  @IBInspectable var errorColor: UIColor = .red
  @IBInspectable var showToggleShowPasswordIcon: Bool = false
  
  @IBOutlet weak var topToThisBottomConstraint: NSLayoutConstraint?
  var hideErrorConstraints: [NSLayoutConstraint] = []
  var showErrorConstraints: [NSLayoutConstraint] = []
  
  var placeholderLabel: UILabel?
  var errorLabel: UILabel?
  var underlineView: UIView?
  var clearErrorOnType = true
  var errorText: String? {
    didSet {
      if (errorText != nil && errorText != "") {
        showErrorLabel()
      } else {
        hideErrorLabel()
      }
    }
  }
  
  open override var isEnabled: Bool {
    didSet {
      if !isEnabled {
        self.appearDisabled()
      }
    }
  }
  
  open override var accessibilityIdentifier: String? {
    didSet {
      setPlaceholderAccessibilityIdentifier()
      setErrorAccessibilityIdentifier()
    }
  }
  
  open var isLockableIfPreFilled: Bool = false
  
  var oldText: String?
  open override var text: String? {
    didSet {
      oldText = text
      movePlaceholderLabel()
      appearDeactivated()
    }
  }
  
  open override var placeholder: String? {
    didSet {
        self.placeholderLabel?.text = self.placeholder
    }
  }
  
  private func setPlaceholderAccessibilityIdentifier() {
    isAccessibilityElement = false
    placeholderLabel?.isAccessibilityElement = true
    placeholderLabel?.accessibilityIdentifier = "\(accessibilityIdentifier ?? "")_placeholder"
  }
  
  private func setErrorAccessibilityIdentifier() {
    isAccessibilityElement = false
    errorLabel?.isAccessibilityElement = true
    errorLabel?.accessibilityIdentifier = "\(accessibilityIdentifier ?? "")_error"
  }
  
  open override func awakeFromNib() {
    clipsToBounds = false
    setupPlaceholderLabel()
    setupUnderlineView()
    setupErrorLabel()
    showToggleShowPassword(isSecureTextEntry)
    bringSubviewToFront(toggleShowPasswordImageView)
  }
  
  open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    let labelFrame = CGRect(x: self.bounds.origin.x,
                            y: self.bounds.origin.y - self.bounds.size.height,
                            width: self.bounds.size.width,
                            height: self.bounds.size.height)
    let errorFrame = CGRect(x: self.bounds.origin.x,
                            y: self.bounds.origin.y + self.bounds.size.height,
                            width: self.bounds.size.width,
                            height: self.bounds.size.height)
    if toggleShowPasswordImageView.frame.contains(point) {
      return showToggleShowPasswordIcon ? toggleShowPasswordImageView : self
    } else if bounds.contains(point) {
      return self
    } else if labelFrame.contains(point) {
      return placeholderLabel
    } else if errorFrame.contains(point) {
      return errorLabel
    } else {
      return nil
    }
  }
  
  func setupPlaceholderLabel() {
    placeholderLabel = UILabel(frame: bounds)
    setPlaceholderAccessibilityIdentifier()
    // Set anchor to left, top to prevent weird scaling animation
    placeholderLabel?.layer.anchorPoint = CGPoint(x: 0, y: 1)
    
    // Adjust frame again after setting anchor
    var frame = placeholderLabel!.frame
    frame.origin.x = 0
    frame.origin.y = 0
    placeholderLabel?.frame = frame
    
    placeholderLabel?.font = font
    placeholderLabel?.textColor = placeholderInactiveColor
    placeholderLabel?.text = placeholder
    addSubview(placeholderLabel!)
    
    placeholderLabel?.isHidden = !isPlaceholderEnable
  }
  
  func setupUnderlineView() {
    underlineView = UIView()
    underlineView?.translatesAutoresizingMaskIntoConstraints = false
    var frame = bounds
    frame.size.height = underlineWidth
    frame.origin.y = bounds.size.height
    underlineView?.frame = frame
    underlineView?.backgroundColor = underlineInactiveColor
    underlineView?.autoresizingMask = .flexibleWidth
    underlineView?.translatesAutoresizingMaskIntoConstraints = true
    
    addSubview(underlineView!)
    
    setupUnderLineViewConstraint()
  }
  
  private func setupUnderLineViewConstraint() {
    addConstraint(NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: underlineView!, attribute: .leading, multiplier: 1, constant: 0))
    addConstraint(NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: underlineView!, attribute: .trailing, multiplier: 1, constant: 0))
    addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: underlineView!, attribute: .top, multiplier: 1, constant: 0))
    addConstraint(NSLayoutConstraint(item: underlineView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 1))
  }
  
  func setupErrorLabel() {
    errorLabel = UILabel(frame: bounds)
    setErrorAccessibilityIdentifier()
    errorLabel?.translatesAutoresizingMaskIntoConstraints = false
    
    errorLabel?.font = UIFont(name: font!.fontName, size: font!.pointSize / 1.25)
    errorLabel?.alpha = 0
    errorLabel?.textColor = errorColor
    errorLabel?.text = nil
    errorLabel?.numberOfLines = 0
    errorLabel?.lineBreakMode = .byWordWrapping
    addSubview(errorLabel!)
    
    setupErrorLabelConstraints()
    setupErrorLabelClearing()
  }
  
  private func setupErrorLabelConstraints() {
    let high = UILayoutPriority(rawValue: 850)
    errorLabel?.setContentCompressionResistancePriority(high, for: .vertical)
    errorLabel?.setContentCompressionResistancePriority(high, for: .horizontal)
    
    let low = UILayoutPriority(rawValue: 200)
    errorLabel?.setContentHuggingPriority(low, for: .vertical)
    errorLabel?.setContentHuggingPriority(low, for: .horizontal)
    
    func cc(_ i: Any,
            _ a: NSLayoutConstraint.Attribute,
            _ r: NSLayoutConstraint.Relation,
            _ t: Any,
            _ ii: NSLayoutConstraint.Attribute,
            _ m: CGFloat,
            _ c: CGFloat) -> NSLayoutConstraint {
      return NSLayoutConstraint(item: i, attribute: a, relatedBy: r, toItem: t, attribute: ii, multiplier: m, constant: c)
    }
    
    addConstraint(cc(self, .leading, .equal, errorLabel!, .leading, 1, 0))
    addConstraint(cc(self, .trailing, .equal, errorLabel!, .trailing, 1, 0))
    let errorToUnderline = cc(errorLabel!, .top, .equal, underlineView!, .bottom, 1, 8)
    errorToUnderline.priority = UILayoutPriority(rawValue: 750)
    addConstraint(errorToUnderline)
    let bottomConstraint = cc(errorLabel!, .bottom, .equal, self, .bottom, 1, 8)
    bottomConstraint.priority = UILayoutPriority(rawValue: 749)
    addConstraint(bottomConstraint)

//    let superview = self.superview?.superview ?? self.superview
    let superview = self.superview
    superview?.constraints.forEach { c in
      // Swap self bottom constraints to error bottom constraints
      let bottomConstraint: NSLayoutConstraint
      if c.firstItem as? UnderlineTextField == self && c.firstAttribute == .bottom && c.relation == .equal {
        bottomConstraint = cc(errorLabel!, .bottom, c.relation, c.secondItem as Any, c.secondAttribute, c.multiplier, c.constant)
      } else if c.secondItem as? UnderlineTextField == self && c.secondAttribute == .bottom && c.relation == .equal {
        bottomConstraint = cc(c.firstItem as Any, c.firstAttribute, c.relation, errorLabel!, .bottom, c.multiplier, c.constant)
      } else {
        return
      }
      
      bottomConstraint.priority = c.priority
      bottomConstraint.isActive = false
      superview?.addConstraint(bottomConstraint)
      showErrorConstraints.append(bottomConstraint)
      hideErrorConstraints.append(c)
    }
  }
  
  private func setupErrorLabelClearing() {
    addTarget(self, action: #selector(clearErrorIfNeeded), for: .editingChanged)
  }
  
  @objc private func clearErrorIfNeeded() {
    errorText.flatMap { _ in
      guard self.clearErrorOnType else { return }
      self.errorText = nil
    }
  }
  
  @discardableResult
  open override func becomeFirstResponder() -> Bool {
    let shouldBecome = super.becomeFirstResponder()
    appearActivated()
    movePlaceholderLabel()
    bringSubviewToFront(toggleShowPasswordImageView)
    return shouldBecome
  }
  
  @discardableResult
  open override func resignFirstResponder() -> Bool {
    let shouldResign = super.resignFirstResponder()
    appearDeactivated()
    movePlaceholderLabel()
    return shouldResign
  }
  
  func movePlaceholderLabel() {
    if isFirstResponder || (text != "" && text != nil) {
      self.placeholderLabelBecome(active: true)
    } else {
      self.placeholderLabelBecome(active: false)
    }
  }
  
  func showErrorLabel() {
    self.errorLabel?.alpha = 0
    self.errorLabel?.text = self.errorText
    self.showErrorConstraints.forEach { $0.isActive = true }
    self.hideErrorConstraints.forEach { $0.isActive = false }
    UIView.animate(withDuration: 0.5, animations: {
      self.errorLabel?.alpha = 1
      self.underlineView?.backgroundColor = self.underlineErrorColor
      self.superview?.layoutIfNeeded()
      self.superview?.superview?.layoutIfNeeded()
    })
  }
  
  func hideErrorLabel() {
    self.errorLabel?.alpha = 1
    self.showErrorConstraints.forEach { $0.isActive = false }
    self.hideErrorConstraints.forEach { $0.isActive = true }
    UIView.animate(withDuration: 0.3, animations: {
      self.errorLabel?.alpha = 0
      self.superview?.layoutIfNeeded()
      self.superview?.superview?.layoutIfNeeded()
    }, completion: { completed in
      self.errorLabel?.text = nil
    })
  }
  
  func placeholderLabelBecome(active: Bool) {
    var appearanceBlock: () -> Void = {}
    if active {
      appearanceBlock = {
        self.placeholderLabel?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        var rect = self.bounds
        rect.origin.y -= rect.size.height / 1.3
        self.placeholderLabel?.frame = rect
        self.placeholderLabel?.textColor = self.placeholderActiveColor
      }
    } else {
      if text == "" || text == nil {
        appearanceBlock = {
          self.placeholderLabel?.transform = CGAffineTransform(scaleX: 1, y: 1)
          self.placeholderLabel?.frame = self.bounds
          self.placeholderLabel?.textColor = self.placeholderInactiveColor
        }
      }
    }
    
    UIView.animate(withDuration: 0.4, animations: appearanceBlock)
  }
  
  func appearActivated() {
    UIView.animate(withDuration: 0.5, animations: {
      self.underlineView?.backgroundColor = self.underlineActiveColor
      self.textColor = self.textFocusColor
    })
  }
  
  func appearDeactivated() {
    var appearanceBlock: () -> Void
    if text == "" || text == nil {
      appearanceBlock = {
        self.underlineView?.backgroundColor = self.underlineInactiveColor
        self.textColor = self.textBlurColor
      }
    } else {
      appearanceBlock = {
        self.underlineView?.backgroundColor = self.underlineHasValueColor
        self.textColor = self.textBlurColor
      }
    }
    UIView.animate(withDuration: 0.5, animations: appearanceBlock)
  }
  
  func appearDisabled() {
    UIView.animate(withDuration: 0.5, animations: {
      self.underlineView?.backgroundColor = self.underlineHasValueColor
      self.textColor = self.textBlurColor.withAlphaComponent(0.7)
    })
  }

// MARK: isSecureTextEntry overriding
  open override var isSecureTextEntry: Bool {
    didSet {
      toggleShowPasswordImageView.tintColor = isSecureTextEntry ? .gray : .white
    }
  }

  var hasShowToggleShowPasswordOnce: Bool = false
  
  lazy var toggleShowPasswordImageView: UIImageView = {
    let imageView = UIImageView()
    let image = UIImage(named: "ico-show-password")
    imageView.image = image
    imageView.contentMode = .scaleAspectFit
    imageView.tintColor = .gray
    imageView.isUserInteractionEnabled = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(imageView)
    self.bringSubviewToFront(imageView)
    var metrics = ["w": 22, "h": 17]
    let views = ["toggle": imageView, "super": self]
    var constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[toggle(w)]-(10)-|", metrics: metrics, views: views)
    let centerY = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: imageView, attribute: .centerY, multiplier: 1, constant: 2)
    constraints.append(centerY)
    self.addConstraints(constraints)
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleShowPassword))
    imageView.addGestureRecognizer(tapGesture)
    return imageView
  }()
  
  func showToggleShowPassword(_ show: Bool) {
    toggleShowPasswordImageView.isHidden = !show
  }
  
  @IBAction func toggleShowPassword() {
    isSecureTextEntry = !isSecureTextEntry
  }
  
}
