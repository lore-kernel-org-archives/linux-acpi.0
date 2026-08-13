Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com [148.163.143.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6CC2C3266;
	Thu, 13 Aug 2026 03:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.241
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786590575; cv=fail; b=bibkd2WrdwhuNXko+k6dTgNH/zFGpqUivw1AtACWIa4aUT8wcL72a/n02ovQazf8f4cqkmBOWExW+YUIGPPHNAAynfzARr0eNFJdafbswl5eO7u0YRHR5gPrDIkhu8uJgyibJXoNfZ8+P+FcXFeHa/CcNK26a9i484LtirJk03A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786590575; c=relaxed/simple;
	bh=uqNH+plQCDY6WS/grj9g9klfZYZVxSCmKbb0u7NfpL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qWKhCaBEGtNNApCnHWOJrHEC0LKCIes7DwrR3xW8L3+84pyDOf1efVoUSj2EP/WQ5fBxxbc4S8RpfM46gBSaI3qQSYnITK0gSH5rjTQgnbC9+sCAJoLdnt9wXa7ACfsKFUMIKdIBy+pWAMfnrOAQjQs0NKlzJwb0yst8J3q/Nyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ford.com; spf=pass smtp.mailfrom=ford.com; dkim=pass (2048-bit key) header.d=ford.com header.i=@ford.com header.b=wdcsccSS; dkim=pass (1024-bit key) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b=S2VK2ku3; dkim=pass (2048-bit key) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b=eYh7TkE2; dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b=LW5Ir6B2; arc=fail smtp.client-ip=148.163.143.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ford.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ford.com header.i=@ford.com header.b="wdcsccSS";
	dkim=pass (1024-bit key) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="S2VK2ku3";
	dkim=pass (2048-bit key) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="eYh7TkE2";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="LW5Ir6B2"
Received: from pps.filterd (m0367128.ppops.net [127.0.0.1])
	by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D2Jk1i2466426;
	Thu, 13 Aug 2026 02:41:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=ppford; bh=H2TDDn4zhQx8mYfM8iwfvgCjE
	c9AC7xGCiHx8d+Otcg=; b=wdcsccSScCWemJrhhT+4m8Y2Le1X+54WbjrlNKFoI
	v1aBGlCTgcggMimQnwVxT/F9svqQ3TRGtezJA58vie1bj8z378JsydNhqcpGIVCG
	mrLGEiYrCRXUF8CpaqqVCSPsMw2e4nNGWVSCYtt1/nMX5OTuTbuUUSd3Xg6dNPxL
	kWW7mDdixuUawp9ux86qBJyFwpiUBm+9ZtsTKeRw7QVqAHQalt48+gJJg7r1X32U
	N98VnQ/4UnBbb22lMK4uEEE3Vgq7zYq/L8gjUfIDSJO8YOF9CWfvDbG5SlTpAOYy
	q4h+9ZIA0w6eak9bSol+y/J7BoNd0Fxg4tdNXzwC8xSpw==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011022.outbound.protection.outlook.com [40.93.194.22])
	by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4g10gyj25q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 02:41:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVg/AQmgl5RObdZCnutlukRzgLZabdMq18hUEleGfMHVlvIwiF3/zT13TmMKAI41ZLqsMQjrk72sRnAttXhoQ7pploPExiIRZ7Hcps1Vf0UFGZvrtG3r2+3AfE3xw4ZC3+2GrBSJ94tBZ+l95+CY/ey+x67I1H7DMSWh//rLknQdKnj8LfN6zEl6pq2ias+lkGcFwbLfgtEkHLj9Y4rz5zdz9Sp9mL+lkY6UVTNyqLgSKyWibnq7f4LUMC0NE++CQJzAp7nrAGSNz4e0gaOW1d7+TD9leOpksxNYoipskqM0Ln2u2KtBnPt+Hk3NDsC8nwZhD1BdIZI4GzYws2ZwCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2TDDn4zhQx8mYfM8iwfvgCjEc9AC7xGCiHx8d+Otcg=;
 b=IutixqVUiojJDBnjMXWdxwgzUFKgz3GnekiJWccwHIDFKfv9fXFpz5tjYWcsiYGKgy/4g6mHq1Y1LEsGM/28JYoCuQMUuYDvhJmRhokD7y7TFumiShimZcO+XONZIPtdperGl9tnOlWAM//QR+VaXEqVPi/WxcRNaZl1tr44jO8pjBPTy43NN01AEKF1xAyAMYVcaqkQaG3zxNhnWYdF8RM7PpnHDnCpt6MiyZscA1v/unH5SE1CvFXden8H3baOnSH5Xf0G1NSTcV1Gu8QQAwbUkS9VaK8Vamf8W2N0lR1plGKttglnFjWa59TdRRpX0eiIuVK7cubTUyz7LhpzdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2TDDn4zhQx8mYfM8iwfvgCjEc9AC7xGCiHx8d+Otcg=;
 b=S2VK2ku3nFa0wbLUTwwJj0J+PKY1Vxe5Bd4KpZ5iSm13As1/XoQlB/VLqz6GS4pff1GCvEBlFfYEPbeZcYWLCm4gTgUgOtx6/xRTfryuCNEzgAwbmCJNfN7rA0873s8PuzRDdC4cMNg1Fx/2ecMUpWQCLV5v6AFk4NjkJLzY2OA=
Received: from CH0P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::32)
 by DS5PPFFE37258D0.namprd16.prod.outlook.com (2603:10b6:f:fc00::7eb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 02:41:35 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::9d) by CH0P223CA0001.outlook.office365.com
 (2603:10b6:610:116::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Thu,
 13 Aug 2026 02:41:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3 via
 Frontend Transport; Thu, 13 Aug 2026 02:41:35 +0000
Received: from pps.filterd (m0373460.ppops.net [127.0.0.1])
	by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D2Llwa3100805;
	Wed, 12 Aug 2026 22:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
	:message-id:mime-version:subject:to; s=ppserprodsaar; bh=H2TDDn4
	zhQx8mYfM8iwfvgCjEc9AC7xGCiHx8d+Otcg=; b=eYh7TkE23uud7gkEBKWqWS2
	J/xe1xeARrtMXFHxa7TSo4plpWQNwhdv6IR4HzHVXMYG6shJV7XH73kw25NEtOqP
	ZtEKY1MU3Z4YT1M6SIRVEeblLFDTOftc4r4OTzwdmlZDLM8c4qc4yQHDOz554fgK
	+wyja0oiDz+O8ozst9fpb+tckGNDvEPXKI1M/++ctDtPfCW1wjf4jwpvzdm3cetW
	24pudDn5pgTv1Q1Pqke1CNsjIgP65c7V2vedKNfQn/3Agq6AKnUMxsynMh+7uGdZ
	TgEEucJC6yAtVQNnVGjlbeFfGeMEVHiXEoG/Sp+WVC9VAF5sHWej1QyK8MfvkfQ=
	=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=ppfserpocford; bh=H2TDDn4zhQx8mYfM8iwfvgCjEc9AC7x
	GCiHx8d+Otcg=; b=LW5Ir6B2HbfuOv5oa3vSBG7thjgMz90Yfyk2LLBY4oeoqGV
	cQyCmz/OoWfk3pSS/DaxajySNyfOikyO4HBeViDFvn48kUtvf/t3RZunR7F2sEti
	xUE8WHMN+Nv9B1MrcYYA/QQCExdJgSM3TNPKE9P3gUyraF267AulOmr7bUY+arbC
	hwuXoyzFXMaAED4tHuxVmBUGRaH7zw8ioEZ+S2qIivP1Hgfuy2mlXwL9h8k5fYlB
	4lIApapsZhQFeIY4i9jQqCFHkE6u55ZxgaMlnta7JdqOWfqwub6AnA+xLV6fGZgn
	Ol2bFii8CwvBQ3lV6DqSTmbk6rAFkuc2hPwQFyw==
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com [44.208.76.22])
	by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4fxnaxmwys-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
	Wed, 12 Aug 2026 22:41:34 -0400 (EDT)
Received: from localhost ([19.12.92.221])
	by cmsmtp with ESMTPSA
	id uLNswZkgkyclKuLNsw45g5; Thu, 13 Aug 2026 02:41:33 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: uLNswZkgkyclKuLNsw45g5
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Denis Mukhin <dmukhin@ford.com>
Subject: [PATCH 0/2] acpi: add kernel option to skip binding drivers to certain devices
Date: Wed, 12 Aug 2026 19:41:27 -0700
Message-ID: <20260813024129.905583-1-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130017
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|DS5PPFFE37258D0:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a0318542-6ca5-4458-3221-08def8e46477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|10067099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	GrxGo9DocANM4bBcaSVTLIsgh0DU30p6+Mfk5Y96yuitIbT4WLCW2dSbkSR7G8zrmpdOXs/5JA7jt09slHvrBgllrBVKAzew0opzQtn4wStTxOxNMNnudZCcduX6RF2qE7sXZo3E2cKO4PWuD5c5kIVBC1QNjdJQicIpZ3huqHp2jXU3vsrHFWVZaiNoXw4aMNch/swMkRbJVil173gnoLnpHUABkC1/AXezG/DvdGx0kb/SiQZ//ai/InkSdeH/d7hw50PeVVEbpVJPxuTLsXYInhJ0BPVF/UVEl+vv8b1eeXixpTdj1+mq34m7lezbV4wddLHoZIsXW8E7k4bDQibO1z5LCAe1mCxZmNhXIXVWM07Hvq8jM5i/LGShBa9GCb3C0AXbI3zhf/EBXgF18Wuuihb2h7vCLx+D2NR2B8+mRrKgbeEgm02Jk446zbB9JLBLDeiMfK45ruBXR5Wk77FsUdRDGNWG4u4tIJSMsSERKSETrbzD+ILMWiG7folZF05SIyGvhzVHG4H2TXTCnPcgdzoo0/BLXvJo3Udkf4SHtFT1wJsKnooNpOpuzirLZWsFWPTeTHFyTNGqkBiOzdjhN2zTKPwzvsT5mWsA2JrFePWYxjHRITd3rmK3Xj8rmeF6OiY/jPceNoN2+RQPAkH3bmOKOrKT+hNk8PIh6E62cIthR9JaUUYzgn4OborPYD+4gbPQtAuGFQDTqJTyZw==
X-Forefront-Antispam-Report:
	CIP:205.220.161.53;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mx0a-00498f04.pphosted.com;PTR:mx0a-00498f04.pphosted.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(10067099003)(56012099006)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vvqFUSP259vthw1lGH/7jBIT06UNghtb6KMNFY4Y8SsC7AjuToB232dNrViTzn9hYlGcK/ZAbRbbNH/ao/Lz4ibCgxyPglt7aLpW8SdzHyhV2XNP2Czfnbtj94nHs98eE4u/7E9HtBCO3GitTOFfOSKtTZAiEA0uyg+jOHO9b7pQ0PbOuwO8SXZ0KiX2wz8t4Vmp1Aq34wAZomNlP/sCMpg4gOhZq1lvJetUdT09HfK4mLsH3SLr2c3a8hamN+99GPMs5y4vO0d0AacBiTdZqiPi8sHrgzTn2AbRYywmZczrH0Y5wnj/2rLYdYkZXNUV95+SHOXTaj6CEMJOEq8VeIVIpEyF302vFRKGRYyqGPARQN+K1/IE0Ts7XQmaXPhxU+6V144/5Xu3shKdw55vRkKnxjj3INTg7ufALTrjF4yx8WuoQ5IV9p1YHprNJR1Z
X-Exchange-RoutingPolicyChecked:
	ET/+/UTPnjT2FCRVu6BRFKghlcfdxR0H8jFGh5wLPEpTSm0TMD0bS8Yz+pVVIL7dBNoQX3oUNmYOviQN1qSXWRgGTTodwGZkSsZ6KteXSruwUPO7xI8xoiV6ruFfaWD7wM/fyVScZniAU707f7/ktvW4Zp5BjtokobW96fJD4wbSfWqPPTg1S2Z69DCFrTUFNo8U/Z/DoBlOX5j5rbwiq8RE+33jwO++w6Ks6QPbm/p4d2xuyNMmncb9aMe5CIGolYc0mQVtnhZ/KX2QoBurRSPZ5DnI/lA37yPqE/vrDR3NoN43aGQQGRzGoWSjT+TjIAzs0BJCDfckrHHOvaSYzg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jbbvlPoQwPLJZQQ6G7HLFI601czssEg7jNPxC3hdh9+BAknJuZ72b4vcINxpM5mgEtQLQGQrxLeS7XgAWbpM6DkWD5RV3dcP6a92qO0kBrzkqEvuP1puFibRgxnJ63vW8GpITommsfnCXEIpGDVnlKcq6YlTeHA2fNQ0hkbIZTD45WcBp/vrOE7RaqstdRduStUGdQpYHuaJ0gG+DZU8H36IanTKuA3LXDnaBwupsyNtRQ0vNYaAImJzmWCeIEPn2g8d7fGtsmM/9yUke+BqGbUeJmoiaD4pjy+vAhXbPYqSMpT11SHCJ/eDUXHmbeflWCDOpwuRUYKAnAGgAcIs4jHQJ062cryqbWJtyAcBveK1SMCiPBDmpgoSr6ERuohAECCeDE6aRo/N10AjbzedGReuHFh68S/zRRV0Jo4KpESfHu1SEbZDucx8KKrfQNFdBJSXeny55+Pi32H3AIfDWMX7hVxjMDc+6DDu94NVxHcea0jW45H9i1F/TL99XnrjWXsu/pmI9zhoOf2+zszxhx0DoaO2k2q6MSnXrcaWka1WtaVHoEMbYj2a9jyg9cys/P3X4h0GhEyfMl1vL2xkotwFEt0YEcD2Owt9L7bOAnLgc3fJHtSJBrB/djtuiESazjoBHZ0Ew5m129DujlVJRw==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 02:41:35.3240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0318542-6ca5-4458-3221-08def8e46477
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0;Ip=[205.220.161.53];Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFFE37258D0
X-Proofpoint-ORIG-GUID: 9pC_IR__5SFFhQyEsEHtpVRaNYr3c2om
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDAxNyBTYWx0ZWRfX83hfDtg3lJx0
 SAZE/g++HMX7fbtYeQM01Rr9rWgvrga1ED5ms4ymhmBTSKCgiJteABazfGuqhlnq3G5fjBPT41Z
 DcbCtnU/dFheP3HMzIq9EAd4wbrOjYmz0ANAfmw/hLqC6lyHdy9bNmstLD1Uiy4hRROWMoUW8Nh
 iocmT9b+DCVJf0UAgv5wbLvQHxTx93HD9HMUvyfl5y4IO7QClRegolfgabcuPbynJfuDxyS7JoD
 DkwpNCWCquFYeRyYQrDfmNgREcQe5SFNCOXkHKY4z2uUAR4XXhPKZHS3v+7ZLx2qitQfUF05XJE
 802hhZOhhvA5HdeFvqnwsJ0NbSJ6yo37NYxiGlrJks67bxBagN1E1XLCrtxck5IxVyJR4GdvT0B
 wynJdCBwiO9r0MERX1VJyVFXpYDG2B+ugB1YhJB5X5MwbUx2NIlCRORloQQyLmYlONEa5Z8F+BB
 ev15bzjFeJ0ZMtWx9bQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDAxNyBTYWx0ZWRfX3DBQpSf8es+w
 vHa5oLfmHMbBx3d9q3m758PsiH26+MLtanSS03HqNA+N74jur1Pwcf8bqUsvsvV5ZoDr7QB0naZ
 WJpIorzaeC6X4Ci32E5ExC8uyb8N471j2+lmbEaS449aPaZ5SMcf
X-Authority-Analysis: v=2.4 cv=O58Jeh9W c=1 sm=1 tr=0 ts=6a7d2ee5 cx=c_pps
 a=nhquEFRPp8Cuo1IKRjcF3Q==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=WER9OelvoqQQjwJToBYG:22 a=aNBV-tA2cxkfx07qmVsA:9
 a=3whSkbs7g9Me0DR5EJEX:22
X-Proofpoint-GUID: 9pC_IR__5SFFhQyEsEHtpVRaNYr3c2om
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130017

Mini series to allow fine-grained platform device ownership in
virtualized environment.

Patch 1: cleanup - replace an open-coded string with an existing symbol.
Patch 2: introduce the acpi.skip_ids= boot parameter.

Tested on: Linux 6.12.

Denis Mukhin (2):
  acpi: Use METHOD_NAME__UID instead of open-coded _UID
  acpi: bus: Introduce acpi.skip_ids= boot parameter

 .../admin-guide/kernel-parameters.txt         |  5 ++
 drivers/acpi/acpi_processor.c                 |  2 +-
 drivers/acpi/bus.c                            | 60 +++++++++++++++++--
 3 files changed, 62 insertions(+), 5 deletions(-)

-- 
2.54.0

