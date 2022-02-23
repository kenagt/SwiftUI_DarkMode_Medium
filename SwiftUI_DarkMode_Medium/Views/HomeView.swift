//
//  HomeeView.swift
//  SwiftUI_DarkMode_Medium
//
//  Created by Kenan Begić on 29. 1. 2022..
//

import SwiftUI
import Combine

struct HomeView: View {
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    @State private var isDarkModeOn = false
        
    init() {
        UINavigationBar.appearance().barTintColor = UIColor(named: "ColorPrimary")
        UINavigationBar.appearance().backgroundColor = UIColor(named: "ColorPrimary")
        UITableView.appearance().backgroundColor = UIColor(named: "BackgroundColorList")
    }
    
    func setAppTheme(){
        //MARK: use saved device theme from toggle
        isDarkModeOn = UserDefaultsUtils.shared.getDarkMode()        
        //MARK: or use device theme
        /*
         if (colorScheme == .dark)
         {
             isDarkModeOn = true
         }
         else{
             isDarkModeOn = false
         }
         */
        changeDarkMode(state: isDarkModeOn)
    }
    
    func changeDarkMode(state: Bool){
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first!.overrideUserInterfaceStyle = state ? .dark : .light
        UserDefaultsUtils.shared.setDarkMode(enable: state)
    }
    
    var ToggleThemeView: some View {
        Toggle("Dark Mode", isOn: $isDarkModeOn).onChange(of: isDarkModeOn) { (state)  in
            changeDarkMode(state: state)
        }.labelsHidden()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.BackgroundColorList.edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading) {
                    Text("Switch theme").foregroundColor(Color.TextColorSecondary).padding(10).font(Font.custom("Baloo-Regular", size: 15))
                    ToggleThemeView
                }
                .background(Color.BackgroundColorList)
                .font(Font.custom("Baloo-Regular", size: 20))
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(
                    leading:
                        Text("DarkModeSwitch").font(Font.custom("Baloo-Regular", size: 20))
                       
                )
                .navigationBarBackButtonHidden(true)
                .foregroundColor(Color.TextColorPrimary)
            }
        }
        .background(Color.BackgroundColorList)
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: {
            setAppTheme()
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        
        HomeView()
            .environment(\.colorScheme, .light)  //Light mode
        
        HomeView()
            .environment(\.colorScheme, .dark)  //Dark mode
        
        HomeView()
            .environment(\.colorScheme, .light)  //Light mode
            .previewLayout(PreviewLayout.fixed(width: 896, height: 414))//Landscape
        
        HomeView()
            .environment(\.colorScheme, .dark)  //Dark mode
            .previewLayout(PreviewLayout.fixed(width: 896, height: 414))//Landscape
            }
}
