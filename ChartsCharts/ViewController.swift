//
//  ViewController.swift
//  ChartsCharts
//
//  Created by 준수김 on 2021/09/30.
//

import UIKit
import Charts

class ViewController: UIViewController {
    @IBOutlet weak var BarChartView: BarChartView!
    
    var months: [String]!
    var unitsSold: [Double]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //데이터
        months = ["섭취 칼로리", "소모 칼로리", "잔여 칼로리"] //각 막대의 이름
        unitsSold = [20.0, 4.0, 16.0] //각 막대의 수치 삽입
        
        //데이터가 없을 때
        BarChartView.noDataText = "데이터가 없습니다."
        BarChartView.noDataFont = .systemFont(ofSize: 20)
        BarChartView.noDataTextColor = .lightGray
        setChart(dataPoints: months, values: unitsSold)
    }
    func setChart(dataPoints: [String], values: [Double]) {
        //데이터 생성
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
                dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "칼로리")
        
        // 차트 컬러
        chartDataSet.colors = [.systemBlue]
        
        // 데이터 삽입
        let chartData = BarChartData(dataSet: chartDataSet)
        BarChartView.data = chartData
        
        // 선택 안되게
        chartDataSet.highlightEnabled = false
        // 줌 안되게
        BarChartView.doubleTapToZoomEnabled = false
        
        // X축 레이블 위치 조정
        BarChartView.xAxis.labelPosition = .bottom
        // X축 레이블 포맷 지정
        BarChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)

        
        // X축 레이블 갯수 최대로 설정 (이 코드 안쓸 시 Jan Mar May 이런식으로 띄엄띄엄 조금만 나옴)
        BarChartView.xAxis.setLabelCount(dataPoints.count, force: false)
        
        // 오른쪽 레이블 제거
        BarChartView.rightAxis.enabled = false
        
        // 기본 애니메이션
        //BarChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
        // 옵션 애니메이션
        BarChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInOutBack)


        // 리미트라인
        let ll = ChartLimitLine(limit: 10.0, label: "타겟")
        BarChartView.leftAxis.addLimitLine(ll)


        // 맥시멈
        BarChartView.leftAxis.axisMaximum = 30
        // 미니멈
        BarChartView.leftAxis.axisMinimum = -10

        
        // 백그라운드컬러
        BarChartView.backgroundColor = .yellow
        
    }
    

}

