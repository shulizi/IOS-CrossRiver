//
//  GameScene.swift
//  FlappyBird
//
//  Created by LingNanTong on 2017/7/4.
//
//

import SpriteKit

let birdCategory: UInt32 = 0x1 << 0
let riverCategory: UInt32 = 0x1 << 1
let floorCategory: UInt32 = 0x1 << 2
let boatCategory: UInt32 = 0x1 << 3

class GameScene: SKScene, SKPhysicsContactDelegate {
    var objects:[Object] = []
    func setObjects(objects:[Object]){
        self.objects = objects
        initC(Int32(objects.count),Int32(objects[0].load))
        for n in 0..<objects.count{
            var boatingInt = 0
            var crossInt = 0
            if (objects[n].boating){
                boatingInt = 1
            }
            if (objects[n].cross){
                crossInt = 1
            }
            addObjectC(Int32(n), Int32(objects[n].num), Int32(crossInt), Int32(boatingInt))
            
        }
        for n in 0..<objects.count{
            let masterArray = objects[n].master.components(separatedBy:" ")
            let naturalenemyArray = objects[n].naturalenemy.components(separatedBy:" ")
            let predatorArray = objects[n].predator.components(separatedBy:" ")
            let competitorArray = objects[n].competitor.components(separatedBy:" ")
            for m in 0..<objects.count{
                if (masterArray[0] == objects[m].name){
                    setBreedingC(Int32(m),Int32(n))
                }
                
            }
            for name in naturalenemyArray{
                for m in 0..<objects.count{
                    if (name == objects[m].name){
                        setInhibitionC(Int32(m),Int32(n))
                    }
                    
                }
            }
            for name in predatorArray{
                for m in 0..<objects.count{
                    if (name == objects[m].name){
                        setPredationC(Int32(m),Int32(n))
                    }
                    
                }
            }
            for name in competitorArray{
                for m in 0..<objects.count{
                    if (name == objects[m].name){
                        setCompetitiveC(Int32(m),Int32(n))
                    }
                    
                }
            }
            
        }
//        initC(2,2)
//        addObjectC(1, 3, 1, 1)
//        addObjectC(2, 3, 1, 1)
//        setInhibitionC(2,1)
        
//        initC(4,2)
//        addObjectC(1, 1, 1, 1)
//        addObjectC(2, 1, 1, 0)
//        addObjectC(3, 1, 1, 0)
//        addObjectC(4, 1, 1, 0)
//
//        setPredationC(3, 2)
//        setPredationC(4, 3)
//        setBreedingC(1, 2)
//        setBreedingC(1, 3)
//        setBreedingC(1, 4)
        
        
        let a = searchC()
        
        for i in 1..<100 {
            var row = [Int]()
            var temp = Int(a![i])
            for j in 0..<objects.count{
                let tmp = objects[j].num + 1
                row += [temp%tmp]
                temp = temp/tmp
                
            }
            boatState += [row]
            if (a![i] == 0){
                break
            }
        }
        for object in objects{
            print (object.name,object.num,object.boating,object.naturalenemy,object.load)
        }
    }
    enum GameStatus {
        case idle
        case running
        case debark
        case embark
        case over
    }
    var boatLeftFlag = true
    
    var gameStatus: GameStatus = .idle
    
    var river1: SKSpriteNode!
    var river2: SKSpriteNode!
    var river3: SKSpriteNode!
    var river4: SKSpriteNode!
    
    var floor1: SKSpriteNode!
    var floor2: SKSpriteNode!
    
    var boat: SKSpriteNode!
    var boatState = [[Int]]()
    var boatAnimalsCount = 0
    var species = [[SKSpriteNode?]]()
    lazy var gameOverLabel: SKLabelNode = {
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = "Game Over"
        return label
    }()
    
    lazy var metersLabel: SKLabelNode = {
        let label = SKLabelNode(text: "step:0")
        label.verticalAlignmentMode = .top
        label.horizontalAlignmentMode = .center
        
        return label
    }()
    
    var meters = 0 {
        didSet {
            metersLabel.text = "step:\(meters)"
        }
    }
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor(red: 80.0/255.0, green: 192.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        
        // Set Scene physics
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsWorld.contactDelegate = self
        
        // Set Meter Label
        metersLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height/1.5)
        metersLabel.zPosition = 100
        addChild(metersLabel)
        
        
        
        
        // Set rivers
        river1 = SKSpriteNode(imageNamed: "river")
        river1.anchorPoint = CGPoint(x: 0, y: 0)
        river1.position = CGPoint(x: 0, y: 0)
        
        addChild(river1)
        river2 = SKSpriteNode(imageNamed: "river")
        river2.anchorPoint = CGPoint(x: 0, y: 0)
        river2.position = CGPoint(x: river1.size.width, y: 0)
        
        addChild(river2)
        
        boat = SKSpriteNode(imageNamed: "boat")
        boat.anchorPoint = CGPoint(x: 0, y: 0)
        boat.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 0, y: 0, width: boat.size.width, height: boat.size.height))
        boat.physicsBody?.categoryBitMask = boatCategory
        addChild(boat)
        
        // Set rivers
        river3 = SKSpriteNode(imageNamed: "river2")
        river3.anchorPoint = CGPoint(x: 0, y: 0)
        river3.position = CGPoint(x: 0, y: 0)
        
        addChild(river3)
        river4 = SKSpriteNode(imageNamed: "river2")
        river4.anchorPoint = CGPoint(x: 0, y: 0)
        river4.position = CGPoint(x: river1.size.width, y: 0)
        
        addChild(river4)
        var animals = [SKSpriteNode?]()
        for n in 0..<objects.count{
            animals = []
            for _ in 0..<objects[n].num{
                let animal = SKSpriteNode(imageNamed: "player1")
                animal.physicsBody = SKPhysicsBody(texture: animal.texture!, size: animal.size)
                animal.physicsBody?.allowsRotation = false
                animal.physicsBody?.categoryBitMask = birdCategory
                
                animals += [animal]
                addChild(animal)
            }
            species += [animals]
        }
        
        
        // Set floors
        floor1 = SKSpriteNode(imageNamed: "floor")
        floor1.anchorPoint = CGPoint(x: 0, y: 0)
        floor1.position = CGPoint(x: 0, y: 0)
        floor1.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 0, y: 0, width: floor1.size.width, height: floor1.size.height))
        floor1.physicsBody?.categoryBitMask = floorCategory
        addChild(floor1)
        
        floor2 = SKSpriteNode(imageNamed: "floor")
        floor2.anchorPoint = CGPoint(x: 0, y: 0)
        floor2.position = CGPoint(x: self.size.width - floor2.size.width, y: 0)
        floor2.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 0, y: 0, width: floor2.size.width, height: floor2.size.height))
        floor2.physicsBody?.categoryBitMask = floorCategory
        addChild(floor2)
        
        shuffle()
    }
    
    func shuffle() {
        
        gameStatus = .embark
        
        boat.position = CGPoint(x: 200, y: 0)
        boatLeftFlag = true
        meters = 0
        gameOverLabel.removeFromParent()
        for n in 0..<objects.count{
            for i in 0..<objects[n].num{
                species[n][i]!.accessibilityLabel = "left"
                species[n][i]!.physicsBody?.isDynamic = false
                species[n][i]!.anchorPoint = CGPoint(x: 0, y: 0)
                species[n][i]!.position = CGPoint(x: floor1.size.width*CGFloat(n)/CGFloat(objects.count), y: floor1.size.height + self.size.height/2*CGFloat(i)/CGFloat(objects[n].num))
                
            }
        }
        

        birdStartFly()
    }
    
    func moveBoat() {
        
        //make boat move
        if boat.position.x > floor2.position.x - boat.size.width {
            
            boatLeftFlag = false
            gameStatus = .debark
        } else if boat.position.x < floor1.size.width{
            
            boatLeftFlag = true
            gameStatus = .debark
        }
        if boatLeftFlag{
            boat.position = CGPoint(x: boat.position.x + 4, y: boat.position.y)
            for n in 0..<objects.count{
                for j in 0..<objects[n].num{
                    if (species[n][j]!.accessibilityLabel == "boat"){
                        species[n][j]!.position.x = species[n][j]!.position.x + 4
                    }
                }
            }
            
        }else {
            boat.position = CGPoint(x: boat.position.x - 4, y: boat.position.y)
            for n in 0..<objects.count{
                for j in 0..<objects[n].num{
                    if (species[n][j]!.accessibilityLabel == "boat"){
                        species[n][j]!.position.x = species[n][j]!.position.x - 4
                    }
                }
            }
            
        }
        
        
        
    }
    func debark(){
//        print("debark",boatAnimalsCount)
        if (boatAnimalsCount == 0){
            gameStatus = .embark
            return
        }
        for n in 0..<objects.count{
            
            if (boatLeftFlag){
                
                for j in 0..<objects[n].num{
                    
                    if(species[n][j]!.accessibilityLabel == "boat" && species[n][j]!.position.x >  floor1.size.width*CGFloat(n)/CGFloat(objects.count)){
                        species[n][j]!.position = CGPoint(x: species[n][j]!.position.x - 4, y: species[n][j]!.position.y)
                    } else if (species[n][j]!.accessibilityLabel == "boat"){
                        species[n][j]!.accessibilityLabel = "left"
                        boatAnimalsCount = boatAnimalsCount - 1
                        break
                    }
                    
                }
                
            } else {
                
                for j in 0..<objects[n].num{
                    
                    if (species[n][j]!.accessibilityLabel == "boat" && species[n][j]!.position.x < floor2.position.x + floor1.size.width*CGFloat(n)/CGFloat(objects.count)){
                        species[n][j]!.position = CGPoint(x: species[n][j]!.position.x + 4, y: species[n][j]!.position.y)
                        
                    } else if (species[n][j]!.accessibilityLabel == "boat"){
                        species[n][j]!.accessibilityLabel = "right"
                        boatAnimalsCount = boatAnimalsCount - 1
                        break
                    }
                    
                }
            }
        }
        
        
        
    }
    func embark(){
//        print("embark",boatAnimalsCount)
        var sum = 0
        for n in 0..<objects.count{
            sum = sum + boatState[meters][n]
        }
        if (boatAnimalsCount == sum){
            gameStatus = .idle
            if (meters >= boatState.count - 1){
                gameOver()
            }
            return
        }
        for n in 0..<objects.count{
            
            var count = boatState[meters][n]
            if (boatLeftFlag){
                
                for j in 0..<objects[n].num{
                    if (count == 0){
                        break
                    }
                    if (species[n][j]!.accessibilityLabel == "left" && species[n][j]!.position.x < boat.position.x +  boat.size.width*CGFloat(n)/CGFloat(objects.count)){
                        species[n][j]!.position = CGPoint(x: species[n][j]!.position.x + 4, y: species[n][j]!.position.y)
                        count = count - 1
                    }else if(species[n][j]!.accessibilityLabel == "left"){
                        
                        species[n][j]!.accessibilityLabel = "boat"
                        boatAnimalsCount = boatAnimalsCount + 1
                        break
                    }
                }
            } else {
                
                for j in 0..<objects[1].num{
                    if (count == 0){
                        break
                    }
                    if(species[n][j]!.accessibilityLabel == "right" && species[n][j]!.position.x > boat.position.x +  boat.size.width*CGFloat(n)/CGFloat(objects.count)){
                        species[n][j]!.position = CGPoint(x: species[n][j]!.position.x - 4, y: species[n][j]!.position.y)
                        count = count - 1
                    }else if(species[n][j]!.accessibilityLabel == "right"){
                        
                        species[n][j]!.accessibilityLabel = "boat"
                        boatAnimalsCount = boatAnimalsCount + 1
                        break
                    }
                }
            }
            
        }
        
        
    }
    func gameOver() {
        
        gameStatus = .over
        
        birdStopFly()
        
        isUserInteractionEnabled = false
        
        addChild(gameOverLabel)
        gameOverLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height)
        gameOverLabel.run(SKAction.move(by: CGVector(dx:0, dy:-self.size.height * 0.5), duration: 0.5), completion: {
            self.isUserInteractionEnabled = true
        })
    }
    func getTextImage(str:String)->UIImage?{
        let image = UIImage(named: "animal")
        if (UIImage(named: str) != nil){
            return nil
        }
        let size = CGSize(width: image!.size.width, height: image!.size.height)
        UIGraphicsBeginImageContext(size)
        let point = CGPoint(x:0,y:size.height/2-25)
        image?.draw(at: CGPoint.zero)
        let mulDicts = NSMutableDictionary()
        mulDicts[NSFontAttributeName] = UIFont(name: "Chalkduster", size: 50)
        mulDicts[NSForegroundColorAttributeName] = UIColor.black
        NSString(string: str).draw(at: point, withAttributes: NSDictionary(dictionary: mulDicts) as? [String: AnyObject])
        let imageWater = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageWater
        
    }
    func birdStartFly() {
        
        let flyAction = SKAction.animate(with: [SKTexture(imageNamed: "ghost1"),
                                                SKTexture(imageNamed: "ghost2"),
                                                SKTexture(imageNamed: "ghost3"),
                                                SKTexture(imageNamed: "ghost2")],
                                         timePerFrame: 0.15)
        let personAction = SKAction.animate(with: [SKTexture(imageNamed: "person1"),
                                                SKTexture(imageNamed: "person2"),
                                                SKTexture(imageNamed: "person3"),
                                                SKTexture(imageNamed: "person2")],
                                         timePerFrame: 0.15)

        for n in 0..<objects.count{
            for i in 0..<objects[n].num{
                
                if (objects[n].name == "ghost"){
                    species[n][i]!.run(SKAction.repeatForever(flyAction), withKey: "fly")
                } else if (objects[n].name == "person"){
                    species[n][i]!.run(SKAction.repeatForever(personAction), withKey: "fly")
                }else {
                    var animalAction  = SKAction.animate(with: [SKTexture(imageNamed: objects[n].name)],timePerFrame: 0.15)
                    let image = getTextImage(str:objects[n].name)
                    if (image != nil){
                        animalAction  = SKAction.animate(with: [SKTexture(image: image!)],timePerFrame: 0.15)
                    }
                
                    species[n][i]!.run(SKAction.repeatForever(animalAction), withKey: "fly")
                }
                
                
            }
        }
        
    }
    
    func birdStopFly() {
        for n in 0..<objects.count{
            for i in 0..<objects[0].num{
                species[n][i]!.removeAction(forKey: "fly")
                
            }
        }
        
    }
    
    func moveScene() {
       
        
        //make river move
        river1.position = CGPoint(x: river1.position.x - 1, y: river1.position.y)
        river2.position = CGPoint(x: river2.position.x - 1, y: river2.position.y)
        
        //check river position
        if river1.position.x < -river1.size.width {
            river1.position = CGPoint(x: river2.position.x + river2.size.width, y: river1.position.y)
        }
        if river2.position.x < -river2.size.width {
            river2.position = CGPoint(x: river1.position.x + river1.size.width, y: river2.position.y)
        }
        
        //make river move
        river3.position = CGPoint(x: river3.position.x + 1, y: river3.position.y)
        river4.position = CGPoint(x: river4.position.x + 1, y: river4.position.y)
        
        //check river position
        if river3.position.x > river3.size.width {
            river3.position = CGPoint(x: river4.position.x - river4.size.width, y: river3.position.y)
        }
        if river4.position.x > river4.size.width {
            river4.position = CGPoint(x: river3.position.x - river3.size.width, y: river4.position.y)
        }
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch gameStatus {
        case .idle:
            meters += 1
            gameStatus = .running
        case .running:
            print ("running")
        case .over:
            shuffle()
        case .embark:
            print ("embarking")
        case .debark:
            print ("debarking")
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveScene()
        
        if gameStatus == .running {
            moveBoat()
        } else if (gameStatus == .debark){
            debark()
        }else if (gameStatus == .embark){
            embark()
        }
        
        
//        if gameStatus != .over {
//            moveScene()
//        }
    }
    
}

