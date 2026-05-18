Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011032.outbound.protection.outlook.com [52.101.65.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F25375F67;
	Mon, 18 May 2026 10:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.32
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779101921; cv=fail; b=pDlb0KyRZZm8aBHvIFI/E1BTZxFdgFccqdu+E1+79YKr0e1HtJ/1Zgat1G1522Gg+LJ88UTMIVQdfH2KDZDKF944snYEaEwOfrrCh6LOnZeIah03+AQ1wEzqMsqkahBS+GXctNF2aijubHuJs3M10vgvqPkWNYmuWQycHZi1mUg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779101921; c=relaxed/simple;
	bh=jqKvxbdiWjOvEKISdbn5kd4yCmwjtzen2SPbIDntr7Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N02/7TnzdAfy+TEFlVAOFQuDje9t0IvGwG4LiZtfGrLISauyadFECUlnk2oxZSYbopY/0o6ATEI8iRurILnWy0wxMCEMYajW8BecL/dqGo5Ulq6H/r87YvfL5sLhhD+RMR3/chgIkTuwN1Aj5GJGCPR18uX3hxOxIOArYp2trtM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BgY4zp4A; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BgY4zp4A; arc=fail smtp.client-ip=52.101.65.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BgY4zp4A";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BgY4zp4A"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=uOj8kOAbMntZjJ8Bfg3avM8bntbWwzTsaJlLW2wCk5Nqhzf+kfGKskqOs7cIXYQdYhDu9ZYaiEDwBLkhNcxYl5VM+7rRtn4fwwzK9pvdoiG3+gDZdOkMEnNytjgH/LUWc61xQQjgw664m7F7CYvDTttikCUIPYWu7dwuJFmwZXDD16rFqpdDaOl/9QzZBiTM13Fy3RnchPHQep6kN4yWvNoMSFEoqfgsFfTyQlA3N9mfhBxl4OfBs3pP6Nh9TZ6l4bKSTbMU3y63mimrAitvdUzB8gE63zHiEwtRXVC5CtDs7omSpJCujeG/V0YzJAtMS4QPoYNZytFjHyeSk3/1Dg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2SyuGkHeWoQ8X7TK3zS+q4Er9LuEcTJWTwvh1EY+XQ=;
 b=ZRKGL9WVPt8MNDmkd1pY2lmcvKXrzJurgXZBNWYFmLt7miu4TcCe+1Uf22QjTdC6ftHyjQZsBeh/B0EDJqfeSIWGC0ktgC1EujmOT90MO4HTFuDz182YXiEciYmYxHnz6Q9VrkWBMII7RhPumg5AVYAfNQG7FrMJw/iYdZ1E0JaHwfeAkrjJM+1AVljzljCIMQYN4hdmHT5oyuhgWjiJJk8LFBxOot6H3Ols1qdYKgdsqgmqrDR1cWTMl0pVZUjRakufyfhoH8PKPSBHU8APGrEWVUpKezFMze+mIj2dnAArwP+FV/bsdiHZIUyfACSSuS/0t63ruBlZ7GjQeYq0oA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2SyuGkHeWoQ8X7TK3zS+q4Er9LuEcTJWTwvh1EY+XQ=;
 b=BgY4zp4Azr6hLydBdZG3W7e4jAmAhOqdrbZ9TUHcrSG2kEnvmLIDzzNT+aKe90KtAUAbKBK36DhgV3r6FgAiGgE3dE8hENKoYRcbCaCA0wxN8kTaZhLWhM0l0mzUZGQqDqPlRJ03ac41LMe3mQ2DNQ4QCmsIUzCuOopktNqwpgY=
Received: from CWLP123CA0269.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1d5::12)
 by AS8PR08MB9041.eurprd08.prod.outlook.com (2603:10a6:20b:5b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 10:58:19 +0000
Received: from AMS0EPF000001A4.eurprd05.prod.outlook.com
 (2603:10a6:400:1d5:cafe::5e) by CWLP123CA0269.outlook.office365.com
 (2603:10a6:400:1d5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 10:58:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001A4.mail.protection.outlook.com (10.167.16.229) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.11
 via Frontend Transport; Mon, 18 May 2026 10:58:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+wJs1Rq+IvHaF7NCZecmHde4uJvb0ne2JY9fvPf4+s9tw0ZmsZD8EO0E7lP1chNioV/Sm7Rfq1SZqpSZ312KJbsrUvVz0v2GiuBxb4CxpfLPyi8T7qvHQZ/dwgT7j/IiQzEnQM+ojYHrBchbS/eMVUS6FOvuzYYAQ23OvwLcLhubrdjyoICuBokAEhUDyE23mVOJ1snTceji/yU0yeDX7R4pVIuMQ06V1sruxjxZePmFFwtSKqz6GlpDaKemPnzkhjBaAHHCSVZkNKUS5w0NPMjihBLtuuQ89FS+XlslzVZG/hi3Zrk7ae9tqgQLLjGYtUFWXYVF0sOwZTiEccyIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2SyuGkHeWoQ8X7TK3zS+q4Er9LuEcTJWTwvh1EY+XQ=;
 b=iDW2TVu3KL0EFONmznXS+qbmrfR5PiAmUXBp8qWN25r6/mYj4dlXuiMjfhysZeUqCL02hQPeWjI0GwLvYZ8FhR2M/ibPqjIfIeXJAodqUNT0NYhLjyWKkxPucdGVTb82d1lDDnWvyH4fIsXxXD3DDj8CIhqLXJCLXYp3+R+RaJMPv7/x7ht2vqp+ml5dKpuNwYVzGAXYbXhmnJM3T7B8tXtuuv25HmEmd/+8e9T2Gm5ge0EA3DWKNiQMwWjorIaAfGWJ8scgcfLwC3CrtoNPJiFvN2vEtWvirg0N/pS9VPlHEcKfd31ViUYJrsH3VoHi0ps2WEjHRHKYM2rVbbPWaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 172.205.89.229) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2SyuGkHeWoQ8X7TK3zS+q4Er9LuEcTJWTwvh1EY+XQ=;
 b=BgY4zp4Azr6hLydBdZG3W7e4jAmAhOqdrbZ9TUHcrSG2kEnvmLIDzzNT+aKe90KtAUAbKBK36DhgV3r6FgAiGgE3dE8hENKoYRcbCaCA0wxN8kTaZhLWhM0l0mzUZGQqDqPlRJ03ac41LMe3mQ2DNQ4QCmsIUzCuOopktNqwpgY=
Received: from DUZPR01CA0073.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::11) by AS2PR08MB10376.eurprd08.prod.outlook.com
 (2603:10a6:20b:545::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 10:57:13 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:10:3c2:cafe::a7) by DUZPR01CA0073.outlook.office365.com
 (2603:10a6:10:3c2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 10:57:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 172.205.89.229)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 172.205.89.229 as permitted sender) receiver=protection.outlook.com;
 client-ip=172.205.89.229; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (172.205.89.229) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 10:57:11 +0000
Received: from AZ-NEU-EX04.Arm.com (10.240.25.138) by AZ-NEU-EX03.Arm.com
 (10.240.25.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 18 May
 2026 10:57:08 +0000
Received: from e132472.cambridge.arm.com (10.2.78.53) by mail.arm.com
 (10.240.25.138) with Microsoft SMTP Server id 15.2.2562.29 via Frontend
 Transport; Mon, 18 May 2026 10:57:08 +0000
From: Niyas Sait <niyas.sait@arm.com>
To: <andre.przywara@arm.com>
CC: <ben.horgan@arm.com>, <catalin.marinas@arm.com>, <fenghuay@nvidia.com>,
	<guohanjun@huawei.com>, <james.morse@arm.com>, <jic23@kernel.org>,
	<lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lpieralisi@kernel.org>, <rafael@kernel.org>, <reinette.chatre@intel.com>,
	<sudeep.holla@kernel.org>, <will@kernel.org>
Subject: Re: [PATCH 4/5] arm_mpam: prevent MPAM-Fb accesses inside IRQ handler
Date: Mon, 18 May 2026 11:57:08 +0100
Message-ID: <20260518105708.3268174-1-niyas.sait@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429141339.3171205-5-andre.przywara@arm.com>
References: <20260429141339.3171205-5-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	DB5PEPF00014B9B:EE_|AS2PR08MB10376:EE_|AMS0EPF000001A4:EE_|AS8PR08MB9041:EE_
X-MS-Office365-Filtering-Correlation-Id: feb45c8e-f272-456e-afee-08deb4cc5e94
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|11063799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info-Original:
 pHbmRn2aIKplyKldKaEtz9gjSBpQKZgAyuK+q/lv4tpDCqH7UiO4FqTFgPjAs4y0Tiu9x1beJDcEOWmOy98ThBGSOOhHAZijtHwxY33T3WwYDL3hbefhZSk5TAEX7H0VWbf94aceolj1/DBJym/AUrtMNXY5C2R+xJphVkLmdD8qKYpmIMjyvSpNtOSqXHGx6/m+yWkLEiuFFnFVFSb2XynytEAXj2N4jhyQF+Wtr1TVqlqFz/KA6+kF/DPZlX/KU76C3yqj/6/Z/qntlWVnCtB6VGH2mxbhJO8wUGC0Gh6wa7v+p7kw4fnQSesxYDpGAGXtJoGP1XxQLeZyIASUM8hdI7K3mxudga5WJYKb2C451cmDR5UFVvrY3NmG1LbLN4xyPJjQrDRkNaeGgtQZV3nxhJAmahYDcsE94U3IaI4hOOPzAuBqGwHk48cCXtrqISCakcPBOanLnWctb1KbFh9o0N9Tr3uFUSIkveEnhdEEVZwdReEtEFjgpUtEdvXyFaTbyPl5ooQQc82uAnhKuqzioe0Ajbccduu3b2JmnAED/v9vy7YYAbUeLF1+4fBczmJLe+YDPAjnWJ4N+0B+Ke9wzKij0JQXBLNZrisnGp8tnbfVHTQ+tZDPJODqUA1JKV6tavAHaCHTf0QPQXHWejhm8/R/ilk4ljSNRpHXC7EXSi0paYWt1MPCvj8TSmaoxZGA8sHRfZ1OdBFni7eFlu0GRxEV4Kjng+np3XXwD5s=
X-Forefront-Antispam-Report-Untrusted:
 CIP:172.205.89.229;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(11063799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 TkPo9gvQSeGfzos4c58GSCg/FLZS1Sp/dobWIvuLY/DBwzBdIp5kFzKPM9R7MWrq92cx9AG0DTJqQU2JxffTOAbL/RVQ33ET1yUNohDDAImeepFKMSqoI+NjtItxo3/XG0pg9k7cTbG2TFSLSKH2st4TFS6znIi8yYKhPDotJ+3g+CX8v6qqYlXHWJlgGaqBzVq1r5leTlEr1w1mGfYU8ww3cogVNKZiZ91liASlBQwmvzK/4U3sU4JBjcyQLxUm3kPjlY6MoLDwgs/7EMSTrb7VDYdqPHPgxxn9QBS79OMvvu6z+dz0Fe4y1CmkVfgnpd5HpQEnTa7LS7aZGRVLYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10376
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ec5dbdcc-7546-47fa-71be-08deb4cc36b9
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|35042699022|82310400026|14060799003|7416014|376014|1800799024|56012099003|18002099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	BYIYGbR1UKm5m0BDYF0ni4da7pVTo8v9A2MGwS+Kq7sSL+ThpSXFRu3jJpfg6DXSaHg5WLUgAmhb8N5i8d2DMROEy7+gjxe7AvW/TK1IQ/g3K1x79LKSo9MZDZ3iJtHw4fU8cFijho2yFM6AD0EujcLyNxHX1a8mt7nfxAPoOMCGV6Phj/YJVNJ5JM2iXpOhjPxZedagaW2x3cC/moMRm1iRbW20LKD+91kzLGHrbGAKtf51hjUq8nnzDBwbEqqKnLsq5iZrQnIa7s8wzvXvmvJNxyj9TYAk0tPtn6CC92DpSPC6RveX8czGOPTNh9Sd14oQERpv04xUROHMAgqsyBX5kFJfe5lvVrLvjeR28k2TIHyuS+RAEZ4/TXKWlmXp3WPSbBkMCUQ9N8EwmI9dKl5JfJ/PO9T6yr/pQcbSU85+Hkq5ZMqzKBm9L92n0WK52bYy70zSBOzvCub0fU/BgPJfrp4a/qYH+kZdf523wa39ExD1qEro9G3Wh5kFEnjSH+iVqv5LX6f5IV18ImzUlQjngC69qrFonskE1ePwoM9l0jmv1O/8iI5m9AfnCVOtaAbG1KWm1Smxj1biUS72hPS6yAx30bd5HsfTt2zyJHdUmzwJ6sHwVAdWu9m+cHX3VK+w/IOtbrrAJ8OD/vnuxnRBJIEGO76wcG9sfcnC8TH0qqY9gtHAO9aS3+zmgc/zsfzGlHkW4n375QgY/Q6NvKI1yLr9VV1D0tQJ9lgbBFA=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(35042699022)(82310400026)(14060799003)(7416014)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oj+/ZvbY33dezac8uJU6n1T93ULrIkX3lCg5r8rRcrtUE3dlVN0vQ5gYzsz6/+eBO8JZhvLHeakBMq9AJ8p9IP099XybhzdwUxl0tgXhnpTrVgv8OYt3kLVoi1YIyqcG2Rveey55Hs6nV7lgxCzijUhCjnngfGy/k5zwRvf4x10DiYpmm9uV/gItWROyD1JYYUnWjNCVjKRMM1Nw0F/tVhYLwt5vX5uNY/MMF3jiYXzzzOzjOnIeqmf+gBT4zA13wG2OYE7XUTYVj2xs8TbW20XOdeIZytnzHXV0lbEcU5xqMOBa5UTa/bJKxXxheuD/kSvHV+rWaixsLS+acvlHONQxbDbNuH1JSailA4lNDB86ticPWdd9dHwd0KaSX91Gu/UpB0DpetSNZSqxPkoYxxBXZH129uNUiwfARcpPB+8OA9pYjprqtrw+8VDsf/fF
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 10:58:18.5403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: feb45c8e-f272-456e-afee-08deb4cc5e94
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9041

Hi Andre,

On Wed, Apr 29, 2026 at 04:13:38PM +0200, Andre Przywara wrote:

> This error report relies on reading the MSC's error status register
> (ESR) in the IRQ handler, which is not possible for MPAM-Fb based
> MSC accesses, since they involve mailbox routines that might sleep.

I think there are a few other places where we may still end up invoking
the MPAM-Fb path from atomic/IRQ context.

For example, _msmon_read() uses smp_call_function_any(), which runs
__ris_msmon_read() in callback/atomic context

static int _msmon_read(struct mpam_component *comp, struct mon_read *arg)
{
    ...
    err = smp_call_function_any(&msc->accessibility,
                    __ris_msmon_read, arg,
                    true);
    ...
}

For MPAM-Fb, I think we could potentially avoid the smp_call_function_any() path entirely
and invoke directly from the current CPU. Since PCC accesses are effectively CPU agnostic, 
I think that should be fine for the MPAM-Fb case.

Thanks,
Niyas
