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

class SearchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    
//    var arrRes = [[String:AnyObject]]()
    var movies = [Movies]()
    var index = 0
    var pg = 1
    var searchKeyword = "ab"
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableMovies: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableHeightAutomatic()
        self.fetchData(pageNO: 1)
    }
    
    
    // Table automatic height
    func tableHeightAutomatic(){
        tableMovies.estimatedRowHeight = 162
        tableMovies.rowHeight = UITableViewAutomaticDimension
    }
    
    // MARK: - Table view data source
    
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
        
        if indexPath.row == movies.count - 1 {
            self.fetchData(pageNO: pg+1)
            self.pg = self.pg+1

        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: Constants.segueFromMoviesToDetail, sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! DetailViewController
        destVC.imdbID = movies[index].imdbID!
    }
    
    
    // MARK: - Search bar Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchKeyword = searchBar.text!
        movies.removeAll()
        self.fetchData(pageNO: 1)
        self.view.endEditing(true)
    }
    
    
    // MARK: -  API call
    func fetchData(pageNO : Int){
//        arrRes.removeAll()

        let manager = APIManager()
        manager.request(with: MoviesEndPoints.getMovieList(searchKeyword: searchKeyword, pageNo: pageNO) , completion: { (Response) in
            print(Response)
            switch Response {
                
            case .success(let json):
                if json["Search"] != JSON.null {
                    
                    for movie in json["Search"].arrayObject! {
                        let mov = Movies(JSON: movie as! [String: Any])
                        self.movies.append(mov!)
                    }
                    
                    print(self.movies)
                    self.tableMovies.reloadData()
                    break
                }
                else{
                    self.showAlert(error: json["Error"].string!)
                }

            case .failure( _):
                break
                
            }
        }, isLoaderNeeded: true)
        
        
    }
    
    
    // MARK :- Alert View
    func showAlert(error:String){
        SCLAlertView().showError(Constants.errorMessage, subTitle: error)
    }
}
