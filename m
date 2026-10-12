Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011070.outbound.protection.outlook.com [52.101.52.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CBE36E477;
	Mon, 12 Oct 2026 06:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791785345; cv=fail; b=VQ3ShBfyAzX5mOc4xIQUKn89+bpl2vYKFRvF9eXdqzKJ+VLpcSILxNfhx8C9pa3ORLR45nkVD0XEN8NerMLdyDE2VVgBt2XvQv4pSNEa21ZonSFWdXcjL8oWXGJ297md7wRyLkNMcSE5UKizvDolJLCamUx9OBwQ8ZC8fqV8V2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791785345; c=relaxed/simple;
	bh=LmjosT6kLaPczGdyy1VlL1z22GYmTRa4zmhYXZk4MCY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jjFbm+9tPf9QPheV2lEWGc3qdpyjzdpi1gbFjWQ2FdRtlYlr03SZtMI36psvjGavGVLd9rMz+4CAi+v6MKtFPfYgMy7AZHuswmk+9ggEe236OQq2Pru79PU2kKAdkL2EX03I+rPp1zhS3RdvJgA6kfE7PlOff+53rDjJubLV+d4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RbaYzL5L; arc=fail smtp.client-ip=52.101.52.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RbaYzL5L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wtqDKiFyX4dzkUpSZV37BkDLT2yTPlU6kUTzd0Bdks6vFNLMnLWDru0DqbciAr9jJHd2RNVHyfZH3mXNUgAlbMUIATUQVmzzv5J3dJ/k60TvM0wyIQ0DDQfQNC53QWIvYYXqaIXVvS+OxaanB8Hi7JhqOY12lR/P5Gh8N/wVVQWEyjRHk999mBTNFMWAfGZ4A+Bw2bA9bqvNx0bFxFAzwyzWs9jTTP8Vxpy9LZ+KA9INJz7K2ConTK1a6Rad9JimodvSighHBVGlaRqhIj2JP52sX4vXs6F+iuitA0oTaJ51BlVz5kU4aTC69BIJ2AOjdTR91/a0cY5Wh5MBIojEEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFDtviAjCI6Fm2/ci961TLfayoagnPWvlihuuzr/lfU=;
 b=vHej2989CbFUCOSlSk+S7zofGeOTKCctipZY1qPuCz7Uhhr+U74yGqQHfPJZ6hs0WtR2eaq2yyqoPWD5fvfbvv/a9sTUZpXW8mVkUiDV25cGG3TIohsE/tUi1XNYzswNIoKLakoDxfYQXCURVSg7hpwXWDeBQmhJRXcWQ16IEao2it/dVUu+XokRcvgReWHBFgoeR11mlIVePjQvwSi8PXxsWGxkoTi+JOj13U6fNk4Rh35on8aTTKOptBMCqxThT3tUC/fpIIT7Qk0gzUdGYgkbhTKm9Lgbdzphh6nwgsbavt78RneK8fSKpA60Q1wxif8QILnUrL4Ml1a06c7EJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFDtviAjCI6Fm2/ci961TLfayoagnPWvlihuuzr/lfU=;
 b=RbaYzL5LTSARrDV/EaZgk+YBVW5ctgtWHenrIYWbHHy+IKI5ViTjvFuuDk57gXm/NezAzYvzJoAXSd+Adm4AVtEw5uQoYuJx7RsPKzvno/HwZ3wZMU1n/pLtM3squIPlC0fdvUOjuA3jnjeUC7Do2y7dS9erh4aUfrZWzHiOBrY=
Received: from BN9PR03CA0395.namprd03.prod.outlook.com (2603:10b6:408:111::10)
 by EAYPR12MB141103.namprd12.prod.outlook.com (2603:10b6:303:300::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 06:09:00 +0000
Received: from BN2PEPF0000A804.namprd02.prod.outlook.com
 (2603:10b6:408:111:cafe::51) by BN9PR03CA0395.outlook.office365.com
 (2603:10b6:408:111::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 12
 Oct 2026 06:08:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A804.mail.protection.outlook.com (10.167.245.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 06:08:59 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 12 Oct
 2026 01:08:53 -0500
Received: from localhost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Mon, 12 Oct 2026 01:08:51 -0500
From: Baorui.Liu <baorliu@amd.com>
To: <rafael@kernel.org>
CC: <lenb@kernel.org>, <robert.moore@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linuxfoundation.org>,
	Baorui.Liu <baorliu@amd.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH v5] ACPI: button: Report wakeup key only for power button wakeups
Date: Mon, 12 Oct 2026 14:08:47 +0800
Message-ID: <20261012060847.486-1-baorliu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260922024232.816-1-baorliu@amd.com>
References: <20260922024232.816-1-baorliu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A804:EE_|EAYPR12MB141103:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa2024c-f4a9-4fae-2a56-08df28274e5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|6133799003|10067099003|22082099003|18002099003|260925022911599003|260925021311599003|260925021911599003|13003099007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	qqsMGMkmzA0k57izhIPjz0aRe2w22AsSIJQwxtZoxmn6pAhg+wKZYasWMbpNFQecCy+3EcUYkZfR9aQmbRVdAfxMjtVDuUbfsUg/kToYirk3mmuauMLZ76djdvQx/oASOTTTqFenFQRhHAOVIdC95uw6Oj2zN9CyvOhSIV+BeTqPT+yRGwbJA/XGDddvY9H2a7bNRP452Bgcf5sJBs3yyf6d+APyoEXOGhw3a1VhOcJH2DRV3M4wBkojfSVHYcmnq64dPY7okB3b5Mu0ty5yPnhPJhbFBNWXDoW3OGmvtgqhhdUIQJZ8zpFFKoccy+jHJw6F/eNRsDsYbMkrfxiKNnwlqUxYE0kKiwWE0GYmVLaMKDkKkml2mzTTsAQzgx6d33vd5XD4b2tbn7JBljRkXPWvd3PcXOTgLgGNmcSYH7H9TV9d5H0PVJdPjlRnhWnrTr05X7XMykfzS8hbeQFUHh3bZlvhdePmnKXvqsxtyRpn2OFrjvAk+yoZjeLiUFUn9TYxqZYAMhlGxJIhHF+KIjazP0zD9+3bamUEJuuqUzMalNyU0Arf+mycQmNMg/LZTfyf0iAdXJEdyHJgmpjwWIl9dvxlBHnDdvYpuZzGyj9tLgGGSCoMQbmpuF4mCOGtBx41M5tHoIdxXdOnQU0sndwp2EnWK3U13vVbteJWeF0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(6133799003)(10067099003)(22082099003)(18002099003)(260925022911599003)(260925021311599003)(260925021911599003)(13003099007)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VcHQgi+MYsLWUUpRl/k8YgFi3x04/J96YmkQAmt85qEoRp+E+Vori0/+VWA+HsFM4YkID/uaoBR/FAcf54A/TdO4c5T2i59Vc94SPQKnNSGrIfanTWo6TZ86Qx0nrNrr/mVX5p+dY3ttFGy8TtnsTB/7/bV8JdLdjt6Zq6i4kX0kD3XT8ckrxdIs2Dz+S/fBLsuQVrGKvxrNNBY4DNBFNfKRs8Qj1lSaWw4KDdnS/7Yq+hK1lc4mm9W5FhrLJaqJwMCuI5lRWQ/LxGP8SelGCeJPfhbgdUSuJG5ZcUSqCsLZ+prsx0RF1Lox6oZVYr7HYfbSaEeI5udj3SsB/E72z62xBscQ8/UQzaLlFN05HfwFOOqFB59L7J6ymmYViXpuhOm7iVfO2ZNAHLDHS7Cy3GRrrljYMuX5/YBsRQPj59xL8SQVYErvCQCELOHy7y21
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 06:08:59.3016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa2024c-f4a9-4fae-2a56-08df28274e5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A804.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB141103

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
case.

When the fixed power-button status bit is set during early S3 resume,
clear it to avoid a deferred KEY_POWER delivery to userspace, and mark
wakeup_pending so button resume can still report KEY_WAKEUP. Also clear
wakeup_pending before setting suspended to avoid a race with a power
button SCI during suspend entry.

Declare acpi_button_power_wakeup_pending() with IS_REACHABLE so that
CONFIG_ACPI_BUTTON=m does not leave an unresolved reference in built-in
sleep.c.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202609290454.LJrhMCb3-lkp@intel.com/
Signed-off-by: Baorui.Liu <baorliu@amd.com>
---
Changes since v4:
- Fix LKP build ERROR when CONFIG_ACPI_BUTTON=m by declaring
  acpi_button_power_wakeup_pending() with IS_REACHABLE().

 drivers/acpi/button.c | 46 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/acpi/sleep.c  | 27 +++++++++++--------------
 include/acpi/button.h | 13 ++++++++++++
 3 files changed, 70 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index cdbb1023a8ee..c07de417df5d 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -191,6 +191,7 @@ struct acpi_button {
 	bool last_state;
 	ktime_t last_time;
 	bool suspended;
+	bool wakeup_pending;
 	bool lid_state_initialized;
 	bool gpe_enabled;
 };
@@ -397,6 +398,34 @@ static void acpi_lid_forget(struct acpi_device *adev)
 }
 
 /* Driver Interface */
+/**
+ * acpi_button_power_wakeup_pending - Mark fixed power button wakeup pending.
+ *
+ * Used when the fixed power-button status bit is observed and cleared during
+ * early S3 resume, so KEY_WAKEUP can still be reported from button resume
+ * without delivering a deferred KEY_POWER to userspace.
+ */
+void acpi_button_power_wakeup_pending(void)
+{
+	struct acpi_device *adev;
+	struct device *phys_dev;
+	struct acpi_button *button;
+
+	adev = acpi_dev_get_first_match_dev(ACPI_BUTTON_HID_POWERF, NULL, -1);
+	if (!adev)
+		return;
+
+	phys_dev = acpi_get_first_physical_node(adev);
+	if (phys_dev) {
+		button = dev_get_drvdata(phys_dev);
+		if (button && button->type == ACPI_BUTTON_TYPE_POWER)
+			button->wakeup_pending = true;
+	}
+
+	acpi_dev_put(adev);
+}
+EXPORT_SYMBOL_GPL(acpi_button_power_wakeup_pending);
+
 int acpi_lid_open(void)
 {
 	guard(mutex)(&acpi_lid_lock);
@@ -476,6 +505,9 @@ static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
 
 	acpi_pm_wakeup_event(button->dev);
 
+	if (button->type == ACPI_BUTTON_TYPE_POWER && button->suspended)
+		button->wakeup_pending = true;
+
 	if (button->suspended || event == ACPI_BUTTON_NOTIFY_WAKE)
 		return;
 
@@ -498,6 +530,11 @@ static void acpi_button_notify_run(void *data)
 
 static u32 acpi_button_event(void *data)
 {
+	struct acpi_button *button = data;
+
+	if (button->type == ACPI_BUTTON_TYPE_POWER && button->suspended)
+		button->wakeup_pending = true;
+
 	acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_button_notify_run, data);
 	return ACPI_INTERRUPT_HANDLED;
 }
@@ -507,6 +544,12 @@ static int acpi_button_suspend(struct device *dev)
 {
 	struct acpi_button *button = dev_get_drvdata(dev);
 
+	/*
+	 * Clear wakeup_pending before marking suspended. Otherwise a power
+	 * button SCI between the two stores could set wakeup_pending and then
+	 * be overwritten here, losing a real wakeup.
+	 */
+	button->wakeup_pending = false;
 	button->suspended = true;
 	return 0;
 }
@@ -523,12 +566,13 @@ static int acpi_button_resume(struct device *dev)
 		acpi_lid_initialize_state(button);
 	}
 
-	if (button->type == ACPI_BUTTON_TYPE_POWER) {
+	if (button->type == ACPI_BUTTON_TYPE_POWER && button->wakeup_pending) {
 		input = button->input;
 		input_report_key(input, KEY_WAKEUP, 1);
 		input_sync(input);
 		input_report_key(input, KEY_WAKEUP, 0);
 		input_sync(input);
+		button->wakeup_pending = false;
 	}
 	return 0;
 }
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 132a9df98471..30e268987e37 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -22,6 +22,7 @@
 #include <linux/syscore_ops.h>
 #include <asm/io.h>
 #include <trace/events/power.h>
+#include <acpi/button.h>
 
 #include "internal.h"
 #include "sleep.h"
@@ -504,12 +505,11 @@ static void acpi_pm_finish(void)
 
 	acpi_resume_power_resources();
 
-	/* If we were woken with the fixed power button, provide a small
-	 * hint to userspace in the form of a wakeup event on the fixed power
-	 * button device (if it can be found).
-	 *
-	 * We delay the event generation til now, as the PM layer requires
-	 * timekeeping to be running before we generate events. */
+	/*
+	 * If woken by the fixed power button, provide a wakeup event on that
+	 * device. KEY_WAKEUP input reporting is handled by the button driver
+	 * via wakeup_pending; do not synthesize KEY_POWER here.
+	 */
 	if (!pwr_btn_event_pending)
 		return;
 
@@ -626,14 +626,11 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
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
+	/*
+	 * ACPI 3.0 (P62): OSPM should clear the fixed power-button status bit
+	 * so the event does not reach userspace as KEY_POWER. Remember that a
+	 * power-button wake occurred so button resume can report KEY_WAKEUP
+	 * and acpi_pm_finish() can emit a PM wakeup event.
 	 */
 	if (ACPI_SUCCESS(status) && (acpi_state == ACPI_STATE_S3)) {
 		acpi_event_status pwr_btn_status = ACPI_EVENT_FLAG_DISABLED;
@@ -642,8 +639,8 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 
 		if (pwr_btn_status & ACPI_EVENT_FLAG_STATUS_SET) {
 			acpi_clear_event(ACPI_EVENT_POWER_BUTTON);
-			/* Flag for later */
 			pwr_btn_event_pending = true;
+			acpi_button_power_wakeup_pending();
 		}
 	}
 
diff --git a/include/acpi/button.h b/include/acpi/button.h
index af2fce5d2ee3..c909c00664c7 100644
--- a/include/acpi/button.h
+++ b/include/acpi/button.h
@@ -15,4 +15,17 @@ static inline int acpi_lid_open(void)
 }
 #endif /* IS_ENABLED(CONFIG_ACPI_BUTTON) */
 
+/*
+ * sleep.c is built-in and calls this helper. Use IS_REACHABLE so that when
+ * CONFIG_ACPI_BUTTON=m the call site gets an inline stub instead of an
+ * unresolved vmlinux link reference (0day/LKP ERROR).
+ */
+#if IS_REACHABLE(CONFIG_ACPI_BUTTON)
+extern void acpi_button_power_wakeup_pending(void);
+#else
+static inline void acpi_button_power_wakeup_pending(void)
+{
+}
+#endif /* IS_REACHABLE(CONFIG_ACPI_BUTTON) */
+
 #endif /* ACPI_BUTTON_H */

base-commit: 4a819ee5f2834330656d6ac168c4c8cf27fdeec2
-- 
2.34.1

