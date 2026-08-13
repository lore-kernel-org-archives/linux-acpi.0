Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com [148.163.146.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F88381B0C;
	Thu, 13 Aug 2026 22:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.146.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786660997; cv=fail; b=h7PwfG2NdPUg0BjKBoL5pk+GQDD/C4tpemamQFHL6A9nkcTdc0C0GczGm9o9Ujfchi+2gCGXn/lmwmRQ2G5tBJRa4S7LS5jRXx099uJcX3B4pai80JbPIm0YexXGo5iFIolxU+VRDSgspsH5adtr7F69T8y3pwmJGcE0qFCPvg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786660997; c=relaxed/simple;
	bh=wH5yVl6Q0w5X7r3mS/rOGe3ZURPMWFQeqyQ6WrLJlKw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+he2mmaj54O/ddTEczKL8ITZmNhJaV+5/Yh93XTqcNkQcwAiKKguPiLOS1t2dgGTOc8vDTBMCpOi2F0l/NKULTv+cdRNoCretZCd3nGPokF7uqGg0veydYrPRObcrXWvHs9aLuPnNWlsxZZIld1QDxCspJA8qKwC3MfYQ6YAjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ford.com; spf=pass smtp.mailfrom=ford.com; dkim=pass (2048-bit key) header.d=ford.com header.i=@ford.com header.b=h4aiy6+9; dkim=pass (1024-bit key) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b=Xmwd8iRZ; dkim=pass (2048-bit key) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b=IoKjYlCB; dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b=mENztRoF; arc=fail smtp.client-ip=148.163.146.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ford.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ford.com header.i=@ford.com header.b="h4aiy6+9";
	dkim=pass (1024-bit key) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="Xmwd8iRZ";
	dkim=pass (2048-bit key) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="IoKjYlCB";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="mENztRoF"
Received: from pps.filterd (m0482516.ppops.net [127.0.0.1])
	by m0482516.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67DLXG5o1269463;
	Thu, 13 Aug 2026 15:43:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=ppford; bh=5SY
	wsHjxbJ+kf9ED5nXR+UiCU+k+Ad4Sa0424rWbZ6k=; b=h4aiy6+9YLtYQD1ZA8X
	L4b5kWbXCTzzkeYJZNAc+8j2XmTu2Ziqs/V/F1VGkmygKGJrH1ftiDJCVzOhLNFj
	4epX8DoM5L0YZyv2sTgTgSmTka4wIkorJRlC3geWvemedP3LxiikOICXKqPEYtwC
	KRGHpQOsZoAOdmlMW0W2oLw08b4u6yu46F29vpLVSXEAjfctPrDGLanHMs4Qx5GZ
	fPp9DfTSqz9Bot7x4K1C4HvAqPiT0AVH740XYmWEdp5sWWVrIZaVbkLNIAfK1JUY
	WKWmCL5gWir4xLfZVPVCYspxq9DT3Kk4h5FNfsOwTunGCaf6oHPEIJoo/mKlmuYZ
	apQ==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013019.outbound.protection.outlook.com [40.107.201.19])
	by m0482516.ppops.net (PPS) with ESMTPS id 4g1h88m2c1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 15:43:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KnL3eGRm1rOvHJRLOgv0i020Kg/3jts6eNwz8MaeNYiGLPcZvZ8rSk5ETu2UOcrV93cw9n8EHoIMmrYrCJ9CicD3g0r3cSJ9+6uhO81t4gqsNoCkSOZRDvQA00ird1OxtRLauy54f7L7b2tYW/ONI4Q1VLpXI21UCkEdG3toEPTNFleSBPCl8w7qgVkwRCkEgsalthOZihxVvr6lyPlIEgqW3RYfX/PD52lhDfNOo/5UFAmZkpE/5o3UUNOaFLNfB96a05QWkT6jCwhP3+LomEcrDZQVYzLp6GVkytEliPszK4W2eFRZHBHYe/K7sX56AMpsoy44cRw70pqk1e0d/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SYwsHjxbJ+kf9ED5nXR+UiCU+k+Ad4Sa0424rWbZ6k=;
 b=ygLJSyMr0iPZT3wW75Vjbp55/Q9TxipPzb0v2qFAyb6+rMip6039tRXj0eR5HBDZdDtnLXs/nl3LzO/j58m7lohkjPEMBBOjLu8RKC8iB70/mLFe6pwq+Kd6Y3sgbMl/1T3wf3h6J9mAtrxfasyhd8xbQx3aCJE6Rk8W0BYJuQcoZLCTYMpx/Ci9bkm563ln36CJR9tn3Gewe5NCWoyIkodiOVhmKQOopGX5bruwKJerCJV8hn9+2BWc44LuoCOT9BF81yS1IoGRs41sDa+X2BNezHW7tLmaCyyalNzUnNSqydcI1ANeCOkLze2fg/de3SxCiiptezW/GzlW20jK8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SYwsHjxbJ+kf9ED5nXR+UiCU+k+Ad4Sa0424rWbZ6k=;
 b=Xmwd8iRZQij8hVj06JcldNAjCQUb27sU8OlXroSLH7oigxDuBxRY9w+w8ytik+mSoE/cYWQWvwCF/BqC2/Mx/6/H+LlG5Ui7p4SA+NzqEobKjjdV/uWF31cZQFi7O4XgzNm3OwfVGpfXUqUVz/W6FGWE5hY7vofjLk0eySjx5iQ=
Received: from BN9PR03CA0846.namprd03.prod.outlook.com (2603:10b6:408:13d::11)
 by LV3PR16MB5811.namprd16.prod.outlook.com (2603:10b6:408:1a8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 22:43:08 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:408:13d:cafe::d) by BN9PR03CA0846.outlook.office365.com
 (2603:10b6:408:13d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Thu,
 13 Aug 2026 22:43:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3
 via Frontend Transport; Thu, 13 Aug 2026 22:43:07 +0000
Received: from pps.filterd (m0426315.ppops.net [127.0.0.1])
	by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DLVci21343738;
	Thu, 13 Aug 2026 18:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	saarlouis.ford.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to; s=ppserprodsaar; bh=5SYwsHjxbJ+kf9ED5nXR+UiCU+k+Ad4
	Sa0424rWbZ6k=; b=IoKjYlCBN2l+3TN/Q3ptiFcWR0Omx2bd6+n/ZzG4vB/bQ12
	NULFsfbDqI0mxDHkpj/1CedCst0jQWxe9sws30q1USfoOUzBhTvPlLb/izoTAihT
	A6l6Rnppq1Er+0BmG36Ox/Rpm8l8nMxS+16Kca13VYAp3UizxXzm8a9NSVT1ipZS
	tYPFo2Q2xlNJfm7Z2SKTCxsLf2/HfZPFw7X9I4+3NUrgiQzxoqyKjIWBlUEI80+B
	hDhUxMJuiFrCtrGdvWIMLlfWohvBmVSGqgk8BKY5uwNNzafSyKPXN5m8MIJR9o/L
	IqTA2eNylEAUZEYvbjDLVaZOjlwU2XIBsfJO7Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=ppfserpocford;
	 bh=5SYwsHjxbJ+kf9ED5nXR+UiCU+k+Ad4Sa0424rWbZ6k=; b=mENztRoFacoV
	LUBd+Rs2LfTcLssjD+bqn+MzcYKe1MGkziDFnh4tClJ4+Nc3GRyruAFPq4+gOYN2
	hUo9HPZabCpJzlKcbYLMa19d/5znx6ywKi4+jw8VfwV05BCf8LGEpy86AblmPnwi
	mBIH1Tet8WJUDIBId4O3dydLcvnqVOI88kByl8gyxOZJbMnnrmIpAP4EnqE1BDIp
	Iw3CvHbS9UjbRfeMbaKaFCxDRDTE9eLCGPGKcGbGjnrHWwypeoLJ315VtituBnnT
	BfSnZU51fL1VGpq6p9ev1LNcDRNsJGxsNLiYSKmP/SqmhqHLOZuc1HKOzx4dxNWB
	SIWV3FiQHA==
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com [3.215.31.156])
	by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4fxpbsnw0p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
	Thu, 13 Aug 2026 18:43:07 -0400 (EDT)
Received: from localhost ([19.12.76.222])
	by cmsmtp with ESMTPSA
	id ue8fwT1dwQLYTue8gwoPLy; Thu, 13 Aug 2026 22:43:06 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: ue8fwT1dwQLYTue8gwoPLy
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
Date: Thu, 13 Aug 2026 15:43:04 -0700
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: dmukhin@ford.com, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] acpi: bus: Introduce acpi.skip_ids= boot parameter
Message-ID: <an5IePwLSjb9lGLJ@kraken>
References: <20260813024129.905583-1-dmukhin@ford.com>
 <20260813024129.905583-3-dmukhin@ford.com>
 <CAJZ5v0iB5JkQ_xso_exDjsrbC1ezH68vTAJAh7V4XwV57AqniQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iB5JkQ_xso_exDjsrbC1ezH68vTAJAh7V4XwV57AqniQ@mail.gmail.com>
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_07,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130166
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|LV3PR16MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: a3aef960-abae-4656-e158-08def98c3ec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|6133799003|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RwSbcXCpoXnzOb4HkPSMFNIEVO+gkIK13kmQBEpmIir2Ed1fMr027kr6l6QT6Mxd04suuH6TbVY6lU5+KjrqVkiVyRlVmPo33jv8mc9BiMJ2EMH+e3k0csRv8pB++oNp8x/bPZTuXDNFLLNCZ86vw6AJppjca6N3aFNx2BsYtidS5ZpjZbBUNffiQbqlRhXap3WV66hkNLiVaRc+QN5lhkgEj7VhCYB5ocGsiwaQjRy3cvSOqN65QDxUz6OU83RcTEWTMJG7jg2kHUVFPWlwPKJ3ClM7zKU1qWKUbe1EdM60mAuUnhg+1Vh+PloMwZ4N8I6kxG9Lxsfz//2HJ49P7z+BNRamrSZv6lt5S12GpjW2zN4VdWq/5YA4Am27s3K8D6/91awqWRGhV+hyll/Rjg8oq6p/GPATChb8pBB60vUe9cpv9W7nDaDTRd1Xj4TxCqTIqihmD3M/hGB1sP2sgqw51OD2vrx8/78TK2ctIqykYJuUPOrEBJaGTz2nStDp9ZWmW4IIDgJQ2Ces8fuQWufffsvJlvSpQ8kSCMBsbXAV3d8QC8UbBZR7DkkAUyoifqLW4YPEJ3/rWbJIE522L0QzRabvHKPTTkFpZsdFUTZikdg86it10l9xsgO/w5ZzDR2/HCdQhvGmtlz/wrz24HLjRdWsJM48cWNbZGLOBGJOlvvFcrl5E8l6YA1xZ346K+eLxzGxRtRoDZMH3B1rvg==
X-Forefront-Antispam-Report:
	CIP:148.163.138.245;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mx0b-00498f04.pphosted.com;PTR:mx0b-00498f04.pphosted.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9A+3Ua1cUkCqMtwDMzx9FBjKwCiv+0gE7PQMRYib3IrNj8T5PFXSpdRVgJgCv1g69WRc6N28/3YvSW+5USBEIoOGIYnXl5ojMInqvTN2TD5i3zB720jVH0F7W1lSMGa/JTIkc6LzNhoN/oygsM3pRRc2fTFY1abxsabUjy7P2ZflVubpsQM90DZcSF2Tzk3isk8iBnFmUPey0THqkSb8yoSYkvOS7mntd8eP756uyGVLe5lLrZrNLs8YvCEEbyFkE+N4Xuu9o8KIYnoA0AhWoWBmO3gTda5a4FD2D3kKHazFYIKkcllPI1qipkqJCp9rZ0VK5kICBEAFsi57O6NYu5y69W4Hed73HjvX240o++cR5aTrJFXti2BWf7ARrsU+tZARNt6QETc5kNhMFFDFgG4Hy17GRXLgyGcIh49pP8u+RrfTmk1xWDEU3KrOuwBw
X-Exchange-RoutingPolicyChecked:
	jco29c0R+Ayn2HNBafnY0Ms7vwLTlnyRrNu+kCvtz+oj2dbI2faNB0gBJucgARGhZTDubk3n1P+tSwXnYBohXOY+fRr5IzXL/A+ErGaqXOz0xmdBPbwtMbsa5BrQBbj1t0w7wTXUAoYPso2MkUurDc9HP4UDtZzd+CpfVQHkuhRxwBkMqqiI1mwbszv2UaGf4RrwhNVE6Arll+JkheHuFA1ok4lWitu0+Fzs7hU8p6OxU1sD4cNRktNo1W+buAg0dWNT2OLxEgY4r5XlnwPVGH3/UmXuB/ZnHuuabhNO6d6hQCJayBOl7WDzik3mWGp4nUoVbpt/iscwKTK2GcuEhA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PLfFlcPBV/eQCE7KXjkicwZM5FOSkaAWWxcRn4qEg40fAC7vtLFqsiIyn2Ulu9+5k2Z+VHLKiLBoXr3n6mHjSjwGFYh3mrye1ViNLHEXg6xRXU9dYoayCvvxaOVtlpKpeh9evsfKHUPnZe8cWy59weoax+pPpfj3DgnIMA4TJ7oxKWGPuTPPs+Q7TvvK+jyVuPQbO1JbdJoclV2cdfk+M+AU+IM6kTVXwYCAolLgm0/SDoJrdfMUbOE5mN/5RNff+fj8miRvQcq+fuutLEYI8/7y2d2QIvXNlV9gKR/Hb3PCzpe+rEh+t4GFiTydrCzHcmGVn0fohWF8PCp+WSc6mhG4y3PrvbnN/QSc4amu+deuVdr1GrSc2ltVfhJ5FGy1zyPaoWxYjmHziJChrKOBYmOn7DX7XvXenBogyO4LomZ2fJtVdKjQrzoZ0cSThfLkjUAyrQHDWohqiTLhOwfQtOrIULendmwHPtt9o6iZPUO+MamNYeCoGo/ANLf87DODG2yNdS5GtHQdLGF8FlL1vcPnPndQ4xz7vt7uHU1/lSe3ZBhTvUCnd5mU92V3kAfYZi6CJqnLzzcIMtCSxPApVHfeLQJ0ND4QV9OgRhlTovr95txzxpYn4ET3sP/4Psc9iRiZ9Lerjr8YHBde3bN2pQ==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 22:43:07.5845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3aef960-abae-4656-e158-08def98c3ec2
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0;Ip=[148.163.138.245];Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR16MB5811
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDE2NiBTYWx0ZWRfX68+US54GhEVL
 iIlDWLf+7rEYGI1We3ogoNcgEdVOqAxLJsTmZMXzgG4d50cQCeE+yXIO6eHrwkaSufbZnkDBJUi
 3TlBdlVgPW/M3x12XOPZguDeGS9jgioIwU18Ug2HVuCwgOPRX3DT
X-Proofpoint-ORIG-GUID: 3-3Lnu0CdXN18l3Wi9CYXENDdbEgIDnE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDE2NiBTYWx0ZWRfXyL3/PRDdQydT
 +j7JGh67lvknvXSftY9q7j7MDAJ/viVviMHD1u7tMciKooHjeDse8uJCY+nGtaRiiHCfZyk03WM
 agqaF+0fsjBtN11zOEoFwj/xGIfuvwLXZx8B8RU5DXfhjSPhEgD87DvhiMFLSLF/E01erjIdeY5
 IKFrKYd8ShiMPCmBSn74zLd6hp2dJ7QVOVqAlZ/z7KNEkdshNZZlf2LHfx06ahiZLd0LY33TgL3
 8SLuIQdKqKe1hyS/rIDkuu6vmETyltnzVyhdsnbPpxlkgfhF78kXIJ3yLm/UaATYIxc0aFrTwth
 aEFrI2SOFQ5KPSLmVzFR24j9dUP033Xxzk6j6z7ZlXWWiIj+2LXroNe8zzQ7utdqfWBS9XKGMbl
 /upA4Qf9JkagvsqSjyaLKDK4q+eTTJ8x4QKn6QViqEpfDF9Rc98zmx/UA7mnmmCGn66HO55rzSe
 pMWGhD1kAkLnRZpHi5g==
X-Proofpoint-GUID: 3-3Lnu0CdXN18l3Wi9CYXENDdbEgIDnE
X-Authority-Analysis: v=2.4 cv=Xda5Co55 c=1 sm=1 tr=0 ts=6a7e4881 cx=c_pps
 a=UA+Ybm6NSixuq697YtHT5A==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=3PXLN80vpJUA:10 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P_n1zlmtWsCQbjROFjcg:22 a=NvsXeTrgx-CJMFV-xl94:22
 a=cbNQJ9GKAAAA:8 a=WrgTi4t3HTPjek_z4TwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=G69WFyCBNqGPyalROSdv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_07,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130166

On Thu, Aug 13, 2026 at 12:09:41PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Thu, Aug 13, 2026 at 4:41 AM <dmukhin@ford.com> wrote:
> >
> > From: Denis Mukhin <dmukhin@ford.com>
> >
> > In virtualized environments it is possible that a device managed by the
> > hypervisor or another VM is described in the ACPI tables. In these
> > cases, binding a device driver to it can cause functional issues.
> 
> Examples, please.

One example would be a system with two MMIO-based UARTs described in ACPI
tables. Both UARTs have the same _HID, but different _UIDs. One UART reserved
for the hypervisor console, another is assigned to the guest.

Both devices reported as present and same platform driver may probe both device
instances.

I understand that, ideally, guest ACPI tables should omit the unassigned
device or report it unavailable via _STA.

The proposed parameter was intended for configurations where the device
assignment varies between boot environments while the firmware-provided ACPI
description remains common.

What would be the preferred way to prevent Linux from enumerating or probing
one specific _HID/_UID instance in such a configuration?

Thanks,
Denis
