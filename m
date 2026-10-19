Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.69.61
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792432555;
	b=IWL9gylBPire8JvdMYXC7EA2wj2eUjMv9UW6Gv6H3wYprewk60SZmCXjauMvHCYUrY1M
	 YsHPBaaDfIbfIoQ132ATWMq8kLCNGZCqZ8CnwN97n8R+iLOcrsMPSI1LcEh9va6a+9V0n
	 fHIs/QOyAUgAIrXLRZr/yWBicrFTlYiUPOPQZttJxj98Q3ZfILuLwpMtqFqd+/V205bTI
	 XiucSIVs0mCRyj1qx8XmyAtCtgFeYackNp2IzftpL5v0G6phYLpHQypTIud1ZFsTKz/LH
	 Xarpx10FoMuBt26pNRLhTmzsoIdH7hHk9TmoFpHewYwqdQ81KyIRHXM8PhgmISHyGig==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432555;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
	 DKIM-Signature:Authentication-Results-Original:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 x-checkrecipientrouted:NoDisclaimer:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=s2fS3+jw3JUH1jkWKlZ7UavWq+1ufeUzkz/USutmL4k=;
	b=Ds0HSDIjMyWjeapgc3lwGTNS3Lw2uobQ9hXc90BCVqEoPtsh3A/jfvIO52hvJTnXgkPY
	 tjnhD7adbqOaPgkr1r08DCGpA9h3Y6aWIAM/KdRVuDgAs1uGXPl2Fh0+BAlV3EXxgCJSX
	 DRVk+IqcJqfmyyuVJ6NlSzYpx4GLbcjfnD/ETT+HC7EIUsMLUkDTt85uMvKg/JpsN8Akm
	 XfM8H3PUmeMWbrPYQfi1Tl2A30blBNyMbMsRMwbA9BbGTYTMjR1Up5FbuumjOVrYq786m
	 78S1+mbQ+l+KkeSRBSxC0run3t9WUx6zOCICu0loTaSJGpPuuidE+/V1sDVIaZiZAUw==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b="Kn1/J8yw";
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b="Kn1/J8yw";
	arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.69.61
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881D6606A31B;
	Mon, 19 Oct 2026 17:55:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 881D6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Kn1/J8yw;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Kn1/J8yw
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=d8S7+V1JXKXNb84rCWRBjzxFeI21XkTiprLuJBDhpvdNtpu6Qi4dJ2bf67u1+vBt08uvjGocox1MwOZV0bxPZeSF2fkaI+x7jVE18utW4E6Tl5j86Q+RB0qYDGLMUudEcEDeng2e6/uTec2uFfxAqEresGqH+05tfOe6hrEtR5IQeGFTMlI3iQ1Cvu38O1GgNn6utNjCFpPQ/DJ4Nbn6y6TLnqhIeWxTuiNbxc6aUKsWTeX/Ii+J03JYU8Y4NtnPPYJldPrLNjIltGfXV9qZU4RnC0VzJ0e56yKI+b/hgbfmJOqfnus04yVtz4/qGFxjF/mibHOveVCddM8+LHgRaA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2fS3+jw3JUH1jkWKlZ7UavWq+1ufeUzkz/USutmL4k=;
 b=bOGLqHsv9LNKHL6M/yuOKdHJVLzoKWny+Q1m4vv0S9RoB21hNvCLDoenUNp1QICi6TCso1VyZM1dYgxhM5ZZz2qvhIt45bhdsIuCNr+1Z20gOdSXg/DbUCxHw5JaR0jMoXIACECjQuoEZ9FWAj9DQQbKFhf3pYLwM33DrRJCjlRBIiH+g1AOQhuho+5vsjq26bpefCJVdLA6DMi3vakrxKSk62gLsMK2+huwgm6wtML3ARx2yB7+jnh61/MbO5zf59saKXLNTZzSzukfbSEvgtOmpmBfLyDLP6VA+LLnAfQAi89D6CPI3+cjNzDw2SHTgPkC0SYrnqE6RgZ58SMgYA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2fS3+jw3JUH1jkWKlZ7UavWq+1ufeUzkz/USutmL4k=;
 b=Kn1/J8ywCqgZZFiSO3rNvT4jt7FoGJgWTMpjIogxDKVXZZecjWQSBgQrzDJWGOY4lYwUTbNoq/jJGlnCMqPtF0pywBo5PMgzUsfc88SGVHXG7qqHq9pCUQxSr9pApQP32BRWub384aTF+X3BZnoBT48sCSzX7AVLdkDV1xxACtU=
Received: from DUZPR01CA0215.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::9) by DU0PR08MB8229.eurprd08.prod.outlook.com
 (2603:10a6:10:3a7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Mon, 19 Oct
 2026 17:55:47 +0000
Received: from DU2PEPF00028D0C.eurprd03.prod.outlook.com
 (2603:10a6:10:4b4:cafe::ad) by DUZPR01CA0215.outlook.office365.com
 (2603:10a6:10:4b4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 17:55:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D0C.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Mon, 19 Oct 2026 17:55:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+fw9RqrsKNt4CuAPclwqBOA4FZNGsWGoN5SGdHUA4CKZmJ2hZphOKKyZZSQ1t9qM0oRFv6/9rQ+2ynhd3MMXZeL8Qa7kIJNjg98BlWdodgACXgu3GOLexIuUBpdOYtW01ZOKS17FB7t14W8a9X+LFp0VUMH8P9+rGor3YMDQgQb2xkqDeSdpS9NE7RjZz66sipXUO6E4DO1mR+saEDTLOApw/NBrh63ppR9Ld9qWe/NFaFA4bUVzZH+8tCQF5fpwjzH3OuieRa743bqpeWzZKq+fL5jAa9JgfDI54FEJQyNiXPUIcIpNze1+UcbLknmk0Ngm5O27mZkz1vxLkJAKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2fS3+jw3JUH1jkWKlZ7UavWq+1ufeUzkz/USutmL4k=;
 b=EfzrQYaNH1/9UZTDgt8+m60ToCzWutOGS+CtNCIcuOBDC0ypHti76pQhaArlCwgDbdm1uHGowUwEh2euQSQ/vblPnUi/2yKB8W2kDcrot/cnT38dwsOb/XuIuVSRqpAu4gQz7fN9giTZPMPiTfPGK3M50GwrkuVVYY8OGWaTVZXJ1ADy4jGcf1W6xLsR8v8AEj1eeRNLpupiDmhzWbOJY5ETVduu5+ktFKNCm1DhjgbpTBU4JuYQ1zDz1pMaQK+c7DBA6iHAKvUlpyFUWPNFCoG0T7J2zh4aVi+Fi3Dgpak6b7GNiE2iajNdEvZJgjldRhc0fUlo62HbiC002LAdnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2fS3+jw3JUH1jkWKlZ7UavWq+1ufeUzkz/USutmL4k=;
 b=Kn1/J8ywCqgZZFiSO3rNvT4jt7FoGJgWTMpjIogxDKVXZZecjWQSBgQrzDJWGOY4lYwUTbNoq/jJGlnCMqPtF0pywBo5PMgzUsfc88SGVHXG7qqHq9pCUQxSr9pApQP32BRWub384aTF+X3BZnoBT48sCSzX7AVLdkDV1xxACtU=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 (2603:10a6:b10:109::23) by DB3PR08MB9010.eurprd08.prod.outlook.com
 (2603:10a6:10:42b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.6; Mon, 19 Oct
 2026 17:55:13 +0000
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62]) by BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62%6]) with mapi id 15.21.0546.012; Mon, 19 Oct 2026
 17:55:12 +0000
Message-ID: <51d89cca-a519-4856-931d-328987585d11@arm.com>
Date: Mon, 19 Oct 2026 19:55:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] ACPI: extlog: fix extlog_mem_event build issue
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
 Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Dave Jiang <dave.jiang@intel.com>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Breno Leitao <leitao@debian.org>, Terry Bowman <terry.bowman@amd.com>,
 Dan Williams <djbw@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Morduan Zang <zhangdandan@uniontech.com>, linux-acpi@vger.kernel.org,
 linux-edac@vger.kernel.org, acpica-devel@lists.linux.dev
References: <20261019145643.1877246-1-pierre.gondois@arm.com>
 <20261019145643.1877246-2-pierre.gondois@arm.com>
 <20261019093648.00002db2@oss.qualcomm.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20261019093648.00002db2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P192CA0008.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::13) To BESPR08MB999898.eurprd08.prod.outlook.com
 (2603:10a6:b10:109::23)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	BESPR08MB999898:EE_|DB3PR08MB9010:EE_|DU2PEPF00028D0C:EE_|DU0PR08MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: 583c3c02-2736-44b5-ea0b-08df2e0a3422
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|10070799003|366016|376014|7416014|1800799024|56012099006|11063799006|4143699003|18002099003|10067099003|22082099003|261009223027099003;
X-Microsoft-Antispam-Message-Info-Original:
 6VqBOX80R9ibDyPMvb4XerdkpOZOTzksaX6249qBPY8RxQaZ0c0KtEn70i3q9RoXBy/HeJEMDjdOJNrCvso4i+3iQmUTpiE+YKh91LiG9Csy1ZL3l6gl+vkX/qiyVqbZzqEr0XQjLbZwDoWGPb+E4TC8K/yAJj5GoBS6JIkEvY9AErw1b94J4GERb5cIiijlki44k1T7OVqcuvYTG3JECnrnGV0zO9iILlSMKS3KrxSJQ2T2U+Zdd4FchGa39vgPQipFb1S84XcIEjB9qc4AH0WCodxS1/r8Dhv/MzpMOibK0xWIEz01Yk6P0a6SjOk5YaWaE9mpcUY4ifP3dcak9iCiuCNnCWIYubiYd6AjGTv5jD/Oi/xJVKRwzKGTnrLRxblpGxI9jVMH0dE1pyqRIVFXEY8AnkEk4SAhmgrsUnvDEToj9wBV95MRb8N2WbZdT+QZVJu3iLNB5XRDLtRyTyPEfQ20WsIl0lQfwrjb2hTmlBpjdAhvUaoMNGiIV7QehdCdDmUAGObiGV5CcLU6cgoqz4DX9pSAjSeZqi1Rzhm3LNXU/pnOT+mO7w2YopdugE/R4wG0xFC2I/mLZsiRIi7kc7n/rdDldHRe5Ob9Ui1qTgFOs82SGr9E3q7nugB1Z5tAmZ8q4IfSk+LixtKaqQaDAwT+wqgc8tC9R4FhBtY=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESPR08MB999898.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(366016)(376014)(7416014)(1800799024)(56012099006)(11063799006)(4143699003)(18002099003)(10067099003)(22082099003)(261009223027099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 B9Ry6LW7ToJBf4hNTxumzSXdDse6zDVrqtSmdcVioorbj/fDWUFMxZ/BzSPI02PgkiEKCbCuwyezJvu2yRPus1zSoW5TpxLhxW0dEsokZOXJKj9+bbQMerUhf338/n+s28jdRasR7Yze/OSSnzr6EsAFtUWkRh/Jq4myQcEruvNJcNUCd6UU/AJPvfrfWld37Acz3IZmB/Ix4yYIRbKrsIIFkIONYjtIO5mlQVPJf+oCytM7MJJ8iG5a8nbCY2b+CBPmJSmpAl3TiOK5iEJSrgknO8upcyhgewJQaPSkYD9RQV+QdVnCA5lXZBAQ/Npk0u2MfMRaz/vS1qgEWraYnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB9010
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D0C.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8e4c786a-b99e-44c8-e9fd-08df2e0a1f9c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|23010399003|1800799024|35042699022|7416014|376014|82310400026|36860700016|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	g24TpS8L5DwuZt99eP+h/WOAxlPEwicR2VU2a1uXe34DyBKzl8BMXegjI9AwqGNxbYohDvrax8wlmI0cFTpGlOPQE2pISROWYtXTUqrcUOZh50HJCuqFXLI77kjdCCr1v5gvRa2HMtQ7Y/2+IdjnELrZXTs8I9g0b5gMKiaf8dMpk/VkSIa6RyE088o/FUYWgCkTa/O7evjH4qkx66lmXaW2cdqmTP2fqsNPmpAHuqMdmRulk0RlS7EkXhrFHauOthoBXKrxgjZb8FZEp3JtiLb83IplRPNvR/x/zUD/wNeGRpSc/kNZYXrRLHgOAMUtjOnNJIkFARsBF+iPhm+jvkMhxbqgDCC8Zs8MwCb2AAGQF+fgH4kvbf8j+usobGlSfBuWVEyFKZbN53FU97P89ghWRexfnGTCDe0INnLlP6cwCah2cN1wUIFKS5mnkV0VlHw51YudFtAv5VILfYh+fdKZFe0yPXxdKA68oreef7ofVrlzftuSe93EddkFc0irvkTNuQP8HqSxCQgFQ49E1D5Ug9U7imuvESoRNIi0Exj22XxRVxbRl7P9EnReb0PZXzUrrP/Bi5GW0bTjbuFiVrfdfG2NUaLxavN6/H24DvjQ9G7HkB7AcnrMKwEhqo/SyT/nw00Kdn83pFp2AxzUiGnG4SanxXyG4TD7dxVqF/br4MDYc7dQlzfOUdJ3phY92K85q1H+4Ah4ouJ4lmOcUQ==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(23010399003)(1800799024)(35042699022)(7416014)(376014)(82310400026)(36860700016)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GfFmN2lHVF9g2BG4PK/L6lZbJmV3WSK/ii5NCUR9sXYpfd1S7I5SA7chguqd0L+ZPzUZcP9S9bT2Wr3Xec050kmn+GZObLTo9l9R0QEC/St2fMbV6qx22z97VbTdnW5yph8SrhD9y8UcBxFYvyRI6+vwfxNhAFPYx33wZX4EMwVZhxV3X9wWD4v69C7up+PFAvq55moSzpWPYHnca6WKhTuM/AE5i3+9+4xbsHvH2ieuWi+pHLgw6Q4x0r0D3sqP/nUEsdo7D2vuZCCwNfGXJIcEcbdPfWme05CFlV4NocXK3mt1IQ0Z7luJ9DwLf65UWmAXDo0l/qmZvCZWKrDmxuWpJHxOpdMTLj6FAmb3FRn6k4r6G+FRFKOsGy0jOpCguDDRbW0eyuOuyPIlpZRNJaQUKoNHphmnqgM7Q1UxWG6foJib+zHsD8uBYOgO4mlf
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 17:55:46.8186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 583c3c02-2736-44b5-ea0b-08df2e0a3422
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0C.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8229


On 10/19/26 18:36, Jonathan Cameron wrote:
> On Mon, 19 Oct 2026 16:56:08 +0200
> Pierre Gondois <pierre.gondois@arm.com> wrote:
>
>> With CONFIG_ACPI_EXTLOG=n and with the following command:
>> make -j4 drivers/acpi/acpi_extlog.o drivers/acpi/
>>
>> trace_extlog_mem_event() is not defined. Add a extlog_mem_err_event()
>> wrapper to fix the build issue.
>>
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> I'm lost.  This file is normally only built if
> CONFIG_ACPI_EXTLOG is not = "n" so how do you get to this code.
> Ah you are forcing build of a file...
>
> If you do need to do this sort of ifdefery it belongs in a header with
> the function cleanly stubbed rather than in here.
>
> Anyhow, far as I can tell this doesn't make any sense for
> upstream.
>
> J
Ok sure this will be dropped.
