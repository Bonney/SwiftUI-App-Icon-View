//
//  ContentView.swift
//  SwiftUI App Icon View
//
//  Created by Matt Bonney on 6/28/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        AppIconView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct AppIconView: View {
    enum IconType {
        case macOS, iOS, watchOS, tvOS
    }

    @State private var iconSize: CGFloat = 200

    private var iconScale: CGFloat = 0.55
    @State private var macOS: Bool = false
    @State private var type: IconType = .iOS

    var body: some View {
        VStack {
            GeometryReader { g in
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom)
                        .mask(
                            RoundedRectangle(cornerRadius: g.size.width * (type == .watchOS ? 0.5 : type == .tvOS ? 0.15 : 0.25), style: .continuous)
                        )

                    Color.white
                        .opacity(type == .macOS ? 1 : 0.9)
                        .mask(
                            Image(systemName: "command")
                                .font(.system(size: g.size.height * iconScale, weight: .semibold, design: .rounded))
                        )
                        .scaleEffect(type == .tvOS ? 0.8 : type == .macOS ? 1.2 : 1.0)
                        .frame(height: g.size.height * (iconScale + 0.1))
                        .shadow(color: .black.opacity((type == .macOS || type == .tvOS) ? 0.25 : 0), radius: 8, x: 0.0, y: 6)
                        .offset(x: type == .macOS ? g.size.width * 0.25 : 0.0, y: type == .macOS ? g.size.height * 0.25 : 0.0)
                }
                .frame(width: g.size.width)
                .frame(height: type == .tvOS ? g.size.width * (9/16) : g.size.width)
                .animation(.spring())
            }
            .frame(width: iconSize, height: iconSize, alignment: .center)

            Divider().padding(.vertical, 50)

            VStack {

                HStack {
                    Button(action: { type = .iOS }) {
                        Label("iOS", systemImage: "iphone")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(.secondarySystemBackground).opacity(type == .iOS ? 1 : 0))
                            .mask(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .animation(.easeOut)
                    }

                    Button(action: { type = .watchOS }) {
                        Label("watchOS", systemImage: "applewatch")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(.secondarySystemBackground).opacity(type == .watchOS ? 1 : 0))
                            .mask(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .animation(.easeOut)
                    }
                }

                HStack {
                    Button(action: { type = .macOS }) {
                        Label("macOS", systemImage: "desktopcomputer")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(.secondarySystemBackground).opacity(type == .macOS ? 1 : 0))
                            .mask(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .animation(.easeOut)
                    }

                    Button(action: { type = .tvOS }) {
                        Label("tvOS", systemImage: "tv")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(.secondarySystemBackground).opacity(type == .tvOS ? 1 : 0))
                            .mask(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .animation(.easeOut)
                    }
                }

                Slider(value: $iconSize, in: 60...300)
            }


        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

