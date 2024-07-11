//
//  InverntoryView.swift
//  App652
//
//  Created by IGOR on 29/06/2024.
//

import SwiftUI

struct InverntoryView: View {
    
    @StateObject var viewModel = InventoryViewModel()
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Text("Inventory")
                    .foregroundColor(.white)
                    .font(.system(size: 28, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Rectangle()
                    .fill(.gray.opacity(0.2))
                    .frame(maxWidth: .infinity)
                    .frame(height: 1)
                    .padding(.bottom)
                
                Text("Added (\(viewModel.added))")
                    .foregroundColor(.gray)
                    .font(.system(size: 13, weight: .medium))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if viewModel.inventories.isEmpty {
                    
                    VStack(spacing: 15) {
                        
                        Image("empty")
                        
                        Text("Empty")
                            .foregroundColor(.white)
                            .font(.system(size: 24, weight: .bold))
                        
                        Text("Add your inventory!")
                            .foregroundColor(.gray)
                            .font(.system(size: 13, weight: .regular))
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAdd = true
                            }
                            
                        }, label: {
                            
                            HStack {
                                
                                Image(systemName: "plus")
                                    .foregroundColor(Color("bg"))
                                    .font(.system(size: 15, weight: .regular))
                                
                                Text("Click to add")
                                    .foregroundColor(Color("bg"))
                                    .font(.system(size: 15, weight: .regular))
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color("prim")))
                        })
                    }
                    .frame(maxHeight: .infinity)
                     
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
                            
                            ForEach(viewModel.inventories, id: \.self) { index in
                            
                                Button(action: {
                                    
                                    viewModel.selectedInventory = index
                                    
                                    withAnimation(.spring()) {
                                        
                                        viewModel.isDetail = true
                                    }
                                    
                                }, label: {
                                    
                                    VStack(alignment: .leading, spacing: 5) {
                                        
                                        Image(index.inPhoto ?? "")
                                            .resizable()
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 130)
                                            .overlay (
                                                
                                                VStack {
                                                    
                                                    HStack {
                                                        
                                                        Spacer()
                                                        
                                                        Text(index.inStatus ?? "")
                                                            .foregroundColor(.white)
                                                            .font(.system(size: 12, weight: .medium))
                                                            .padding(4)
                                                            .background(RoundedRectangle(cornerRadius: 7).fill(Color("prim")))
                                                    }
                                                    
                                                    Spacer()
                                                }
                                                    .padding(8)
                                            )
                                        
                                        Text(index.inName ?? "")
                                            .foregroundColor(.white)
                                            .font(.system(size: 16, weight: .medium))
                                        
                                        Text("\(index.inQuantity ?? "") pcs | \(index.inModel ?? "")")
                                            .foregroundColor(.white.opacity(0.2))
                                            .font(.system(size: 12, weight: .medium))
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg2")))
                                })
                            }
                        })
                    }
                }
                
            }
            .padding()
            
            VStack {
                
                Spacer()
                
                Button(action: {
                    
                    withAnimation(.spring()) {
                        
                        viewModel.isAdd = true
                    }
                    
                }, label: {
                    
                    Image(systemName: "plus")
                        .foregroundColor(.black)
                        .font(.system(size: 16, weight: .regular))
                        .padding()
                        .background(Circle().fill(Color("prim")))
                })
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding()
        }
        .onAppear {
            
            viewModel.fetchInventories()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            AddInv(viewModel: viewModel)
        })
        .sheet(isPresented: $viewModel.isDetail, content: {
            
            InvDetail(viewModel: viewModel)
        })
    }
}

#Preview {
    InverntoryView()
}
