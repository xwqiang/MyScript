package com.hskj.common.util;

import java.util.HashMap;
import java.util.Map;

public class MyLevenshtein {

	public static void main(String[] args) {
		//Ҫ�Ƚϵ�}���ַ�
		String str1 = "424224";
		String str2 = "afarfwr24545535";
//		String str1 = "���,��λ����ѻ��[169]��,��ӭ�ٴι��١��~��ù�l��";
//		String str2 = "���,��λ����ѻ��[25]��,��ӭ�ٴι���!���~��ù�l��";
//		String str3 = "���,��λ����ѻ��[437]��,��ӭ�ٴι���!���~��ù�l��";
		System.out.println(levenshtein(str1,str2));
	}

	private static Map<Integer,Float> levenshtein(String str1,String str2) {
		
		if(str1==null||str2==null){
			return null;
		}
//		String tmpStr1 = str1.replaceAll(" ", "");
//		String tmpStr2 = str2.replaceAll(" ", "");
//		if(tmpStr1.length()>1){
//			str1 = tmpStr1;
//		}
//		if(tmpStr2.length()>1){
//			str2 = tmpStr2;
//		}
		int len1 = str1.length();
		int len2 = str2.length();
		int[][] dif = new int[len1 + 1][len2 + 1];
		for (int a = 0; a <= len1; a++) {
			dif[a][0] = a;
		}
		for (int a = 0; a <= len2; a++) {
			dif[0][a] = a;
		}
		int temp;
		for (int i = 1; i <= len1; i++) {
			for (int j = 1; j <= len2; j++) {
				if (str1.charAt(i - 1) == str2.charAt(j - 1)) {
					temp = 0;
				} else {
					temp = 1;
				}
				dif[i][j] = min(dif[i - 1][j - 1] + temp, dif[i][j - 1] + 1,
						dif[i - 1][j] + 1);
			}
		}
		float similarity =1 - (float) dif[len1][len2] / Math.max(str1.length(), str2.length());
		
		Map<Integer,Float> map = new HashMap<Integer,Float>();
		map.put(dif[len1][len2], similarity);
		return map;
	}
	public static float levenshtein1(String str1,String str2) {
		
		if(str1==null||str2==null){
			return 0;
		}
		String tmpStr1 = str1.replaceAll("-&&-", " ");
		String tmpStr2 = str2.replaceAll("-&&-", " ");
		if(tmpStr1.length()>1){
			str1 = tmpStr1;
		}
		if(tmpStr2.length()>1){
			str2 = tmpStr2;
		}
		int len1 = str1.length();
		int len2 = str2.length();
		int[][] dif = new int[len1 + 1][len2 + 1];
		for (int a = 0; a <= len1; a++) {
			dif[a][0] = a;
		}
		for (int a = 0; a <= len2; a++) {
			dif[0][a] = a;
		}
		int temp;
		for (int i = 1; i <= len1; i++) {
			for (int j = 1; j <= len2; j++) {
				if (str1.charAt(i - 1) == str2.charAt(j - 1)) {
					temp = 0;
				} else {
					temp = 1;
				}
				dif[i][j] = min(dif[i - 1][j - 1] + temp, dif[i][j - 1] + 1,
						dif[i - 1][j] + 1);
			}
		}
		float similarity =1 - (float) dif[len1][len2] / Math.max(str1.length(), str2.length());
		
		return similarity;
	}

	private static int min(int... is) {
		int min = Integer.MAX_VALUE;
		for (int i : is) {
			if (min > i) {
				min = i;
			}
		}
		return min;
	}

}
