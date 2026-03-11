Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013039.outbound.protection.outlook.com [40.107.159.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB583D47B1;
	Wed, 11 Mar 2026 10:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.39
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773225988; cv=fail; b=u2lGnRQUVcwahxPj7sH5Hapyh0pJOTRt1lj0P0EBahum/lvMUJ5dFHSl4NwECFkEj8eersAPUGmdW64MFzcZ3wynBP9ARd+LqssGGgy2t7sYGV7FstatOHOTMu7z4Xi6/y1W/ARb6SAgYRKHU06z2mjCrq38thIpB47NXCy+7eA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773225988; c=relaxed/simple;
	bh=uv0Xe1BFI9cBRK9IdUzEFslX2g7+y/mDomz/KYE5q1o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DukvPjAA8qCxUHH/ZeT/kJs7FFd7lwH0/udTlT/8p16PVaqviC+3vtToyRyDh4LXvPRnPnOboPgW22VMp1eDaG83yvI7wp+X8AiiTk9MdSgjfWh4HJdQeRDv86Wg/TpN9iHQCRa26jlTp1YtfcOEVTA2UkYOhqcIYaJKBLpx2Dg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WIfR5/Vo; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WIfR5/Vo; arc=fail smtp.client-ip=40.107.159.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WIfR5/Vo";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WIfR5/Vo"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=crB8HcSrx81mYKiRj9MbGIe+vhXX8tgoV/3dx4LpIGbueFykdUpjV8X53rPi2A4FNYvn7VafAuAuSfI8EDyJD3t3CMM9un5PGlkKjR8YautbEVm7VQ6tjMOgJZooRqC3IbkT3uiPFThGsBHovdoIvtM1Hv9MXCiNtJlwR8lpQ2aY8teBfmNtpRZpfYD5jSwvnh78o5QRIWXdSXnOgOpEB5+MaKJQ3bRC15Z4KzGbpyo4KEnykPZiFgmEldYG476l7AkgygEnSoI1fdTWqXFprY9UEQ6LZbrEweM6N8vuK6J9UwlBLcPQvGr61Qcwg5AAje+LLgGjUPvsswcHD4yF7Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zzf83srxkXzKcR9rNOjEBz3ASbWdrwKKjH4BEjlt/Z8=;
 b=RO8o+cOpoiErfwY5jtqRVLOLS2o0c1McfyEFTWwvoYeEe38sm7+YGE6JpKHazjXReQOc6RgfXZGK9FMcE4HqVA+7bQx0proP1reUdh460/M2o4ucr0V49mG7r3nJhGvh79AA3m2e12rTpcu9Q966M1fgun/afPx4XQ2cBdZA7rA78hSr6XwqymQuMDLJVEdrNkfgXqmmXc4gqfMm02Ay/MopdqmixbbAeeFNNTHRxiTGnT4OE2EPTZ8aVhQKrAHxhYGFdpWQW0+pTOct0+Nl+GNdLJvaL2ySCOo4r6QO/A2crDqrzvwW6wC+Y7qF8jqEvCszkibqcgRjCs15bz6eyA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zzf83srxkXzKcR9rNOjEBz3ASbWdrwKKjH4BEjlt/Z8=;
 b=WIfR5/VoMvc1opz6DahS3S0uaPBhFzfnmj+NyWc7KWD2BCjBohXwA+nd2pz12l1dUmLOA3MExMhXlyCl+7lG28RCd6AV8bvGq2Fnb/Pdsle3E/qiwxcdpAQeFboE8b1BytrhztiCULYjyf8+Ffc8cwsbwCOxAiZhuNGlKC+KK9I=
Received: from DUZPR01CA0030.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::19) by DU5PR08MB10413.eurprd08.prod.outlook.com
 (2603:10a6:10:518::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 10:46:18 +0000
Received: from DB1PEPF000509ED.eurprd03.prod.outlook.com
 (2603:10a6:10:46b:cafe::11) by DUZPR01CA0030.outlook.office365.com
 (2603:10a6:10:46b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 10:46:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509ED.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.16
 via Frontend Transport; Wed, 11 Mar 2026 10:46:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ik4d8vk4LfmbgWtxIvcNpGXcE/sGDGksldnznrJ8g8mADx3LimMtjtxyE7h0gyAkaF/TzAmS/w85EAKccl1XCquxaMQhFP7P18DUOR8eh0+fB1WLgPHkeGMwHA3Qg09lVOC1+JmO9rr00rqwo1xtjqaLVszYOStnmQTrehaPDf1o8ApHFAjhuHMsm7FRxgx9ww42i477y/kequ4iEmpaJvbMw9eQnov917MULLSMwU0MrSnpMh2lE9KpNEIa+3jeDH/R/Y701ynIOOhbE2Tuy4PyrBcEuZ+3rXGLOWPmNryiATiK+9bZ/hiH+L0mz9HfC+7PidlKHduSR/VztAl3pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zzf83srxkXzKcR9rNOjEBz3ASbWdrwKKjH4BEjlt/Z8=;
 b=P6bJo4YCWvNJq1VavLs8iM0u6/EKgaRSydBf/tGcA8cUv7VN7Dj3jFOdzMjeEXttp0pA5AHhufU8hcgneSKVjEBDpx+3lt1ziL0vhgGsXB/yGwjxE9P4YBlb/XfMPaQVQu9jOvwhBYqSizGBdcSXG4MHYabGcdG7c9BKxOlKPOBOHT6tmHU47WALgERHdsDoxb4aFsvG3lkD6OwbCNfSg0vnJYeMKrboiDi9Us82ztgN2DMlTH1XKqVmpC4G7z1penz8Cki+Oo+gb041nSY+TRlykeq11bTEm/LnvSwllyWGlr3qAIiSz1ql5DG3BmbdL+zIhw9I+6Nrx4j82wiXAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zzf83srxkXzKcR9rNOjEBz3ASbWdrwKKjH4BEjlt/Z8=;
 b=WIfR5/VoMvc1opz6DahS3S0uaPBhFzfnmj+NyWc7KWD2BCjBohXwA+nd2pz12l1dUmLOA3MExMhXlyCl+7lG28RCd6AV8bvGq2Fnb/Pdsle3E/qiwxcdpAQeFboE8b1BytrhztiCULYjyf8+Ffc8cwsbwCOxAiZhuNGlKC+KK9I=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11823.eurprd08.prod.outlook.com (2603:10a6:800:324::5)
 by GV1PR08MB8620.eurprd08.prod.outlook.com (2603:10a6:150:84::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 10:45:11 +0000
Received: from VI0PR08MB11823.eurprd08.prod.outlook.com
 ([fe80::694c:3790:be1a:8ddd]) by VI0PR08MB11823.eurprd08.prod.outlook.com
 ([fe80::694c:3790:be1a:8ddd%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 10:45:11 +0000
Message-ID: <3ce33210-94d0-4220-bc58-142b51079aed@arm.com>
Date: Wed, 11 Mar 2026 10:44:51 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] ACPI: APEI: share GHES CPER helpers and add DT
 FFH provider
To: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 Dmitry.Lamerov@arm.com, catalin.marinas@arm.com, bp@alien8.de,
 robh@kernel.org, rafael@kernel.org, will@kernel.org, conor@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 krzk+dt@kernel.org, Michael.Zhao2@arm.com, tony.luck@intel.com
References: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-0-347fa2d7351b@arm.com>
 <CA+Ht8=a_fw-u2PLEf1GY7qYLT945OaJ0LeW6K+X2SvSWLqsrXA@mail.gmail.com>
Content-Language: en-GB
From: Ahmed Tiba <ahmed.tiba@arm.com>
In-Reply-To: <CA+Ht8=a_fw-u2PLEf1GY7qYLT945OaJ0LeW6K+X2SvSWLqsrXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0073.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::6) To VI0PR08MB11823.eurprd08.prod.outlook.com
 (2603:10a6:800:324::5)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB11823:EE_|GV1PR08MB8620:EE_|DB1PEPF000509ED:EE_|DU5PR08MB10413:EE_
X-MS-Office365-Filtering-Correlation-Id: 9425a41a-774b-4219-5dc6-08de7f5b6c45
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info-Original:
 4rNJe6ry+rkTLEkBeXYTKiT2HL0nN6MGhIMl5NCcvBm0BRDmx8PLvGB75+6Iyf5NeYAmFMAURleJpvAn53weJFFZsgjehczYk0mWFshHgzXB3hyMUVNj8b9X4CRTjYbSCycH29KLCx4KZ0WVcCK9+chxfxN/D2MMGK1Saey7SKktQqJuoop5taTXmTFj52HNMA2af6u4xONkBCAWwQJ59dHL81pyYZvzx4ivwKxQZlcbAQva7RIcbxpzLBqHhAIHQp1G4CrP2wvbi6jApIdeZQBGtD1N4LJplj78BghwOR2m/Hg7R0ucZlK5bnURN5zRrte5kKfMvdmKxR3SBSiqLvIxsdk9Ny2f5eQhV8wJ8ikOiLz6CPcrmKIddn4j0eeS8ViPJZtLLOjoD5pGjSwaVTpOvQAOOVdPgZV5LhjYjlcYqannU0I0b2CKEu3vy6SqyFrsTLAtSArbWCz4ysQyYm28ptVZtdqO/fJWjMiiU1MShdbLn3mCLCFGlj8aeoBB9jAg59a/LVMeYGwqm1lx1GeP9y4zgfcS3ouK3se/gIx2rCKp5K5vMSwN5H9T6nnOm03v9J9TUXbYmW4t2+cnpWYDNf/Uwpx0S+HCr1uBsnSyocbDgNDl8GO1ZYJBlzKeK598ZvM1zEXZYse1p6HLaumH9f9yHKk208cDr1872b1F6PaIbeD11l5+MUbMBZ79Xz9jwBmKv4QS5lcMZKNh7M0d8MjomwYlWwtB7F6nCStojluCZFtsfK3ywyhh19Zz
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB11823.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 XnsyYk/okXRTvaAs/2zdoLA4CF4T5cSnIApAFN1mg4ZVNrpm6U1LL1cTbkm4KbyEiJK+eHZx0c5X5tr1baJhHdAFC9OfOnvctdYMF5pPIK+ZxJUyEX+fuWD2R4h7tQI96fzojAqewCV1/XOsCwAHbAp/m6sPWMlICFikbc6OMcYAzWdT7v81gva7DnL2Lj9mdk+kHhmCTk8rP84iyddJB+T9UQ4Mty3StDBMTjTR9Z22xbfIlCcc6cYNyqjGvubEbWtltPIbPKECUpzvTtpGuyDP8LKgyLP7hXH0E+1H6+VkbWJ4Oz/Bm+E/eXdj1Mwu+WENHNB1K62xB9GsP4X/Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8620
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509ED.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1e3968a4-5ce0-4a1f-1338-08de7f5b44e6
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|82310400026|36860700016|376014|7416014|35042699022|13003099007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SW4FgeBcoq8nZW2xlr1JJWhgXkwtfhveumFoaOwduS62sdlie65TWzxi9K35z8+tter2dfJ+EbKUp0yzMMTiU6Y/9JZqh59E6jTuMLWmbvW9XyYYyvkH7RqAGT689G8wGCfi75o/c2xScCW2yFswVaHm6lVBmN0eBGTQ46r/e4K+xWkVkBICmDOau/Mbz8DPPXL5VUm1c74tfkya5uAa20/+qz32kHg5wH/NvqwS2eV0OgGnD7w22awSY304dzP+hpt1o4b3MNG1jRM/YWuXrptuFUogUODjrxzcgXBUBqMcURpL0a1bMd7p0Qfyg38fYgV6XwANpAQ4aesDRsrQSw7aberMV5lqB95kmRRhJWmYEWRFBfSVl3gD5z6rdfpElbqSwG0keeeyKMgArOEOFXkvCCpgQr5KMeVbi7mhCHCWrFtJY9Zxsxd5KA1N/+IN9F12UYUKXKjBf828Zio9CMHcG0Wm5WvSRlS7+c0yldWuIZ5oPol2iCWSJLdgiqEZZrWrWe9nDXO8okbcRu+SNOubudcgUA/QebuY+24k2HPrGPKZsPFA0FGEs0/u3v427V9r2l6MKLBDkgOFZsRlcvDt0TUYSROkUTVHmids1DZ6eDXkces1nOpjjTbTJXeMbQjjTqo+Ze+o61Bfs4dw9b7RmQkk4026mrkSx+CDjNhalypnbdMvzcyhv2kdvRv3F70YrnVWrvOYYZ98VOz2EXsk63L/jEKxzUin+cjY2X2efgqopG9i4cR35CAwgwv8G1o/1qDegZZRdBv0CeIT6Q==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(82310400026)(36860700016)(376014)(7416014)(35042699022)(13003099007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9oS32He7TTjwCTlZvC5cG2FNIhfiIlhhc4OP0enzsEhYCZC3esQsfaF+/WgWmEkHig9pBcuPPVSputtZWC8R3+x0Suzyi9iCrvBtl7u0tBdFL4FQSDD3kgQOhWaUMjsJF0kPLr0qLp4NSYTCWwQayPUTAOMwiOFTekiLP14RWEnOZ4kJHgCjYL2shIGZ45VdLEegEjuD7b2YywDofiVqJZ7h1T9FDjuDaTGtS47r8+etnWsozZHnP0PK/wa5nisNZKKfxATycoFbF/0uiFToJodF19kYu65uLcJzofNHhQkuz3Xbcwo3BhJ3qw/roTlwnGn4Je3IGHsWEYCW0qkZ+uHARAkEQiqGg2QhiAPVUczlfj5wEZiBMK07SMn+EF7gqc2zsdwRPYUJB0dGlomnwlADGwr3S8MVAIKC2XZHUZ+g8M48wjG8GFS0Wy/RRwOE
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 10:46:16.7399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9425a41a-774b-4219-5dc6-08de7f5b6c45
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509ED.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10413

On 26/02/2026 07:05, Himanshu Chauhan wrote:
> On Fri, Feb 20, 2026 at 7:14 PM Ahmed Tiba <ahmed.tiba@arm.com> wrote:
>>
>> This is v2 of the GHES refactor series. The goal is to reuse existing
>> GHES CPER handling for non-ACPI platforms without changing the GHES
>> flow or naming, and add a DT firmware-first CPER provider, while
>> keeping the changes mechanical and reviewable.
> 
> It seems almost all the code is being moved from ghes.c to ghes_cper.c
> in multiple patches. It is not making sense and looks like an
> unnecessary churn.
> What is that which can't be handled in a separate file for non-ACPI platforms?

The intent is to reuse the existing GHES CPER parsing
and reporting logic for non‑ACPI platforms without duplicating it.
That does require moving the shared CPER handling into a common helper 
file so both GHES and the DT provider call the same code.

>>
>> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
>> ---
>> Changes in v2:
>> - Dropped the proposed "estatus core" and kept GHES naming/flow intact
>>    (per Borislav Petkov).
>> - Re-sliced the series into smaller mechanical steps (per Mauro Carvalho Chehab).
>> - Minor DT binding fixes based on Krzysztof Kozlowski's feedback.
>> - Removed fixmap slot usage from the DT FFH driver (per Will Deacon).
>>
>> Series structure:
>> - Patches 1-8 are mechanical moves only and do not change behavior.
>> - Patch 9 wires the shared helpers back into GHES.
>> - The DT firmware-first CPER buffer provider is added in the final patches.
>> - "ACPI: APEI: introduce GHES helper" is internal build glue only
>>    and does not introduce a new user-visible configuration option.
>>
>> - Link to v1: https://lore.kernel.org/r/20251217112845.1814119-1-ahmed.tiba@arm.com
>>
>> ---
>> Ahmed Tiba (11):
>>        ACPI: APEI: GHES: share macros via a private header
>>        ACPI: APEI: GHES: add ghes_cper.o stub
>>        ACPI: APEI: GHES: move CPER read helpers
>>        ACPI: APEI: GHES: move GHESv2 ack and alloc helpers
>>        ACPI: APEI: GHES: move estatus cache helpers
>>        ACPI: APEI: GHES: move vendor record helpers
>>        ACPI: APEI: GHES: move CXL CPER helpers
>>        ACPI: APEI: introduce GHES helper
>>        ACPI: APEI: share GHES CPER helpers
>>        dt-bindings: firmware: add arm,ras-ffh
>>        RAS: add DeviceTree firmware-first CPER provider
>>
>>   Documentation/admin-guide/RAS/main.rst             |   18 +
>>   .../devicetree/bindings/firmware/arm,ras-ffh.yaml  |   71 ++
>>   MAINTAINERS                                        |    6 +
>>   drivers/Makefile                                   |    1 +
>>   drivers/acpi/Kconfig                               |    4 +
>>   drivers/acpi/apei/Kconfig                          |    1 +
>>   drivers/acpi/apei/apei-internal.h                  |   10 +-
>>   drivers/acpi/apei/ghes.c                           | 1024 +------------------
>>   drivers/acpi/apei/ghes_cper.c                      | 1026 ++++++++++++++++++++
>>   drivers/ras/Kconfig                                |   12 +
>>   drivers/ras/Makefile                               |    1 +
>>   drivers/ras/esource-dt.c                           |  264 +++++
>>   include/acpi/ghes.h                                |   10 +-
>>   include/acpi/ghes_cper.h                           |  143 +++
>>   include/cxl/event.h                                |    2 +-
>>   15 files changed, 1558 insertions(+), 1035 deletions(-)
>> ---
>> base-commit: 8bf22c33e7a172fbc72464f4cc484d23a6b412ba
>> change-id: 20260220-topics-ahmtib01-ras_ffh_arm_internal_review-bfddc7fc7cab
>>
>> Best regards,
>> --
>> Ahmed Tiba <ahmed.tiba@arm.com>
>>
>>

