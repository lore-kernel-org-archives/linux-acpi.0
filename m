Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013024.outbound.protection.outlook.com [40.93.196.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E57F383993;
	Tue, 22 Sep 2026 02:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790044975; cv=fail; b=IY5wkhTwCPX5ESUCmhh1buqnFRXf66YVZFFhGIsbpOF+7HQUK7db3y8Ym8qMaHE66MM4WmEvI2ugeKx5/cn5IlD6Lk7o52QgUwxF+e8Enu88PIFaay0+uN+lVCOo+yDrS6VzbbF1RDfBzEJJ2KAKNuplF5IWhtE8D4ToFwFSw0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790044975; c=relaxed/simple;
	bh=lI8kFYLo8zTG2vTXGo2fbXV3VFCNwjFbbQwwzzY0LN8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CnjNDkxYce1jUPSP2Xj4xr5Tf1dubz1GZwVs1xZs2//EsypcS+dBypFXZZ7Ug3lmI+bvus/jts/GUIgoljaiqnN9F3N4fE3vCVED50Kew0zgYK4FcbIK4yonUEdp0boXoLQ/RBXQnEN1D4+e6x6Pjvc8n2C2NDUzvUvuQwgQz1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gYVSH7M6; arc=fail smtp.client-ip=40.93.196.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gYVSH7M6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HPld6sorzRVMplo7A/XxNpbTXGw0jcPkVNc1Vwnz003I4Citqk2mtjN7OxNgPxOUyNS1t94yy0DegEmVl6FelA9PRFUjTwmEWM8pRVYc4DtTExpM3ea6p9A2QakSrHMHLTTS9xgOd11cpogz212jvdXwHHxedJVhsDlC+jhKhn3NHWSYyLqf87M7IHGoGUeOTmDOxITb1IOB7bGb9sSgUj98j+mxizzYLRggrSZwyaVgxUKuYzpOfunFlK7ferqFcNkZbWkuGGuDwkcx3H7CdYO0qR5XkqhckVzR3HyorM8fIR0A0/7PLB6BYBqp1OlUR4fBoJbH0ML7/jvXe6PfkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1DqEngzNzSd0WBqvQ2HhZlMCs9EObiz4jH1O1QWSr4=;
 b=aLnlrXOoZoHYMB9iXLYhMncXlep1jnWTjWcnMGfcCt3hGEmNYAjEFYggvzsMV0Uusaq/kqNkr+7cIsvlWS+1RtaNdRH5Z0qwa6sFC46TvnLq/7M69W+JoBbicqqEoTj+g2Kkxo3vRVBwPQ2Rh5gcJs7PUyjWy3NHJRPeff2Sp96k2x7M9Cunw5Qn3QTz15woZAcg5MPrK4qngU2i2U41GvJg7uR4+F8StrIQ2rtInZoPlknphdqkZ+kyL2XZR6cGncRYVDdHC3mhFEsBpaxMvoWLGUYFoxWEW7H7cITk4LIeOKa7hfnW0fgtTkUtDmAuVaTGAshvWJ0iLO7l7oKjXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1DqEngzNzSd0WBqvQ2HhZlMCs9EObiz4jH1O1QWSr4=;
 b=gYVSH7M6DAnDABGIIO1OSg4cSh3GPWHk6n5j42iGPr5JlQIOTGYVAjipDEUZK1SimZeGGiKDC04eCN/O6MQIIazwpu8K4ZWbWlGCeNddzRD1tlBDCOOeZxxkXGP8hr6QLtGp+Lw8z45LhnL/PPsSiPV6YUf8RNp2tR7vFN8i+Ak=
Received: from SJ0PR13CA0126.namprd13.prod.outlook.com (2603:10b6:a03:2c6::11)
 by LV3PR12MB9119.namprd12.prod.outlook.com (2603:10b6:408:1a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Tue, 22 Sep
 2026 02:42:49 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::94) by SJ0PR13CA0126.outlook.office365.com
 (2603:10b6:a03:2c6::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.12 via Frontend Transport; Tue,
 22 Sep 2026 02:42:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 02:42:48 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 21:42:47 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 21:42:47 -0500
Received: from localhost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 21:42:45 -0500
From: Baorui.Liu <baorliu@amd.com>
To: <rafael@kernel.org>
CC: <lenb@kernel.org>, <robert.moore@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linuxfoundation.org>,
	Baorui.Liu <baorliu@amd.com>
Subject: [PATCH v4] ACPI: button: Report wakeup key only for power button wakeups
Date: Tue, 22 Sep 2026 10:42:32 +0800
Message-ID: <20260922024232.816-1-baorliu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260917143116.445-1-baorliu@amd.com>
References: <20260917143116.445-1-baorliu@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|LV3PR12MB9119:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e3efae2-b876-472f-7b69-08df18533085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Cwnpe+toYUosZ3kC8MailAKIKSv+VXW7EO5dfgzegFqjhUao1x+ApWwhkO7boFu8qr48kvNeBtqQbovaZk8YKnDHBCDcYLqadpknCS3gJtDbK+EIQ/JNUUsqVRH+JiFxgjgy0eKD9KWkxlZIhgCWdcPscHG8gJnIS0qKq70xtkfHuytaEVFpj7eJofBYDJ3oYvqtETD3fPNTB2ZyLYswcidsbvUGwTEqQy4pEHGQ+b/WmqE/NI/lTNLwOSESilX6lePL6EYJkPq/FxvvcFrm6wlMAdR3tCxr852Z5prtvi05Lv3rYIbVNCdozpRhT1rmvOWn6Wh32ZIo104/qrcB6KfMlZdfKBfG8rkV84MrWmTscT9rMY2KPLO5r6+bG9FN9ZhcO71e539NAkBG5HOrPC6WZ4Dq++sp+cy/HxnEPtMCmiUALCnLJqZ3z3Lg35bil7qekXwrIt/36SBuqIYEEKd1pd7+A/f4Q/EmSlg2fpmegUCKM49H5jM/5DC/5QJsAL0QZexvO43TUlZ+nbSbCHfPW8WGoiY0L/qSkbT/LfCdDZD6c5BcR2lKYuaQw6aQrGTiitBWs12JJeuhiprfJEbhgUySpWWr7xaXOQlPPkr0124irXa8e+FiHNgSo7+jz8H9ntDK5o1NlU5ruHKRwrdnp4RjY/G08fjw4Renopz9WTxgBFxkyHyXwnpdvB+cP8S5Quz9F5WQiZPAa+A4Nw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	s8YIMJNpAL9W4UCfPYYczePUf8Mfiet0+S7JjVz1bMjTHMdx+z2KEAMZzEUoAAYk831wezGWEZHD45RDZCw75Y6TOeTcSk0PGhqj5BE55xNG2NOytUJztgk4bLKD+zvcXPg2Y3exI6msO3nhfEnryu8/R1ICkw5PbUSuFj4ZgjwynICuCn1jMQ1UEk+zvGX3/sgmvfSdVH0Km2nPrXgU4JwhTU3wqFiU4/E7vB9FIk/XrG3GKS1vCnQXeMbcJMuEiTSDhWtRxqOmmwIr+NWllMAEZZapX0m0sJeraR7ODSQm2NG4xX3e+7GL74UvyXcFnEoUT8abwbHL+tUrnOhr2ziCIO2TiNcTP816SIJOxuBn/QYyXptr0voPKJNSy9/b1kLqm9zk7lyip0wMZnYbz9RtjkpxG+/6+Gu+/hVQaaBcVVmFjU8qnip2FcURbHNX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 02:42:48.3992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3efae2-b876-472f-7b69-08df18533085
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9119

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

Signed-off-by: Baorui.Liu <baorliu@amd.com>
---
 drivers/acpi/button.c | 46 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/acpi/sleep.c  | 27 +++++++++++--------------
 include/acpi/button.h |  5 +++++
 3 files changed, 62 insertions(+), 16 deletions(-)

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
index af2fce5d2ee3..213c6cfd0264 100644
--- a/include/acpi/button.h
+++ b/include/acpi/button.h
@@ -8,11 +8,16 @@
 
 #if IS_ENABLED(CONFIG_ACPI_BUTTON)
 extern int acpi_lid_open(void);
+extern void acpi_button_power_wakeup_pending(void);
 #else
 static inline int acpi_lid_open(void)
 {
 	return 1;
 }
+
+static inline void acpi_button_power_wakeup_pending(void)
+{
+}
 #endif /* IS_ENABLED(CONFIG_ACPI_BUTTON) */
 
 #endif /* ACPI_BUTTON_H */
-- 
2.34.1

