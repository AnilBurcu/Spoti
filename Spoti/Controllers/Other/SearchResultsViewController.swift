//
//  SearchResultsViewController.swift
//  Spoti
//
//  Created by Anıl Bürcü on 11.09.2023.
//

import UIKit

struct SearchSection {
    let title:String
    let results: [SearchResult]
}

protocol SearchResultsViewControllerDelegate: AnyObject {
    func didTapResult(_ result: SearchResult)
}

class SearchResultsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    


    weak var delegate: SearchResultsViewControllerDelegate?
    
    private var sections: [SearchSection] = []
    
    
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        
        
        tableView.register(SearchResultSubtitleTableViewCell.self, forCellReuseIdentifier: SearchResultSubtitleTableViewCell.identifier)
        tableView.register(SearchResultsDefaultTableViewCell.self, forCellReuseIdentifier: SearchResultsDefaultTableViewCell.identifier)
        tableView.isHidden = true
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        
        print(sections)

        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
      
        tableView.frame = view.bounds
        
        
    }
    
    func update(with results: [SearchResult]) {
            let artists = results.filter({
                switch $0 {
                case .artist: return true
                default: return false
                }
            })

            let albums = results.filter({
                switch $0 {
                case .album: return true
                default: return false
                }
            })

            let tracks = results.filter({
                switch $0 {
                case .track: return true
                default: return false
                }
            })

            let playlists = results.filter({
                switch $0 {
                case .playlist: return true
                default: return false
                }
            })

            self.sections = [
                SearchSection(title: "Songs", results: tracks),
                SearchSection(title: "Artists", results: artists),
                SearchSection(title: "Playlists", results: playlists),
                SearchSection(title: "Albums", results: albums)
            ]

            tableView.reloadData()
            tableView.isHidden = results.isEmpty
        }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return sections.count
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return sections[section].results.count
        }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let result = sections[indexPath.section].results[indexPath.row]

                switch result {
                case .artist(let artist):
                    guard let cell = tableView.dequeueReusableCell(
                        withIdentifier: SearchResultsDefaultTableViewCell.identifier,
                        for: indexPath
                    ) as? SearchResultsDefaultTableViewCell else {
                        return  UITableViewCell()
                    }
                    let viewModel = SearchResultsDefaultTableViewCellViewModel(
                        title: artist.name,
                        imageURL: URL(string: artist.images?.first?.url ?? "")
                    )
                    cell.configure(with: viewModel)
                    return cell
                case .album(let album):
                    guard let cell = tableView.dequeueReusableCell(
                        withIdentifier: SearchResultSubtitleTableViewCell.identifier,
                        for: indexPath
                    ) as? SearchResultSubtitleTableViewCell else {
                        return  UITableViewCell()
                    }
                    let viewModel = SearchResultsSubtitleTableViewCellViewModel(
                        title: album.name,
                        subtitle: album.artists.first?.name ?? "",
                        imageURL: URL(string: album.images.first?.url ?? "")
                    )
                    cell.configure(with: viewModel)
                    return cell
                case .track(let track):
                    guard let cell = tableView.dequeueReusableCell(
                        withIdentifier: SearchResultSubtitleTableViewCell.identifier,
                        for: indexPath
                    ) as? SearchResultSubtitleTableViewCell else {
                        return  UITableViewCell()
                    }
                    let viewModel = SearchResultsSubtitleTableViewCellViewModel(
                        title: track.name,
                        subtitle: track.artists.first?.name ?? "-",
                        imageURL: URL(string: track.album?.images.first?.url ?? "")
                    )
                    cell.configure(with: viewModel)
                    return cell
                case .playlist(let playlist):
                    guard let cell = tableView.dequeueReusableCell(
                        withIdentifier: SearchResultSubtitleTableViewCell.identifier,
                        for: indexPath
                    ) as? SearchResultSubtitleTableViewCell else {
                        return  UITableViewCell()
                    }
                    let viewModel = SearchResultsSubtitleTableViewCellViewModel(
                        title: playlist.name,
                        subtitle: playlist.owner.display_name,
                        imageURL: URL(string: playlist.images.first?.url ?? "")
                    )
                    cell.configure(with: viewModel)
                    return cell
                }
            }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at:indexPath, animated: true)
        
        let result = sections[indexPath.section].results[indexPath.row]
        
        delegate?.didTapResult(result)
        
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }


}
