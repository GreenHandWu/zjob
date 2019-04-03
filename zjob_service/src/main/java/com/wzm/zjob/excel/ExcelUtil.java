package com.wzm.zjob.excel;

import java.io.OutputStream;
import java.text.DateFormat;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.util.CellRangeAddress;
import com.wzm.zjob.entity.Order;


public class ExcelUtil {
	//将数据导出到对应的excel文件
	public static void exportExcel(List<Order> orderList,
			OutputStream outputStream){
		try {
			//1:创建工作簿
			HSSFWorkbook workbook = new HSSFWorkbook();
			//2:创建工作表
			HSSFSheet sheet = workbook.createSheet("订单信息");

			//设置行高
			sheet.setDefaultRowHeightInPoints(20);

			//设置列宽
			sheet.setDefaultColumnWidth(18);

			//合并单元格
			//将第一行的第1到第6列合并
			CellRangeAddress cellRangeAddress = new CellRangeAddress(0, 0, 0, 6);

			sheet.addMergedRegion(cellRangeAddress);

			//创建行
			HSSFRow rowTitle = sheet.createRow(0);

			//设置行高
			rowTitle.setHeightInPoints(40);
			//在该行上创建一个单元格
			HSSFCell cellTitle = rowTitle.createCell(0);
			//设置样式
			cellTitle.setCellStyle(createCellStyle(workbook,HSSFColor.RED.index,(short)18));

			//添加文字
			cellTitle.setCellValue("订单信息表");

			//创建表头,并设置列头
			//创建第二行
			HSSFRow rowHead = sheet.createRow(1);

			//创建一个数组，用于保存列头值信息
			String[] titles = {"序号","企业用户","产品","购买数量","总价","创建时间"};
			//遍历该数组，将值写入对应的单元格
			for (int i = 0; i < titles.length; i++) {
				//在列上创建每一个单元格
				HSSFCell cellHead = rowHead.createCell(i);
				//设置样式
				cellHead.setCellStyle(createCellStyle(workbook,HSSFColor.BLACK.index,(short)14));
				cellHead.setCellValue(titles[i]);
			}

			//遍历students集合，将内容写入excel表
			if(orderList!=null){
				for (int i = 0; i < orderList.size(); i++) {
					Order order = orderList.get(i);
					HSSFRow row =sheet.createRow(i+2);//从第三行开始
					HSSFCell cell0 = row.createCell(0);
					cell0.setCellValue(i+1+"");
					HSSFCell cell1 = row.createCell(1);
					cell1.setCellValue(order.getCompany().getCompanyName());
					HSSFCell cell2 = row.createCell(2);
					cell2.setCellValue(order.getProduct().getProductName());
					HSSFCell cell3 = row.createCell(3);
					cell3.setCellValue(order.getProductNum());
					HSSFCell cell4 = row.createCell(4);
					cell4.setCellValue(order.getOrderSum());
					HSSFCell cell5 = row.createCell(5);
					DateFormat df = DateFormat.getDateTimeInstance();
					cell5.setCellValue(df.format(order.getCreateTime()));
				}
			}
			//输出到硬盘
			workbook.write(outputStream);
			workbook.close();
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		
	}

	private static HSSFCellStyle createCellStyle(HSSFWorkbook workbook, short color, short fontSize) {
		
		//设置单元格样式
		HSSFCellStyle cellStyle = workbook.createCellStyle();
		
		//设置垂直和水平居中
		cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);//水平居中
		cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//垂直居中
		
		
		//设置字体
		HSSFFont  font =workbook.createFont();
	    font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);//字体加粗
	    font.setColor(color);//设置颜色
	    font.setFontHeightInPoints(fontSize);//设置字体大小
	    cellStyle.setFont(font);
	    
		
		
		
		return cellStyle;
	}

}
