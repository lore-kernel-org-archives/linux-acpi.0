Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.72.66
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793380609;
	b=XrllMenKN7WtGWA42ZqW8DlddxDZBcqXPrqIi4uFcWGYcXBw1aICLkg5OR2wbdnN6z97
	 4s3wtQBOPmJponu1xjkmfMOQw68ZSTB+nf7wyeEDHPtjIEpLAyI8IgLitB0HOHeIZaUSc
	 b5fcgmy5FZiCL7IFWEEFJzUiK0jmDNgpl42I22j9De43c0xWY9gr+Bu7vSaSG3QcJewq1
	 s+aqvb+AYGxqvG8irc6kBQXhKsiCDIsJ7F7N+rc3br+sBEhvw7breGnIjoKo9UFEn6WDE
	 zZdW6tAROPxoRelTiRrd74edgwlfZXmCCXRy+bY6ROmj3AhgUYElOXwOGBHlSZYrMbw==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380609;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
	 DKIM-Signature:Authentication-Results-Original:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:x-checkrecipientrouted:
	 NoDisclaimer:X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam-Untrusted:
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
	bh=ulftxReYr3KHrT+I7F0fbXgqGCGzvpAVtxC4AQT6UhE=;
	b=3I0fFRvvkT5YUg9LzzXsNv9OrTeCE+OVgW2ph+Xu55Y/cPm492rMTfOCFY+4P6L+caVf
	 7+au8B6YCAUPSLAo7dONzFvGwgatXIV1HSduFMVOo+CJncYSUNPftgw043m/AVw2L5aG/
	 zZjnzX/mxElwRErJ+kPTEhAL5S0NArkZMBFfSA9i/py3EdRYj7OMFMQTmfe0eNjYUvgg+
	 ThTNmCVGtA4jliUbwzipA1IqupC4VlA4MFE8lt5jN5JDoXeTQUjPOp2mORycvDbxnmp2+
	 C/veNOq1CYWq4qGdksczmB8WUpTN6oFN1U4hXUU9W+fkkTsXRxV2wvIRQyen+uzGrwg==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=AmIGbwHC;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=AmIGbwHC;
	arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.72.66
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013066.outbound.protection.outlook.com [52.101.72.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC4C606A31C;
	Fri, 30 Oct 2026 17:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFC4C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=AmIGbwHC;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=AmIGbwHC
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=T/NMudMKW5LqNz9gQfK729TKxbOo2k2yvcljHmVkzLlw7mnOoc0Zi+ZOAeEuxvuUuOWaI6Thrk4N4XW0RWrOhLg+NdXS1JVtXfE4sCrZKMvrquq/jTW+VVO2Nixl41vRe7FLg8oUGfKKNz9ydB0fXHGPKYlxvndw+Pklq5QJrrA5nt0wcEM8Jl4TtYq3tVr64YbK00ws9YThYkhVjUTwQLRliAfuN+yToLRLIAuKrKL838wGKKLDslcOBYa9O+lpkOkd/4TbbrkBLBNTCTxFj9iAjI5wn7jC3bRj49C/XxbuWVx8VmOgW1BdddT2UWoqClm00Lj2imf7FTPoHRPnTA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulftxReYr3KHrT+I7F0fbXgqGCGzvpAVtxC4AQT6UhE=;
 b=TCsK1pu4Fqob7zGcVEGBBj03PCWrl3HYtFKmnmYcsaqmWjmrsuHS+TF+hbdEqjFe9bsSw+rMIMViHFHo1BT2mIq9+ajnKZqm194pVfMbG0F4lZdgvkbl1R6nQ5BOeTa2zW84ENtYLv3dLO9LvEIdFv6JdxS1QqtE6YWOQJdrEEJfaHYCZoJTkKR7FmfAmblNe3Xgko0B63tU12RfQjKqSiIbaKYML/ns5Oso50iz9DCj3tpuWiHD1GcfT0vaNowud4L0bDjIgZmhRDuzxo1mrembz30cY9ZyHthIUpEEpkgwzYySDc2p21/NHkUtKx1sWNe7jN349P1Y5eIxY1tM1w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulftxReYr3KHrT+I7F0fbXgqGCGzvpAVtxC4AQT6UhE=;
 b=AmIGbwHCXHHVfYcNtDKkZ7wnkBNYc1eB3JKtNavOaAx/lWEVDm7q3FnIqof8baO7w3A96WKok2FGJvk+y2Y3AuPxg00BVgEKVnPjZAqTRgbVF+nMcKhX0AYeifsd9Yfe1HdI3e4r4C0ZuOo+yLW2T+H2kXx4eTGT+OZEt2dLuDE=
Received: from DU2PR04CA0086.eurprd04.prod.outlook.com (2603:10a6:10:232::31)
 by DB9PR08MB8268.eurprd08.prod.outlook.com (2603:10a6:10:3c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 17:16:41 +0000
Received: from DU2PEPF00028D05.eurprd03.prod.outlook.com
 (2603:10a6:10:232:cafe::22) by DU2PR04CA0086.outlook.office365.com
 (2603:10a6:10:232::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Fri, 30
 Oct 2026 17:16:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D05.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.4
 via Frontend Transport; Fri, 30 Oct 2026 17:16:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vYC8t/69vf6PIYfn4hzqe/+j2Ep7SeazFbinhHSGHFyJHOtaG0h5uPvi9GPtlSUwSmo274d7lamwASqbDTRLicTlDVte2LX5ZY/P7xiemRmoExrs+i4mG68lzye1eCNjHoFrTEcCYdIzoG1hbyDm8NWpMpbAoCb6sPrZn5JirZXt8F6Q7DOlhFV41adQxg7Il5q9ScQxKPeTBNjE6oAQmRb4ncrF0SnSVHOpcePyfT3vjpYqewUX/A5Rg3KVjxxFhPElVRjMHYs3fmjCDSo/pxYzbLIc7Soq9+HDnpXqNAJ9h3gPD1OIVdWrWMLMAZOa+gCwbg8aHfez1Or7QfBWYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulftxReYr3KHrT+I7F0fbXgqGCGzvpAVtxC4AQT6UhE=;
 b=XWb/Q8ntMqyaNtyJRLktsxijnZShKc9j5ykFGhJpyrvhNR3psiWjxL0A/pk51YlI+PIjjqU3db/3fpTATuES9q7cKeKW5KrnS5PN0DqQ6wrxpnjfpkm+kBqLmYua8FSpMf+c04wLVm9fv439Wf9OWkDrHNR/CfKE5ycg8H5xZBM5hsvloUYQ3J76Pwc1PeNMg/Xoll+aAuZQZmBIoJko5s+z+Ihb8XaMPLwpfeg1vSve+Era16yE2+lJtTkBYXQO1IfTaralZjvJ4UcdE56gXQrNESRKkZbX/Zmhxh4tf8yx3FUaE93iebHmK+cVPu2uVmHw2MzanYKJm4x1Zpm8PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulftxReYr3KHrT+I7F0fbXgqGCGzvpAVtxC4AQT6UhE=;
 b=AmIGbwHCXHHVfYcNtDKkZ7wnkBNYc1eB3JKtNavOaAx/lWEVDm7q3FnIqof8baO7w3A96WKok2FGJvk+y2Y3AuPxg00BVgEKVnPjZAqTRgbVF+nMcKhX0AYeifsd9Yfe1HdI3e4r4C0ZuOo+yLW2T+H2kXx4eTGT+OZEt2dLuDE=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 (2603:10a6:b10:109::23) by AS8PR08MB7369.eurprd08.prod.outlook.com
 (2603:10a6:20b:445::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 17:16:08 +0000
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62]) by BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 17:16:08 +0000
Message-ID: <fdbce441-921f-4ef9-9c57-0685706cdf89@arm.com>
Date: Fri, 30 Oct 2026 18:16:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] CPER: Add Memory Error Section 2 support
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Ashok Raj <ashok.raj@oss.qualcomm.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
 Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Dave Jiang <dave.jiang@intel.com>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Breno Leitao <leitao@debian.org>, Dan Williams <djbw@kernel.org>,
 Terry Bowman <terry.bowman@amd.com>, Ard Biesheuvel <ardb@kernel.org>,
 Morduan Zang <zhangdandan@uniontech.com>, linux-acpi@vger.kernel.org,
 linux-edac@vger.kernel.org, acpica-devel@lists.linux.dev,
 Ashok Raj <ashoraj@qti.qualcomm.com>
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
 <20261020101048.00000186@oss.qualcomm.com>
 <0817615d-5e96-4a3a-b39e-3e5d1b88e716@arm.com>
 <20261023142621.00007051@oss.qualcomm.com> <20261024003917.283b890d@foz.lan>
 <20261023170405.000060b8@oss.qualcomm.com>
 <at0rs4parlHFGI7k@hu-ashoraj-lv.qualcomm.com>
 <43301529-f169-493c-bc59-fa08b77e1ef3@arm.com>
 <20261030081941.000040e7@oss.qualcomm.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20261030081941.000040e7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0447.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:398::11) To BESPR08MB999898.eurprd08.prod.outlook.com
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
	BESPR08MB999898:EE_|AS8PR08MB7369:EE_|DU2PEPF00028D05:EE_|DB9PR08MB8268:EE_
X-MS-Office365-Filtering-Correlation-Id: e35c5147-a201-4959-9e18-08df36a99069
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|10070799003|366016|23010399003|1800799024|6133799003|18002099003|22082099003|56012099006|11063799006|4143699003|5023799004|261026140227099003|261026121527099003|261028144727099003|10067099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info-Original:
 eSBLfTJMpR5y4W+O6eScFei5b05vMYdqF7Pge/ZRYkf0fHghqZckl3x609JNH7cbbSx/eF5C3MBwP899zBigsxj5C4f9+GXtRc7TIVnNe5kKcEd9vEzNN0hmKZenXjHk+wY0zZGnADaXGi8h9jYzzpid39FCqllmEPmJIffuqPRWyaXi6j3qq75cT/1boFhzyT0bA/MJyiML+gBxI1qRvYk1zmL5kGQbIOS8Z3oE6i+onWVjdleELfLf535eSIDib6OnxneXztAOOPLg6+NqDfy3SmXJ3V2ABiieu2j9kGuIbYZt1N3O3jRris6GoCVISucvZkhHMzTmi3N+W7DQuW57niLUZilFYqWn2S6i7gCxEEjAiRH6qgWsk9DHZrcPHsLX4zXf6D1C17kwrt5PyeGuM9olkbld6fBGTPZYm5X+l6fK1n9xzBUQq06Otx6ycbca5ZdBCSllM8XMdgFqVQJywjF0vjYQC0gtMKVtiJPP3+AGaMkAc6kVPgv8tP8VKTreDdJ1Eh6fStuvfQGZp7Wf+lsFpHrcPrgTrVX5Ne0vt7bZ9GX8Js8jLgs8EK5zHNCUWUNLf6L4wLPmn1lZOAFr8XOsrAlmc6EDwCgUd0Y5/dmPEOLf54i2tEXmhdaQKjPncSARXGrJsp0nQ//TmDXhLu4LNBNHKVzcwo9FJ3I=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESPR08MB999898.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(366016)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(5023799004)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 ST5S8cX5YdjxPW31kmH+oj3X3Ie4GYBPSb1X5yflix+3NNYWcFT03MfM4t5lWm9YOFMfuXZfb5Fk9KjYVht4kqWsoKgEgOLeLU2FDwL46Fexu/fh8LdzEJJB86/euGOohHTSth/IkjJfVj9x4iEoAGDa6ScqJTsiVsGzUEm+ngQv1b0w4pFx+JxUOm4eS2js4+Zghp0FOCbIrKSouHmSVLPZfgLFIov8DoeUdLOl9Fa9sMsHQz5Nv4hi6fq2Eic7pQu72YrwcZo1S/7E7MkNNKLs7QEzmHvobv0YxYhyjc8GqdhJLADfxLEGCQ4xq+nwQEh86/NQbxuWLTPYSrKgYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7369
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D05.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1127707c-d5e7-4a97-cbe8-08df36a97cdf
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|36860700016|82310400026|35042699022|376014|7416014|23010399003|30052699003|1800799024|6133799003|10067099003|18002099003|22082099003|56012099006|5023799004|4143699003|11063799006|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	kZN5iWkqgaJJF5ssaHEiohPJ+5udJvQeNlZ2cZmWlIAkI2nrOqYiuvrBdG9FzE+Y2efXdQokknWIz184ryF4d7MR+VjAmDtLtAhw5sQjB5a0o6gkbHl5Pov/lnwINL+olon4MiTfNeRlKvctX7Z82PG9AiqmAsTrnCo2rkYI/2XBqqhBoIh3CR4WqxD2ryTBKGIqLWsdwm6j5HXgUcitlnWk9YGmNkVmEG68zJ8My5nCcJZgvLJlEvLenvQAtpytXDXLTmZ1579RmRUK4M54Zih3sYwHjqdW3GHd0I7lI+TNW6vJhtaMnPXs+cabUnFbEHn/EXez35waoSAIFWCTHEJ7E6xAR/rU7etRgrb/lF5A80fmO6+T+8KXSf3IPEp8mUZKRzv95mt6X0b6Vmh53N8VfKJ0AMjhRIT5I0vMH5WLWOOMRMAp8ntbvHt7bZMwwu5DDPusxuAhjbc1ZJaVaVrWxM4oxe4q4zMmJd2EQ6dlegj1oDA/1d7+EtkWRLPaeVlI2d64XbvQ+UqKrflFl6FF/XJPtfIyoWMtvQahzohgtQuYVIXnXemHS32sIh2GCMMkLbYbP26vk5HNmKcCBsSHn0dFyqcRMqCXUjpR7BOkUC11biulwanU0cmxxW5YmfQDrv+n+0GSsQdH347lvWfOmKAi2QZCllnevDJ2Qd9iJiGMEl7aFl9fBfFBSF7V7OpwQJYzfZozXHwAbgO8/Q==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(36860700016)(82310400026)(35042699022)(376014)(7416014)(23010399003)(30052699003)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(5023799004)(4143699003)(11063799006)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pZD7aFbIlkJzg3uuR8cvsmz35m/F9VOggNzhVXrHaft+FYKsngyBzJr0Uv0438qdKMg/bxtjAKVeZNv1DTziu0PQrjSWbnIqmcpFCeObo2pFCoB9bMgaEDZhkV/SLWylBXm8iBhHlaj2Yp+wYz/vhjHeqCUf3VnJqDnQBrppqZYtYJYie8xukHWJ18IBIWnT/cxigYp1wwN7c79t8MKXtHgplQY2zc4SZ/wbRtjtSBzNUf0/202errkY2NJUmxF1FVKZ7DAIt15chxBOmY4nEDCp74HB5AdqORQDKVAzst3mertBoRGqEK9bWqVZOY3I3nHp9Bb/LSfhSNX0TaUrHDLFaXJ3srXEWf+zeJEuZCBYdcVDEXM5qriInEexObnHVp5tthyLVbWX9w/dkr4HDZ+v8HDnwo1d72Itdr2CJghty1abLAfBXRK0jGd18kn0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 17:16:40.9046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e35c5147-a201-4959-9e18-08df36a99069
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D05.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8268


On 10/30/26 16:19, Jonathan Cameron wrote:
> On Fri, 30 Oct 2026 12:51:47 +0100
> Pierre Gondois <pierre.gondois@arm.com> wrote:
>
>> On 10/25/26 00:05, Ashok Raj wrote:
>>> On Fri, Oct 23, 2026 at 05:04:05PM -0700, Jonathan Cameron wrote:
>>>> On Sat, 24 Oct 2026 00:40:33 +0200
>>>> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
>>>>   
>>>>> On Fri, 23 Oct 2026 14:26:21 -0700
>>>>> Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:
>>>>>   
>>>>>> On Thu, 22 Oct 2026 09:07:25 +0200
>>>>>> Pierre Gondois <pierre.gondois@arm.com> wrote:
>>>>>>       
>>>>>>> On 10/20/26 19:10, Jonathan Cameron wrote:
>>>>>>>> On Mon, 19 Oct 2026 22:38:39 +0200
>>>>>>>> Pierre Gondois <pierre.gondois@arm.com> wrote:
>>>>>>>>          
>>>>>>>>> The support is mostly duplicated from Memory Error Section handling.
>>>>>>>>> Other than differences coming from the content of  Memory Error
>>>>>>>>> Section 1 and 2, differences in the support are:
>>>>>>>>>
>>>>>>>>> - v2 do not rely on a compact "struct cper_mem_err_compact" struct.
>>>>>>>>> This structure was used to support older versions of the Memory
>>>>>>>>> Error Section (1). This is not needed for the new structure.
>>>>>>>>>
>>>>>>>>> - The compact version is also used by the tracing framework.
>>>>>>>>> To avoid relying and propagating a non-standard record format,
>>>>>>>>> through trace event (cf. extlog_mem event) the new trace event
>>>>>>>>> prints each field individually.
>>>>>>>>>
>>>>>>>>> The last patch of the serie was only build-tested due to the
>>>>>>>>> absence of relevant hardware. apei_mce_report_mem_error() and
>>>>>>>>> arch_apei_report_mem_error() implementations were also removed since
>>>>>>>>> last version.
>>>>>>>>>
>>>>>>>>> It will also require a proper handling from the rasdaemon. Applying
>>>>>>>>> this last patch without rasdaemon support will silent the reports of
>>>>>>>>> Memory Error Section 2 error, cf. ras_userspace_consumers() check.
>>>>>>>> Hi Pierre,
>>>>>>>>
>>>>>>>> I'd slow down a bit.  We are mid merge window and convention is normally
>>>>>>>> one version a week or so anyway.  Better to gather up feedback from
>>>>>>>> a number of folk and spin only one revision to cover it all.
>>>>>>>>          
>>>>>>> Hello Jonathan,
>>>>>>>
>>>>>>> Ok sure, as the v1 was reviewed quickly I thought there was a chance
>>>>>>> of having the serie accepted quickly aswell. I ll wait a bit more.
>>>>>>>
>>>>>>> Thanks for the review,
>>>>>>>
>>>>>>> Pierre
>>>>>>>         
>>>>>> A general question that came up in a related thread with one of
>>>>>> our RAS architects. How does firmware decide what to send?  As far as
>>>>>> I can tell firwmare has no way to know whether the OS understands the CPER
>>>>>> Memory Section 2.
>>>>>>
>>>>>> So options that come to mind.
>>>>>> 1. Firmware must send a CPER with both Memory Section and Memory Section 2.
>>>>> Please don't do this: this would require either Kernespace or userspace to
>>>>> discard one of the reports, only if the other one is there, which can be
>>>>> tricky. Could be done more easily at userspace, but only if some database
>>>>> support is enabled, but, at least on rasdaemon, this is an optional module.
>>>> Good. That confirms my view that is horrible.
>>> Hi Jonathan,
>>>
>>> I agree that an _OSC capability is the right long-term solution.
>>>
>>> Firmware should select one native CPER format based on OS support, rather
>>> than emit both Section 1 and Section 2 and leave deduplication to the OS
>>> or userspace.
>>>
>>> For a Section 2-capable kernel, we may still avoid a second GHES notifier
>>> chain: preserve the existing struct cper_sec_mem_err * contract and give
>>> it a lossy Section 1 projection of a Section 2 record. The conversion must
>>> translate validation bits and clear validity for values that cannot be
>>> represented, rather than truncate them.
>> I understand we might want to emit a new extlog_mem2_event and a lossy
>> extlog_mem_event for legacy userspace, but I'm not sure to follow how
>> you want to do it.
>>
>> Do you suggest that we only need one notifier (ghes_report_mem_chain)
>> and that we should not add ghes_report_mem2_chain ? This would mean
>> that the .notifier_call (= ghes_edac_report_mem_error) should handle
>> both cper_sec_mem_err/cper_sec_mem_err2 struct.
>>
>> Another solution would be to keep the ghes_report_mem2_chain,
>> which would be responsible of creating the lossy v1 struct and
>> triggering the original ghes_report_mem_chain.
>>
>>> That preserves legacy EDAC consumers, but cannot carry all Section 2 data.
>>> Updated userspace needs the native Section 2 payload through a
>>> full-fidelity path, such as the existing GUID-tagged raw CPER event.
>>>
>>> This does mean an updated userspace listener may receive both the legacy
>>> EDAC summary and the raw Section 2 record for the same firmware error.
>>> They are two kernel views, not two firmware reports. We should therefore
>>> add a shared GHES record/section ID to both events, so userspace can
>>> correlate them reliably; address and timestamp are not sufficient.
>>>
>>> So _OSC solves firmware selection for old versus new kernels, while a
>>> Section 1 projection plus the raw payload handles legacy versus updated
>>> consumers on a new kernel.
>>>
>>> Thoughts?
>> This will put more burden on the firmware, but this seems the right
>> thing to do. I ll share the thread with the group working more closely
>> on the architecture aswell,
> We have will have a code first proposal for the _OSC part shortly. Just going
> through internal review.  I'll make sure you + others here are on the +CC.

Ok thanks,
If you can also also add Mark Brown <broonie@kernel.org>


