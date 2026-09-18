Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012040.outbound.protection.outlook.com [52.101.53.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D184F403F;
	Fri, 18 Sep 2026 16:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789748145; cv=fail; b=njJWldtIXlQ0Lf3lRs5o/wL7VfvXDFWRaMH0SdLy64JLEo+gmcCbByeJvxFU8Ui0Jg4TRx+s1AYsKlmMoFpv8Q4n6XdP2r3Ziv9Rp9SJ6S2jOu4BDMpcceOpU1nWuCr4LeSZuM7b8hsP0W2e0vxidgREjf2WJQhtvB5q3ezqjZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789748145; c=relaxed/simple;
	bh=QLG64Lk9Qo+wSa/UoMfS9Cd32ZbWvo/1GRFToRmYhMI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=auRCnbdDK3OpvMCtpgeD5VtxV6CI5gWhEy8Jy5Py0iKk1SWZCpbbLRSZ0CY6QDAAavy+fUbEb1dnK1x9Vvqg9+bOlDmsX1qeKvrraqxV4ILxR1+RyE8Iang86ytjuEviPm8uqyBDL3XSFL0kg26o6bLr09/CSG1gDKjvWOYsxa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RFFq/k7K; arc=fail smtp.client-ip=52.101.53.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RFFq/k7K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFZmHfNS813zXdNc/XEnSnNOfy/WKHzyFBORA0fGwwn9/8S/yJh5/na9xCenmL19QZzATX5f2jgxu3e0DPz3IzVvG2IkMxL9PN9cOG/VI2ArFVKqPvyWk43ril2MXt+bdeoHKMeDfqiL6j6y5q16SmfyFhlMa9plMm/Rymvu/Ba+sILk+IBhKBSNsDmcElWKPPNhbKrcBZnSXpI2YeJvmPpcwy58oIOFUDheehV60NxciwaXHQFtIe4QQ4NKP3iRWZ9OEhL9ttRpqHmjeRuNaPcN96hh0YztwnnsLbA+IHZTSQOaJZ6exk2HZxsksX5fcZkhpxMA4ssKDdIZAPD3lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLG64Lk9Qo+wSa/UoMfS9Cd32ZbWvo/1GRFToRmYhMI=;
 b=LbokbbF1iEsW66AZuMO0j3uM4CAnZ+w6ZjAUEDV9oQgy22jbLy4ke48sAnQipeh5vjc3GdXxKmm7D6AJJdtW+Ch6u0/DwF+hJIGQd8VnBEAI5JMRD1KrkjqSkVHaSYIio2d0eXpXn1ez0rr8ARri834w0xkNNLL0NEjjMGrGVMK4NEXqQmLO7rjayw3mDrBwX3qvb6SrFZ4pPHzZRnmLb3LsMLZyoLH3Go0H0pJEwndudO5VlwaPIc4OZJF4wSZ+X+9T6a1uxwkNwDxqaub+MxyMmngrNrDbKXgFRLxBEoAZkpoGdKUGOzRaOtIHpMwt/WobJ88tU1YR/8SUqG+FrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLG64Lk9Qo+wSa/UoMfS9Cd32ZbWvo/1GRFToRmYhMI=;
 b=RFFq/k7KOo8H67N6n2wEBf9+5RBhU3UM7a3NgmYzIgDsBpi++HRcIwabNiP3Vb/88iBOydXe81lna2hmk4w1l4Piu57TVy+ibLl3UKAIH0UTnqtXO5Z1XFisfqALlKVyCelAwItnv6qRViFvAgk3EtQkQwoVfoZZ4AaDkKsVolyFvbGTcM4t8mcBv2RIOOxex2BaelXZ//qMgMhMI7TGQaSHWhjMAgnWpwxAaV4HgkBPZlss1tJgzTQebGA7w0TDQ8Uw91qLHvSUiSHFAa8rnq2D0eK59aUdZYj4kDqhqy1XkNPcI7CUmBC9kSG4rRPHg0FK9jVw6NH32+Ya6/bWdw==
Received: from DS7PR03CA0322.namprd03.prod.outlook.com (2603:10b6:8:2b::29) by
 IA1PR12MB8519.namprd12.prod.outlook.com (2603:10b6:208:44c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 16:15:32 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:8:2b:cafe::85) by DS7PR03CA0322.outlook.office365.com
 (2603:10b6:8:2b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 16:15:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 16:15:31 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 09:14:58 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 09:14:58 -0700
Received: from dgx-1v-42.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Fri, 18 Sep 2026 09:14:58 -0700
From: Jamie Nguyen <jamien@nvidia.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
	<guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>, "Catalin
 Marinas" <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "Rafael J
 . Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, Dat Mach <dmach@nvidia.com>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Jamie Nguyen <jamien@nvidia.com>
Subject: Re: [PATCH v2 0/3] ACPI: arm64: FFH Operation Region support for FF-A (offset 2)
Date: Fri, 18 Sep 2026 09:14:57 -0700
Message-ID: <20260918161457.1441579-1-jamien@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901192906.133670-1-jamien@nvidia.com>
References: <20260901192906.133670-1-jamien@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|IA1PR12MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: c8c4e1b9-59cd-492f-8ad5-08df15a01017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|23010399003|36860700016|22082099003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	25DUMHU7mqUGzsbIpiAucpyDDE8yLmL49f8jB92neeey7i7/p9iMsnfCgnEc+0nW8B2kiFv1qRYYoptS0Lx8t7XCKHXzDHYs20gEy2shgj8fHq7xsK4w73T4k+4IBUtvzGPOVAJc+PeDjyqklJ3MySuWkzOvCtoJueDoTnG5fZWHQhSBZqBkY7lJ8xeDRGFb8As8mF43zY0RP47Fruq1rXRMrthkt5DwEfCD4hgv4JJgeQXmaqa/eR4+KEksSeSrTQtP77pyRAqAN6urH7In2Sy1BYxFnJY6stfqdz++Ql2XU94/rOsiSNLimANRc3Lk4TJCxy6u9xx16Vk0pyfGG6UmtpBVnURZRT0Q4m5njzZyz8sjeP6JfC4FqajkAa8pfnEmTOeOzLs+bYrMa0hCJkzYPSPrc2xsYPiRYePmAOrFY+Tuavu4VwP5YByp9NymckCJ6DbPVKcoxXOJ4if7VzJjMuGXwFQIpnTE9tFxyoa51sVPQ5pXkfX6+Ug/bgK87eFcaP0obDuRlItLaRG7c9KV5M+hjmoKPPfyHnQzD/DgPmsYdKk1eQhXq5x2+wgCN352wh1o6SB0lXAwZdL1XN/AMSnD8e132l8v/Js6AtNXt0LdnlXsHq8qSwMA8+ITE//3lkB21/Ah011j4SLLh8j2xcmB6PKgg7s0xJmZh4awgfCO77LRbl5IUxIMPkLh94I/s4hMYWp+3AJZVeAqnw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(23010399003)(36860700016)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aSpvSnw1tzSt3WNF8kd6GlUmslmKxvJvhUMr/SLsnf1pRgM7ZoNjlsFtb4eGRECd1wlvdSb+m1E1Om134xGmVd5Dy6yPPUxRmGLvMh+Y7NwzzWOMIqY/lsKI4BBTMq4eSyioKESP0Kme6BhDXQJ2dyWtECns1NKXzh9Gz3dZ46uI+uJ+yiSqvaWNsQRFdcq/oAnoB8jVBSTdzEso4F5ui/pjyxL/CwhKQ7nf0JSi9Us2EG4a5n1of3+IFT7mKolykZiVGpYfkqoCCG/Ap6H8Y5v2QrwV0FqtwiQprDb2Ai3iSv+UlNzVQfTH1stxJQOtOH+ld2nZFR84weM75NGG3TdNBQf/BOCogRNd4L5CJSHMpM7CocvuSbBh4cgOFv+2ZU9Nhu7UF/lxkiwv1rrhCwcSJ9GVrAVXFxqUpu2qPeIymofATq48526SXdt/4hd+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 16:15:31.7904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c4e1b9-59cd-492f-8ad5-08df15a01017
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8519

Gentle ping on this. The series still applies cleanly to v7.3-rc1 and
current linux-next, and I'm happy to respin if you'd prefer anything
changed.

Thanks,
Jamie
