//
//  HttpUrls.swift
//  Class
//
//  Created by 马腾 on 2024/07/28.
//

import Foundation

let baseURL = "https://api.hikids.blog"                                 // 正式服务器
//let baseURL = "http://api-test.hikids.blog"                             // 服务器生产环境
// let baseURL = "http://b73irr.natappfree.cc"                          // 云鹏电脑测试

let loginURL = "/v1/login"                                              // 登录接口
let checkTokenURL = "/v1/system/user/list"                              // 检测token
let getKindergartenURL = "/v1/business/hikidsTask/getKindergarten"      // 获取园区围栏信息
let getDestinationsURL = "/v1/business/kindergarten/destinations"       // 获取目的地列表
let getStudentsURL = "/v1/business/kids/getAllKids"                     // 获取班级孩子列表
let getAssistantURL = "/v1/business/assistant/getall"                   // 获取助教列表
let destinationInfoURL = "/v1/business/destination"                     // 目的地信息
let studentsLocationURL = "/v1/business/hikidsTask/uploadLocation"      // 查看学生状态
let taskAddURL = "/v1/business/hikidsTask/taskAdd"                      // 创建任务
let getTaskURL = "/v1/business/hikidsTask/getNowTask"                   // 获取当前任务信息
let changeTaskStateURL = "/v1/business/hikidsTask/changeStatus"         // 修改任务状态
let getSleepTaskURL = "/v1/business/sleepTask/getTaskInfo"              // 获取午睡任务接口
let getSleepReportURL = "/v1/business/sleepTask/getSleepTaskReportInfo" // 获取午睡报告接口
let getTravelReportURL = "/v1/business/report/travelreport"             // 获取散步报告接口
let getTaskWithCalendarURL = "/v1/business/hikidsTask/getTasks"         // 根据时间获取周报告
let getMonthCalendarURL = "/v1/business/hikidsTask/getMonthTasks"       // 获取一个月的报告
let getPDFURL = "/v1/business/hikidsTask/getSleepReport"                // 获取pdf地址
let getKidInfoURL = "/v1/business/kids"                                 // 获取小孩详情
let getInfomationURL = "/v1/business/hikidsTask/getCorrentTaskInfo"     // 获取情报
let setRingNumberURL = "/v1/business/teacher/setRingNumber"             // 设置警报铃声
let getWarnStrategyURL = "/v1/business/hikidsClass/warnStrategy"        // 获取报警灵敏度
let setWarnStrategyURL = "/v1/business/hikidsClass/warnStrategy"        // 设置报警灵敏度
let stopWarnURL = "/v1/business/hikidsTask/stopWarn"                    // 手动停止报警
let changeWalkWarnURL = "/v1/business/hikidsTask/warnStrategy"          // 活动中修改报警
let changeModeURL = "/v1/business/hikidsTask/changeMode"                // 切换乘车模式Mode
let helpURL = "https://yohaku-bunka.notion.site/Q-A-66b097ecd75f4103938c30238525e677?pvs=4" // 帮助页面


