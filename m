Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013039.outbound.protection.outlook.com [40.93.201.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C639D5908C2;
	Thu, 17 Sep 2026 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655492; cv=fail; b=ZUdWE5xuoJRSnT0+ZXQnBUuS6fe8uM3dLcKnCwJq+KJkdSSJfCbP21/LJas5VN/5cm/zveeEgymfUspP/W4Jg0cnML4iK3G3KuE2+t9D9aff1YBk8aN+LxhQDr05KpRv2QYzPDPRqVNZL1yn7mgsh9DbjuSrBZEK7SELRa8Hdgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655492; c=relaxed/simple;
	bh=3SbNoaQ+sY/hXoQU+jPNs/iCFD2iEh9WlAZj7suDB6c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s/P8MOAVFOjaL+5WC4QFTm/TdGK+yiJSC5P5lfF/TEMNBq15U6jI8RX+fuEmWmOYPlxcvzBatkFh58a0sezHUpwQcQAOQsl+yK2mHuGVysnESJfIewA8mXV9op3eMnZHzhR8HyWcVGYPhxOMH8eK9GAWBiMWNALGndjOto8efVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q4VfN+7c; arc=fail smtp.client-ip=40.93.201.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q4VfN+7c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JsKmEsLGv1vx2A6GdTPMOKftttC8lQDt6slwa4FYMs4Nr+UuHYhyoaQ6qWcghj3JCSku1MPDWB1k7iDu65aivIGrs2GqqVbv3zFRPp+/fZ7/mIW091ZMnGfG0ILOUt4jBVMSi5JAzMNNSEAXYMISGmn9BFgOhys/J0QzmrrrNPMZrifLSrDsI0eMCfTD61twrvpnaw2PMxLDv2MlupjBCHl+3qP3KamhOfiv7YqhP9CMx15juCFOLYJPwpb74RHL7wdq7fFsjDdJVQ3QXdxOg6saeSbHtnfkhg9c3nWoBhBWKtVq/LwAGWzPLT03mxFQ/xA+XyRngJOdN6TjKUcKlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jZfbz10axuN2WkrK+HeQ74eCW/IFJ0hXxMePpcTJc0=;
 b=dSx+RGMZXXnBZcYdsqjz/Mzr9efmowmuXxdiYL9J7Qb+c93C1nVjpMefIhTTF7FeXPfPCZ0HzwNmfh1WSBYv7GpLDvG9BmwCM6Ej4PP4c9I4KCQANOU9fbUXL/IkImhqS5st8Ew6uH7p4LdVhM07nCW+WDOfWfca+K7r2WQ1SRpUHTRiFV4BOSRygG3EIJZJPp/n2xC0jF67HQN5Le+EiwsFAYnRyI21OfZs8fCeAfgFyBHzXMZYU1hkjRw+9MSD9R/CexKALS4aqDjcpDD826QGA6glXluEWiMDZTRYxLNFiQ0a/0D94xAbYelp3HmJSFdZ6GDcETrYC+fbf+zu/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jZfbz10axuN2WkrK+HeQ74eCW/IFJ0hXxMePpcTJc0=;
 b=Q4VfN+7cPkSaN8jiPSFEIfa6hlZMtv3DdY2kkSYLF7FJ+hJGMTMquXvJg0lVtTdtENPF+WoP4ACnlEQgVpum1c+zSCFAiv4MkCVHFPIYMWN3zJZxB26R10q4nBx06UdXz8xXWcZ24oxoCS0DMCxPpdIeUuMsLKSf8wGomU3hnW8=
Received: from BL1PR13CA0256.namprd13.prod.outlook.com (2603:10b6:208:2ba::21)
 by DS7PR12MB6190.namprd12.prod.outlook.com (2603:10b6:8:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 14:31:27 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::20) by BL1PR13CA0256.outlook.office365.com
 (2603:10b6:208:2ba::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8 via Frontend Transport; Thu, 17
 Sep 2026 14:31:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 14:31:27 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 09:31:27 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 09:31:26 -0500
Received: from localhost.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Thu, 17 Sep 2026 09:31:25 -0500
From: Baorui.Liu <baorliu@amd.com>
To: <rafael@kernel.org>
CC: <lenb@kernel.org>, <robert.moore@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linuxfoundation.org>,
	Baorui.Liu <baorliu@amd.com>
Subject: [PATCH v3] ACPI: button: Report wakeup key only for power button wakeups
Date: Thu, 17 Sep 2026 22:31:16 +0800
Message-ID: <20260917143116.445-1-baorliu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260819085528.575-2-baorliu@amd.com>
References: <20260819085528.575-2-baorliu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|DS7PR12MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: b60be0db-b6a6-4d7b-6db1-08df14c85bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|6133799003|22082099003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Ht+hyOkE9+ZkbUObVoVr6ePGdBQlJINZ/bk47I32IiJvsKULI4d6o8B38ZHsqwFXAh/L36zJSvymYt1E+6igp4Yt34XEYCaihsnMFJqHJYg8fa+ktd841MUUOzeP2cbqsxWH0djB7cdfeKl0yrstD99jdEVY2REcHB52Ib2HgEKRhghiJcDkDBBd/l91o7NelWJhQ01JI0KHgwezdR93xzYmmED2e7kDYlhvvn0TY2UW0q7444ldvLdFFMhSVcGrhq0EI4ZRz10r0jLlvwFrFsMTAwMF/AC39fcxs3y7dYSDxrGss49cfImFLkLMujjWf3xYREl56U894ALDc4CBFpiAAUqBc/vT49OT6p6puieeu3wa5f5MCKZB4OhnRFv11in04QCQegoDuToCrAPToFCWH+aLZok/tVmF3wF5lCR4e1uqUVM8+S+fn4gABV6k8epVtTSvVFETcwXpi+V1okdstSjCoKU4vi666tCP6SBZ5xWdD1vE1OLkxgDNFPaHFKCDSu/o48TkHDmlMALe08cr/d9x2Y1XCloT+uUqbVWvYoqmnRdMsb5S3w1wZvsfBMNytzXmfeMZvX1gBx+ck4M5DfZzg7IgmkA3G4g+zEEV+KgxVStFYBSsB57SqYqP/1qFy8EyP7knEw+5RCmrb/+QVn92Kk/Agu2kSCttH0tya5aVz0wlym07CwqayZbkMVYluyU4lnk8HhAOyCJftw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(6133799003)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	e6lCWvp54v6DB+PxulGcgPWKAWssV2JYFL0pP9H/pCpV9Fuo/wLPAq8jZaNkrwMnQ5EN2yNrR0FrHQqg/D6mi+oKD89sfGezxg5jrMamq9opLxhNX044jP37zTsT+yQvSEFC/TWIVq7D0zxBQQJDCc6jrrtZN57t90vm7psjROI8xVRQ+Yy48Gbc0zRCl3XWSYWQiQY4OZwoxHnmZRXU4rCBn4WfWWjBCdcQ30d5HZAabWYE21x9e6QWsadZKsoq9SH08gvhHg1PmsRXP5eccAG90VTFxDAapc/WjTurkhF+v1tnXc7t7AMicYk0ZocHfXAjlSYXzpUipPHoudbsePn5UTHL8Iy+8mfYemDCI57Ul8IJO6x/+lVomAzcFiUHXUsZJMvAIbxu9vcER+PESvW1So3DP5fq9pLknHchOgvWK472NmC7LtWVo1abdEEs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 14:31:27.5514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b60be0db-b6a6-4d7b-6db1-08df14c85bca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6190

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
 drivers/acpi/button.c | 13 ++++++++++++-
 drivers/acpi/sleep.c  | 41 -----------------------------------------
 2 files changed, 12 insertions(+), 42 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index cdbb1023a8ee..7a708fe351fb 100644
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
@@ -476,6 +477,9 @@ static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
 
 	acpi_pm_wakeup_event(button->dev);
 
+	if (button->type == ACPI_BUTTON_TYPE_POWER && button->suspended)
+		button->wakeup_pending = true;
+
 	if (button->suspended || event == ACPI_BUTTON_NOTIFY_WAKE)
 		return;
 
@@ -498,6 +502,11 @@ static void acpi_button_notify_run(void *data)
 
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
@@ -508,6 +517,7 @@ static int acpi_button_suspend(struct device *dev)
 	struct acpi_button *button = dev_get_drvdata(dev);
 
 	button->suspended = true;
+	button->wakeup_pending = false;
 	return 0;
 }
 
@@ -523,12 +533,13 @@ static int acpi_button_resume(struct device *dev)
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
index 132a9df98471..7296e4bb0e4d 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -104,8 +104,6 @@ u32 acpi_target_system_state(void)
 }
 EXPORT_SYMBOL_GPL(acpi_target_system_state);
 
-static bool pwr_btn_event_pending;
-
 /*
  * The ACPI specification wants us to save NVS memory regions during hibernation
  * and to restore them during the subsequent resume.  Windows does that also for
@@ -484,7 +482,6 @@ static int acpi_pm_prepare(void)
  */
 static void acpi_pm_finish(void)
 {
-	struct acpi_device *pwr_btn_adev;
 	u32 acpi_state = acpi_target_sleep_state;
 
 	acpi_ec_unblock_transactions();
@@ -503,23 +500,6 @@ static void acpi_pm_finish(void)
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
-		acpi_dev_put(pwr_btn_adev);
-	}
 }
 
 /**
@@ -626,27 +606,6 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
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
-- 
2.34.1

