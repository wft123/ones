package com.hanains.webrtc.xmlparser;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import com.hanains.webrtc.vo.CounselVo;

public class DomParser {
 private File file; 
 private DocumentBuilderFactory documentBuilderFactory;
 private DocumentBuilder documentBuilder;
 private Document document;
 private NodeList nodeList;
 
 public DomParser(File file){
  super();
  this.file = file; 
  
  try {
   documentBuilderFactory = DocumentBuilderFactory.newInstance();
   documentBuilder = documentBuilderFactory.newDocumentBuilder();   
   document = documentBuilder.parse(this.file);
  } catch (ParserConfigurationException e) {
   // TODO Auto-generated catch block
   e.printStackTrace();
  } catch (SAXException e) {
   // TODO Auto-generated catch block
   e.printStackTrace();
  } catch (IOException e) {
   // TODO Auto-generated catch block
   e.printStackTrace();
  }
 }

 public List<CounselVo> parse(String tagName){
  List<CounselVo> listOfData = new ArrayList<CounselVo>();
  nodeList = document.getElementsByTagName(tagName);
  for(int i = 0; i < nodeList.getLength() ; i ++){
   Element element = (Element) nodeList.item(i);
   String employeeId = this.getTagValue("employeeId",element);
   String password = this.getTagValue("password", element);
   String name = this.getTagValue("name", element);
   listOfData.add(new CounselVo(employeeId, password, name));
  }
  return listOfData;
 }

 private String getTagValue(String tagName, Element element){
  NodeList nodeList = element.getElementsByTagName(tagName).item(0).getChildNodes();
  Node node = nodeList.item(0);
  return node.getNodeValue();
 }
}