//
//  NewReleasesResponse.swift
//  Spoti
//
//  Created by Anıl Bürcü on 12.09.2023.
//

import Foundation

struct NewReleasesResponse: Codable {
    let albums: AlbumsResponse
}

struct AlbumsResponse:Codable {
    let items: [Album]
}

struct Album:Codable {
    let album_type:String
    let available_markets:[String]
    let id:String
    var images:[APIImage]
    let name:String
    let release_date:String
    let total_tracks:Int
    let artists:[Artist]
}



/*
 
 
 {
     albums =     {
         href = "https://api.spotify.com/v1/browse/new-releases?country=TR&locale=en-GB%2Cen%3Bq%3D0.9&offset=0&limit=1";
         items =         (
                         {
                 "album_type" = album;
                 artists =                 (
                                         {
                         "external_urls" =                         {
                             spotify = "https://open.spotify.com/artist/5Ip3Eje7dzsa2I38I1izYO";
                         };
                         href = "https://api.spotify.com/v1/artists/5Ip3Eje7dzsa2I38I1izYO";
                         id = 5Ip3Eje7dzsa2I38I1izYO;
                         name = Skapova;
                         type = artist;
                         uri = "spotify:artist:5Ip3Eje7dzsa2I38I1izYO";
                     }
                 );
                 "available_markets" =                 (
                     LR,
                     MW,
                     MV,
                     ML,
                     MH,
                    
                 );
                 "external_urls" =                 {
                     spotify = "https://open.spotify.com/album/3ZnS1uvQyVH4sLSLL6eGKc";
                 };
                 href = "https://api.spotify.com/v1/albums/3ZnS1uvQyVH4sLSLL6eGKc";
                 id = 3ZnS1uvQyVH4sLSLL6eGKc;
                 images =                 (
                                         {
                         height = 640;
                         url = "https://i.scdn.co/image/ab67616d0000b273468653ba0223fef45907c369";
                         width = 640;
                     },
                                         {
                         height = 300;
                         url = "https://i.scdn.co/image/ab67616d00001e02468653ba0223fef45907c369";
                         width = 300;
                     },
                                         {
                         height = 64;
                         url = "https://i.scdn.co/image/ab67616d00004851468653ba0223fef45907c369";
                         width = 64;
                     }
                 );
                 name = "yaln\U0131zl\U0131\U011f\U0131 b\U0131rak";
                 "release_date" = "2023-09-08";
                 "release_date_precision" = day;
                 "total_tracks" = 12;
                 type = album;
                 uri = "spotify:album:3ZnS1uvQyVH4sLSLL6eGKc";
             }
         );
         limit = 1;
         next = "https://api.spotify.com/v1/browse/new-releases?country=TR&locale=en-GB%2Cen%3Bq%3D0.9&offset=1&limit=1";
         offset = 0;
         previous = "<null>";
         total = 100;
     };
 }

 
 
 
 
 */
