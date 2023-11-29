//
//  WonDescription.swift
//  KakaoBankCloneTests
//
//  Created by Eric on 2023/09/19.
//

import XCTest
@testable import KakaoBankClone

final class WonDescription: XCTestCase {

    /// 테스트 진행 전 기본값 설정
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    /// 정수 형태의 금액을 콤마(,) 구분 형식의 문자열로 변환하는 로직 테스트
    func testCommaSeparation() {
        // Given
        let intNumbers = [10_000_000, 1_234, 567_890]
        
        // When
        let stringNumbers = intNumbers
            .map { $0.commaSeparatedWon }
        
        // Then
        let answers = ["10,000,000", "1,234", "567,890"]
        for index in 0..<stringNumbers.count {
            XCTAssertEqual(stringNumbers[index], answers[index])
        }
    }
    
    /// 정수 형태의 금액을 콤마 구분 + 한글 형식의 문자열로 변환하는 로직 테스트
    func testKoreanStyleWon() {
        // Given
        let intNumbers = [1_234, 12_345, 123_456, 1_234_567, 12_345_678]
        
        // When
        let stringNumbers = intNumbers
            .map { $0.koreanStyleWon }
        
        // Then
        let answers = ["1,234", "1만 2,345", "12만 3,456", "123만 4,567", "1,234만 5,678"]
        for index in 0..<stringNumbers.count {
            XCTAssertEqual(stringNumbers[index], answers[index])
        }
    }
    
    /// 테스트 진행 후 초기 상태로 돌려놓기
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

}
