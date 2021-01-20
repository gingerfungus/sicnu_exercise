//
//  WeiboImagesCell.swift
//  sicnu_exercise
//  微博九宫格图片布局
//  Created by apple on 2021/1/4.
//

import SwiftUI

private let ImageSpace:CGFloat = 6  //图片间距

struct WeiboImagesCell: View {
    let images: [String]
    let width: CGFloat
    
    var body: some View {
        Group{
            switch images.count {
            case 2:
                WeiboTwoImageCellRow(images: images, width: width)
            case 3:
                WeiboThreeImageCellRow(images: images, width: width)
            case 4:
                VStack(spacing: ImageSpace){
                    WeiboTwoImageCellRow(images: Array(images[0...1]), width: width)
                    WeiboTwoImageCellRow(images: Array(images[2...3]), width: width)
                }
            case 5:
                VStack(spacing: ImageSpace){
                    WeiboTwoImageCellRow(images: Array(images[0...1]), width: width)
                    WeiboThreeImageCellRow(images: Array(images[2...4]), width: width)
                }
            case 6:
                VStack(spacing: ImageSpace){
                    WeiboThreeImageCellRow(images: Array(images[0...2]), width: width)
                    WeiboThreeImageCellRow(images: Array(images[3...5]), width: width)
                }
            case 7:
                VStack(alignment: .leading,spacing: ImageSpace){
                    WeiboThreeImageCellRow(images: Array(images[0...2]), width: width)
                    WeiboThreeImageCellRow(images: Array(images[3...5]), width: width)
                    WeiboThreeImageCellRow(images: Array(images[6...6]), width: width)
                }
            case 8:
                VStack(alignment: .leading,spacing: ImageSpace){
                    WeiboThreeImageCellRow(images: Array(images[0...2]), width: width)
                    WeiboThreeImageCellRow(images: Array(images[3...5]), width: width)
                    WeiboThreeImageCellRow(images: Array(images[6...7]), width: width)
                }
            case 9:
                VStack(spacing: ImageSpace){
                    WeiboThreeImageCellRow(images: Array(images[0...2]), width: width)
                    WeiboThreeImageCellRow(images: Array(images[3...5]), width: width)
                    WeiboThreeImageCellRow(images: Array(images[6...8]), width: width)
                }
            default:    //默认图片为1张的布局
                loadImage(name: images[0])
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: width * 0.55)
                    .clipped()
            }
        }
    }
}

//2张图片单行排列格式。
struct WeiboTwoImageCellRow: View {
    let images:[String]
    let width:CGFloat
    
    var body: some View {
        HStack(spacing: ImageSpace) {
            ForEach(images,id: \.self){ image in
                loadImage(name: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: (width - ImageSpace) / 2, height: (width - ImageSpace) / 2)
                    .clipped()
            }
        }
    }
}

//3张图片单行排列格式。
struct WeiboThreeImageCellRow: View {
    let images:[String]
    let width:CGFloat
    
    var body: some View {
        HStack(spacing: 6) {
            ForEach(images,id: \.self){ image in
                loadImage(name: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: (width - ImageSpace * 2) / 3, height: (width - ImageSpace * 2) / 3)
                    .clipped()
            }
        }
    }
}

struct WeiboImagesCell_Previews: PreviewProvider {
    static var previews: some View {
        let images = UserData().recommendWeiboList.list[0].images
        let width = UIScreen.main.bounds.width
        return Group{
//            WeiboImagesCell(images: Array(images[0...0]), width: width)
//            WeiboImagesCell(images: Array(images[0...1]), width: width)
//            WeiboImagesCell(images: Array(images[0...2]), width: width)
            WeiboImagesCell(images: Array(images[0...3]), width: width)
//            WeiboImagesCell(images: Array(images[0...4]), width: width)
//            WeiboImagesCell(images: Array(images[0...5]), width: width)
            WeiboImagesCell(images: Array(images[0...6]), width: width)
//            WeiboImagesCell(images: Array(images[0...7]), width: width)
//            WeiboImagesCell(images: Array(images[0...8]), width: width)
        }
        
        .previewLayout(.fixed(width: width, height: 450))
    }
}
