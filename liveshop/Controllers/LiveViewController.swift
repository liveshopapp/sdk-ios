//
//  LiveViewController.swift
//  liveshop
//
//  Created by Renan Kosicki on 23/08/18.
//  Copyright © 2018 LiveShopApp. All rights reserved.
//

import UIKit
import SocketIO
import AVFoundation
import AVKit
import IJKMediaFramework
import IHKeyboardAvoiding

class LiveViewController: UIViewController {
  
  // MARK: - Outlets
  
  @IBOutlet weak var emitterFaceheart: WaveEmitterView!
  @IBOutlet weak var emitterMoney: WaveEmitterView!
  @IBOutlet weak var emitterMoneyFlying: WaveEmitterView!
  @IBOutlet weak var giftArea: GiftDisplayArea!
  @IBOutlet weak var inputContainer: UIView!
  @IBOutlet weak var liveView: UIView!
  @IBOutlet weak var shopButton: UIButton!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var textField: UITextField!

  // MARK: - Variables
  
  var comments: [Comment] = []
  var manager: SocketManager?
  var player: IJKFFMoviePlayerController?
  var room: Room?
  var shopButtonPressed: (()->())?
  var dismissButtonPressed: (()->())?
  var socket: SocketIOClient?

  // MARK: - Lifecycle Methods
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.contentInset.top = tableView.bounds.height
    tableView.reloadData()
  }
  
//  override func viewWillDisappear(_ animated: Bool) {
//    super.viewWillDisappear(animated)
//    player?.shutdown()
//    socket?.disconnect()
//  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }
  
  // MARK: - Setup Methods
  
  func setupViews() {
    guard let key = room?.key else { return }

    setupPlayerWithRoom(key: key)
    setupTableView()
    setupTextField()
    setupSocket()
  }

  func setupPlayerWithRoom(key: String) {
    let urlString = "\(Config.videoUrl)\(key)"
    player = IJKFFMoviePlayerController(contentURLString: urlString,
                                        with: IJKFFOptions.byDefault())
    guard let player = player else {
      fatalError("Could not instantiate the video player with the given URL!")
    }
    
    player.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    player.view.frame = liveView.bounds
    
    liveView.addSubview(player.view)
    
    player.prepareToPlay()
  }
  
  func setupTableView() {
    tableView.estimatedRowHeight = 30
    tableView.rowHeight = UITableViewAutomaticDimension
  }
  
  func setupSocket() {
    manager = SocketManager(socketURL: URL(string: Config.socketUrl)!, config: [.log(true), .compress])
    socket = manager?.defaultSocket
    socket?.connect()
    socket?.once("connect") {[weak self] data, ack in
      self?.socket?.emit("create_room", self?.room?.toDict() ?? [:])
    }
    
    socket?.on("moneyflying") {[weak self] data, ack in
      self?.emitterMoneyFlying.emitImage(UIImage(named: "money-flying", in: Bundle(for: LiveViewController.self), compatibleWith: nil)!)
    }
    
    socket?.on("faceheart") {[weak self] data, ack in
      self?.emitterFaceheart.emitImage(UIImage(named: "face-heart", in: Bundle(for: LiveViewController.self), compatibleWith: nil)!)
    }
    
    socket?.on("upvote") {[weak self] data, ack in
      self?.emitterFaceheart.emitImage(UIImage(named: "emoji-money", in: Bundle(for: LiveViewController.self), compatibleWith: nil)!)
    }
    
    socket?.on("comment") {[weak self] data ,ack in
      let comment = Comment(dict: data[0] as! [String: AnyObject])

      self?.comments.append(comment)
      self?.tableView.reloadData()
      self?.tableView.scrollToBottom()
    }
  }
  
  func setupTextField() {
    KeyboardAvoiding.avoidingView = inputContainer
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(LiveViewController.handleTap(_:)))
    view.addGestureRecognizer(tap)
  }
  
  // MARK: - Action Methods

  @objc func handleTap(_ gesture: UITapGestureRecognizer) {
    guard gesture.state == .ended else {
      return
    }
    textField.resignFirstResponder()
  }
  
  @IBAction func clickShop(_ sender: Any) {
    player?.shutdown()
    socket?.disconnect()
    shopButtonPressed?()
  }
  
  @IBAction func dismiss(_ sender: Any) {
    player?.shutdown()
    socket?.disconnect()
    dismissButtonPressed?()
  }
  
  @IBAction func faceHeartButtonPressed(_ sender: AnyObject) {
    guard let key = room?.key else { return }
    socket?.emit("faceheart", key)
  }

  @IBAction func moneyFlyingButtonPressed(_ sender: AnyObject) {
    guard let key = room?.key else { return }
    socket?.emit("moneyflying", key)
  }

  @IBAction func moneyButtonPressed(_ sender: AnyObject) {
    guard let key = room?.key else { return }
    socket?.emit("upvote", key)
  }
}

// MARK: - UITextField Delegate Methods

extension LiveViewController: UITextFieldDelegate {

  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard let key = room?.key else { return false }

    if string == "\n" {
      textField.resignFirstResponder()
      if let text = textField.text , text != "" {
        socket?.emit("comment", [
          "roomKey": key,
          "text": text
          ])
      }
      textField.text = ""
      return false
    }
    return true
  }
}

// MARK: - UITableView Delegate Methods

extension LiveViewController: UITableViewDataSource, UITableViewDelegate {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return comments.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CommentCell
    cell.comment = comments[indexPath.row]
    return cell
  }
}
