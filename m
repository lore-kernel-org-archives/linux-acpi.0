Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012040.outbound.protection.outlook.com [40.93.195.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC89364E80
	for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 02:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043825; cv=fail; b=JJ4u9Fe4jODu6+L5Fx2E7932MrrWGuTB0UC5O0S3nVqXluDVff1/eTpYal4q2C7Jzm0P4gULHZOgTnK0Q7qI9NgPgcRMyYUGQcErgBrOn5LT1010P0v4CeA5j7D8rFK0l5KE+0CDRsdUQQcD5PTuuH3PvFwzDvFcXGAKLwcSDWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043825; c=relaxed/simple;
	bh=bIjYY4JGB3oobHSpKJ/9pat8C5jD1sMpW1G1eVXGnHo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1pk+R0iLopV2Sa2Y9+enjwaBnJp5oELiMUlb9ADS7eYGaA5jJoHY6jqMj9qJYFtNSigHPqQyIIXF/buhUc9Qcvi9UKbOCqcCAk0jF3HSC/Bdl1ELMGXL21rek4oBFRrdtvM2uIjiNEWesoIPVVqNKXryqHmUJ3oDAAIITxaztk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ISwDv/E1; arc=fail smtp.client-ip=40.93.195.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ISwDv/E1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDaafOdK1FGKKpPVBy6Nd/vKdLvu5ntxb9YkmdLEYcDJC4bS+wuO/gp5YH1mVBKwby/hIFYgUS9FRCetgZ8EX2xpsgsC7ZgMNsqdWsRenUpBVrkrMdNJIDBtEbjMWQFU8VKl7Ir1z7EnWT6vVh1fFCnYd4p4zAwBe2i3JaAn2rp/Q+z51ytUlyQ5zxw4TVYpDgmD0oHroI5N5EYrt12zmzuvJhz+gztaz3SS+FXXslfAhoPXWaFulLCtjJFYrtVu8LNmpxfMHRPsNjCEIISiFoFYt4LyY8pxh6tpaF5s7fIG/R8N6dO6rEanICD8DTvBT9TBfuxpi9SCsCjU8ZVGjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIjYY4JGB3oobHSpKJ/9pat8C5jD1sMpW1G1eVXGnHo=;
 b=odZgqqvuGMu6gDceB3dsTqEfwmZQXK0c5zQDWDmMaIMjahL0LxgVF9JcbZ6mUuDEWzJRJt9+TGuOQoDXSjagz5A6mYNibafe7OgPDuqI8kHbE1CI8tzYM4HVM7O8rSWFlJOVcU6fTl2k0mTDpeKgtHTaoHQA6GXSvcJqxVxEUWCFTz7YPzbic/wA7AHIbE4CwVJld7I6JQka3O7ttU1QvBga8b5dlnhhAbqy8uPcQSkghm0cEGNEQW7EihblQYNvUEK56/duv9t0RLl6RLZcP2L4cW/8z08Orcrx2F1b2TLqq7MQ+IfW1vx1JdfPoH1czdB4N+1ce8Hp0JXT7s29dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIjYY4JGB3oobHSpKJ/9pat8C5jD1sMpW1G1eVXGnHo=;
 b=ISwDv/E1heoZVVIQ6Non/oppYYwLEe+MXzUl2lkyQrSWIio06ydsZoVgdRrq9i1eynIO9mgOO8j1hLcc/5tYWrkOvdixe1h0tFNQ/pdCxPQHxwywvwpMt63KE4PwPdNqY5E6+/YrtLSH1OKMyRwNcvOmQmvD1TPN1kTT592ZPFI=
Received: from BL1PR13CA0309.namprd13.prod.outlook.com (2603:10b6:208:2c1::14)
 by SAWPR12MB999269.namprd12.prod.outlook.com (2603:10b6:806:55e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 02:23:41 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:208:2c1:cafe::1c) by BL1PR13CA0309.outlook.office365.com
 (2603:10b6:208:2c1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.9 via Frontend Transport; Tue, 22
 Sep 2026 02:23:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Tue, 22 Sep 2026 02:23:41 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 21:23:41 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 21:23:40 -0500
Received: from localhost.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 21:23:39 -0500
From: Baorui.Liu <baorliu@amd.com>
To: <rafael@kernel.org>
CC: <linux-acpi@vger.kernel.org>, "Baorui . Liu" <baorliu@amd.com>
Subject: Re: [PATCH v3] ACPI: button: Report wakeup key only for power button wakeups
Date: Tue, 22 Sep 2026 10:23:30 +0800
Message-ID: <20260922022330.490-1-baorliu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAJZ5v0jb7QNF32To0AoOBxXHObUAS7QCrFAGObFJU1=VtOqm+w@mail.gmail.com>
References: <CAJZ5v0jb7QNF32To0AoOBxXHObUAS7QCrFAGObFJU1=VtOqm+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|SAWPR12MB999269:EE_
X-MS-Office365-Filtering-Correlation-Id: 049828bd-501d-43d4-ff20-08df185084db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	oMuAIcb6oPLDwLR2Z2EnYKzlW6lSo3kBYA5cHwzmHSqdKOzym5x26GE4jDRi6R878KSbiW7D2qxMXApdykBKTaSe6MFkBxiuNSLtRremhdZtXJ4zFrqUznSYXOiYVLWjPl7RqpFF/lOtAcbohS4j3/cixrc4lPqWK3tC+WruKepkmQ2D7LMj7d73hxShqQu7uaJ8oQHHS+0X9lv42T7udtdo3GmQd1z3mBHUnksEou6QA3+5lmwhe1TtWdKnLZ6ThCP6DQuBf6krCw/PGqwziVZ+yLPlV06Llb1/9g1G5Xf+ZhlGhHa82SSEQkzgc17iFf6Uke9ooaP50IOnTYraucNPjZgGd733ZMFTOj2pbk9fa5F0DJUucPWKEMUG5X8gwALLsXq3k/sGWWFGNkh0mNOLxd7/eSSa6cMYLY7ijix5e3mRK8iFbDW6f78rC49ylNq+gC+bWj7GE9qWBnhaKEAihXN4fcHA0aBUzgck/NXl0KqrEOKJo1B5OXAV69LTNNcb8xG3pAlUnwd7DFIsey/BdbcuwjqgDaL0n5DgdIJzujURz3bx1pb72EiwOd80Bt1KCJq0X6rGv/aNo/ByEjXSCtC1bwDNP6wGrQ12ny/bIrztNUeQGAwqIh/Effs7fq6gVX8Q6DFinPts0Wr5OpkXZxVAtPEnCIuEC+wdsp2QQj7GLdEScWxBBcJy1S4GLmVKqA0x9Xac9JbERsmTDg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hehuS4UeGpxBu5ukejZVRL5GrStldub5k6f5N8kiV+sttCFxMARVkgBZJ14z0p4mtZ2rlNj9IztHai1rsP8qdT10Uw6FlYMgQIV59BREPGUb4gnMBMvtfmgs7uUqHKu8G9HDelA5vs3p0w0gvumBgV6F9/TOWASb8JdetI489hb3eheqzH9kHAxHz4tGZKhi8AwwtdT5KYCj38o7fQUp0IC5K9yYHtxq+wlYATazW0wxvpoIcekurviLvu0buzw8fDATxi5LyEkW/7q4kwmeLyxjaxqbBve8DAtY5WyvLRZGzEQHbifGKMQUErjAUt4m/oZmUNVHFVPQ0LNDiVRfwOkUy2kozyNhlTpqhOMzDBUoAivFFaHbA13emT/cZEQJBuLy8I30iCqwERgGM+kpB8PKUgxI1VK60EcUWiBRNYE+ZiieAvqD7yUR48MgPkGW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 02:23:41.4938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 049828bd-501d-43d4-ff20-08df185084db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999269

Hi Rafael,

I reviewed the Sashiko findings and agree with both of them.

1) High: race in acpi_button_suspend()
Clearing wakeup_pending after setting suspended=true can lose a
power-button SCI that arrives between the two stores. I will clear
wakeup_pending before setting suspended.

2) Medium: removing acpi_clear_event(POWER_BUTTON)
Dropping the status-bit clear can allow a deferred STATUS notify to
report KEY_POWER after resume has cleared suspended, which may confuse
userspace. I will keep clearing the fixed power-button status bit, mark
wakeup_pending so button resume can still report KEY_WAKEUP, and keep
the PM wakeup event on the fixed power-button device. KEY_WAKEUP is
still not synthesized from the generic ACPI sleep path for non-power
wakes.

I will send a v4 with these updates.

Thanks,
Baorui
