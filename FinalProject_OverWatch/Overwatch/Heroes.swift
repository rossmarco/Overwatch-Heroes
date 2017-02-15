/*
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 
 *Marco Ross rosmarco
 *Mena Shafik Shafikm
 *Ken Suong  suongk
 
 */

import UIKit

struct Heroes {
  let name: String
  let bio: String
  let image: UIImage
  let heroClass: String
  var details: [Details]
  
  init(name: String, bio: String, image: UIImage, heroclass: String, details: [Details]) {
    self.name = name
    self.bio = bio
    self.image = image
    self.heroClass = heroclass
    self.details = details
  }
  
  static func artistsFromBundle() -> [Heroes] {
    
    var heroes = [Heroes]()
    
    guard let url = Bundle.main.url(forResource: "heroes", withExtension: "json") else {
      return heroes
    }
    
    do {
      let data = try Data(contentsOf: url)
      guard let rootObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any]  else {
        return heroes
      }
      
      guard let artistObjects = rootObject["heroes"] as? [[String: AnyObject]] else {
        return heroes
      }
      
      for artistObject in artistObjects {
        if let name = artistObject["name"] as? String,
          let bio = artistObject["bio"]  as? String,
          let imageName = artistObject["image"] as? String,
          let image = UIImage(named: imageName),
          let heroclass = artistObject["heroClass"] as? String,
          let worksObject = artistObject["details"] as? [[String : String]]{
          var details = [Details]()
          for workObject in worksObject {
            if let workTitle = workObject["title"],
              let workImageName = workObject["image"],
              let workImage = UIImage(named: workImageName + ".jpg"),
              let info = workObject["info"] {
              details.append(Details(title: workTitle,image: workImage,info: info, isExpanded: false))
            }
          }
          
          let hero = Heroes(name: name, bio: bio, image: image, heroclass: heroclass, details: details)
          heroes.append(hero)
        }
      }
    } catch {
      return heroes
    }
    
    return heroes
  }
  
}
