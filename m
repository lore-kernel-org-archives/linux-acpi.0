Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010030.outbound.protection.outlook.com [52.101.61.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A505F4DA546;
	Wed, 23 Sep 2026 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790167286; cv=fail; b=YMgxi3Z0cfHhO/Ty+YM3GtnPUY8w09GcBTqe/RHgPTA300pIPskLQZW2diaMzy3WUjnZZOLWqIhywB90k+hTaiq5VOm1G2zn59eT1hCI/ENA3IhsI57LTVVUq9glcieqawk0zYs3an0Iab83D+8AIBj/roD2woRnGDpw3IHDWkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790167286; c=relaxed/simple;
	bh=J0o3K+qSj0rH8rNjckbvlQGUFlWUX6ljGlyEpLaiCLk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kEyAL+UHtRIkR/qJhd1J9m5zCir/y7iD+2IbcfKFBcrw+iQLTTn1+LAaE3xOqd53PhSlHfASsefR7wlbIh6JbkWLVjN6L5un61zmsgHGgK8T7/hJoaCgeizpfIqZH4vTPyNzMUAmhOI77cRzU32U8wvLQpPlTjSDe0i2llI4xQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O8nntD9X; arc=fail smtp.client-ip=52.101.61.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O8nntD9X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylNVLnVUaW8c20zHsWauTAZBVIMIxdCVDkSWVpisfMn+SUjXR9FBw4J6dL9ybpbZ9cGTeRhkVRaO24NFFGjVSEBgu51v3UAzM8HE7Rpw4UyrhEfgxTNYhfJplhudiTLKmF/tVqtIi1dKIOig8Q8DXIWd+8TDZHmWVJcfAY8n8CewoYH4zSz2SUDg2uLMG4WN8PBg4/GLTWNbSZq4yA2L4ZB65Ruu5/K1d5CAdrf6uqXYJPlgL1bwnzE87OQVC0cDkjWckcW3p0qKIguNSYFFcD0SCm4d3lCQi+33G/joTkEo5TzKkqtMQNKWeJjTPNLEqnF89QXnKt2/OezY2g0XpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0o3K+qSj0rH8rNjckbvlQGUFlWUX6ljGlyEpLaiCLk=;
 b=YT9Zu53uEhBsoDWA7q9iW+60op43DkhiomXNuSzwFbbTUIbQHvM4uoB6oNkKSkrv02BDv81JfTpFFQUVMyiY/dLf78Cv8XIVNLpTcVMKhNco2VVZgiYLvYa1W0TXhrdra8pZIRkhkXhkkzXBZjyt1XI4kf26FP5iYCHzIUQNmfhrBxR7NoaHhxn4zmNUqZXK5ElcNhX7SyrOqX1K1PNZcxif96PR64Wmd9s4fqAm1Kg5VpzHtm0yc5GHPlmmAoXQf2OSXCyC+9FDXaCycD3C12to2AlPVRbmmPPRq1AJvJkOKXFo9fmE/xbIix3Vug0xb9M5iasujAqSqsQ2h2n7Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0o3K+qSj0rH8rNjckbvlQGUFlWUX6ljGlyEpLaiCLk=;
 b=O8nntD9X7qlkFPrYpB8jk3TD7yiK1m7eF2u+I0BsTAu+SXmbiHGZy00hn1iLml7ToDS+SmQw+iM6mphxUA8SlCY1RkqxDZXw0wbQNlt6WNL1woA6GwY75Wcv6EJDn8Lpuq+rGSLuxqsxzeO+As+EKQI5VrXmIeVKG1lNHZR5aCeZHaKbABVrQHBORneDjf2H7gBt29B/UBhZ6Tnq7Yg5CxC79wSmBXyYFqs61e6GbhA6l11I0axU7R5p7OLrItXtRCUHdi6SVy8KU+2iBQ+qDm9RWcr1bT0/5Di1FgNyJ1MPpDHg/CW2fTt9IEEKzgVzUq/M9kZF/JWuca4J9wxCZw==
Received: from BN0PR04CA0182.namprd04.prod.outlook.com (2603:10b6:408:e9::7)
 by MW6PR12MB8836.namprd12.prod.outlook.com (2603:10b6:303:241::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 12:41:13 +0000
Received: from BN1PEPF00018547.namprd05.prod.outlook.com
 (2603:10b6:408:e9:cafe::71) by BN0PR04CA0182.outlook.office365.com
 (2603:10b6:408:e9::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 12:41:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00018547.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 12:41:13 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 05:40:52 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 05:40:51 -0700
Received: from dgx-1v-42.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 05:40:50 -0700
From: Jamie Nguyen <jamien@nvidia.com>
To: Sudeep Holla <sudeep.holla@kernel.org>
CC: Jamie Nguyen <jamien@nvidia.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, Dat Mach
	<dmach@nvidia.com>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] ACPI: arm64: FFH Operation Region support for FF-A (offset 2)
Date: Wed, 23 Sep 2026 05:40:50 -0700
Message-ID: <20260923124050.3270801-1-jamien@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922-exuberant-earwig-of-opportunity-4fecff@sudeepholla>
References: <20260901192906.133670-1-jamien@nvidia.com> <20260922-purring-fennec-of-exercise-bbce5e@sudeepholla> <20260922155211.676134-1-jamien@nvidia.com> <20260922-exuberant-earwig-of-opportunity-4fecff@sudeepholla>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00018547:EE_|MW6PR12MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eff6a1c-c33e-426d-0aa7-08df196ff3d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|7416014|376014|23010399003|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	QKJDFDM6XtjvRlZsBC0WSAoj40CoRSmT2zRY2R5kEhFZgNzdOXGu5NTujTM+qIyVFaQdAbo2bC9/qVGH26U6HywaP428zSmi62U5ytAQ8aMPDe7GbXDxuXSy6ARuO7mBHjT+TyU2SaGik7kwdy3SBz7r/KQu1PBY+P2iHKvDH2UvhOdfn5wTuZrbG9r8X/5EUIaqx5Wp3fCypDxccaoFuvoaQ9xvPowBDi+YFL1udwgzQ75I5L4Lgqcw0K64gr/FmEs2d4R33mYEbt8J7JUQbLbx0yX4DK9siPvlgC4R38Nbg00f6n+7INyNuUyFhEz7Y1N/0na7pXekd3mlJG9EewQ2nFO1PHRTL+UpxlpS6LNvBqdOBmb9PiaNS551ifBlQYP4+nRmPT3CIvapvfhE9uGkNLHDIpcsHzmtpkkmkZdt3piaA21aZ7zT4MMgE2R/Ox62/jMutAJBlfkSu0CsXFKjoqfpywh7Qx489DMgC28o1z/8K97sQMg7vYxySOBAS+BU04K8s6dXLhNThHQcoNJvhKCMXHTHlKdbm7P3TSTYpt9xIP1RtTULLvN4CSb/VhNwObHN/V6k40h94MhQZPf1xJpWR0GKxGsSR0oaWkgIb78Bx2/UShRze52t4u4f9GKsWBuCeec7vjuTKgav1VWxNBdQtxF5CKfm5kdbr0/SwXOxjjH15Crj981Fx5kHQIRpyawaOqAhXuNSsrbuKw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(7416014)(376014)(23010399003)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BAFkMSYp++sftzVKKTePpAn6A97R2nvjzWRIVPqzAhuJI/rCB/EoXKiyl+i400n9Bi/QfFuP8q6G9LZ62OkImg2u40lzYlYj65/u/tgUAjPEP5ZRhweXznXkl3W32SlUANEu62yvDdL+dxMH/YcYiU7UNOomOBt6KupOlHUuxNWyip+YMSCJaS2lE9+bEPuJcOwZgNDGdojVv1hmAZRG1AtU7DtxBy4SSVzC24C26qPjsv92Lt8eZUmsH3YEkL1tpIFT7/uFuDtR23b4TCIVF/lAhvZ+oGc7OfyfcS938mm1KeGT368yoBNimxvs1TUymTzA7/XOTVdmPXF9mFDQfv+3fqUtctvrP59mjdWBiUzCxsUlEHeMhGHpbhhoxUqbP0Pbn061S9CDIXlCEMgRepv43u+G+c+65rj1j+WB7GztQfCIfuGZd90+G1VHguJ5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 12:41:13.0956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eff6a1c-c33e-426d-0aa7-08df196ff3d5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018547.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8836

On Tue, Sep 22, 2026 at 07:06:02PM +0100, Sudeep Holla wrote:
> Equally ugly. FF-A spec doesn't talk about ACPI FFH, so it doesn't
> belong in FF-A driver.

Okay -- I'll move the ACPI-specific handling into ffh.c.

> So if on a platform, ASL has FFH with offset 2, we fail if FF-A driver
> fails to initialise ? What if this FFH offset 2 is used in some other
> device methods that need to be executed before FF-A module is inserted ?
> We pull that device down as well ? Is that acceptable ?

You're right. With the current registration, offset 2 may be unavailable
during initial enumeration or before module load. That's not suitable for
AML.

> There is no state management with simple FFA_MSG_SEND_DIRECT_REQ2, it is
> synchronous send request if you look at it along wih offset 0/1 and
> without FF-A driver knowledge.

The request itself is synchronous and register-only. But the whole operation
still shares FF-A state: version negotiation must be coordinated with other
FF-A use, and X1 == 0 needs UUID lookup. It looks like
FFA_PARTITION_INFO_GET_REGS is optional at the Non-secure physical instance
according to DEN0077A Table 13.1. As such, I believe a portable
implementation would need the shared RX/TX buffers. For example, if X1 is
zero and that ABI is unavailable, UUID lookup would need to fall back to
FFA_PARTITION_INFO_GET, whose results are returned through the caller's RX
buffer.
