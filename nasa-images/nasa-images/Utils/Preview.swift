//
//  Preview.swift
//  teste
//
//  Created by Gabriela Sillis on 04/02/22.
//

import UIKit

#if canImport(SwiftUI) && DEBUG
import SwiftUI

public struct Preview<View: UIView>: UIViewRepresentable {
	private let view: View
	
	public init(_ builder: @escaping () -> View) {
		view = builder()
	}
	
	public func makeUIView(context: Context) -> View {
		view
	}
	
	public func updateUIView(_ uiView: View, context: Context) {
		uiView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
		uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
	}
}

#endif
