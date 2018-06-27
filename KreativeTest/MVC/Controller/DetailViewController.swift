//
//  DetailViewController.swift
//  KreativeTest
//
//  Created by thejus manoharan on 26/06/2018.
//  Copyright © 2018 thejus. All rights reserved.
//

import UIKit
import SwiftyJSON
import SCLAlertView
import Cosmos

class DetailViewController: UIViewController {
    var imdbID : String = ""
    var movie = MovieDetails(JSON: ["": ""])
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelYear: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var lableLanguages: UILabel!
    @IBOutlet weak var labelDirector: UILabel!
    @IBOutlet weak var labelActor: UILabel!
    @IBOutlet weak var labelPlot: UILabel!
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var viewRating: CosmosView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.fetchData(imdbID: self.imdbID)
    }
    
    @IBAction func actionGoBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: -  API call
    func fetchData(imdbID : String){
        
        let manager = APIManager()
        manager.request(with: MoviesEndPoints.getMovieDetails(imdbID: imdbID) , completion: { (Response) in

            switch Response {
                
            case .success(let json):
                if json != JSON.null {
                    self.movie = MovieDetails(JSON: json.object as! [String: Any])

                    self.updateData()
                    
                }
                else{
                    self.showAlert(error: json["Error"].string!)
                }
                
            case .failure( _):
                break
                
            }
        }, isLoaderNeeded: true)
        
        
    }
    
    // MARK: -  Change UI
    func updateData(){
        
        labelYear.text = "Year: " + (movie?.Year)!
        labelPlot.text = "Plot: " + (movie?.Plot)!
        labelType.text = "Type: " + (movie?.movieType)!
        labelActor.text = "Actors: " + (movie?.Actors)!
        labelGenre.text = "Genre: " + (movie?.Genre)!
        labelTitle.text = "Title: " + (movie?.Title)!
        labelDirector.text = "Director: " + (movie?.Director)!
        lableLanguages.text = "Language: " + (movie?.Language)!
        imagePoster.sd_setImage(with: URL(string: (movie?.Poster)!), placeholderImage: UIImage(named: Constants.placeHolder))
        viewRating.settings.fillMode = .precise
        viewRating.rating = ((movie?.imdbRating! as NSString?)?.doubleValue)!/2
    }
    
    // MARK :- Alert View
    func showAlert(error:String){
        SCLAlertView().showError(Constants.errorMessage, subTitle: error)
    }
}
