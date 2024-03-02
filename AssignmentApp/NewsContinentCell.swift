//
//  NewsContinentCell.swift
//  AssignmentApp
//
//  Created by Nayan Sayare on 21/06/22.
//

import UIKit

protocol NewsContinentCellProtocol: AnyObject {
    func didSelectAnotherSection(with sectionSelected: [SpecialReport]?)
}

class NewsContinentCell: UITableViewCell {

    @IBOutlet var viewcontainers: [UIView]!
    @IBOutlet var lblTitleArr: [UILabel]!
    
    weak var delegate: NewsContinentCellProtocol?
    var model: DailyBriefings?
    
    func configureCell(with model: DailyBriefings?, delegate: NewsContinentCellProtocol) {
        resetView()
        self.delegate = delegate
        self.model = model
        if let _model = model {
            if _model.asia?.count ?? Int.zero > 0 {
                viewcontainers[0].isHidden = false
                lblTitleArr[0].text = "Asia"
            }
            if _model.eu?.count ?? Int.zero > 0 {
                viewcontainers[0].isHidden = false
                lblTitleArr[0].text = "Europe"
            }
            if _model.us?.count ?? Int.zero > 0 {
                viewcontainers[0].isHidden = false
                lblTitleArr[0].text = "U.S"
            }
        }
    }
    
    func resetView() {
        viewcontainers.forEach({
            $0.isHidden = true
        })
    }
    
    
    @IBAction func didTapToSelectAnotherSection(_ sender: UIButton) {
        if sender.tag == 1 {
            self.delegate?.didSelectAnotherSection(with: model?.asia)
        } else if sender.tag == 2 {
            self.delegate?.didSelectAnotherSection(with: model?.eu)
        } else if sender.tag == 3 {
            self.delegate?.didSelectAnotherSection(with: model?.us)
        }
    }
}
