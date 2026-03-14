# Spoti

A native iOS client for Spotify built with Swift and UIKit, featuring OAuth authentication, music browsing, search, library management, and audio playback.

**Architecture: MVC + Presenter Pattern | Programmatic UI | Protocol-Oriented Communication**

<!-- Screenshots: Add 2-3 app screenshots here -->

## Features

- **OAuth 2.0 Authentication** -- Secure login via Spotify's authorization flow with automatic token refresh
- **Browse** -- New releases, featured playlists, and personalized track recommendations on a compositional home feed
- **Search** -- Real-time search across tracks, artists, albums, and playlists with categorized results
- **Library Management** -- View, create, and edit playlists; save and unsave albums
- **Audio Playback** -- Play track previews with full player controls (play/pause, forward, backward, volume)
- **Album and Playlist Detail** -- Browse tracks, share playlists, and save albums with a single tap
- **Category Browsing** -- Explore Spotify's music categories and their curated playlists
- **User Profile** -- View account details including subscription plan and profile image

## Tech Stack and Architecture

| Layer         | Technology                                              |
| ------------- | ------------------------------------------------------- |
| Language      | Swift                                                   |
| UI Framework  | UIKit (100% programmatic, no Storyboards)               |
| Networking    | URLSession                                              |
| Audio         | AVFoundation (AVPlayer / AVQueuePlayer)                 |
| Auth          | WKWebView-based OAuth 2.0                               |
| Image Loading | SDWebImage                                              |
| Layout        | UICollectionViewCompositionalLayout, frame-based layout |
| Architecture  | MVC + Presenter + ViewModel                            |

**Architecture: MVC with Presenter Pattern**

The app follows MVC as its primary pattern, extended with two additional layers where plain MVC falls short:

- **Presenter** -- `PlaybackPresenter` owns all audio playback logic (AVPlayer/AVQueuePlayer lifecycle, track queue, play state). This keeps view controllers free of media management code, making them lean and focused on UI. Controllers communicate with the presenter through `PlayerDataSource` and `PlayerViewControllerDelegate` protocols rather than direct coupling.
- **ViewModel** -- Lightweight, non-reactive view models (`NewReleasesCellViewModel`, `FeaturedPlaylistCellViewModel`, etc.) handle the mapping from API models to display-ready data. Cells configure themselves from these view models, so controllers never deal with formatting or image URL resolution.
- **Singleton Managers** -- `AuthManager` and `APICaller` centralize token lifecycle and network requests behind clean interfaces, preventing auth and networking logic from leaking into controllers.
- **Delegate Pattern** -- All view-to-controller communication uses protocols (`PlaylistHeaderCollectionReusableViewDelegate`, `LibraryToggleViewDelegate`, `ActionLabelViewDelegate`), keeping views reusable and controllers interchangeable.

This combination was chosen over a full MVVM+Coordinator stack to keep complexity proportional to the app's scope -- every added layer solves a concrete problem (playback state, cell configuration, auth) rather than existing for architectural purity.

## Technical Highlights

**Centralized Playback Presenter** -- A shared `PlaybackPresenter` manages the full audio lifecycle, switching between `AVPlayer` for single tracks and `AVQueuePlayer` for album/playlist playback. View controllers communicate with it through `PlayerDataSource` and `PlayerViewControllerDelegate` protocols, keeping playback logic decoupled from UI code.

**Compositional Collection View Layout** -- The home feed uses `UICollectionViewCompositionalLayout` with three distinct section layouts (horizontal scroll for albums, grid for playlists, vertical list for recommendations), each with orthogonal scrolling behavior and section headers -- all defined programmatically.

**OAuth Token Management** -- The `AuthManager` handles the full token lifecycle: initial authorization code exchange, secure caching via UserDefaults, and proactive refresh 5 minutes before expiration. All API requests pass through a `createRequest` wrapper that injects valid tokens automatically.

**Coordinated Parallel API Calls** -- The home feed fetches new releases, featured playlists, and recommendations simultaneously using `DispatchGroup`, ensuring the UI updates only after all three responses arrive. This avoids partial rendering and keeps the loading state clean.

## Project Structure

```
Spoti/
├── Resources/          App lifecycle (AppDelegate, SceneDelegate, Extensions)
├── Managers/           AuthManager, APICaller, HapticsManager
├── Models/             Codable structs for API responses and domain objects
├── ViewModels/         Lightweight view models for cell configuration
├── Presenter/          PlaybackPresenter for global audio state
├── Controllers/
│   ├── Core/           TabBar, Home, Search, Library
│   └── Other/          Auth, Player, Album, Playlist, Profile, Settings, Categories
└── Views/              Custom cells, headers, and reusable UI components
```

## Getting Started

**Prerequisites**: Xcode 14+, CocoaPods, a [Spotify Developer](https://developer.spotify.com/dashboard) account

1. Clone the repository

   ```bash
   git clone https://github.com/<your-username>/Spoti.git
   cd Spoti
   ```

2. Install dependencies

   ```bash
   pod install
   ```

3. Open `Spoti.xcworkspace` in Xcode (not `.xcodeproj`)

4. In `AuthManager.swift`, replace the client credentials with your own Spotify app's Client ID and Client Secret. Set your redirect URI to match the one registered in your Spotify Developer Dashboard.

5. Build and run on a simulator or device running iOS 13.0+
