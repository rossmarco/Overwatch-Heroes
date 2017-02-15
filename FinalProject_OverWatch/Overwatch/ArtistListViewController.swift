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

class ArtistListViewController: UIViewController {
  
  let heroes = Heroes.artistsFromBundle()
  
  @IBOutlet weak var tableView: UITableView!
  
  // determines the size of the view to make sure its dynamic and compatible with all sizes
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 140
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    NotificationCenter.default.addObserver(forName: .UIContentSizeCategoryDidChange, object: .none, queue:
    OperationQueue.main) { [weak self] _ in
      self?.tableView.reloadData()
    }
  }
 

  /*
   this prepare for segue function retrieves the new view to be opened when the user
   is directed from the previous page
   */
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let destination = segue.destination as? ArtistDetailViewController,
        let indexPath = tableView.indexPathForSelectedRow {
      destination.selectedArtist = heroes[indexPath.row]
    }
  }
}

/*
 this extension uses the protocol UITableViewDataSource which is responsible for the loading of
 the structure and defining the layout of the table view. many attributes and constraints are set here
 additional to the constraints set in the auto-layout on the main.storyboard
 */
extension ArtistListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return heroes.count
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    tableView.backgroundView = UIImageView(image: UIImage(named: "Mainbackground.jpg"))
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                             for: indexPath) as! ArtistTableViewCell
    let hero = heroes[indexPath.row]

    cell.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
    cell.artistImageView.image = hero.image
    cell.nameLabel.text = hero.name
    
    cell.bioLabel.text = hero.bio
    //cell.bioLabel.textColor = UIColor(white: 114/255, alpha: 1)
    
    //cell.nameLabel.backgroundColor = UIColor(red: 1, green: 152/255, blue: 0, alpha: 1)
    //cell.nameLabel.textColor = UIColor.white
    cell.nameLabel.textAlignment = .center
    cell.selectionStyle = .none
    
    cell.nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    cell.bioLabel.font = UIFont.preferredFont(forTextStyle: .body)
    
    return cell
  }
}

/*extension ArtistListViewController: UITableViewDelegate
{
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    // 1
    guard let cell = tableView.cellForRow(at: indexPath) as? WorkTableViewCell else {return}
    
    //var details = selectedArtist.details[indexPath.row]
    
    // 2
    details.isExpanded = !details.isExpanded
    selectedArtist.details[indexPath.row] = details
    
    // 3
    //cell.moreInfoTextView.text = details.isExpanded ? details.info: moreInfoText
    cell.moreInfoTextView.textAlignment = details.isExpanded ? .left : .center
    
    // 4
    tableView.beginUpdates()
    tableView.endUpdates()
    
    // 5
    tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    
    cell.workTitleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    cell.moreInfoTextView.font = UIFont.preferredFont(forTextStyle: .footnote)
  }*/
  


  
  
  
//  /// in progress
//  @IBAction func RoleFilter(_ sender: Any) {
//    
//    switch UISegmentedControl.selectSegmentIndex
//    {
//    case 0:
//      ArtistTableViewCell.accessibilityElementsHidden()
//    case 1;
//    if()
//    {
//      isRowHidden
//      }
//    case 2:
//    case 3;
//    case 4:
//    default:
//      break;
//    }
//  }


