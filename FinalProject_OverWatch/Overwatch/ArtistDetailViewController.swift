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
 */

/*
 *Marco Ross rosmarco
 *Mena Shafik Shafikm
 *Ken Suong  suongk
*/


import UIKit

class ArtistDetailViewController: UIViewController {
  
  var selectedArtist: Heroes!
  
  let moreInfoText = "Select For More Info >"
  
  @IBOutlet weak var tableView: UITableView!
  
  // the function is loaded after the view is sucessfully loaded.
  // it makes sure that the screen view is compatible with all screen sizes
  override func viewDidLoad() {
    super.viewDidLoad()
    title = selectedArtist.name
    
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 300
  }
  
  // loads the table data
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    NotificationCenter.default.addObserver(forName: .UIContentSizeCategoryDidChange, object: .none, queue:
    OperationQueue.main) { [weak self] _ in
      self?.tableView.reloadData()
    }
  }
}
/*
 This extension is used to provide the structure for the table view.
 It will describe the layout and how it should look. It uses the UITableViewDataSource protocol
 which is more
 */
extension ArtistDetailViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return selectedArtist.details.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    tableView.backgroundView = UIImageView(image: UIImage(named: "Mainbackground.jpg"))
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WorkTableViewCell
    cell.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
    let details = selectedArtist.details[indexPath.row]
    
    cell.workTitleLabel.text = details.title
    cell.workImageView.image = details.image
    
    //cell.workTitleLabel.backgroundColor = UIColor(white: 204/255, alpha: 1)
    //cell.workTitleLabel.textAlignment = .center
    //cell.moreInfoTextView.textColor = UIColor(white: 114/255, alpha: 1)
    cell.selectionStyle = .none
    
    //cell.textLabel?.text = work.info
    
    cell.moreInfoTextView.text = details.isExpanded ? details.info : moreInfoText
    cell.moreInfoTextView.textAlignment = details.isExpanded ? .left : .center
    
    return cell
  }
}
/*
 This extension is more responsible for the behaviour and logic of the app.
 It utilizes the UITableViewDelegate which is different from the Data Source. This protocol
 is concerned with managing sections of the table such as deleting and adding headers and footers,
 as well as scrolling behaviour.
 This extension is also responsible for making sure that accessibility such as larger text is supported
*/
extension ArtistDetailViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    // 1
    guard let cell = tableView.cellForRow(at: indexPath) as? WorkTableViewCell else {return}
    
    var details = selectedArtist.details[indexPath.row]
    
    // 2
    details.isExpanded = !details.isExpanded
    selectedArtist.details[indexPath.row] = details
    
    // 3
    cell.moreInfoTextView.text = details.isExpanded ? details.info: moreInfoText
    cell.moreInfoTextView.textAlignment = details.isExpanded ? .left : .center
    
    // 4
    tableView.beginUpdates()
    tableView.endUpdates()
    
    // 5
    tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    
    cell.workTitleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    cell.moreInfoTextView.font = UIFont.preferredFont(forTextStyle: .footnote)
  }
  
}



