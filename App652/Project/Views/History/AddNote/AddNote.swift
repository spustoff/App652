//
//  AddNote.swift
//  App652
//
//  Created by IGOR on 29/06/2024.
//

import SwiftUI

struct AddNote: View {

    @StateObject var viewModel: HistoryViewModel
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack(spacing: 15) {
                
                Text("New note")
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .regular))

                HStack {
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            router.wrappedValue.dismiss()
                        }
                        
                    }, label: {
                        
                        HStack {
                            
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 17, weight: .medium))
                            
                            Text("Back")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 16, weight: .regular))
                        }
                    })
                    
                    Spacer()
                }
                .padding(.bottom)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 15) {

                        ZStack(alignment: .leading, content: {
                            
                            Text("Name")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.hisName.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.hisName)
                                .foregroundColor(Color.white)
                                .font(.system(size: 14, weight: .semibold))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("bg2")))

                        ZStack(alignment: .leading, content: {
                            
                            Text("Date")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.hisDate.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.hisDate)
                                .foregroundColor(Color.white)
                                .font(.system(size: 14, weight: .semibold))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("bg2")))
                        
                        ZStack(alignment: .leading, content: {
                            
                            Text("Comment")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.hisComment.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.hisComment)
                                .foregroundColor(Color.white)
                                .font(.system(size: 14, weight: .semibold))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("bg2")))
                        .padding(.bottom)
                    }
                }
                
                Button(action: {
                    
                    viewModel.addNotes()
                    
                    viewModel.hisName = ""
                    viewModel.hisDate = ""
                    viewModel.hisComment = ""
                    
                    viewModel.fetchNotes()

                    withAnimation(.spring()) {
                        
                        router.wrappedValue.dismiss()
                    }
                    
                }, label: {
                    
                    Text("Add")
                        .foregroundColor(.black)
                        .font(.system(size: 15, weight: .regular))
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("prim")))
                })
                .opacity(viewModel.hisName.isEmpty || viewModel.hisDate.isEmpty || viewModel.hisComment.isEmpty ? 0.5 : 1)
                .disabled(viewModel.hisName.isEmpty || viewModel.hisDate.isEmpty || viewModel.hisComment.isEmpty ? true : false)
            }
            .padding()
        }
    }
}

#Preview {
    AddNote(viewModel: HistoryViewModel())
}
