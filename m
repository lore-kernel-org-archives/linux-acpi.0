Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010059.outbound.protection.outlook.com [40.93.198.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A84530EF86;
	Wed,  3 Jun 2026 06:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780468475; cv=fail; b=bB+KT6QIyMjQu/2rDBKUsbHdYpGncUEMv9HWNF4aEuD1KF7IeG9QgmncrvqRZ5cs2d9yZyTKd4IrPrTO4xrWEdMJ+LrTjA+aaEYJiQ4EMZPHLSojCeaCRWhDawELdP49iPgyZvh+IeAiDKvR6UuOrPj1BvTzL53CbL2HimsmY7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780468475; c=relaxed/simple;
	bh=Kjfq0iAB2MyNOw33O9fmj/zU1HHVaacHBC30qGlBN2o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=phWby+d9Asf4l+RuAQm/U56/7NDEYoUfhVM9gHINT0HHOHuTeCSbJA2Ph7nHPHF9eIuz9b0zJnFobTng5Lhw/32A+0U0aXTKnjwN9CYVyIMZVFE286fsa1Tst71UZHLe4qgHB7oyy7rYmGleTFFwvEx7Apx5s40Fmi5hlBwKz54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CrPC3LS6; arc=fail smtp.client-ip=40.93.198.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CrPC3LS6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rB/MX/lPBoDs1T6GNYOrCQEsWKfZ/kDmRSWXZioMz7rmrHYRr6yCR31pEWqr9iLWwIK5DX5HlcfrnkC0xXd1h685dJg5iQHBvJ2l9jgdfbsu/oxKaelKHpMRX8pZsxeGcN/PNSZAT08SkZ8FPsvgsDbCRHHaNLF/dcsVr421YM3TuXdp0EBENTI+WMJifJPq4VlyHFjzIjK72zeWZI93EGaQ0tGVHOHMAqOQy6tjFPEGCRthEkuGdR2gjT2T5xLfBjs5JAKTc/zD/HazqWfyFd5DmePdVm3nXuVdDdr9ZU1s9E8vNml44+rIDgdlR9y8+9C4gLsw8xrRZCHYaCeBMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+eenYNIgHofDTfAQdJeuTg2StyNzSTWiPXC7lv70ug=;
 b=DYPIoooPVJAty7xGvEbwmwpK7mJudb9PHb8YUMcTSiQgZZnmD0Nss1nIE9M4lSPPVx1vPNERfAE9EjHkrYl7q6SQxMUpbr/ZUhGPtN5LAm24pKGXxo7lP+BQDhlSBGUNPUhehzt0hEBCcNx551Ja30yOanm2pcf7vP8I8A+NeXi9NHUiNCoVLDYBcXttIv+9c8gA0MnQhc1vv6aQEW/G/Kwcdl6DNBiDDD8TFRnUn4ik5sgw2D1CBZLPbnFptaIni73PkdnFYSx7xIsfuaJqV1EBKfTXoJC2T4ksY7PrZI/ajFT/refvukzShMVtER4Q1Y3o5CuGMA9pqo5aQjF0Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+eenYNIgHofDTfAQdJeuTg2StyNzSTWiPXC7lv70ug=;
 b=CrPC3LS6DEODS/CZWUyifjV26D5ZvuSKwL80UvUH2ZHpOt76xYAUF2HcoOGHlgB5qZoB9In4/n3AzljREx7X/iMP5lnGc0A9Nr2lbEn0Vr81hjJ9Kb8SJJwvKTjwLx/r8LYn9xrEZKbINPxFCB3FdGAufFcHOEQOrYjqSvXrLHk=
Received: from BL0PR05CA0005.namprd05.prod.outlook.com (2603:10b6:208:91::15)
 by DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 06:34:28 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::40) by BL0PR05CA0005.outlook.office365.com
 (2603:10b6:208:91::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 06:34:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 06:34:28 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 01:34:23 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Mario Limonciello
	<mario.limonciello@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, Thomas Gleixner <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>
CC: Vilas Sridharan <Vilas.Sridharan@amd.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Cooper
	<andrew.cooper3@citrix.com>, Mikhail Paulyshka <me@mixaill.net>, Kai Huang
	<kai.huang@intel.com>, Rong Zhang <i@rong.moe>
Subject: [RFC PATCH 3/3] x86/cpu/amd: Fetch S5_RESET_STATUS from PHAT when supported
Date: Wed, 3 Jun 2026 06:33:16 +0000
Message-ID: <20260603063317.13665-4-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603063317.13665-1-kprateek.nayak@amd.com>
References: <20260603063317.13665-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|DS7PR12MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: 0762d25c-5396-498c-1b85-08dec13a29cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|921020|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	EYxKBC2wjfGd+xGvAdVj7B7aakWAXHLakQBS8U2i/AXmUN4MV2JXxlPJjaLiNuPcL7wbg00r2dXzW8eHdObTqXh+Vji4jezYY+Pq1ktLxdzx5ai8hxvbbkOTdvwK908SLOBJbgofOsulJGmbHGjex92JL3K6IIqqHNwyJ7xowmZTt2E65SEdOrYxRUWHb4Rp/G3+gcsNKQwKywGLY4QOY6U5IoLm4pjpvypfNnIis1m31ZdtjiA0lnc+wRrss82gZ6rozz6I/ThCE8bDjr1+NMYyGIfO8eM6DkcjpuMUWqXkP8pFW02Ff22sZ9xHet5+1bg1lgCirY1rzYi6gDmlXsN4HsCt5S1VZiSQX7d+jvrCWwBiI1KwhsEwjVADJeJ09CMsZ6hnOlezSjQTR5Onq34oe1W2uumm74XyZQtWn7XlUZpMYCVYM7OxT8B9RXL82DIK1wTzUqMh+VsM3LCBlkfb+4EgGjhzJ+astj/KNsS19ausjMzJRc5vrz/9QMIbZ/lfTdIHhHa5an4eje8GLcNVVWwQAzn0LGuADpI+zhy7ITicDhHyhf1WZ1p6K3jO5z7PeiYWAialpGwALlVl/0TMEBpE0kvNl0emDCHDT+riz427JcLw/U0/5d/jdkc3M6Qpts9xfpR/6IuMbf6t1mLGjqdzXeXDu3e0F9yn5THf3A36IOdT0O7Q0vGftt8mg1AMPrKUpknxsqERjs3g59YGvC6Zq1iT3totSEwzBFxMFmchDnA1buuflvrFKVtBcV0uOaTl+dVCk7ni/perXg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(921020)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1s7RJjGFNa9ecz6bYJo5TGKqlwVsc6Jn/UDJJuZpMtWeecJAWh7P2T3pt+AFDIdsbDhDdwOrT4xq4qj5miYq3r7e4xvONiGyG7o5nKbeaf78T7ttRcQKyiY0iECnis5+f2r91o/1myIAAWLcLVQHp4I3ivRxPzTfrrZ9CbKLtxodCDb/fUm/yTqLS3Hc5fhYWBIHmdGBNjFBr8vFHprZSwMSit1bkqdfslZi2/8ozhRC/VTEZUz5jwYVqFYmNdlpNggcz9b+/gvtUZjm9bPMHSqwHisiSpvMBWrbCERNNPuq/4bMe+isitykwWGM4rskDgFAUWXvExmj4WhoHqF7l5JfrLeWvnLFTzmxf3exUjTyTRLNOB9I004ML5A2YNw3s/xPpugkiK3vCQwnD2D+jheKerAWN7ThIjALYGUeXjHC5FNLYcqbdSDocUF8NoDl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 06:34:28.6525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0762d25c-5396-498c-1b85-08dec13a29cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6005

Firmware can consume the S5_RESET_STATUS from the FCH register and the
OS may see an incorrect value at the time of boot on certain platforms.

Vilas, Yazen noted that S5_RESET_STATUS is also populated in ACPI PHAT
on newer AMD platforms which is more reliable than the status from the
FCH register.

Use the S5_RESET_STATUS from the ACPI PHAT which is described in the
"Platform Health Assessment Table (PHAT)" section of "AMD Family 1Ah
Models 00h–0Fh and Models 10h–1Fh ACPI v6.5 Porting Guide" [1] on
supported platform and fallback to the legacy FCH path if the PHAT
record is not found.

Unlike the FCH register, PHAT only provides a read-only value which
cannot be cleared once consumed and will persist across kexec boots.

Link: https://docs.amd.com/v/u/en-US/58088_0.90_PUB [1]
Suggested-by: Vilas Sridharan <Vilas.Sridharan@amd.com>
Suggested-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 arch/x86/kernel/cpu/amd.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 2f8e8ff2d000..d3dee7fd4c51 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/export.h>
+#include <linux/acpi.h>
 #include <linux/bitops.h>
 #include <linux/dmi.h>
 #include <linux/elf.h>
@@ -11,6 +12,8 @@
 #include <linux/random.h>
 #include <linux/topology.h>
 #include <linux/platform_data/x86/amd-fch.h>
+
+#include <acpi/actbl2.h>
 #include <asm/processor.h>
 #include <asm/apic.h>
 #include <asm/cacheinfo.h>
@@ -1342,8 +1345,21 @@ static const char * const s5_reset_reason_txt[] = {
 	[31] = "a software sync flood event occurred",
 };
 
+/*
+ * "AMD Family 1Ah Models 00h–0Fh and Models 10h–1Fh ACPI v6.5 Porting Guide"
+ * specifies the vendor-specific GUID of FCH::PM::S5_RESET_STATUS record as
+ * "1f425831-da46-4f65-9296-3c4d44c387ab" alongside the format of reset reason.
+ */
+#define S5_RESET_STATUS_GUID GUID_INIT(0x1f425831, 0xda46, 0x4f65, 0x92, 0x96,\
+				       0x3c, 0x4d, 0x44, 0xc3, 0x87, 0xab)
+
 static __init int print_s5_reset_status_mmio(void)
 {
+	struct reset_status_record {
+		struct acpi_phat_vendor_element		header;
+		u32					s5_reset_status;
+	} __packed *record;
+	guid_t guid = S5_RESET_STATUS_GUID;
 	void __iomem *addr;
 	u32 value;
 	int i;
@@ -1351,6 +1367,23 @@ static __init int print_s5_reset_status_mmio(void)
 	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
 		return 0;
 
+	record = (void *)acpi_phat_get_vendor_reset_reason(&guid);
+	if (!IS_ERR(record)) {
+		bool record_valid = false;
+
+		/* Sanity check before using the parsed record. */
+		if (record->header.length == sizeof(*record)) {
+			pr_debug("Using ACPI PHAT record for S5_RESET_STATUS\n");
+			value = record->s5_reset_status;
+			record_valid = true;
+		}
+
+		acpi_phat_put_vendor_reset_reason((void *)record);
+
+		if (record_valid)
+			goto parse_status;
+	}
+
 	addr = ioremap(FCH_PM_BASE + FCH_PM_S5_RESET_STATUS, sizeof(value));
 	if (!addr)
 		return 0;
@@ -1374,6 +1407,7 @@ static __init int print_s5_reset_status_mmio(void)
 	iowrite32(value, addr);
 	iounmap(addr);
 
+parse_status:
 	for (i = 0; i < ARRAY_SIZE(s5_reset_reason_txt); i++) {
 		if (!(value & BIT(i)))
 			continue;
-- 
2.34.1

