Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011020.outbound.protection.outlook.com [52.101.52.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39B8424655;
	Wed, 19 Aug 2026 08:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787129789; cv=fail; b=E8ZOyPP9Zk2+Xi0LHukmmWAkCZlBgqmztlsA7DKW2KNv3PoXkm2xvCIFPXrnsY9wE/d3NJ+9u71YyYfOZGZOAJHqH6lQN+jwST3kTuS9rKoGykS87PnWyBRjerbJvp6QTMNTAj5QfQVWD42K2KUPcLHHkSms+QvalrsPRqMbhmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787129789; c=relaxed/simple;
	bh=2TmeCto5PrXz4QsG04xRfbemdUTijo3migUiQHEV0QM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BbrSDEEnDnZAvca2TLCu+RFE1GuutV0skekNvkRAH7HDCxPbUM2Lf8XZGPk9PAvRQaktjVlhnVSk4YT3bJb88lTE+YD4ZOurKu2xmq2rjKnkpVWb7tY51dhjwGUU5hEO8UwIVDnNSViCcH6sj4BcZEJDA/fz0B7+hfotpt5dFpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OSCEhK+0; arc=fail smtp.client-ip=52.101.52.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OSCEhK+0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFzBWEZ+L/Ju2CuDkBVP0saz1wvc0SxyT1DQVEasx771MPK+AdieQaGGNYwjTwtD+vDTiXWaX3cz3uByPzmkcezOFBGgQzMTBWfb4yfDzTYZBMW3emHa/CQMt0E1V+xp+nukZbm5eEqoMPCxfRiX1OLM+VGImVILECFI3nNfhVYgWqLshmrol2r/TL/RqwiOHRRrb4yof4Y1Jj9akZ4RlQuxnoJIf0+8Fk+5H332e2N2XyzKCm2K9D63yy2O3GSx1y4HGaY285zRdV9m0OqeygF5F5iRcsw8lAYObGsnzslMqSwoXSOGVTghPaay19TiWVVW5md1NNFDqLil7Zmq8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHDrsWZWrRR58XkpmArXMEhSXnMbV1CIFMKNj2p5Sqk=;
 b=igNL8wwjuy5u2IMsAu9fEwtS7gX0UiWhDNaJ2DNGLZ4XEVU1QaTC6tqyy7303RUjHDpw6UG6bTQI4RzAQF/PQrk4kpI392SmGNpXtQXu8/FAjips8I2XjB4wEHWrYq2DSZoYX80LhEG20kEvgrjlpDPdc/bQzTATBBnY8XjrCxFJNudAlkYvC/7QdGlxIVgL79LLVFAlHgy09cCZoRd6Kv03gnRhpyAKoRfqgu2yMs6ON5H6LZS1JgSNNFEFIvs55s60tcp/fhzMXO3i7TdLnQ72qZLRCNKkpCXwt4lA7NULkHouc9t4vFlK8clSWQ4UQQzWP8DDJz9ci7n+5XBtqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHDrsWZWrRR58XkpmArXMEhSXnMbV1CIFMKNj2p5Sqk=;
 b=OSCEhK+0nkEB+krUtkc0p6Hxj0Aidd/1rrPLJ4bvXgZnd8bla0mGVwOZw4q35dkCI7JYiEDFr2rhROC9UtezxOowoIm0Tk7e97gfIQweRmPh8d+y4icz2gGvFfZ7S3qnB0P1J47wsyp2GuQyuXeewGXKCKEBIrQbg7Rh8jwdoHk=
Received: from CY5PR19CA0080.namprd19.prod.outlook.com (2603:10b6:930:69::29)
 by DS0PR12MB9322.namprd12.prod.outlook.com (2603:10b6:8:1bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 08:56:22 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:930:69:cafe::77) by CY5PR19CA0080.outlook.office365.com
 (2603:10b6:930:69::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Wed, 19
 Aug 2026 08:56:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 08:56:22 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 03:56:21 -0500
Received: from localhost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 19 Aug 2026 03:56:19 -0500
From: Baorui.Liu <baorliu@amd.com>
To: <rafael@kernel.org>
CC: <lenb@kernel.org>, <robert.moore@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linuxfoundation.org>,
	Baorui.Liu <baorliu@amd.com>
Subject: [PATCH v2 1/1] ACPI: button: Report wakeup key only for power button wakeups
Date: Wed, 19 Aug 2026 16:55:28 +0800
Message-ID: <20260819085528.575-2-baorliu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260819085528.575-1-baorliu@amd.com>
References: <20260806122732.533-1-baorliu@amd.com>
 <20260819085528.575-1-baorliu@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DS0PR12MB9322:EE_
X-MS-Office365-Filtering-Correlation-Id: ac163976-b230-4e76-4a67-08defdcfbe00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|10067099003|56012099006|6133799003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	GxcELZysGMlQ+tUHf+XsZ7YPmvmAzyWTzArLj/DNRggFhX+09gSrXxoa7GtFgM6Yro6ChWCHdY2j9LGWCBZYoga4s1EK9yuFcwZqhKa04wvOuTkUip2dNZeUKXp6AQP5IAoVD+V3yJIBziocrgLsuawlV39X7QAxqhTOR9GojT1im/a8ECLhx96zj6qHejpMz6uj2TFNRT49ebvxE34F3934qZGgnoYLkOhq/dwmEyWohlHA5kiJedu/UUT3sJRtU66i3xiRsMsPI8A+9/ZEZSUJg3/c0caxUcl2RXedPXZLjiiOHCkdQzM9zboaZ+nLXAsp59NTDXG8WOCkiosO1tSz/h4RzI0c/PtYSoUHx/Bc2Rf9NeQGAeYd3iwZLpByBcudfm99HTa+/QP+P4yGls7ASKGZRVmgIBFVXXuIu/4cqOb5uU3GPjYZQhUopMyKyR1QIt6POj5bT/zn794BVWAVHbt2yH0d9auhZe/3QGKLr8q8eSJ5F/tBEU0JXRn08qi/UrEVZbydUm7+qj2rpmdZA4xowQakQYci+vFrF+oooK50bLH34HJbQ/arQfvncJU4YlmFWHVARiFAr2/X9PSYfuwczEdVolwBwvJLA2hSUNMeyLOajNqQOWFcJ6GjPrrHbE5edRRFGXEfKLncXMJqSEwkpd1dOShuA9dhuaPx2t3j5RCi9ocXVRs++pniwKQumr3os4erNtk/PccatA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(10067099003)(56012099006)(6133799003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YBl3T++qOQcy1CHaDQSEg6SoM4rQF3IHgTmnR736Z7VC5gg3fGDY+cowQFtOzaN01fZBw9oDJVOja6+c3+U5wjVOVyZhyC8HvkO/Qgm31MjsiLi5Dx84vk1DPWYwTTjZXNJXsa5EQXjVfA4I9D1HtHZHc2FPOCrW8G4UU9GzE/ITgTpeJvAHaQcnPHpLpIxg+cCF9F2Bbs2r70fcqQmdew3XGMBKpgiEffYWczdv2/fkOwBrBxi8xpCQDVYLvxh0qaf3mDiQeC1Qv7FsjRUDU275LlCQNQJG32jNOj138P7cOj9oQDWQhwDYEhJF+1YktCUCkP+ezmyzzgGARt5noARAcfVzPweQhjWmGRjZGETVbIKq2/JUsJj13VJalUoeA9eFEjh++RWl/J0ZrOzIIz+URMbTkKh+pNX7Kpj2BRl6vTLgRI5NQC1uTKCp3dXQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 08:56:22.0060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac163976-b230-4e76-4a67-08defdcfbe00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9322

The ACPI button driver reports KEY_WAKEUP from the Power Button input
device to let userspace know that the system was resumed by a power
button wakeup.

However, reporting KEY_WAKEUP from generic system resume paths can make
userspace observe a Power Button wakeup even when the system was resumed
by a different wake source.

This is reproducible on an AMD Android 15 Xen guest. With a kernel
without this fix, a non-power-button S3 resume:

  echo mem > /sys/power/state
  xl trigger android s3resume

makes the Power Button input device report KEY_WAKEUP. The same test on
a kernel with this fix no longer reports KEY_WAKEUP from the Power Button
input device.

Track whether a power button event/notify is observed while the ACPI
button device is suspended, and report KEY_WAKEUP on resume only in that
case. Do not synthesize a Power Button input event from generic ACPI
sleep resume code.

Signed-off-by: Baorui.Liu <baorliu@amd.com>
---
 drivers/acpi/button.c | 38 ++++++++++++++++-------------
 drivers/acpi/sleep.c  | 56 +++----------------------------------------
 include/acpi/button.h |  5 ----
 3 files changed, 24 insertions(+), 75 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 8d2843bece29..f9b6b7fff5bd 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -175,6 +175,7 @@ struct acpi_button {
 	int last_state;
 	ktime_t last_time;
 	bool suspended;
+	bool wakeup_pending;
 	bool lid_state_initialized;
 };
 
@@ -452,6 +453,9 @@ static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
 	acpi_pm_wakeup_event(&device->dev);
 
 	button = acpi_driver_data(device);
+	if (button->type == ACPI_BUTTON_TYPE_POWER && button->suspended)
+		button->wakeup_pending = true;
+
 	if (button->suspended)
 		return;
 
@@ -468,23 +472,6 @@ static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
 					event, ++button->pushed);
 }
 
-void acpi_power_button_wakeup(struct acpi_device *device)
-{
-       struct acpi_button *button = acpi_driver_data(device);
-       struct input_dev *input;
-
-       if (button->type == ACPI_BUTTON_TYPE_POWER) {
-               input = button->input;
-               input_report_key(input, KEY_WAKEUP, 1);
-               input_sync(input);
-               input_report_key(input, KEY_WAKEUP, 0);
-               input_sync(input);
-       }
-
-       return;
-}
-EXPORT_SYMBOL(acpi_power_button_wakeup);
-
 static void acpi_button_notify_run(void *data)
 {
 	acpi_button_notify(NULL, ACPI_BUTTON_NOTIFY_STATUS, data);
@@ -492,6 +479,12 @@ static void acpi_button_notify_run(void *data)
 
 static u32 acpi_button_event(void *data)
 {
+	struct acpi_device *device = data;
+	struct acpi_button *button = acpi_driver_data(device);
+
+	if (button->type == ACPI_BUTTON_TYPE_POWER && button->suspended)
+		button->wakeup_pending = true;
+
 	acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_button_notify_run, data);
 	return ACPI_INTERRUPT_HANDLED;
 }
@@ -503,11 +496,13 @@ static int acpi_button_suspend(struct device *dev)
 	struct acpi_button *button = acpi_driver_data(device);
 
 	button->suspended = true;
+	button->wakeup_pending = false;
 	return 0;
 }
 
 static int acpi_button_resume(struct device *dev)
 {
+	struct input_dev *input;
 	struct acpi_device *device = to_acpi_device(dev);
 	struct acpi_button *button = acpi_driver_data(device);
 
@@ -518,6 +513,15 @@ static int acpi_button_resume(struct device *dev)
 		acpi_lid_initialize_state(device);
 	}
 
+	if (button->type == ACPI_BUTTON_TYPE_POWER && button->wakeup_pending) {
+		input = button->input;
+		input_report_key(input, KEY_WAKEUP, 1);
+		input_sync(input);
+		input_report_key(input, KEY_WAKEUP, 0);
+		input_sync(input);
+		button->wakeup_pending = false;
+	}
+
 	return 0;
 }
 #endif
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 0adfcd0fb55e..d655248c20d4 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -22,7 +22,6 @@
 #include <linux/syscore_ops.h>
 #include <asm/io.h>
 #include <trace/events/power.h>
-#include <acpi/button.h>
 
 #include "internal.h"
 #include "sleep.h"
@@ -105,8 +104,6 @@ u32 acpi_target_system_state(void)
 }
 EXPORT_SYMBOL_GPL(acpi_target_system_state);
 
-static bool pwr_btn_event_pending;
-
 /*
  * The ACPI specification wants us to save NVS memory regions during hibernation
  * and to restore them during the subsequent resume.  Windows does that also for
@@ -463,7 +460,6 @@ static int acpi_pm_prepare(void)
  */
 static void acpi_pm_finish(void)
 {
-	struct acpi_device *pwr_btn_adev;
 	u32 acpi_state = acpi_target_sleep_state;
 
 	acpi_ec_unblock_transactions();
@@ -482,24 +478,6 @@ static void acpi_pm_finish(void)
 	acpi_target_sleep_state = ACPI_STATE_S0;
 
 	acpi_resume_power_resources();
-
-	/* If we were woken with the fixed power button, provide a small
-	 * hint to userspace in the form of a wakeup event on the fixed power
-	 * button device (if it can be found).
-	 *
-	 * We delay the event generation til now, as the PM layer requires
-	 * timekeeping to be running before we generate events. */
-	if (!pwr_btn_event_pending)
-		return;
-
-	pwr_btn_event_pending = false;
-	pwr_btn_adev = acpi_dev_get_first_match_dev(ACPI_BUTTON_HID_POWERF,
-						    NULL, -1);
-	if (pwr_btn_adev) {
-		pm_wakeup_event(&pwr_btn_adev->dev, 0);
-		acpi_power_button_wakeup(pwr_btn_adev);
-		acpi_dev_put(pwr_btn_adev);
-	}
 }
 
 /**
@@ -604,27 +582,6 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 	/* Reprogram control registers */
 	acpi_leave_sleep_state_prep(acpi_state);
 
-	/* ACPI 3.0 specs (P62) says that it's the responsibility
-	 * of the OSPM to clear the status bit [ implying that the
-	 * POWER_BUTTON event should not reach userspace ]
-	 *
-	 * However, we do generate a small hint for userspace in the form of
-	 * a wakeup event. We flag this condition for now and generate the
-	 * event later, as we're currently too early in resume to be able to
-	 * generate wakeup events.
-	 */
-	if (ACPI_SUCCESS(status) && (acpi_state == ACPI_STATE_S3)) {
-		acpi_event_status pwr_btn_status = ACPI_EVENT_FLAG_DISABLED;
-
-		acpi_get_event_status(ACPI_EVENT_POWER_BUTTON, &pwr_btn_status);
-
-		if (pwr_btn_status & ACPI_EVENT_FLAG_STATUS_SET) {
-			acpi_clear_event(ACPI_EVENT_POWER_BUTTON);
-			/* Flag for later */
-			pwr_btn_event_pending = true;
-		}
-	}
-
 	/*
 	 * Disable all GPE and clear their status bits before interrupts are
 	 * enabled. Some GPEs (like wakeup GPEs) have no handlers and this can
@@ -797,19 +754,12 @@ bool acpi_s2idle_wake(void)
 
 void acpi_s2idle_restore_check_powerkey(void)
 {
-	struct acpi_device *pwr_btn_adev;
 	acpi_event_status pwr_btn_status = ACPI_EVENT_FLAG_DISABLED;
+
 	acpi_get_event_status(ACPI_EVENT_POWER_BUTTON, &pwr_btn_status);
 
-	if (pwr_btn_status & ACPI_EVENT_FLAG_STATUS_SET) {
-		pwr_btn_adev = acpi_dev_get_first_match_dev(ACPI_BUTTON_HID_POWERF,
-			NULL, -1);
-		if (pwr_btn_adev) {
-			pm_wakeup_event(&pwr_btn_adev->dev, 0);
-			acpi_power_button_wakeup(pwr_btn_adev);
-			acpi_dev_put(pwr_btn_adev);
-		}
-	}
+	if (pwr_btn_status & ACPI_EVENT_FLAG_STATUS_SET)
+		acpi_clear_event(ACPI_EVENT_POWER_BUTTON);
 }
 
 void acpi_s2idle_restore(void)
diff --git a/include/acpi/button.h b/include/acpi/button.h
index be02d3ff2896..af2fce5d2ee3 100644
--- a/include/acpi/button.h
+++ b/include/acpi/button.h
@@ -8,16 +8,11 @@
 
 #if IS_ENABLED(CONFIG_ACPI_BUTTON)
 extern int acpi_lid_open(void);
-extern void acpi_power_button_wakeup(struct acpi_device *device);
 #else
 static inline int acpi_lid_open(void)
 {
 	return 1;
 }
-static inline void acpi_power_button_wakeup(struct acpi_device *device)
-{
-       return;
-}
 #endif /* IS_ENABLED(CONFIG_ACPI_BUTTON) */
 
 #endif /* ACPI_BUTTON_H */
-- 
2.34.1

