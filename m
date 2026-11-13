Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794608983;
	b=YsKKLAqQiAnuCt46yFVS1hTDlULMk1RUZnoscrJhTraU+DionCIHa9+NQ2oJL+6p6A+n
	 njZyLpsrnT1h5sWYWyKfpLMOSw7nHJZqit6GhbRccGCqJrEmmnqdtskominVCf/o0gmW4
	 /43Nw8TagG2gQCaek+SNUJTseKQ4sRnk+kw48JysJbqdO7dmPCiy7lJ7mkbzHT7ccbQNO
	 sw5XZd7TYU6NfjLVdXBxXMpCKUEypPifn4MjQsvO1c06uRmGV7NAhGxQK1PbufF5f/Qyv
	 BACJNHWJCSkODT9g1xcDADUXwQiAli60mFzUn7O4+BEVFVoMjpQ64FD9Nzv9ca2/FDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608983;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=85C/HB1Wy7c1JuLAlOGAaZg+ayin4MQ9IU8l0Fm1QJQ=;
	b=JQe0lNOt5xhS5EplFQBwXRy5DxgaAI/C650N0gYsROwQVuL3jFkFNph7Mpvghd7TJXcq
	 yIkr71jQ4qjAh35KSLYO7ZRxJG3tZTBBagD19IhXiw7TGDiV4pwR5nxLM6B0RYLqjHMXJ
	 nFh87gZjlVV5fXac3GQ/ma2DRmHoFnYQ8aOEOiojiJcMX2HpW7+hVBtizS7JI73t7lwBW
	 RI9e59U4BK1fYwb4r/x8FCI1sPgyIPCKi1UeJv8bK3q4uAvN4ANLX8nhGRXR0+r+/s+KW
	 a02kagHh+VV7IAbwWu2tD9EJRKEFjLzrUpES2oAoDT9rsq+2C+oNGbwtgCmtRb2Jjrg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="Ca/PKrvk";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.61
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB69606A8B3
	for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 22:29:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DB69606A8B3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Ca/PKrvk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nr1gmSmMrvh3agQfEhb+K/bnSN8ZrpbO+PoOvnoOOkwmWhhKI9itVMVcIjyILscmLLUBfmlRicE7nayq5VnWTz6G6tmMxencmCm/3obzHmIdkxXKodHzm8jyv6S3AXi4d5pS4kYfsJ4hYE55j7zo7IibpjbbTaiXPFRjndKo9Gy1VB9B5Q/sYEoxodOXXTxhKvrt5i21FP2ixWv1kfnPpnuL8p4187gMUI7a2A7ChQAi1THP2XMfrxmm9wCtSHDn52j6aVCy5+VI45jX1iudO5+yPr887MclTXzipNZQO/QAXyA9Xrbfj+1kNohszQbPeiYFLzejUD2kOsm61DxhEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85C/HB1Wy7c1JuLAlOGAaZg+ayin4MQ9IU8l0Fm1QJQ=;
 b=ZCWXXucocsCd2q4ak/1DCDClINRyeaM/efzrmOycLXsPJQRe0WtT98Y7MrRAhzmOTUROJ4gcc/l3AcoVq+RiBwZJu316zlvWbvnICvYuC/A4gBpH/NWVo3yBr3AkzBPzZqTNosQMoFGmdC6UnJ29geamwhegCm0Ju13Z+U4Pqk7pElz+EmnouHipTJchEZlooSx63BQXplTVt0SAsNV+y7xAStJcQ4mYiXECPGkisKIhYht8zNqDR5zOyRp3BC5mkJowlrYN5Yv1ACOxoFcVzMCY0Cwu+LZ4ViOiWe29sYpiioxVOyeiSWzCxdEfry1Vc8eyombewMmPwBps7jHJGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85C/HB1Wy7c1JuLAlOGAaZg+ayin4MQ9IU8l0Fm1QJQ=;
 b=Ca/PKrvk0dOffxONnJgDjJ2mn4Yn0LfGtZyFIJPS1JaqjvQfFIv8OEbuU/tm2NWQMI4wIvy8UVT53Z7UIGnYassB3oCJg6nei0loqih143sbd0kjMwjLLHZgF9sJO1elV12n+YTply9ZkMiX+YoVnrxRGMZ7hoKaWrxzdK9Ayqk9jLboP46OoxL+W6ybABwotJF8ouepfs9G4luvunuwOVPhvsGlIiHCGz2OzKDk7q1X9wpUeKo+ETbo4VH38z186u2N0r39U7LsRhWKSKRmKqffkToCm7pdtiT6WSye8Sayv9SvhqPBetLSffKk415yOvEoTadgyfU5fTPrtCOXxA==
Received: from PH8PR07CA0031.namprd07.prod.outlook.com (2603:10b6:510:2cf::11)
 by CY8PR12MB7633.namprd12.prod.outlook.com (2603:10b6:930:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 22:29:03 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:510:2cf:cafe::60) by PH8PR07CA0031.outlook.office365.com
 (2603:10b6:510:2cf::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 22:29:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 22:29:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 13 Nov
 2026 09:45:18 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 13 Nov
 2026 09:35:23 -0800
Received: from dgx-1v-42.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Fri, 13 Nov 2026 09:35:23 -0800
From: Jamie Nguyen <jamien@nvidia.com>
To: Sudeep Holla <sudeep.holla@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Dat
 Mach <dmach@nvidia.com>
Subject: Re: [PATCH v2 0/3] ACPI: Arm FFH: Add support for OpRegion Offset 2 (FF-A DIRECT_REQ2)
Date: Fri, 13 Nov 2026 09:35:22 -0800
Message-ID: <20261113173522.1544082-1-jamien@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112-acpi_ffh_ffa-v2-0-575a9dbed22b@kernel.org>
References: <20261112-acpi_ffh_ffa-v2-0-575a9dbed22b@kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|CY8PR12MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: cc4e413d-537e-41e1-9a28-08df41d5854c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|11063799006|56012099006|261021121427099003|261026140227099003|10067099003|261022105027099003|261028144727099003|261102123227099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
 eItHvna0/3sp7SNxw/ZQLR5Qt9k5gRRrmWdfjGVXfG7eLYXNaeHagNT3vXRXspq63HYtc9qXHAVUkpFH6SXwteeeR4pvXUsbz8Z6hKgh6TjiYa/FAIYPXf/sDUcRpu1gzqiUQOTOanSfGXnn2E9jklwrcL917nzEockqEE6GjE8hTpjQgu/bXpdAN+c13jX64yy+ipGzFn8v9UgMoNACkSjHpPFu6Wv5R4EfCQZqpUIzxk+adfC5AoznBVYtpE7wausS5nAEAGHY+geRUvUG+BBBBQuobYStQkWH7F3pume3hC/abTiwlPZyPqu23ruTaexfHBaQ0jwH2wZF2wCChPfIU6WTsmNIDewItI/NROKSgksd49vRblwS2AxVoUs9sCBM+YU+OEpUllLkrpNF/1niksoksK5iS9Pv5BjXlEyDI9uZinPBbFMw4KCCO38ZaT11lsHlJaupAjRDqWJXUZBvOyNRtc0NBSr3Auvh1lXSHkpZHEH8Qg327/kZ05NqFB1xg61CCfR8m9QOZBgAWA43FhaI1lsaJdUyzPF4MTYOfD+PDqtHcB137u61GZc5EKxpCfIY9246UgZdfKn5StaKbr9wGAdx5dfonH4EPh+U9ycyUA3P+g2C4a5DqQp0Cbm3ZnIzPuNzTUWYC/Cm6pcuvLUHfMSakFZxUTo73MTLRoOBqO22g2moCAdQHs+Kjp1NGY2pbrZwNaJUs4tSAw==
X-Forefront-Antispam-Report:
 CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(11063799006)(56012099006)(261021121427099003)(261026140227099003)(10067099003)(261022105027099003)(261028144727099003)(261102123227099003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 5eN7sEPF5MfPaaH7Hx7SGt0ZY3EZv+A+7EAyjOldC+ryzHyGdTpStPUBBMuLMk8id+QlaQvLIRwO6WSXo25G2WkO+NVo+W3reugdkfduW/64fg2ZWDNQUSqwbHuJKseLHkorVOJaNxZAwefFwxA3lVfkZWsLz+8jENPtDqXlrzDt6Kdft/auK1azhBxPxu/M6VTHhsJ5/Yv+03u5VQ8AnwdRrL1gsyFkBhr/0bE3ARqvzzMfs1I21p3J3ayj3SPxd2eSN3LBjf39kHK42XqI4ew5plFbatjhDgS1v2Ro62IaUxio05glwlCemMcqEdUGF1avFEkeNKwS1Q3aF5jwrL5TVaBtIE3iKw7W8IGo/XS3eijE9JBS91IDtg+Cca18LYy6fqguJ6uGhcc2mpNmdoX0ER1J4slCmd7YDS2/xFnUbz7eB2TkqzRQlSaSR/Yo
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 22:29:02.9785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4e413d-537e-41e1-9a28-08df41d5854c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
 BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7633
X-OriginatorOrg: Nvidia.com

Tested on an NVIDIA platform (FF-A v1.3) with firmware that uses
offset 2. TPM PPI fails without this series and works with it, both
with and without patch 3. Without patch 3, the second FFA_VERSION
from ffh.c just got v1.3 back from the SPMC.

If you decide to keep patch 3, then the kernel test robot warnings
[1][2] ought to be fixed in a v3.

For the series:

Tested-by: Jamie Nguyen <jamien@nvidia.com>

[1] https://lore.kernel.org/all/202611131010.OMo0VbqM-lkp@intel.com/
[2] https://lore.kernel.org/all/202611131749.3XbZQkPM-lkp@intel.com/
