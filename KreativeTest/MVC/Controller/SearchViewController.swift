//
//  SearchViewController.swift
//  KreativeTest
//
//  Created by thejus manoharan on 26/06/2018.
//  Copyright © 2018 thejus. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftyJSON
import SCLAlertView

class SearchViewController: UIViewController {
    

    var movies = [Movies]()
    var index = 0
    var searchKeyword = Constants.searchKeyword
    var pickOption = [Constants.all,Constants.movie,Constants.series,Constants.episode]
    var isDataLoading:Bool=false
    var pickerViewTextField : UITextField = UITextField()
    var pageNo:Int=0
    var movieType = ""

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableMovies: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createPickerView()
        self.fetchData(pageNO: 1,isloaderNeeded: true)
    }
    
    func createPickerView(){
        
        pickerViewTextField = UITextField(frame: CGRect.zero)
        view.addSubview(pickerViewTextField)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        pickerView.showsSelectionIndicator = true
        pickerView.dataSource = self
        pickerView.delegate = self
        
        pickerViewTextField.inputView = pickerView
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! DetailViewController
        destVC.imdbID = movies[index].imdbID!
    }
    
    
    // MARK: -  API call
    func fetchData(pageNO : Int, isloaderNeeded: Bool){

        let manager = APIManager()
        manager.request(with: MoviesEndPoints.getMovieList(searchKeyword: searchKeyword, pageNo: pageNO, movieType: self.movieType) , completion: { (Response) in

            switch Response {
                
            case .success(let json):
                if json["Search"] != JSON.null {
                    
                    for movie in json["Search"].arrayObject! {
                        let mov = Movies(JSON: movie as! [String: Any])
                        self.movies.append(mov!)
                    }
                    
                    self.tableMovies.reloadData()
                    break
                }
                else{
                    if(isloaderNeeded){
                         self.showAlert(error: json["Error"].string!)
                    }

                }

            case .failure( _):
                break
                
            }
        }, isLoaderNeeded: isloaderNeeded)

    }
    
    
    // MARK :- Alert View
    func showAlert(error:String){
        SCLAlertView().showError(Constants.errorMessage, subTitle: error)
    }
     // MARK :- Actions
    @IBAction func actionTypeFilter(_ sender: Any) {
        self.pickerViewTextField.becomeFirstResponder()
    }
    
}

// MARK: - Table view data source
extension SearchViewController:UITableViewDelegate,UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movies.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchTableViewCell = self.tableMovies.dequeueReusableCell(withIdentifier: Constants.searchCell) as! SearchTableViewCell
        let movie = movies[indexPath.row]
        
        cell.labelTitle.text = movie.Title
        cell.labelType?.text = movie.movieType
        cell.labelYear?.text = movie.Year
        cell.imagePoster.sd_setImage(with: URL(string: movie.Poster!), placeholderImage: UIImage(named: Constants.placeHolder))
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: Constants.segueFromMoviesToDetail, sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
 // MARK :- Picker View
extension SearchViewController: UIPickerViewDataSource,UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row>0 {
            movieType = pickOption[row]
        }
        else{
            movieType = ""
        }
        self.pickerViewTextField.resignFirstResponder()
        if(!searchKeyword.isEmpty)&&(searchKeyword.count>1){
            movies.removeAll()
            fetchData(pageNO: 1, isloaderNeeded: true)
        }
    }

}

// MARK: - Search bar Delegate
extension SearchViewController:UISearchBarDelegate,UIScrollViewDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchKeyword = searchBar.text!
        movies.removeAll()
        self.fetchData(pageNO: 1,isloaderNeeded: true)
        self.view.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchKeyword = searchText
    }
    
    //MARK :- Scrollview Delegate
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isDataLoading = false
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if ((self.tableMovies.contentOffset.y + self.tableMovies.frame.size.height) >= self.tableMovies.contentSize.height)
        {
            if !isDataLoading{
                isDataLoading = true
                self.pageNo=self.pageNo+1
                fetchData(pageNO: pageNo,isloaderNeeded: false)
            }
        }
        
        
    }
}
