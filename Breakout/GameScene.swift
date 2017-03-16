//
//  GameScene.swift
//  Breakout
//
//  Created by Ryan Grogger on 3/9/17.
//  Copyright © 2017 Ryan Grogger. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate
{
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    var ball:SKSpriteNode!
    var paddle:SKSpriteNode!
    var brick:SKSpriteNode!
    var loseZone:SKSpriteNode!
    
    override func didMove(to view: SKView)
    {
        physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        createBackground()
        makeBall()
        makeBrick()
        makePaddle()
        makeLoseZone()
        ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            let location = touch.location(in: self)
            paddle.position.x = location.x
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            let location = touch.location(in: self)
            paddle.position.x = location.x
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact)
    {
        if contact.bodyA.node?.name! == "brick" || contact.bodyB.node?.name! == "brick"
        {
            print("Brick hit")
        }
        else if contact.bodyA.node?.name == "loseZone"
        {
            print("You lose")
        }
    }
    
    func createBackground()
    {
        let stars = SKTexture(imageNamed: "stars")
        for i in 0...1
        {
            let starsBackground = SKSpriteNode(texture: stars)
            starsBackground.zPosition = -1
            starsBackground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            starsBackground.position = CGPoint(x: 0, y: (starsBackground.size.height * CGFloat(i) - CGFloat(1*i)))
            
            addChild(starsBackground)
            
            let moveDown = SKAction.moveBy(x: 0, y: -starsBackground.size.height, duration: 20)
            
            let moveReset = SKAction.moveBy(x: 0, y: starsBackground.size.height, duration: 0)
            
            let moveLoop = SKAction.sequence([moveDown, moveReset])
            
            let moveForever = SKAction.repeatForever(moveLoop)
            
            starsBackground.run(moveForever)
        }
    }
    
    func makeBall()
    {
        let ballDiameter = frame.width / 20
        ball = SKSpriteNode(color: UIColor.orange, size: (CGSize(width: ballDiameter, height: ballDiameter)))
        ball.position = CGPoint(x: frame.midX, y: frame.midY)
        ball.name = "ball"
        
        ball.physicsBody = SKPhysicsBody(rectangleOf: ball.size)
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.usesPreciseCollisionDetection = true
        ball.physicsBody?.allowsRotation = false
        ball.physicsBody?.friction = 0
        ball.physicsBody?.restitution = 1
        ball.physicsBody?.angularDamping = 0
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.contactTestBitMask = (ball.physicsBody?.collisionBitMask)!
        addChild(ball)
    }
    
    func makePaddle()
    {
        paddle = SKSpriteNode(color: UIColor.orange, size: (CGSize(width: frame.width/4, height: frame.height/25)))
        paddle.position = CGPoint(x: frame.midX, y: frame.minY + 125)
        paddle.physicsBody = SKPhysicsBody(rectangleOf: paddle.size)
        paddle.physicsBody?.isDynamic = false
        addChild(paddle)
    }
    
    func makeBrick()
    {
        brick = SKSpriteNode(color: UIColor.green, size: (CGSize(width: frame.width/10, height: frame.height/25)))
        brick.name = "brick"
        brick.position = CGPoint(x: frame.midX, y: frame.maxY - 30)
        brick.physicsBody = SKPhysicsBody(rectangleOf: brick.size)
        brick.physicsBody?.isDynamic = false
        addChild(brick)
    }
    
    func makeLoseZone()
    {

        loseZone = SKSpriteNode(color: UIColor.red, size: (CGSize(width: frame.width, height: 50)))
        loseZone.name = "loseZone"
        loseZone.position = CGPoint(x: frame.midX, y: frame.minY + 25)
        loseZone.physicsBody = SKPhysicsBody(rectangleOf: loseZone.size)
        loseZone.physicsBody?.isDynamic = false
        addChild(loseZone)
    }
    
    
}



















