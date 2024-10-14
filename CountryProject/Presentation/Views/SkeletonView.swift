//
//  SkeletonView.swift
//  CountryProject
//
//  Created by Sergey Gusev on 13.10.2024.
//

import SwiftUI

struct SkeletonView: View {
    var body: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.3))
            .cornerRadius(8)
            .shimmering()
    }
}
