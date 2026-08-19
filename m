Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010063.outbound.protection.outlook.com [52.101.61.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F8C42464B;
	Wed, 19 Aug 2026 08:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787129748; cv=fail; b=K9o/sVQXWju1BYhbq6wFipu3YK3a2CG3eDmiEbtRP0Wy4oeU93SWbk6F6pOhJo+WFOZdOamx4cmLjtJRZuo//vjcZ9HBzK2bfrudw3qixet5JN60k1zwjFLlZSTOcs1OE4zLzGM2N8rFKi+gpGHSyDD6Or6Q3zGoBREBr1c8OJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787129748; c=relaxed/simple;
	bh=ZskHMeqslgnZh9eXjkkqsO59j5gbkXMdXWFj5lxqzdo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L2RkVYHseTv0qsNqopxywQzgycwYu6bLmcCCRSUZjtejH8CGxJFKRldvjRI11/aGqfNRQOpvaSpy77wvmbYGDQ/JzdVLYEoLhm0IZminGKws06fC0luGoA37ff+Nf6erJrNzmYozzJ9AfrsuPvdx8iSPr3LYayH5y8gNDQUEKw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dUIfV28O; arc=fail smtp.client-ip=52.101.61.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dUIfV28O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SlCyw6mJPHdUXdf0SSHi4pywdyyRIfLwCGxpg0fxvZjhiBNDW768sfcMqtHIL8sbfx6sH7uxldn5cfrM4wYOqU2pCPMtiRQfDboRMJ9Wb8v4Y+cYI5iU/aLiCWnd4a4diQZTC8LvHObTdrQWkNfsF38LuBHf0t0ut49K8h2G2ZAEO6lvHP7q9TvqGZ/0mepD0vSlBnAVFwABOzWUiaXtsskDPDFwC8KPJwBBPZo8LrWXoKgiPscKpEn0fjgk0B2jit6gUgwTPW+V5pu8NiaZA5LSAX1xAZmrRmvLVjyfgGSO2l1SQbS9ziP6rNmsLIQrWDg4w/MFnOSg2d+yAfYtdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmOmeSIOxHprq3J7/NmcwJgmIIi0UdaHWFhSXukWjQA=;
 b=U8DeMvITkvYbwF8tchx0Ro5AyLBXH2/f+QNOVS4KHIohSfLtPUcfxUfQH//FeaPDwsdDtGMfej08qN9WgBP+P2nJiAd095225qa4fHI+DZ22lYdMypCPkW7D846Z4ICz3rVNyXHrqTeLN46XZhJEfP7PbKbgyWI6oNLxxbZ8HL7OMPEBZRXgDqq5Pc8VVJmwt1DUwAQDJFVBvatjokNXCE4XB3JGyH0PViCASuoMgCveEfTuKMx5v8CwCD2FEP8Yo4WLCkcNnFK1yWg42bO/SuRa7VA7sehqRuP8P9sx1m4ejM0IF03DA+qngdwMq+sY/N24KGuMltZvLBk3RpsDeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmOmeSIOxHprq3J7/NmcwJgmIIi0UdaHWFhSXukWjQA=;
 b=dUIfV28O/chtU+WwI8kipEw9e4xE6O4e59PS0++D1Mpg1ees+OHlIKarl3Bfw6jNaZ+dtG4CAThKfWQSfHNJOVz4KDDMZG+liTm6D+CdwuFUckYa5qIy6GfDK91viRZ9xFv6SNlIcquqmyoOEtfPydsde+61n44nD2aFbiSpwfA=
Received: from DS7PR03CA0286.namprd03.prod.outlook.com (2603:10b6:5:3ad::21)
 by MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 19 Aug
 2026 08:55:42 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:5:3ad:cafe::45) by DS7PR03CA0286.outlook.office365.com
 (2603:10b6:5:3ad::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Wed,
 19 Aug 2026 08:55:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 08:55:41 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 03:55:39 -0500
Received: from localhost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 19 Aug 2026 03:55:38 -0500
From: Baorui.Liu <baorliu@amd.com>
To: <rafael@kernel.org>
CC: <lenb@kernel.org>, <robert.moore@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linuxfoundation.org>,
	Baorui.Liu <baorliu@amd.com>
Subject: [PATCH v2 0/1] ACPI: button: Report wakeup key only for power button wakeups
Date: Wed, 19 Aug 2026 16:55:27 +0800
Message-ID: <20260819085528.575-1-baorliu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260806122732.533-1-baorliu@amd.com>
References: <20260806122732.533-1-baorliu@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|MW4PR12MB5667:EE_
X-MS-Office365-Filtering-Correlation-Id: 700b4bc4-9997-48af-8f1c-08defdcfa605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|11063799006|18002099003|22082099003|6133799003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	HJKgxV5BbsJBb6KqRiXQisYAFxNUYW4sMZT78KFNXBrGXIoYWMWiOQJKpUVfJyxxq6dqAlRpYtoLifqB7y2Xvs2tTClimo9HbxB/poi8TLYe85SOAeZ4wRQORY1haLQuox3Kmqh05qe71pqOuAGp8wIOlDMvgaAKSFQoVQ1V0oji++le9lZXJM/GBMGSWuALzxvj98LvV3c3fYlGVJMZHo9ALVxJaSIEiBrSfu+CRBI1kIXqixdA/k7z05Xv8Suo5bgFUrwKCJh2iU8UGaD+DzaDVLzvLhGZEv4sLxjvum//NXlFCYjYjsUUdwcOzWihmhlszR6+6PfyZZLfVp/r6zhRvkv85zL23JDTpnqkAQlAFlGaW78oB1RwEKNGEntyWwg1AoeqGs+/cQk/s1tbcBIndVbIycH0Msm6J3XhcKQwrQ1t1UM0UW9iQOGkXu0DkW7027tpe36Wku6LuFESJ/Y8/3B93uHwlzWaI0iP1lZb0NhZdA33af6H66dYoy7N90VS/Esu+Pg0ploZuzvdusKqdB8i04uOOKcO1OjRiTPlCLcsLNIkRNhXOJKTzmH2f/l95lbPoSUu+BVdDNm2RyFoc53BYr53O3UcmSPqnWgjzbzJD3eTFdC/KUyQx/CE5roIOm3v4aKpJnmzwbYVSdzum7soB9MxLS8RLD2mlQzBm90wq+uRH9IzsOPAqSjsgebRi3A9rWqsX6U83KlYeA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(11063799006)(18002099003)(22082099003)(6133799003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hZv4zeGwVUCzUqlVH414riBxuiYrugJ0Mbxy2/yMVa7TA0Q1yqd0wAvQFZ5anEbnBSCxTjOb/FlAkx92BjtUz+4/rouVTpP++j3jdRcExGANPvIFVvDb7itSu2EhFJIlmYRKxZBcB/i1kV104BMXJVJEy0wRRaaJo/UpurJ3cahvea3q/UEZeUQ1Uiw09oK+OM6sLGb7N667UDZAZC8Qp1Kc5p4wx01UO26vYGjX1ul/X5NyvYoHja6N3B3YeqnhIRNbNnyvzZRGBjBKZ/0QhFsjVqYeYxqtswM9+1cYAAN0Ty63S85vICGw/GAS16D7r76xo4J/1+OTHW7cmvhPwJ7bf4mZtwWdeiXqV+KPuaGTtkdjBG5G4CaZDPeaQCaZVpBjaLEjJRuDC3kj0eFwtnk7kUa5uiSwnT2S6wJOlQKci+OrJ3YFG//1E8rcWHuO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 08:55:41.7745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 700b4bc4-9997-48af-8f1c-08defdcfa605
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5667

This v2 addresses the review feedback on v1 by documenting the
practical impact and by avoiding KEY_WAKEUP reporting from generic ACPI
sleep resume paths.

Problem reproduced on an AMD Android 15 Xen guest.

Input device mapping:

  event0: LNXPWRBN Power Button, KEY_POWER + KEY_WAKEUP
  event1: LNXSLPBN Sleep Button, KEY_SLEEP

Runtime trigger mapping:

  xl trigger android power -> event0 KEY_POWER
  xl trigger android sleep -> event1 KEY_SLEEP

without-fix kernel:

  6.6.118-android15-14-maybe-dirty-gc3c82a22502d

  echo mem > /sys/power/state
  xl trigger android s3resume

  /dev/input/event0 reports KEY_WAKEUP DOWN/UP.

with-fix v2 kernel:

  6.6.118-android15-14-maybe-dirty-g5b231ece911d

  The same non-power-button S3 resume path no longer reports KEY_WAKEUP
  from /dev/input/event0.  This was verified twice; both event0 logs are
  empty.

The dmesg log confirms that the test path is S3 suspend/resume:

  PM: suspend entry (deep)
  ACPI: PM: Preparing to enter system sleep state S3
  ACPI: PM: Waking up from system sleep state S3
  Resume cause unknown
  PM: suspend exit

A positive-control power-button S3 wake was attempted in the Xen guest:

  echo mem > /sys/power/state
  xl trigger android power

The guest remained suspended/offline and was recovered with:

  xl trigger android s3resume

Therefore, xl trigger android power is not a reliable S3 wake source in
this Xen setup.  That run is not used as positive-control power-button
wake evidence; it only confirms runtime input-device mapping.

Changes in v2:
  - Add test evidence showing the practical impact.
  - Track pending wakeup reporting in the ACPI button driver.
  - Report KEY_WAKEUP only if a power-button event/notify is observed
    while the ACPI button device is suspended.
  - Stop synthesizing Power Button KEY_WAKEUP events from generic ACPI
    sleep resume paths.

  ACPI: button: Report wakeup key only for power button wakeups

 drivers/acpi/button.c | 38 ++++++++++++++++-------------
 drivers/acpi/sleep.c  | 56 +++----------------------------------------
 include/acpi/button.h |  5 ----
 3 files changed, 24 insertions(+), 75 deletions(-)

-- 
2.34.1

