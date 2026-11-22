Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795371282;
	b=ahBZyJx4EB4LrNpl3XX5z4j3BRYntJ+eXxhO7Itfw/qvkK0Gi3Rn6A5kmX5bb0qe0bC8
	 ulsE7udK7+P96Wz7pLljHNNb5DZdkUnzAU4/AjjWhy4GXYGzEN51Ew4Q1POxzE8MdVOnt
	 bBnpczJfI5POpJIW3Bzd+skVNlykbzbVHfuPenY+X4FQW+ZrILW2si1nq53wl/vq6kfmN
	 3ttQvJ+8DyGBB1SpGBMY5PR2yU6aX3IYjRvH4EcQhkZicPgjinXMigQ+U6pIo3lFIBLey
	 +mV7JyQxflrBBMz9pX90ikNLtGHAdfmGRVD5JENR8VvVc12yKQennvxgFK70s3HHkqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795371282;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
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
	bh=VdbS/jVwf+OvImMSUozxAaTFSaI0UgL7s+IzqBd3ewY=;
	b=A/D5ghE7UfxOeahL658mX8kovxux1QiI5EI3LdY8HP2m1q2v0aPb9dgU46hy4fI/umIx
	 s5ZVh8EYZtkBSVi7rvfxsWX6nIu4uwZtuwaST05zkiVhim6+JtDqZA8El1QaAyJzdxg4t
	 sRykWCEsmhQETxK5TpJd1GKO5FehlaG6f0OKPUKV1t8hZB/uxtrC5gOrcn42jKyG7Z0SN
	 hMX1xgrnzi3polxj0E1jD5SEIu7JZaOTpxwsms2YXB9tK2vB/lXBae5xRnNA2t6wJYvUD
	 cxGMhc95eioUgHCUYHq+14eKM9SMk2EbSahifVGZxZghhEHreEPuz7vU/4OPLeFGfXQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gky7XX+v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.10
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010010.outbound.protection.outlook.com [40.93.198.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4142E606A320;
	Sun, 22 Nov 2026 18:14:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4142E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gky7XX+v
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yk+MY2dawf3KIDlMUDlTHXy+y28lqR5i1j10eWYS4+ajXq7RXPdK4QEnol8Q4iGHwIxS9KOFZ3qtaZhbyayLUEhQUWP0A3lBe7XdAzz2QmnkkqQcQhp1sOYaFedSYKoII51ZfrGCZT+fppyM6Y+Oj6g/shJKESvJcfV/7TJZVgZFLgIarHm3Y+x7y1fcUf3d1v8kOUH6opr9JrXv89D67g6kfSWTFs8fV05YupYvg6a/s5+mc2p75ltB1Uzsyh1bgZcG/LH4ik5lzoawWCqk1c/AIBkWze8cNAeRXCsTQc1RsMiNzK3s63fMoj74xrkeeDvRWldwgYFHAkwbSYbfcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdbS/jVwf+OvImMSUozxAaTFSaI0UgL7s+IzqBd3ewY=;
 b=DutgCarkpS0F61P5D79bQCpW4RT1Z9D2WJCA7hQQYZOBzKcOL4MsnjLb0ek/Ony180NqDgEeHHRcwhAX7iOtdRW2HghoLd0uM0dv/j+rekFeqQwn5/MiwmE+jorgqWQjbbGfp3CNuxL2vWTZTXYqeDE4zzq3NWQ5fmYe7t/JeC3zzo7ZxehEFWSVsRBgh6TqMG2jQI/C3rQaQzejPiH4EHHdcrS/JJJ97LFXiZHPQVgR+B/NI7cLbPTWDKpsVgnlzpt5gFD/gosv7gU/PgjtpwvNhDVy0+raax2r+2tnpWudup5quLUcloSSUv/2Ri5cv3YomwRTELzWKtwG5st+wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdbS/jVwf+OvImMSUozxAaTFSaI0UgL7s+IzqBd3ewY=;
 b=gky7XX+vOcSwmX+ifSjgKen6q1ZJU+xlROSfjmdEhtLegNi03DCFZCJwALFkSXhq+POcOtF5rx0Ni60yBLG8dQ3xdlNqUpFBH3Fo9mWjxCJfetnvsiNVsc4itRRdAVFc/ohLzsFuqI9/IH8Gg2pHNVWhv8b89YMah0lzqOrdGi8=
Received: from MN2PR11CA0009.namprd11.prod.outlook.com (2603:10b6:208:23b::14)
 by LY0PR12MB736177.namprd12.prod.outlook.com (2603:10b6:404:20e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Sun, 22 Nov
 2026 18:14:36 +0000
Received: from BN3PEPF00022BBB.namprd04.prod.outlook.com
 (2603:10b6:208:23b:cafe::81) by MN2PR11CA0009.outlook.office365.com
 (2603:10b6:208:23b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Sun,
 22 Nov 2026 18:14:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BBB.mail.protection.outlook.com (10.167.248.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Sun, 22 Nov 2026 18:14:36 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 22 Nov
 2026 12:14:35 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Sun, 22 Nov 2026 12:14:26 -0600
Subject: [PATCH] ACPI: x86: Work around AMD CPM _L05 notifying a missing
 dGPU on ASUS G513QY
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261122-fdo-gitlab-6061-v1-1-8380b1ec4e09@amd.com>
X-B4-Tracking: v=1; b=H4sIAAExA2sC/yXMQQ5AMBBA0avIrE2ijZS4ilhoZzAiSItIxN0Vy
 7f4/4LAXjhAlVzg+ZAgyxyh0gTc0M49o1A06EwbpbTGjhbsZZtaiyYzCsk4y1TmBVkHsVo9d3J
 +x7r5HXY7stveDdz3A0s4miJzAAAA
X-Change-ID: 20261122-fdo-gitlab-6061-d6cbed847dbc
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>, Mike Lothian
	<mike@fireburn.co.uk>, Mario Limonciello <mario.limonciello@amd.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBB:EE_|LY0PR12MB736177:EE_
X-MS-Office365-Filtering-Correlation-Id: 1afab405-1c62-40b2-fd75-08df48c47737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|6133799003|18002099003|3023799007|13003099007|11063799006|56012099006|261026121527099003|261026140227099003|261102123227099003|261028144727099003|261022105027099003|261022075727099003|261009223027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	uBpmcSR7t/x9I1qq1VwuZCqUe0+mrO5TV/2HoQ32hI8OmqU8Suyg422QzjyJfnO9J2amGEaQPS1pnv7zcMbEL80wNLM4OcG8PVIkVbPJnpsHgmVTv2Fqf7W5YfI3mTSf7UniyWr2koND25wtdx9lF0vQN6s6Mb33LDj8HS0tAIB47qFfGAs9StLEPyJVmvv/f74z2NYtbBtUOrzo1UYp8eUfxm4bRpxRFAEBJUXZLIdYUr25VH6QEva88vntZJpr+E8DltWF7CD05KjNtCRR3EGCDABANnZ47mtkAw2dU0Xuw81paQHAFiZGwKwUww4AewkrWGAvvuUdhgAPL15QotpdANcVjkd/iqOKDoNOOZIEJhVa+MqKBIxt5C3MQwySzi+GjDUxk2PgMFEdP44Fv35ABqMdw0EVH4+3bc+oKywjQ4gWDE/z4MROZf6aVUfyUXRDyYHwHFzAgBJxJmaix4n9Od/5Nig4VeFX84Qp88DcK8Ya4GUWYxfL1XHZuKI/nh1mysmfFXSu27VFiYuAjlJyYXR2LU9ZUk91ga/gpXtbSIYP/kKT8TrLGV2vdlwhgiUrgmZjsyNrjhjtMaAKb/TDCd71hVMuSm34LFKPDIzkZWoXBeQGehq9vsBVshRgxZgAJ/6dKjpgVN0i4+A3WA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(6133799003)(18002099003)(3023799007)(13003099007)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261009223027099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lUBw+9D4zyohWMwK8j4Gu1VoOW4cJ5oMXEqj4aioByefoFxiESYTM7+rkuOh01sJcqbJqVAqCcje/z8JQuIgn2Qzybjw+FlVuxwy+HCZ40tjkeLaOGGugtTyCWqzUgTrk6cn1vFr9vNCmCPIc2jF0uO9PPF3iHHUAY+li8zYgeq18bCakr/RT++uO/T5jWG+N/JmNa3ECtx8vcGD9GtkHdyDF+xGHs9zCJ6wzej5FOD4OEhcONNFG+546Pn5QYdEmCbpbyzxrIWOrDglz9kImD9oCjDFDMGVWnxRRDtZRnT7zlTAsYuLilmlr876ht9a85yZ+iwP+amJnYgS8FhuMqXUxY0Ya8lCvxtnnhE4PZ6hItHstX+NzQ6CbG3AtE8SLBOMfvvvELrDNADTmHfOj5LzfSzNiNOa/KnrNjiNlSrRrxEV7vBvVdJLchEhcmzY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2026 18:14:36.0411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1afab405-1c62-40b2-fd75-08df48c47737
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB736177

The AMD CPM D3cold SSDT (OEM table ID "CPMD3CLD") on the ASUS ROG Strix
G513QY (BIOS G513QY.335) handles the dGPU hotplug GPE with:

  Scope (\_GPE) { Method (_L05) { Notify (\_SB.PCI0.GPP0.VGA, 0x81) } }

On this board the Navi 22 sits behind an on-package PCIe switch and is
\_SB.PCI0.GPP0.SWUS.SWDS.VGA; \_SB.PCI0.GPP0.VGA is not defined by any
table.  The interpreter correctly aborts the method:

  ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.GPP0.VGA], AE_NOT_FOUND
  ACPI Error: Aborting method \_GPE._L05 due to previous error (AE_NOT_FOUND)
  ACPI Error: AE_NOT_FOUND, while evaluating GPE method [_L05]

so the Notify is lost and a dGPU in D3cold is never woken for the
hotplug.  Other firmware on the same board (the _L00 handler and the
ATIF dispatchers) guards both the GPP0.VGA and GPP0.SWUS.SWDS.VGA paths
with CondRefOf(), so only this method was missed.

Aliasing the missing name is not an option: those guarded branches would
then both resolve and dispatch to the dGPU twice.  Instead, load a small
built-in SSDT with a method that notifies the real node and replace _L05
with a GPE handler that runs it.  The handler defers to a workqueue, as
AML can't run in interrupt context, and re-arms the level-triggered GPE
behind the notify queue as ACPICA does for _Lxx methods.

Match the DMI for the G513QY and introduce a new quirk behind a new
ACPI_AML_QUIRKS option.

Reported-by: Mike Lothian <mike@fireburn.co.uk>
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/6061
Tested-by: Mike Lothian <mike@fireburn.co.uk>
Link: https://lore.kernel.org/amd-gfx/20261029151422.56791-1-mike@fireburn.co.uk/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/Kconfig          |  16 +++++
 drivers/acpi/x86/Makefile     |   1 +
 drivers/acpi/x86/cpm_d3cold.c | 161 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 178 insertions(+)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index fa3eb52b22cd8..70a8d3c79a1b5 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -393,6 +393,22 @@ config ACPI_TABLE_OVERRIDE_VIA_BUILTIN_INITRD
 
 	  See Documentation/admin-guide/acpi/initrd_table_override.rst for details
 
+config ACPI_AML_QUIRKS
+	bool "Workarounds for known AML bugs in system firmware"
+	depends on X86
+	help
+	  Some systems ship AML that cannot work as written, for example a
+	  method that notifies a device which does not exist in the namespace.
+	  This option builds workarounds for such firmware bugs. Each one is
+	  enabled only on the specific systems it is known to be needed on
+	  (matched by DMI), and loads small built-in tables and/or takes over
+	  an ACPI event from the firmware's own method on those systems.
+
+	  Currently this covers the AMD CPM D3cold dGPU hotplug GPE on the
+	  ASUS ROG Strix G513QY.
+
+	  Systems that are not on the list are unaffected. If unsure, say N.
+
 config ACPI_DEBUG
 	bool "Debug Statements"
 	default y
diff --git a/drivers/acpi/x86/Makefile b/drivers/acpi/x86/Makefile
index 63c99509ed9de..04c2c7ffc3a1c 100644
--- a/drivers/acpi/x86/Makefile
+++ b/drivers/acpi/x86/Makefile
@@ -4,5 +4,6 @@ acpi-x86-y		+= cmos_rtc.o
 acpi-x86-$(CONFIG_PCI)	+= lpss.o
 acpi-x86-y		+= s2idle.o
 acpi-x86-y		+= utils.o
+acpi-x86-$(CONFIG_ACPI_AML_QUIRKS) += cpm_d3cold.o
 
 obj-$(CONFIG_X86)	+= blacklist.o
diff --git a/drivers/acpi/x86/cpm_d3cold.c b/drivers/acpi/x86/cpm_d3cold.c
new file mode 100644
index 0000000000000..8db5d5ba1a2af
--- /dev/null
+++ b/drivers/acpi/x86/cpm_d3cold.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * cpm_d3cold.c - Work around AMD CPM D3cold tables that notify a missing dGPU
+ *
+ * The AMD CPM D3cold SSDT (OEM table ID "CPMD3CLD") handles the dGPU hotplug
+ * GPE with:
+ *
+ *	Scope (\_GPE) { Method (_L05) { Notify (\_SB.PCI0.GPP0.VGA, 0x81) } }
+ *
+ * On boards where the dGPU sits behind an on-package PCIe switch the device is
+ * \_SB.PCI0.GPP0.SWUS.SWDS.VGA and \_SB.PCI0.GPP0.VGA does not exist.  The
+ * interpreter correctly aborts _L05 with AE_NOT_FOUND, the Notify is lost and
+ * a dGPU in D3cold is never woken for the hotplug.  Other tables from the same
+ * firmware (e.g. the _L00 handler) already guard both paths with CondRefOf().
+ *
+ * Aliasing the missing name is not an option: those other tables would then
+ * see both paths and dispatch to the dGPU twice.  Instead, on boards known to
+ * be affected, load a small SSDT that notifies the real node and run it from a
+ * GPE handler that replaces _L05.
+ *
+ * The built-in SSDT is the following, compiled with iasl:
+ *
+ *	DefinitionBlock ("", "SSDT", 2, "LINUX", "CPML05FX", 1)
+ *	{
+ *	    External (\_GPE, DeviceObj)
+ *	    External (\_SB.PCI0.GPP0.SWUS.SWDS.VGA, DeviceObj)
+ *
+ *	    Scope (\_GPE)
+ *	    {
+ *	        Method (FX05, 0, NotSerialized)
+ *	        {
+ *	            Notify (\_SB.PCI0.GPP0.SWUS.SWDS.VGA, 0x81)
+ *	        }
+ *	    }
+ *	}
+ */
+
+#define pr_fmt(fmt) "ACPI: CPM: " fmt
+
+#include <linux/acpi.h>
+#include <linux/dmi.h>
+#include <linux/init.h>
+#include <linux/printk.h>
+#include <linux/slab.h>
+
+#define CPM_D3COLD_GPE		0x05
+
+#define CPM_L05_PATH		"\\_GPE._L05"
+#define CPM_FIX_PATH		"\\_GPE.FX05"
+#define CPM_MISSING_PATH	"\\_SB.PCI0.GPP0.VGA"
+#define CPM_DGPU_PATH		"\\_SB.PCI0.GPP0.SWUS.SWDS.VGA"
+
+static const u8 cpm_l05_ssdt[] __initconst = {
+	0x53, 0x53, 0x44, 0x54, 0x79, 0x00, 0x00, 0x00, 0x02, 0x7e, 0x4c, 0x49,
+	0x4e, 0x55, 0x58, 0x00, 0x43, 0x50, 0x4d, 0x4c, 0x30, 0x35, 0x46, 0x58,
+	0x01, 0x00, 0x00, 0x00, 0x49, 0x4e, 0x54, 0x4c, 0x28, 0x06, 0x23, 0x20,
+	0xa0, 0x28, 0x00, 0x15, 0x5c, 0x5f, 0x47, 0x50, 0x45, 0x06, 0x00, 0x15,
+	0x5c, 0x2f, 0x06, 0x5f, 0x53, 0x42, 0x5f, 0x50, 0x43, 0x49, 0x30, 0x47,
+	0x50, 0x50, 0x30, 0x53, 0x57, 0x55, 0x53, 0x53, 0x57, 0x44, 0x53, 0x56,
+	0x47, 0x41, 0x5f, 0x06, 0x00, 0x10, 0x2b, 0x5c, 0x5f, 0x47, 0x50, 0x45,
+	0x14, 0x24, 0x46, 0x58, 0x30, 0x35, 0x00, 0x86, 0x5c, 0x2f, 0x06, 0x5f,
+	0x53, 0x42, 0x5f, 0x50, 0x43, 0x49, 0x30, 0x47, 0x50, 0x50, 0x30, 0x53,
+	0x57, 0x55, 0x53, 0x53, 0x57, 0x44, 0x53, 0x56, 0x47, 0x41, 0x5f, 0x0a,
+	0x81
+};
+
+static const struct dmi_system_id cpm_l05_dmi_table[] __initconst = {
+	{
+		.ident = "ASUS ROG Strix G513QY",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "G513QY"),
+		},
+	},
+	{}
+};
+
+static acpi_handle cpm_fix_handle;
+
+static void cpm_l05_rearm(void *unused)
+{
+	acpi_finish_gpe(NULL, CPM_D3COLD_GPE);
+}
+
+static void cpm_l05_work(void *unused)
+{
+	acpi_status status;
+
+	status = acpi_evaluate_object(cpm_fix_handle, NULL, NULL, NULL);
+	if (ACPI_FAILURE(status))
+		pr_err("%s failed: %s\n", CPM_FIX_PATH,
+		       acpi_format_exception(status));
+
+	/*
+	 * Notify() handlers run from the notify workqueue.  As for a firmware
+	 * _Lxx method, only clear and re-enable the level-triggered GPE once
+	 * they have been dispatched so it can't storm while the dGPU resumes.
+	 */
+	if (ACPI_FAILURE(acpi_os_execute(OSL_NOTIFY_HANDLER, cpm_l05_rearm,
+					 NULL)))
+		cpm_l05_rearm(NULL);
+}
+
+static u32 cpm_l05_gpe_handler(acpi_handle gpe_device, u32 gpe_number,
+			       void *context)
+{
+	/*
+	 * Interrupt context, AML can't run here.  Don't return
+	 * ACPI_REENABLE_GPE: the GPE stays disabled until cpm_l05_rearm().
+	 */
+	if (ACPI_FAILURE(acpi_os_execute(OSL_GPE_HANDLER, cpm_l05_work, NULL)))
+		pr_err("unable to queue GPE %02X handler\n", gpe_number);
+
+	return ACPI_INTERRUPT_HANDLED;
+}
+
+static int __init cpm_d3cold_l05_init(void)
+{
+	struct acpi_table_header *ssdt;
+	acpi_status status;
+
+	if (!dmi_check_system(cpm_l05_dmi_table))
+		return 0;
+
+	/* ACPICA keeps using the table, so it must never be freed */
+	ssdt = kmemdup(cpm_l05_ssdt, sizeof(cpm_l05_ssdt), GFP_KERNEL);
+	if (!ssdt)
+		return -ENOMEM;
+
+	status = acpi_load_table(ssdt, NULL);
+	if (ACPI_FAILURE(status)) {
+		pr_err("unable to load fixup table: %s\n",
+		       acpi_format_exception(status));
+		kfree(ssdt);
+		return -ENODEV;
+	}
+
+	status = acpi_get_handle(NULL, CPM_FIX_PATH, &cpm_fix_handle);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	status = acpi_install_gpe_handler(NULL, CPM_D3COLD_GPE,
+					  ACPI_GPE_LEVEL_TRIGGERED,
+					  cpm_l05_gpe_handler, NULL);
+	if (ACPI_FAILURE(status)) {
+		pr_err("unable to install GPE %02X handler: %s\n",
+		       CPM_D3COLD_GPE, acpi_format_exception(status));
+		return -ENODEV;
+	}
+
+	/* Installing the handler dropped the reference taken for _L05 */
+	status = acpi_enable_gpe(NULL, CPM_D3COLD_GPE);
+	if (ACPI_FAILURE(status))
+		pr_err("unable to enable GPE %02X: %s\n", CPM_D3COLD_GPE,
+		       acpi_format_exception(status));
+
+	pr_info("%s notifies missing %s, using %s instead\n", CPM_L05_PATH,
+		CPM_MISSING_PATH, CPM_DGPU_PATH);
+	return 0;
+}
+subsys_initcall_sync(cpm_d3cold_l05_init);

---
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20261122-fdo-gitlab-6061-d6cbed847dbc

Best regards,
--  
Mario Limonciello <mario.limonciello@amd.com>

