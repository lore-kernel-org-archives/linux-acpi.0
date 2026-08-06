Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010009.outbound.protection.outlook.com [40.93.198.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D5B47ACD7;
	Thu,  6 Aug 2026 12:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786019285; cv=fail; b=BVUej8oqcZ2m+sF2zNQAbl1yrT1sAvbelX2yo+yA6cD06XtaW/cEb94+1KZDrMOrot/ihMoAyspRli0vis+7aTEluekWNpgqxtvmsZcWTPDnVN+NJvUKWGIuhmm/YUTd00SyL37EvAjbnS1k4F7H2UnEG5raXot6l79I9hZJwKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786019285; c=relaxed/simple;
	bh=sXlQPhxmA7oV6XT9IkfoGGIvXXKyZIxj9zAMpdX7VIY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GTj7ewEjQTfmGe8HfnTzPbVcDSqmZ13XRxeO7F6azWLKh3JIrhDniJB4GqgyrDiWanigkByFS3Opdbs+RgCUz/aGyRuukO0Q9g1Ga17BMqM0jTXXVKD/arLUVDgRVvJL5c4A+qeCM0j6Cuu+TeypmClt3hh5A8pUDQXYM1sQROo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o8QJx9L0; arc=fail smtp.client-ip=40.93.198.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o8QJx9L0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqFdD8ycPW5rkUnPcavUFC3ejhphlrIrHQ7wSuotpjE94zdxYflFxepmSKJld6ZyjESa5+kqDm5PGQfj7fj1e9FQrV7DGoHzK7oJCfJpCZuBeAmA1h7GmRuKDz44U1PAcibDNsRXzYR2fbQoTW22J6oMcmRSwJkHWVg/5t8e8GGvcRyHr+/nEktRiySPBQfzlFTPX6as6sA4W6abK24OCPTTyCQ0iZF5RLWXOs5bYSl64Kew/8pChIiDw5LqesZDLWFf2S5dQHiyq2QG/ob6i4KVe/LAJciUSGRo0tNyqqj86z8y8N49F3ou3l8hfFVMyUg9nC9wVHm9WoNaKR7xaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UiWw0qNpX3vBEChGCu9SyB4oejHSlrQLcyqjVMnwrOM=;
 b=rXwJiysrRJi4l3G6HuWH+GeysInfyfIZUV8TBiS9YetjCqLFrBjfilEyA+mdsx8+QipAg0/JvknQIAChSD/iCh/f9yWFmKUnmR2FxE4KWc0EBIGymaSIDm0Rj478ErUKFRQfCyO+Vlh45LER6YJRh1H4VCV2g7VNWGhx2pnkzpqQEihoZSp6+7iB5PVYvhf7uxY7FbumiZbu9pDrS8CAP1bmPmsJt0vc5XbA1xOqqlZjZVoK+jFkD7/SKZoe6wwxfgOaInnwZDfbazEtknVQXcirG/z4giMklO14uhexsZQQUzaIJV+OTpofLduYj+SpjsKaYdL7IrZ0u2SsuYMuGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiWw0qNpX3vBEChGCu9SyB4oejHSlrQLcyqjVMnwrOM=;
 b=o8QJx9L0+VJdKobt20P0WDsm0DGaI/amBdlLfoXl0r0PYwZzIKySVzWl8bXEf20lvi6tpCNfF7nJGfUf3s6Pb3OA1yMbzQ1xGgQnedT+Ha2ngobruMsgKPNCR67XT78B8vOJtSRzzw5OFaGvkjXs8EqvauqliKzczdYQG89AphQ=
Received: from SJ0PR13CA0192.namprd13.prod.outlook.com (2603:10b6:a03:2c3::17)
 by LV8PR12MB9690.namprd12.prod.outlook.com (2603:10b6:408:296::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 12:27:55 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::8a) by SJ0PR13CA0192.outlook.office365.com
 (2603:10b6:a03:2c3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.7 via Frontend Transport; Thu, 6
 Aug 2026 12:27:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 12:27:55 +0000
Received: from localhost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 07:27:52 -0500
From: Baorui Liu <baorliu@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, Mario Limonciello <superm1@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, Baorui Liu <baorliu@amd.com>
Subject: [PATCH] ACPI: button: Report wakeup key only for power button wakeups
Date: Thu, 6 Aug 2026 20:27:32 +0800
Message-ID: <20260806122732.533-1-baorliu@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|LV8PR12MB9690:EE_
X-MS-Office365-Filtering-Correlation-Id: ae5e502d-c6d4-46c5-a388-08def3b62456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|11063799006|56012099006|10067099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TcWiGf0n30uzaJ9V7g/JXAcG9vWCfKepUee87pPuNi/4OaH5mz+JahmaMqjBfuzcUsDPxwLJP6fIMbfIQLyKIhAcNOet7EUDL1tLpNTK+1JoasXRCiCsO4R4w6mJ8X/uqqpIUmfXZAucUm4WlIrYVBadVFFFJ2fHZDb9p7p1NpkVdmXxVaDDTzm/RyEy7p8k1SW5H79LT48wrbxh0UxNnW+1XYWFd9y6U9wVyNE1Auz/J7+RiBzDxKmpZsjzX0Ge+THxXGIxnTwrQU83kyVlGvu6uUyG0lJAi+lbQ80XIfrTqdbe4ObWwVER/sj/+3XHccx6Wxqofn88KqA91o/TJIkc0FVnRff+2cgLO5V0ntN7oErXZ3z3y53IaG1NUFfX8bevpzTI/6ZwSrfGYL1sJJH3lTyrp95i2i5PCf/MXLLq9Y3htgIZSDnGSVVz7EQk92dHjm63u5gknlyj2vZZSgPpB0yW2CHlbiMj4Q8g66N06vsNGdRP9L3PptJiF0Wi1qIeFvW4nTrRz+b/x+JiqH1JC2vymkVVw6P/y6QwaJex2Ub4qqmelf14SZGvgcyLZOM4jIEDXjT86D8D/b63BTPCH6OiyEBva4aPaN3cV9qNMIKRTqoU7jyxE7KFO8BJs+gGjEF6/ObQbRIwblc95Jj4d5Ufv2p+2IuB/NkjVknryPT8j4niCPUWEcGxYPvS9AexAikgT+mYOAZ4A7Tw3A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ehKax6pDZHm18JGzTrqx+7TJqA78W4LOd664HtWT6SKDan/Y99h6hpvieHM+/IWA0Mp6ZTrQBOKebwbfkHer9TbS7GtqBMnfd2vBsp6NjEYWv+YyNfQEBW9xmOfdUKS8F7nH1lUB5wrfqVWwChJ4DvH5gI9bVfMQpvoP/ABOSHvI9Y2blKpLkBaZXqaiz0BXlpUm5hvZTf87qUJ48NGt0XEKAKq1FsSQAZWTol9tNHkajMtgObUb8bStOy7JYlfbbEOYXACl5uLRhySi/tmAUcLPl9yJbamuOGj0vLszZapFQAg15wPo7NYoDCAqEmM74pXAcshAcpQfpzEFQZ9weGk+fmeEPCcCVIch1nzpYF8n70ljxi6gGyrhIoBn3bTHKGjzKcR1m2Xqnw1PsIqsQO4lyZ1wrp94wIXILXs0HYFoi3ijl0YMZUYBkxdrKgY8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 12:27:55.1050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5e502d-c6d4-46c5-a388-08def3b62456
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9690

Commit 16f70feaabe9 ("ACPI: button: trigger wakeup key events")
makes the ACPI power button driver report KEY_WAKEUP from its resume
callback. However, that callback is run whenever the ACPI button device
is resumed, regardless of the actual system wakeup source.

As a result, userspace may receive a KEY_WAKEUP event after resumes
caused by unrelated wakeup sources.

Avoid reporting the input event from acpi_button_resume(). Instead,
report it only when the ACPI fixed power button status indicates that
the power button was the wakeup source.

Fixes: 16f70feaabe9 ("ACPI: button: trigger wakeup key events")
Signed-off-by: Baorui Liu <baorliu@amd.com>
---
 drivers/acpi/button.c     | 23 +++++++++++++++--------
 drivers/acpi/sleep.c      | 21 +++++++++++++++++++++
 drivers/acpi/sleep.h      |  1 +
 drivers/acpi/x86/s2idle.c |  4 +++-
 include/acpi/button.h     |  5 +++++
 5 files changed, 45 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 3836ee75dd66..700510f6e5d0 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -480,6 +480,21 @@ static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
 					event, ++button->pushed);
 }
 
+void acpi_power_button_wakeup(struct acpi_device *device)
+{
+	struct acpi_button *button = acpi_driver_data(device);
+	struct input_dev *input;
+
+	if (button->type == ACPI_BUTTON_TYPE_POWER) {
+		input = button->input;
+		input_report_key(input, KEY_WAKEUP, 1);
+		input_sync(input);
+		input_report_key(input, KEY_WAKEUP, 0);
+		input_sync(input);
+	}
+}
+EXPORT_SYMBOL(acpi_power_button_wakeup);
+
 static void acpi_button_notify_run(void *data)
 {
 	acpi_button_notify(NULL, ACPI_BUTTON_NOTIFY_STATUS, data);
@@ -503,7 +518,6 @@ static int acpi_button_suspend(struct device *dev)
 static int acpi_button_resume(struct device *dev)
 {
 	struct acpi_button *button = dev_get_drvdata(dev);
-	struct input_dev *input;
 
 	button->suspended = false;
 	if (button->type == ACPI_BUTTON_TYPE_LID) {
@@ -512,13 +526,6 @@ static int acpi_button_resume(struct device *dev)
 		acpi_lid_initialize_state(button);
 	}
 
-	if (button->type == ACPI_BUTTON_TYPE_POWER) {
-		input = button->input;
-		input_report_key(input, KEY_WAKEUP, 1);
-		input_sync(input);
-		input_report_key(input, KEY_WAKEUP, 0);
-		input_sync(input);
-	}
 	return 0;
 }
 #endif
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 132a9df98471..26bbecd0c166 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -22,6 +22,7 @@
 #include <linux/syscore_ops.h>
 #include <asm/io.h>
 #include <trace/events/power.h>
+#include <acpi/button.h>
 
 #include "internal.h"
 #include "sleep.h"
@@ -518,6 +519,7 @@ static void acpi_pm_finish(void)
 						    NULL, -1);
 	if (pwr_btn_adev) {
 		pm_wakeup_event(&pwr_btn_adev->dev, 0);
+		acpi_power_button_wakeup(pwr_btn_adev);
 		acpi_dev_put(pwr_btn_adev);
 	}
 }
@@ -818,6 +820,24 @@ bool acpi_s2idle_wake(void)
 	return false;
 }
 
+void acpi_s2idle_restore_check_powerkey(void)
+{
+	struct acpi_device *pwr_btn_adev;
+	acpi_event_status pwr_btn_status = ACPI_EVENT_FLAG_DISABLED;
+
+	acpi_get_event_status(ACPI_EVENT_POWER_BUTTON, &pwr_btn_status);
+
+	if (pwr_btn_status & ACPI_EVENT_FLAG_STATUS_SET) {
+		pwr_btn_adev = acpi_dev_get_first_match_dev(ACPI_BUTTON_HID_POWERF,
+							    NULL, -1);
+		if (pwr_btn_adev) {
+			pm_wakeup_event(&pwr_btn_adev->dev, 0);
+			acpi_power_button_wakeup(pwr_btn_adev);
+			acpi_dev_put(pwr_btn_adev);
+		}
+	}
+}
+
 void acpi_s2idle_restore(void)
 {
 	/*
@@ -849,6 +869,7 @@ static const struct platform_s2idle_ops acpi_s2idle_ops = {
 	.begin = acpi_s2idle_begin,
 	.prepare = acpi_s2idle_prepare,
 	.wake = acpi_s2idle_wake,
+	.restore_early = acpi_s2idle_restore_check_powerkey,
 	.restore = acpi_s2idle_restore,
 	.end = acpi_s2idle_end,
 };
diff --git a/drivers/acpi/sleep.h b/drivers/acpi/sleep.h
index 9c3cb109c5d2..50382c90446c 100644
--- a/drivers/acpi/sleep.h
+++ b/drivers/acpi/sleep.h
@@ -18,6 +18,7 @@ static inline acpi_status acpi_set_waking_vector(u32 wakeup_address)
 extern int acpi_s2idle_begin(void);
 extern int acpi_s2idle_prepare(void);
 extern bool acpi_s2idle_wake(void);
+extern void acpi_s2idle_restore_check_powerkey(void);
 extern void acpi_s2idle_restore(void);
 extern void acpi_s2idle_end(void);
 
diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index b6b1dd76a06b..ce6663c1ef70 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -598,8 +598,10 @@ static void acpi_s2idle_restore_early_lps0(void)
 {
 	struct acpi_s2idle_dev_ops *handler;
 
-	if (!lps0_device_handle || sleep_no_lps0)
+	if (!lps0_device_handle || sleep_no_lps0) {
+		acpi_s2idle_restore_check_powerkey();
 		return;
+	}
 
 	list_for_each_entry(handler, &lps0_s2idle_devops_head, list_node)
 		if (handler->restore)
diff --git a/include/acpi/button.h b/include/acpi/button.h
index af2fce5d2ee3..3cbf3272371e 100644
--- a/include/acpi/button.h
+++ b/include/acpi/button.h
@@ -8,11 +8,16 @@
 
 #if IS_ENABLED(CONFIG_ACPI_BUTTON)
 extern int acpi_lid_open(void);
+extern void acpi_power_button_wakeup(struct acpi_device *device);
 #else
 static inline int acpi_lid_open(void)
 {
 	return 1;
 }
+
+static inline void acpi_power_button_wakeup(struct acpi_device *device)
+{
+}
 #endif /* IS_ENABLED(CONFIG_ACPI_BUTTON) */
 
 #endif /* ACPI_BUTTON_H */

base-commit: 4d823c9d06aaa91476b58e56e4d44c4112da2811
-- 
2.34.1

