Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.72.41
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795624245;
	b=bfJu4AC9WbiUu5V0tnqAgg5btjKhEJ54QigxYpBLASjJp4QlU9uTdTM5IlrjvXtShc7I
	 aoV3GFm0NozdrSGUHYwvakd2d6uXSEYRuZu3CNdUUkTykmnmbMtmZKxR52JXLOKsPf+xN
	 nhbv5CTkm2TFmkoN2D5b3XuhzlBACG1rVFl+t05rreOrDBjz+7GraXqFpmpEQ1jhKsFAZ
	 p3+mV5ecVCak/CmfJRmjNS6MotSM8wtFMFwNueyWlt4edaSblsgmNURNfk5hfnA1VuN1q
	 op2je0Z36dpN1F0JiPK32QjNbB/M8HEYfkaK5sMIj3oIUuvAYZL6UCqX7Ig0H0SGihQ==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624245;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
	 DKIM-Signature:Authentication-Results-Original:Received:Received:
	 Message-ID:Date:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
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
	bh=Rf+R6AeWjsRAktss/M+IwIn2Qplj9pv7671kguICTnQ=;
	b=oChhYMeSVlxqX1pgv8+kRWTPCHgkHAL35LHssmV6kw5dRHT4Hvj/s/XS08pq+/pw7ctf
	 MUooVG1iuLBweTH0U8goR9/J54/eSdzsSN2BvDGt6Z9iOPlXs4HbXWFOwLNXCFYz6gSCN
	 r88vdCuIFdc6yl5jODbBRQ/V7qF+d7sWI7oqBUn8O9Ec0FvpTw8x/S/+SjUVTw656BqOU
	 9GxsIw/cnxpMNV2Tly3f3WF65RiAnBMySEeoye1kmF7ZKymvUTzAMpVt87lSCrY/YuHmO
	 hksq85WReO9F5I1TfsXBWyDv8A9Axf8DPyCIRj0/WKXLOdxr7HiUwcV4lHleKokkPRw==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=mIDkTq7t;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=mIDkTq7t;
	arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.72.41
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013041.outbound.protection.outlook.com [52.101.72.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF34606A684;
	Wed, 25 Nov 2026 16:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CF34606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=mIDkTq7t;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=mIDkTq7t
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ObeZ4mn8RL+OeVOL+EgLMRfgRCOcE0980EeVjqJq4X8nQ0feguEAUkeq5Y+XNaE76FAS1ACQbims9/PXqnwOfOnNTdePqhMBaHTyXb2QXB/V7kZtbuwh6zHTaSCIUpqYepMhhtBlh+qn3d3fsrEYb/ZB9q1b7WV5t3OeG47u3G+zfQ3v4lEbsoAZfHRD8CC18CgOP2TnDvKMr3sWgak3cczvFuPsrQ1Pa/2E8ylbCiqGgCym128/SzVnHgS9lXvcaMNkVbaNzIXdar3YhjPfxESOZbqUU3y4j+1087nAM+QaaExygTcRlymC5t33DIQxMqojVyPaka310IwbjgRh3w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rf+R6AeWjsRAktss/M+IwIn2Qplj9pv7671kguICTnQ=;
 b=smKMMrIGftd6GYBmpBe3taFgjoQL4D/hRvahmzSDCcZxjD+9fD/+dD5u882hfQq2w+cxmeK7bmnEGOh5pw8+G6BYAT2PIlBs+WXkSTUkIx3/YcbTxcCTpOxQo8nartRROuxi+OgCdKiXJgPw0LDs8/y2kUUrsRXjU/3oeGUQgnPz1HHmVdLcDz2hN1WX6JucfY/duGbn0JrnCrED6IaUWPwK3TRO8DluaIz4yd3zH0Q+/XW3xswb8DgeieG8hYU/XtXLmDIk2Xdxn7S/K+FTfgyaHYklhJrnncvXsX+pSp+YU2uSSjUPubdelUF2BaJLGbwc3V1zYav0sIVIZfziKw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=alien8.de smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rf+R6AeWjsRAktss/M+IwIn2Qplj9pv7671kguICTnQ=;
 b=mIDkTq7tCPXeizXab6KAmdO14dgsPGDWPPVoF3regOap6TcGbRlrpyvS8k4FR0C7Xfce6ffUm2Ccg0XjjkG28KifiECCHH29gg+tPTuLJxh5+JnUrq5e1Fp2zUEsjKWThzXrLbfNiiJvX5sh2ci37M3MQC9mvrEuyGz/XQjw/nc=
Received: from DU2P250CA0011.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::16)
 by FRZPR08MB11901.eurprd08.prod.outlook.com (2603:10a6:d10:1cb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 16:30:36 +0000
Received: from MAD0EPF000008A9.eurprd04.prod.outlook.com
 (2603:10a6:10:231:cafe::ac) by DU2P250CA0011.outlook.office365.com
 (2603:10a6:10:231::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Wed, 25
 Nov 2026 16:30:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008A9.mail.protection.outlook.com (10.167.241.181) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.3
 via Frontend Transport; Wed, 25 Nov 2026 16:30:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpPY6sHGqlNcsRaZ+38dr5lhzGwF8xY4jL9bMcdwNx8ySiPjFi6KJrCyWlRSjr3FxpyspvAZ36jawA7zEAvlzVVJ8tGo3po8ZBQGO8E28NkiRPtQeyQ2lvff2RexBAH0gv1rWRgMV/V5kJuR4i5OGCu5uGnfsBKKTR7ZiyJqFEQeBeR/ng3P1kVu8v+qC6OFwWbCNxpQCupn1ggUIEw3yQueWBcX1nVbczlmD2xFHQy4lxA//csjoUfQ/gZAqkbK1kD8BPKE1CHScGc0pmDgI0xQhsLBqov1LYWG7oEM/ksGXkZqH7olEmnfIKl7IfBAf5kQ6cvr1HjHzGxffihp5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rf+R6AeWjsRAktss/M+IwIn2Qplj9pv7671kguICTnQ=;
 b=gyuhKbp8ZzcdTuuCR2GGYGPmprprkiFozJSGW0/k4lm5U0GS1N3cOO/kwf0wyeLg2yI/a08/Ts+xCIVOfuy+F8x64ZvChU7+WxdBKvsNBsYUok/iVHA/nSJ2KujM6LA5KhmEK4QnIeK4bCuUBvItmMPBGZA3/uRtQYBCoa3g15IA9H6USOQgfqZzsimmlGVbEWnkv/poJ7NunjZfsaZOWRUSE6YdvfpT0HkAXxbHeub6vpKykxE+P71g191cG3s/yCNZmkqSNXXAdn95kwjlXNrsigyLOAZ2FYUpx6lpCX5NI1buxk5NFD1dhNRI0mB5KXtilTVMkG92jT0lFDqk2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rf+R6AeWjsRAktss/M+IwIn2Qplj9pv7671kguICTnQ=;
 b=mIDkTq7tCPXeizXab6KAmdO14dgsPGDWPPVoF3regOap6TcGbRlrpyvS8k4FR0C7Xfce6ffUm2Ccg0XjjkG28KifiECCHH29gg+tPTuLJxh5+JnUrq5e1Fp2zUEsjKWThzXrLbfNiiJvX5sh2ci37M3MQC9mvrEuyGz/XQjw/nc=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 (2603:10a6:b10:109::23) by DBBPR08MB6315.eurprd08.prod.outlook.com
 (2603:10a6:10:209::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.5; Wed, 25 Nov
 2026 16:30:00 +0000
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62]) by BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62%6]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 16:30:00 +0000
Message-ID: <ca44753b-5d4c-4fc1-b4a7-acab1f009d04@arm.com>
Date: Wed, 25 Nov 2026 17:29:57 +0100
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v4 11/12] EDAC/ghes: Small buffer fixes for mem
 other_detail helpers
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@oss.qualcomm.com>,
 James Morse <james.morse@arm.com>, Mark Brown <broonie@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Tony Luck <tony.luck@intel.com>, Hanjun Guo <guohanjun@huawei.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 Dave Jiang <dave.jiang@intel.com>, Breno Leitao <leitao@debian.org>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Dan Williams <djbw@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Morduan Zang <zhangdandan@uniontech.com>,
 linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
 acpica-devel@lists.linux.dev
References: <20261113132600.3355836-1-pierre.gondois@arm.com>
 <20261113132600.3355836-12-pierre.gondois@arm.com>
 <20261124043051.GNawUS-yBnVpnuUVhH@fat_crate.local>
Content-Language: en-US
In-Reply-To: <20261124043051.GNawUS-yBnVpnuUVhH@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0501.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::8) To BESPR08MB999898.eurprd08.prod.outlook.com
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
	BESPR08MB999898:EE_|DBBPR08MB6315:EE_|MAD0EPF000008A9:EE_|FRZPR08MB11901:EE_
X-MS-Office365-Filtering-Correlation-Id: 02eafcde-645a-4377-c25f-08df4b116efd
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|18002099003|22082099003|6133799003|4143699003|261009223027099003|11063799006|56012099006|10067099003|261102123227099003|261026140227099003|261022105027099003|261022075727099003|261026121527099003|261021123027099003|261028144727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info-Original:
 Hb1efm1iKKLzdwY3IE22OPK88LmHMdHePMt+G78hLd4sVsTuUJMBolz0e92HCYxuCmmg3eT/snvGzlc+NKdJm9af3VRzVVVtjDt/K9QOYocziPps2XaSjnrjNZvHzR2SKr6vtAl0NQi+ahhYD4X1+LHjuQxIhEpEnqg5TQwD+AxQM1+qrAyBMs/eCZbhf8OnXKPm9WAkSBeeOd7U1HwHWwnoau4WZ58dFesMbQbrJNqjPAburuH+X6H65YihwailJ3RyDH6G81cFklMJz93tyqDhri0SxQNxkS3odcpcHAzQBcQUa6QE6Lf9YWK7a2VqNF5L47Awn1jU7ZInXNBf0jdQ/c8lwVmdWpAlo6susuGvUqL4MjvmwCWQJ21hyUkRQFrQybm9hTNhgqaRbKB6vOTSJphp2Og8Z8aOey0s4T90qeLqmJ+9LTWj7BWR1Tf/5poS+w+nMW1sQ4ZWHC3aeVBTDmMx5ZdcMHPReWZAjbLeKUXbfqI/jM+toJBxYGwMrz7sK1n1qsKBhLy6yrWUhKIXlNUv2tFRHYfCGqxsHFjVtGwcUWxZ3M77aDEtWn9GUGpBBpx7pTZMZT+ttkxCIJKjWEFAQ7u3cZ5F3F/xA/+lSZGkRrGhBKMbiPEef5/x
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESPR08MB999898.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(18002099003)(22082099003)(6133799003)(4143699003)(261009223027099003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261026140227099003)(261022105027099003)(261022075727099003)(261026121527099003)(261021123027099003)(261028144727099003)(261021121427099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 b//LL9WIV1SYMySbxgGCC3MwYzmxPzqsHVfgs6oyHh9bERRuPgYHKBuY7ipkEQRf55vCrUM6iJbsmJzfstRIWtQxGLchneQhVkxx2UWJKjAup664VhdfXNHQ/WHKrnqPKUsu+f7xyP14yI5AnTkikZj+A/gF9ihzgId8buWp0AKk1of1+q54QQNCaWeu6rX1CFORRhY0FQwa46mLn0+agPd/7+l93p9a7sq2jkwdyJTvDueoEMFv4lEcisMxO0OmOE+ioyoodxFAMYs/k0ZBnjQsK1U2MpJacMY0ilULUNJESeqP+ZLT3YvQ9bXJiKmr7vfrYn9F9inlVM0TdTAHgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6315
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 MAD0EPF000008A9.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	70d3d4a3-5dab-425b-40ce-08df4b11598b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|14060799003|23010399003|376014|7416014|35042699022|6133799003|4143699003|261009223027099003|22082099003|18002099003|56012099006|11063799006|10067099003|261102123227099003|261022075727099003|261021123027099003|261026140227099003|261021121427099003|261026121527099003|261022105027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	xwfNOMYM0FNrfIHYjqDhn9g2cq1cpAuvVWWZZHHX+qo5/1+pDl0Eh0W8GZ5duXx0J+8UrEorxYXvK3UjpTAHYKLqg+RQogJMaZ4/4KSpKHpjVbKDASeBVYxRi48NjYe0cWPyMRTLubm12z0kvUmH0V3v2+2GNBcHxybK3sRL2QrbgTPh3aL0GI6bXoNz1RwDA+DixdzBETb78gQYhou29AbKNJUAm2llCZsFiETzGBfkC4EgLYwWcYfkUHloatHTggpCoeYd2M4+ZSewxxPS9HCf7i4ke3uuom8FP9szSOj03OQZUfNjkDEOIdsrEvKf1enZ8N7Vam0KYJhY5U0aW7oU0+s5P1dBBnWOT9lBhQ0vg2tE2D+BCPXlMZ7+298Sa2EBY6o2OL8v3o6bVs62S+3zIXbuTpAeg43c5Nh8RbmisHF/Z8i3fN9k16pn4k1IgefU9ABeCSh1jzJ+Ww63sw2SDpbkZey6Nvm//1K+eqSsBBv4YTQ7SnJ4Uv6q0vmemJs9yxfDDUZI9ydLnC26oCYcNZoDczqVb4QPMTcII/ahfHFjY5w9rfh+BqRHFIplvudISUGX7+E3Itdo5yWA8FAI84HXO4mjeaSEr7mbu07aUMGE5emyby2fCWJAdodeKIe/3RM+JCrIvP/j6ouM2oRggOQc6ArybLOtpF6cscg=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(14060799003)(23010399003)(376014)(7416014)(35042699022)(6133799003)(4143699003)(261009223027099003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(261102123227099003)(261022075727099003)(261021123027099003)(261026140227099003)(261021121427099003)(261026121527099003)(261022105027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	D/TmxBgyS62TU+KYu1kAL0M1dVMNcO8/fhIiNBGX/yRb/MBLxgQQ7KUsJb72jgPr4jl9Xl6WEO20BJWLEqV/64Z5cWcKigpJtDj0gAxBnPti8mHPAA+tzpXyo31meuF3/lUXmoC8cN3QsPzVwWt5Lt7+ANSwVAB3S7EiJYX9GO4vzpS32amjz2BQsF47fRDDaJsdWHEpyNs+Vo6dBebsGdki9KqsCsaFPSh9XfNdYrB5oy4yTagdw9GzGvpUmWYTnO8dpWswgLu6+mr02vNcge/4Xv8uvTHcUMXZrCHbDI1rPHZAmwl6QDQBVgk2PusxYp0v4PmLpWbpGYguK8lI1RiG9wbI/x5wSAsjQdFBg053sS8m9+sVtrLI1Z1DsoKTy1o+XM311+4xPtxy+0XU0DLSXjfxooVB+jFIVCS+kq192f4y1Y/5QT4wFdlhsPqV
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:30:35.6392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02eafcde-645a-4377-c25f-08df4b116efd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008A9.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11901

Hello Borislav,

On 11/24/26 05:30, Borislav Petkov wrote:
> On Fri, Nov 13, 2026 at 02:24:53PM +0100, Pierre Gondois wrote:
>> scnprintf() already reserves space for the terminating NULL,
>> leaving one byte unused and under-flowing the capacity when len=0.
>> Callers also remove the last character unconditionally, which
>> can discard valid text after truncation.
>>
>> Update the following functions to fix the above issues.
>> - print_mem_error_other_detail()
>> - print_mem_error2_other_detail()
>>
>> Signed-off-by: Pierre Gondois<pierre.gondois@arm.com>
>> ---
>>   drivers/edac/ghes_edac.c | 18 ++++++++----------
>>   1 file changed, 8 insertions(+), 10 deletions(-)
> Fixes go *first* in a patchset. Then you don't have to fix a function you just
> added in your patchset.

Since the functions are effectively duplicated logic but must be
distinct as operating on different structures, I thought it would
be easier to review to first add the function duplicates and then
fix the 2 functions the same way.

I'll re-organize the patches following an order close to what
Yazen suggested at:
https://lore.kernel.org/all/20261124151417.GB2156781@yaz-khff2.amd.com/

I might take some 'fix' patches from:
https://lore.kernel.org/all/20261117111444.4185512-1-pierre.gondois@arm.com/
when possible/necessary.

> Also, the patch subject should have a verb.
Ok sure
> Also, those functions you're touching here look to me like they're duplicating
> a bunch of code...

I think this is what was advised by Jonathan at:

https://lore.kernel.org/all/20261014094744.00007c0c@oss.qualcomm.com/

Regards,
Pierre

