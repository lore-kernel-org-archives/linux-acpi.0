Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com [148.163.146.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06557368D71;
	Thu, 13 Aug 2026 03:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.146.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786592468; cv=fail; b=eNcVJDgmsUUCyLk6j0EkJ91bzDZuWmayxXtToWOoxktW+rNKfNUEvtpj7/e8VUPXuA866zivY4RKHSqXqVSWFOq9fsq9ruVUC43lLX8+s6xomGPSQQAe14jG+yQDoImoZP2BJDZSa1rIYQi6Pqqb2FNVxA4LhQsE7fAUku/WoFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786592468; c=relaxed/simple;
	bh=qTqWd8qJWisCvUIuwki7i3qTxlao47al1dMlHPCOlME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DYrx/kK3Tv1QAT7OpuqV5KfLBFFmXOAkj1T0Q+W0Tjx6S+D1n5EOMy5CW7rWWjvVqXIsgnlJmiBQbKG91TQMdNpbqzs6t4AjYxI/AxUyV3eCjJmoO5/BU46Cqi6ka/dR3zMS4TbJD3HKNYCGhQ7X5lCMiZ13FCGUfzY9YtgrU24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ford.com; spf=pass smtp.mailfrom=ford.com; dkim=pass (2048-bit key) header.d=ford.com header.i=@ford.com header.b=Q4JYvgWc; dkim=pass (1024-bit key) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b=PZKSdQG8; dkim=pass (2048-bit key) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b=JYiY5/54; dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b=l/6Rk6eP; arc=fail smtp.client-ip=148.163.146.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ford.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ford.com header.i=@ford.com header.b="Q4JYvgWc";
	dkim=pass (1024-bit key) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="PZKSdQG8";
	dkim=pass (2048-bit key) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="JYiY5/54";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="l/6Rk6eP"
Received: from pps.filterd (m0367123.ppops.net [127.0.0.1])
	by mx0a-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D2JmNa2590307;
	Thu, 13 Aug 2026 02:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=ppford; bh=e4/
	OdCtczLm6EBmdP5kwIK+p8OxsrGhSHM9FewIIEHo=; b=Q4JYvgWcWavygr57hvS
	g9otj6S11Y5VvmJpX2qjZXEy9hsQbNBKCq6E7lMWLICSHgsrfdpnEAOOE4MqkFYS
	RtYaCjAhomV6ZcuBMLMQDNjG0Cs2rsOqOJ8Kd4KmBz8nm3lqB9HDbNmmtIDDvZQR
	tYU3c/NdlXNgj0isfU7MDk31DVcPJFyBlWPpAWdTZyF1+YjfGqCjIotdM3OwK0Qu
	qM+TVwmUWRbzukIoSuzIRWvi1F8BY7NyY/TGl+uypzr3NYiXJucav6p44qMCq5LC
	tT7iv2v0BfBirNk0TaFROFsOHJY6TH19Bt8zkRfEHNb2Vsay+MFVQ1ohaQqUW5U+
	jAA==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
	by mx0a-00498f03.pphosted.com (PPS) with ESMTPS id 4g0vx1mre8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 02:41:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CjXOUzMReC30KUMF46P953eEzWLUgx0eHQZTK5S/Tc0U01RFMSSRQ6yLihc0FZ9c/j3uDKNNLXmpGguarQy6Ob031/fl1Ofshac5qhTVJvJlJ2BGzerxx1uyiieLQNmTCpkhuI5qPeGbM4DzLQ266LSz74fNobaXovofzjg32IiE+1lchJDUUV6FwR/KH/fM4028Z/2SvM5eQ3okhHJygQZdlVTpmxMXRsHksGQnkq2ZyYBe/SsOXPUy4VqZjfpmi+eJ62lTmo9ufdTrhcaJpoeV073tV4Iohvv1BlODm4wiwrx9dRUqs5pOGzQZsO6NTuRK5/1TzAijVLpXz9G09Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4/OdCtczLm6EBmdP5kwIK+p8OxsrGhSHM9FewIIEHo=;
 b=a8pjKAVuV2oSe4mez2WM7x0myRT9F34q1emsf713iHC2ruPE2VRhr07XYIMnRGxQwNXILy+vENyfwWftoo3RdhcH+ugb6QZ00/qbxwKcNInSZ0soxUp/lcJpA4Lc2P/Q55K94k5elW+QeAb3a7yanSG9v/KmYD9HlCUuBU5ZdfWKaoyIdr4ADrY16PoS8LrInVcUZ+YDRq0n9tj98NfEnQSK1lR37RGCPnWXdzHyZVCsF6rlNLzVJmSA7WMBZIfu7KBwdzTPDIocHGQP2Inwn5Nmi/I4oM2GF/6vEK+ZOkcNLxHjA5tfqBPdejQFA3elJClVWOxdWv60pN5+AP7xTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4/OdCtczLm6EBmdP5kwIK+p8OxsrGhSHM9FewIIEHo=;
 b=PZKSdQG8y/fKwPYZIhV0M9/GZPDQaRRIs1gRNBW6HohE6p8JXykWU9bkU5iAzHzJovNAQ0wzSgNQveQwCdXudy0+5p/dzULmHOWUgxopx48JPryn9L2OX2qE0bJkPEyRCTyT3V11MLar43qAjyiS35/eLTZQu5FgCfG27CkiOXM=
Received: from SJ0PR13CA0131.namprd13.prod.outlook.com (2603:10b6:a03:2c6::16)
 by PH7PR16MB6816.namprd16.prod.outlook.com (2603:10b6:510:373::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 02:41:39 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::43) by SJ0PR13CA0131.outlook.office365.com
 (2603:10b6:a03:2c6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3 via Frontend Transport; Thu, 13
 Aug 2026 02:41:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3
 via Frontend Transport; Thu, 13 Aug 2026 02:41:38 +0000
Received: from pps.filterd (m0426316.ppops.net [127.0.0.1])
	by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D2JwUE3240115;
	Wed, 12 Aug 2026 22:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	ppserprodsaar; bh=e4/OdCtczLm6EBmdP5kwIK+p8OxsrGhSHM9FewIIEHo=; b=
	JYiY5/54Yj4+Zc8/Lp1Ce5yqN0Ec0O3br1fqGO4CTUX5ZfkVxBOzR29gJ8s+tGTe
	X1BgVRfkI0CtQaYJZl8LR0aiPzMuxDQso/5/X4Hi3xKnqBeg0KlqYhsk/mxHu/Ec
	Ih1yJW3ipWwATSVkTawwPv/enJmwfwNimXqbCnleQ4KHMsc93U+7rQFB7z/yvgSm
	stgqfUCoMrf0QVSyOQhJuPr6tlkmvMXIUy8CRufsO0gHG6RdYy+J8kxcxK/OhGou
	sS2jKp2h8eR5cTGPmFLQgG4tRqkhsy1xkSwIKtBt70oa/k5LKxO1/Koql953s7Vu
	enEKliDbI6YCWeBHWEcVDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=ppfserpocford; bh=e4/OdCt
	czLm6EBmdP5kwIK+p8OxsrGhSHM9FewIIEHo=; b=l/6Rk6eP3xKyPYxUQWPawha
	sBXHAh9JGXM2Ozg+dr1mA9Cgpe1q+DahBnMxi5sr0DORPVjtPJMEn1E1IX5OIqQi
	kMOVDqltAjauenfJzOpX4HK21pvZLnRrBNYMi7hog1umyBHqQT+7tnMoUV5lTX2B
	+UNq5CnJI2DxOM/hKXcM5qE4bzKKqdFplShflVCZvQOYoCWo7D2ADz6rPqvx/ohL
	x3g+fPdMe5lSfjMfS7FQfuH8QYxZVTxASMfcjg9BhtETAUk/lHk30ffLLrtq7xgG
	7BKz6tPyw0fk7YP14sICvWGjPFoS+oZ/htFFI8U+5e6zBps3xk3ECEUxopJz2jQ=
	=
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com [44.208.76.22])
	by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4fxkgccuw1-4
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
	Wed, 12 Aug 2026 22:41:37 -0400 (EDT)
Received: from localhost ([19.12.92.221])
	by cmsmtp with ESMTPSA
	id uLNww1tubRJvquLNxwEq8r; Thu, 13 Aug 2026 02:41:37 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: uLNww1tubRJvquLNxwEq8r
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Denis Mukhin <dmukhin@ford.com>
Subject: [PATCH 2/2] acpi: bus: Introduce acpi.skip_ids= boot parameter
Date: Wed, 12 Aug 2026 19:41:29 -0700
Message-ID: <20260813024129.905583-3-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260813024129.905583-1-dmukhin@ford.com>
References: <20260813024129.905583-1-dmukhin@ford.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130017
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|PH7PR16MB6816:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c2210ec4-e7b8-4c52-d2d0-08def8e466b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|10067099003|56012099006|11063799006|3023799007|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BgEEQK9NXtmQFiCFTEa31zMwwpGFVD+SiZOLPGQO5K+8MOKezGU2/3XdEjKWYKZsGe1edl2Eb+FbnLBoEcsAEMYUo0lHm7u+HzrgXgQuIeq3U08YWBnOHCgcsC1WtGLWob7CsXFdtsDnFJFPC3VwUWzVbCv0WoPRpe+1MlpwsvBs74iRtfeqEHL7t5z1SH4E4ge2Fx9ddxYzGacoNnZD8mLyZRP+RTxdhWCFU0ydJ0OybDgPn9gXiEcsxnZnAwsiAgvFOVTSiP1kIb3hmT0h7WWcXqXa+M7skAgmmlo+S5t18HBIObFIp27jOS4yIBMxgqLWQ1LT/rFGJjfvuS58NkpbSiO/wVjL0/mK1Oj8lb+UpMdyy6B2WpXi4egc4OTZ8pCeCKQGkw/ftEUe+2eb+ZE6q42rZ576W0Narr6hJbYGhu/WNtmnxZ81XBbBjXyACbSZpdrjHlXrPyr0QDDRov+ZbJ2XTk4BGRvvCtWP1fq45v9uU5EulaXD/dSn+VdiF+QNeSQ5IZRM6YpjJbzv5sCCmrj60R8NCJjj4ZT8zQ4zhZgVOYd2FvD8flELFsgUMfb8uUsSODa65g3WMg8BGmhrJw215VLiDzUO4OKA7IbJTpfMcdU+oorI3iwvwtCZmx8VZvoX0fg9JZTA7ynZM3OSbjvh6WB7HhDNBWcNx3AMexZy49iChrWkMR9NplVOLoF1y4aNJ6AFJ13qZsAlUg==
X-Forefront-Antispam-Report:
	CIP:148.163.138.245;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mx0b-00498f04.pphosted.com;PTR:mx0b-00498f04.pphosted.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(3023799007)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4xm5Vxis/vJchTH2e8Fo8+jbTJnTcicmhj45oIGkaDIKRnrSUOqnAKdqTYCcAlUHc1EOngYyDzNqhSVLXfCiH8C80sIfkrLxYLAOjtqD9KgWroVmeBXv8b6Eh5+x6WqwMJDWJRk7ToQPeByIj4C7W6om67w9IIgFmxpurMmcLkhdDHwogdguvb9BdKcK/hXvbW8JeyMDqcwIhPNZT9Bi6eCLGCPLduiPK3sI+Gi1X+qAzf8oUg3V5z7uGIXUFcWXWSGENDunKmxz2AKbzndOxTsnPYWWec1mCDGeJnnAlQGZO3Y/y5XvaCWbrlLtjCrP3Agj2LBRK7nbYipmLLwUN/lNl0GXU84xc8xXGjCHRrYY/O7MON4Qgkv/qcqaExyX1rFytyXoYYG0hcCBiua8/Ux5k/mKxJZQBJrL+M68o7VoFaX3GcpvQq9nZaG05F/r
X-Exchange-RoutingPolicyChecked:
	CB7VHaCjbpu/UaJSLG+C9j4yQpMmkcnUw7559TTzHPiKOnlzdyA+lD8pw8vbLSzyUum4YLPQFkatMPALLfOf8Mwraccj9bFgICZJi3Ik5vJ85aK3dxKDCk2IPFzqGCZ4sPXL5k6EC1CFhL1Ml5SHlxoLmsebdJZWuxynJ30L/7WTvENgym18ZLUMaefDHfrlkpr2vO2sQwyHW7fDFuMb/t/0CHi6tZfrfPfxGWg4Cjak2HJGnKGaLGvz/z8dG9sXfU7XK3tk5YXfZCE8M3tD0wfqSQrZGwu7lyM7TaYd3coJam7Hlux+RD+ySMiDpfX2ZYVDUd96DYnluFs2qZsTFg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	al+vSwfX0AUWiKcFanoxCMuCk8L4bSWNnqtrtg8bFCVFVicr/kwBrxfUIJvvxQq19RNRrMiD3KRuwkgxs+xEd/fCK2yPzR5O1aKoZVKKnt6r2/eBG5xVpGv8RnRj9e1p6TzVWRbHgNJ+3G7HjQAdHEuLtLBYEHjZEehBhMDmPYvrCSN+sh+fJLK/25Lb9fOYsTey8RzT+B1KpkP+Hf+j1Pn7b8+NVQhAGvgjf6CmiCL4AVULJVRdK3PeF4+yDMrUWqw5N8RFHxL6bJRQ9NnPgKCjv49zwF5R69+f2+jJAfVsfkvCSCN9TH7ETm5owyThmYffeAXOVCpx11Vxli+eSqq1/9Ngg0UaI4sRYVksWidrv/cD6dto47+ZOCRqzXoq8+YIYIFZThoRIfRX4jO4LF3kVtSgnW6BGQVapcLcld/tXsXZYC8F6gFsPOJzP/7kYLs8Zs8h/01DtsIzF/9LdPIXTrUalWuvaZ3ZtAGVjtFfViOtJXfDp6q1X9NjPu4WTHpFGxTmm8CNbnmpZk4TN7ZeVA7XScuCWqtRMuxt1rWWVBdlZBK7hlK+8mT6/G3TSLsKbiNaPLOZawWXBz1d1ZP9q3S+8FBYcTgvKDSwkvHujpHiUdv29Gx1C8qv13pEQGml13ZwV1teeGHmZ+BEAg==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 02:41:38.9807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2210ec4-e7b8-4c52-d2d0-08def8e466b5
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0;Ip=[148.163.138.245];Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR16MB6816
X-Proofpoint-ORIG-GUID: BACLkUBA4_j7vAJsFnfuE_bi6JNeKVco
X-Authority-Analysis: v=2.4 cv=BdToFLt2 c=1 sm=1 tr=0 ts=6a7d2eed cx=c_pps
 a=0joluOkswiQ4lQw5hT3+aQ==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=N9_n2FxmZfwfyRXvS9-E:22 a=cbNQJ9GKAAAA:8
 a=kDHMwH0UO8s1aupfHXoA:9 a=3whSkbs7g9Me0DR5EJEX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDAxNyBTYWx0ZWRfX3Rodz4tT+51L
 g3qRXSz7u3DCQ6m9LgFZNSYeeWGPMBjF3BBH5gmoIMfvB69j9JJCduIbWY9KjCR+WDP/AvMLW1J
 qqFcI4n/dNXeHOJszOH+VuPf06MdfH9KAnHglbzL/MeIMBNMT6K6CteU3wVDNasx/EvgZOEW7+J
 GPQtr32pJEg0f4YjFhtfB4QRTGtErJXviL+dgpB3tgF6qOrlSKQsAOKZms/iqckLQo4Js3XqfZN
 tiLWnlUyImgKLyyWcQ1/ReIzCVbLfFX8pxmBY4KjGe0mHUbRWtftdr0e3kAN8yoTLBeHNnzmFxA
 KgtbMGMQVVX6O9GuaTjSs2BDttqZVtp2gLkQ+O9teGo2X5lxbEbK/Zw9XE7cACBn9zRWKb/IICd
 z68v/K7muY08oU6S1mbmvRl/Y5PwxPm26HoLotQCgoLZkoVuHpeuOw23mAV2+ZnHl/72KZ54+e2
 lGto8D57mVLYJjN5YOQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDAxNyBTYWx0ZWRfX946eohkmQKk+
 Z1GxMkgxEp/hgLnzAVfmtGgKBCAe0x6fDN28yyDyMnR0Zg2S20dPStoUOuRrZ7R4AGmGra0HZMS
 YFegQBA6RKZryuvWlpbO82rR50Ea3A+p3fcrYrEcjxziw42AE+Ub
X-Proofpoint-GUID: BACLkUBA4_j7vAJsFnfuE_bi6JNeKVco
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1011 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130017

From: Denis Mukhin <dmukhin@ford.com> 

In virtualized environments it is possible that a device managed by the
hypervisor or another VM is described in the ACPI tables. In these
cases, binding a device driver to it can cause functional issues.

To resolve device ownership conflicts, skip enumeration of ACPI devices
whose ACPI IDs match entries specified via a new boot-time parameter:

    acpi.skip_ids=<HID[:UID]>[,<HID[:UID]>...]

This parameter may also be used when a single kernel image must support
both bare-metal and virtualized environments - for example, when the
image is shared across multiple VMs and only selected platform devices
are exposed through passthrough.

Note, a single driver may support multiple devices and only a subset of
those devices may require exclusion (for example, ABCD0020:00 but not
ABCD0020:01). As a result, existing 'initcall_blacklist=' is not an
appropriate solution to resolve the ownership conflict.

Add brief explanation for apci.skip_ids= in the kernel command line
documentation.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
 .../admin-guide/kernel-parameters.txt         |  5 ++
 drivers/acpi/bus.c                            | 60 +++++++++++++++++--
 2 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3d35270dddef..a2d4bd9e37b9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -195,6 +195,11 @@ Kernel parameters
 			ACPI firmware problems, as the system might behave erratically
 			after having encountered a fatal ACPI error.
 
+	acpi.skip_ids=	[ACPI] Skip enumeration of ACPI devices whose HID[:UID]
+			matches an entry in the given comma-separated list
+			(up to 16 entries).
+			Format: HID[:UID][,HID[:UID]...]
+
 	acpi_enforce_resources=	[ACPI]
 			{ strict | lax | no }
 			Check for resource conflicts between native drivers
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index a30a904f6535..86dba970bfc2 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -38,6 +38,15 @@ struct acpi_device *acpi_root;
 struct proc_dir_entry *acpi_root_dir;
 EXPORT_SYMBOL(acpi_root_dir);
 
+#define ACPI_MAX_SKIP_IDS	16 /* Arbitrary limit. */
+
+static char *acpi_skip_ids[ACPI_MAX_SKIP_IDS];
+static int acpi_skip_num;
+module_param_array_named(skip_ids, acpi_skip_ids, charp,
+		&acpi_skip_num, 0444);
+MODULE_PARM_DESC(skip_ids,
+		"Skip binding ACPI drivers to devices with matching _HID[:_UID]");
+
 #ifdef CONFIG_X86
 #ifdef CONFIG_ACPI_CUSTOM_DSDT
 static inline int set_copy_dsdt(const struct dmi_system_id *id)
@@ -1008,6 +1017,9 @@ static bool __acpi_match_device(const struct acpi_device *device,
 {
 	const struct acpi_device_id *id;
 	struct acpi_hardware_id *hwid;
+	struct acpi_device_info *info = NULL;
+	bool ret = false;
+	int i;
 
 	/*
 	 * If the device is not present, it is unnecessary to load device
@@ -1016,8 +1028,42 @@ static bool __acpi_match_device(const struct acpi_device *device,
 	if (!device || !device->status.present)
 		return false;
 
+	if (acpi_skip_num) {
+		acpi_status status;
+
+		status = acpi_get_object_info(device->handle, &info);
+		if (ACPI_FAILURE(status))
+			info = NULL;
+	}
+
 	list_for_each_entry(hwid, &device->pnp.ids, list) {
-		/* First, check the ACPI/PNP IDs provided by the caller. */
+		/* First, check whether device ACPI ID is in the skip list. */
+		for (i = 0; i < acpi_skip_num; i++) {
+			char with_uid[MAX_ACPI_DEVICE_NAME_LEN];
+			u32 uid;
+
+			if (!strcasecmp(acpi_skip_ids[i], hwid->id)) {
+				ret = false;
+				goto out;
+			}
+
+			if (!info || !(info->valid & ACPI_VALID_UID))
+				continue;
+
+			if (kstrtou32(info->unique_id.string, 0, &uid))
+				snprintf(with_uid, sizeof(with_uid), "%s:%s",
+					 hwid->id, info->unique_id.string);
+			else
+				snprintf(with_uid, sizeof(with_uid), "%s:%02x",
+					 hwid->id, uid);
+
+			if (!strcasecmp(acpi_skip_ids[i], with_uid)) {
+				ret = false;
+				goto out;
+			}
+		}
+
+		/* Second, check the ACPI/PNP IDs provided by the caller. */
 		if (acpi_ids) {
 			for (id = acpi_ids; id->id[0] || id->cls; id++) {
 				if (id->id[0] && !strcmp((char *)id->id, hwid->id))
@@ -1031,12 +1077,18 @@ static bool __acpi_match_device(const struct acpi_device *device,
 		 * Next, check ACPI_DT_NAMESPACE_HID and try to match the
 		 * "compatible" property if found.
 		 */
-		if (!strcmp(ACPI_DT_NAMESPACE_HID, hwid->id))
-			return acpi_of_match_device(device, of_ids, of_id);
+		if (!strcmp(ACPI_DT_NAMESPACE_HID, hwid->id)) {
+			ret = acpi_of_match_device(device, of_ids, of_id);
+			goto out;
+		}
 	}
-	return false;
+
+out:
+	kfree(info);
+	return ret;
 
 out_acpi_match:
+	kfree(info);
 	if (acpi_id)
 		*acpi_id = id;
 	return true;
-- 
2.54.0

