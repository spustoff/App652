//
//  AddInv.swift
//  App652
//
//  Created by IGOR on 29/06/2024.
//

import SwiftUI

struct AddInv: View {
    
    @StateObject var viewModel: InventoryViewModel
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack(spacing: 15) {
                
                Text("Add inventory")
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
                        
                        Menu(content: {
                            
                            ForEach(viewModel.photos, id: \.self) { index in
                            
                                Button(action: {
                                    
                                    viewModel.currentPhoto = index
                                    
                                }, label: {
                                    
                                    Image(index)
                                })
                            }
                            
                        }, label: {
                            
                            if viewModel.currentPhoto.isEmpty {
                                
                                Image(systemName: "photo")
                                    .foregroundColor(.gray.opacity(0.4))
                                    .font(.system(size: 40))
                                    .frame(width: 150, height: 150)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color("bg2")))
                                    
                                
                            } else {
                                
                                Image(viewModel.currentPhoto)
                                    .resizable()
                                    .frame(width: 150, height: 150)

                            }
                            
                        })
                        .padding()

                        ZStack(alignment: .leading, content: {
                            
                            Text("Name")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.inName.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.inName)
                                .foregroundColor(Color.white)
                                .font(.system(size: 14, weight: .semibold))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("bg2")))

                        ZStack(alignment: .leading, content: {
                            
                            Text("Quantity")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.inQuantity.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.inQuantity)
                                .foregroundColor(Color.white)
                                .font(.system(size: 14, weight: .semibold))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("bg2")))
                        
                        ZStack(alignment: .leading, content: {
                            
                            Text("Model")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.inModel.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.inModel)
                                .foregroundColor(Color.white)
                                .font(.system(size: 14, weight: .semibold))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("bg2")))
                        .padding(.bottom)
                        
                        Text("Select status")
                            .foregroundColor(.white.opacity(0.7))
                            .font(.system(size: 15, weight: .medium))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            
                            ForEach(viewModel.statuses, id: \.self) { index in
                                
                                Button(action: {
                                    
                                    viewModel.currentStatus = index
                                    
                                }, label: {
                                    
                                    Text(index)
                                        .foregroundColor(.white)
                                        .font(.system(size: 11, weight: .medium))
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 12)
                                        .background(RoundedRectangle(cornerRadius: 10).fill(viewModel.currentStatus == index ? Color("prim") : Color("bg2")))
                                })
                            }
                        }
                    }
                }
                
                Button(action: {
                    
                    viewModel.added += 1
                    
                    viewModel.inPhoto = viewModel.currentPhoto
                    viewModel.inStatus = viewModel.currentStatus
                    
                    viewModel.addInventory()
                    
                    viewModel.currentPhoto = ""
                    viewModel.currentStatus = ""
                    
                    viewModel.inName = ""
                    viewModel.inQuantity = ""
                    viewModel.inModel = ""
                    
                    viewModel.fetchInventories()

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
                .opacity(viewModel.inName.isEmpty || viewModel.inQuantity.isEmpty || viewModel.inModel.isEmpty ? 0.5 : 1)
                .disabled(viewModel.inName.isEmpty || viewModel.inQuantity.isEmpty || viewModel.inModel.isEmpty ? true : false)
            }
            .padding()
        }
    }
}

#Preview {
    AddInv(viewModel: InventoryViewModel())
}
