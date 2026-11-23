Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795424179;
	b=VNJGfeEG3RVFJCtcs/KgrHfctDRP6qEsYaBEdGT+T7Kt8JPbssYxaL7tetHay9X09nN1
	 vrSX/GgAx1KwOA7YxVWAQHT+y4Mjszc1k7HW4XPVlswpk4eDi+P7DGgonyAe39cRx4FOl
	 hgathM23HThODd14bR5V0oEeOXzSyjjZltCIYlkgi1qBRCuXS+yx2qEqHcNwa1pvGXI+J
	 Enlng3rIEdBnjYp/GQQ1pO5DTxbVpkuSoFu1V+UHwq2u4vp4jU4AoiI7Nq0RgMFFN6Zx0
	 tEBzHj9HQwKIyyLDljUghwN7FdglSxOpgZRg0uHamvV/LhmbRsOg5a66bXaXELnQMsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795424179;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=pp6HdMEH1gMxSpJq8g6sD6eJNtHXoCNpIkAG2W+zxRU=;
	b=QzPahcyb/sc53p00C+tk/c3JE66wllu0Mwu6tJG7niywPJmtfROrbDtcvqbVwIymVUl3
	 ZcP0FKiGCQUdxkRwWA4H6mBLSdGQhdLHBEFjiPy3VYab/6Ar0XtGo4JYDgkoAvMQVYMB0
	 kqlRstFKhyJIuL3Q5/J8XYT+AHPfzCHZ2NbnZmF8fwBP79not1LT8UZgnpt7lG7j/LIfr
	 64RBmjcbyLwZCZ9632+yLW7zwZnDcZoftV5LMoAUB9lmbIE6fMOlgUPrvcR6v4X9RAPpt
	 z+NgLlqo4SG1FQWfI5xaeUAf4zhjj5xJez2sDD2I1Zr1C5Xxe4+O0UnvifV1f9iXqSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="C/nT7SJA";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.6
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013006.outbound.protection.outlook.com [40.93.196.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF21606A33B;
	Mon, 23 Nov 2026 08:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EF21606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=C/nT7SJA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vCxYtF6m0OVA+qgTKm9ACPq/4C5BSTOubC9Plka2Tar5J6n//sgiljZInQV8ZDVRhv3XqsWkHrfEuB6bxWYlsUDWird5Msp0uboFlidWwZYzFApLQfHTx6ktGmODH7555bmtc9itSL4dyoWeByYQ7aEtstQXcmWSfE7RKuWxxUK8pIs/A/uL7KWl/i+zA91ySd5aFVBLpYcqN+KGY6gK6yTGMpPRwBhTI34zXflGF8j8w1ueN+7jA0mVcdT2JKFs4wJ1AZTct6SymjvGtqv3VOG+pQZN33O0MnmF6n8yIlmfr5kJvHUI2eMpDC9TpQFmI7RYZSXrMPhjUxBmDT684A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pp6HdMEH1gMxSpJq8g6sD6eJNtHXoCNpIkAG2W+zxRU=;
 b=NJ2kV1lwsdeA2gN0c49uQYMDbHT7yarYNHAPv3qoUwJl6w2JvYsxhwrUdw1PQltDQu27JObYFRiIQF+fTbVpyfgId070IXcWYzKszwrq8J9kNqHNH/PtwoAL8LmEd4VFHFXdVYmh9Mu7yVJwBQuiHFvjIAKRev4ssxKevPuaBY+gi16yIl5Xq1xUQhI5gXczbipWfzr8L/dMu7+OOJ/GE9dAxFBVHJ7WUbeNn68a3HGl02A/o13IUxqElvCJyLZT48u48nZ4/Qq+woRiWMCS9zcPm2qQu6/BXAEFGvF/ypqgANrUvv/Kg2Y8sRLvW0egLsPbFU3WdOnIgaXAN4CFMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pp6HdMEH1gMxSpJq8g6sD6eJNtHXoCNpIkAG2W+zxRU=;
 b=C/nT7SJAOqqGagNBlCah45fAzgGjfwkkoty9tz5XEGY8+tBV2GA01jmA0Es0UrdZW5Aaz2dUeFqlFBMXcDMKZrx3a1vZgOxPMKrYAiQKdnypuubMynFzWgNgTeOhEUhvXOJnIURkbLBMvDApSuS+Ih9j77CyeqlOHHoQu/UC2hY=
Received: from MW4PR04CA0153.namprd04.prod.outlook.com (2603:10b6:303:85::8)
 by PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 08:56:11 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:303:85:cafe::10) by MW4PR04CA0153.outlook.office365.com
 (2603:10b6:303:85::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 08:56:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 08:56:10 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 02:56:10 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 02:56:09 -0600
Received: from localhost.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Mon, 23 Nov 2026 02:56:07 -0600
From: Baorui.Liu <baorliu@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<acpica-devel@lists.linuxfoundation.org>, kernel test robot <lkp@intel.com>,
	Baorui.Liu <baorliu@amd.com>
Subject: [PATCH v9] ACPI: button: Report wakeup key only for power button wakeups
Date: Mon, 23 Nov 2026 16:56:07 +0800
Message-ID: <20261123085607.476-1-baorliu@amd.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|PH7PR12MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: bfd94e63-80fe-4c57-94df-08df493f9ee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|6133799003|18002099003|261009223027099003|13003099007|261021123027099003|261021121427099003|261026140227099003|261026121527099003|261102123227099003|261022075727099003|261022105027099003|261028144727099003|56012099006|10067099003|261102130727099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Nw47vyfCib2yI4+efGEkpn6Ky//w1Ex7LpYPcjBMea4qun4wAR0Zu2X74CRKBuSbf94XnYsaMjqmh+iE/02oHFFsIH+8lNbHQuooHviQVVT2h0rbOeYRS7UTvGXQhYkEnNkhskCBAXALyJKyGN24wNRyj3tfH7GwE4jpEvU5IEeaSg+5I+6EDZ93odc+HbEsGFGN8duLhyoF6qcT+lUk6MQm7lJGa8hoKPRP4bxIchV1kZHfq1qqSugl3BodZdGm66L4WI8jKYSrFYoNzDRnnO5rwVv9jvrVYo16+YXhU5kHGvBxdix8VjfOMRt/TikmPVaL63/NQ+BrxCYuLg4428yR2eakrfP/pjc0GYp/00bhz+h2PSwKuxuldZgdfUFVpghWvoAy/IDvoABjkCwDjg7C9A8tZI0Con3nWtp9Z7hjJGvVoJhj0gjOufV7RiBJfgtr3QVcB51KZHmzvnzKh6djyfz6YjUYBozPmuTd65ypwNhlEi7Wy/69ReBsD95AqwM2I4VHipsk517FMcmNZON7QCzznAGwEU2um4RiRXkmEvGXRMiiSyn+F2tueAaO02aEKWzypI7c41VlmRsdfzT0cLvyglmva3PTiJx77dHdc/Ug9DKsvodZR1FEiN2CYZeThaL0uwayqIDp+8asbQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(6133799003)(18002099003)(261009223027099003)(13003099007)(261021123027099003)(261021121427099003)(261026140227099003)(261026121527099003)(261102123227099003)(261022075727099003)(261022105027099003)(261028144727099003)(56012099006)(10067099003)(261102130727099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PjPuaRZ7cXws1ecjrmHqgpj6S88IAiJ6WF7jzsUNgvkZoJkfaL6gaJSvKioMX+kcxmXXbLyFfJOkA6lWEF8pF1O2jupvVPQpt9weqdi7C2d4rT6up6bbdIQkq4BJNU9UmDprwBrNsg4XhnovlrhF+GtMErwkmAoX5MlwThyjMba1Uj3CzEJOYY9I0g+BATvdfZeHUfL0dKn3hNtnb+EfweQ1BYTN1WvNsWRKNxSaeke1kES1f/OivF1syIlJiBv0YzsEKEmZ5+dovlVqp93aTE0qymUJrbEfCLWI3lHhirfgpVvgCWWSp9Lk8+W0wilI/WMn2ATEIybQFqnlvbdp0l1wIxa1UOzpRuBptSB2h4JgJd5FoK1DfTpZOQ/aWYcPFuNjXi2+ClqTb7L8Wxa2LBC3mO74tJcaeTydD9rp/DoXWxY9zpE68GysdBRCuWrf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 08:56:10.5976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd94e63-80fe-4c57-94df-08df493f9ee1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8796

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
clear it to avoid a deferred KEY_POWER delivery to userspace, and set a
sleep.c-owned flag so button resume can still report KEY_WAKEUP. Do not
call into the button driver from that IRQ-disabled path. Only the fixed
power button (ACPI_BUS_TYPE_POWER_BUTTON) consumes that flag. Sample the
button driver's wakeup_pending separately and call the helper even when
wakeup_pending is already set, so a short-circuit does not leave the flag
set.

Order the suspended and wakeup_pending updates with SMP barriers. Clear
wakeup_pending before setting suspended, and publish suspended == false
with a release store before dropping a wakeup_pending that arrived in
between. Sample suspended once in the notify path so the handler cannot
emit both KEY_WAKEUP and KEY_POWER for one event. Drain ACPI notify work
before sampling on resume.

Fixes: 16f70feaabe9 ("ACPI: button: trigger wakeup key events")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202609290454.LJrhMCb3-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202611030112.cVsBZFFE-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202611030545.3st9p1ha-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202611100542.1xljQv20-lkp@intel.com/
Signed-off-by: Baorui.Liu <baorliu@amd.com>
---
Changes since v8:
- Consume acpi_sleep_pwr_btn_wakeup_pending() before combining it with
  wakeup_pending, and only from the fixed power button, so the sleep.c
  flag cannot stay set or be taken by a control-method power button.
- Pair suspended and wakeup_pending with smp_load_acquire,
  smp_store_release, smp_wmb, and smp_mb. Sample suspended once in
  acpi_button_notify.
- Add Fixes: 16f70feaabe9 ("ACPI: button: trigger wakeup key events")
  and keep the version changelog below ---.

Changes since v7:
- Guard acpi_sleep_pwr_btn_wakeup_pending() with CONFIG_ACPI_SLEEP,
  matching its definition in sleep.c, so button resume does not link
  against a missing symbol when CONFIG_PM_SLEEP=y and CONFIG_ACPI_SLEEP
  is unset (0day/LKP ERROR on x86_64 randconfig).

Changes since v6:
- Include <linux/types.h> in include/acpi/button.h so the bool
  declaration/stub of acpi_sleep_pwr_btn_wakeup_pending() builds when
  the header is included without prior bool typedefs (0day/LKP ERROR
  via nouveau_connector.c on parisc64-defconfig and arm64-randconfig).
---
 drivers/acpi/button.c | 83 ++++++++++++++++++++++++++++++++++++++-----
 drivers/acpi/sleep.c  | 47 ++++++++++++++++--------
 include/acpi/button.h | 19 ++++++++++
 3 files changed, 126 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index c41fba556030..088d8e80c8b7 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -17,6 +17,7 @@
 #include <linux/seq_file.h>
 #include <linux/input.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/acpi.h>
 #include <linux/dmi.h>
 #include <linux/platform_device.h>
@@ -203,6 +204,7 @@ struct acpi_button {
 	bool last_state;
 	ktime_t last_time;
 	bool suspended;
+	bool wakeup_pending;
 	bool lid_state_initialized;
 	bool gpe_enabled;
 };
@@ -474,6 +476,7 @@ static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
 	struct acpi_device *device = button->adev;
 	struct input_dev *input;
 	int keycode;
+	bool suspended;
 
 	switch (event) {
 	case ACPI_BUTTON_NOTIFY_STATUS:
@@ -488,7 +491,16 @@ static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
 
 	acpi_pm_wakeup_event(button->dev);
 
-	if (button->suspended || event == ACPI_BUTTON_NOTIFY_WAKE)
+	/*
+	 * Sample suspended once. Two separate READ_ONCE() calls can observe
+	 * different values if resume runs on another CPU, and then this path
+	 * either drops the event or emits both KEY_WAKEUP and KEY_POWER.
+	 */
+	suspended = smp_load_acquire(&button->suspended);
+	if (button->type == ACPI_BUTTON_TYPE_POWER && suspended)
+		smp_store_release(&button->wakeup_pending, true);
+
+	if (suspended || event == ACPI_BUTTON_NOTIFY_WAKE)
 		return;
 
 	input = button->input;
@@ -510,6 +522,12 @@ static void acpi_button_notify_run(void *data)
 
 static u32 acpi_button_event(void *data)
 {
+	struct acpi_button *button = data;
+
+	if (button->type == ACPI_BUTTON_TYPE_POWER &&
+	    smp_load_acquire(&button->suspended))
+		smp_store_release(&button->wakeup_pending, true);
+
 	acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_button_notify_run, data);
 	return ACPI_INTERRUPT_HANDLED;
 }
@@ -519,7 +537,15 @@ static int acpi_button_suspend(struct device *dev)
 {
 	struct acpi_button *button = dev_get_drvdata(dev);
 
-	button->suspended = true;
+	/*
+	 * Clear wakeup_pending before marking suspended. Otherwise a power
+	 * button SCI between the two stores could set wakeup_pending and then
+	 * be overwritten here, losing a real wakeup. smp_wmb() makes that
+	 * order visible to the SCI and notify handlers on other CPUs.
+	 */
+	WRITE_ONCE(button->wakeup_pending, false);
+	smp_wmb();
+	WRITE_ONCE(button->suspended, true);
 	return 0;
 }
 
@@ -528,20 +554,61 @@ static int acpi_button_resume(struct device *dev)
 	struct acpi_button *button = dev_get_drvdata(dev);
 	struct input_dev *input;
 
-	button->suspended = false;
-	if (button->type == ACPI_BUTTON_TYPE_LID) {
-		button->last_state = !!acpi_lid_evaluate_state(ACPI_HANDLE(dev));
-		button->last_time = ktime_get();
-		acpi_lid_initialize_state(button);
-	}
+	/*
+	 * Drain notify work queued while suspended so a late power-button
+	 * notify still observes suspended == true, sets wakeup_pending, and
+	 * does not synthesize KEY_POWER for userspace.
+	 */
+	acpi_os_wait_events_complete();
 
+	/*
+	 * Consume the fixed-button flag before combining it with
+	 * wakeup_pending. A short-circuit || would skip
+	 * acpi_sleep_pwr_btn_wakeup_pending() when wakeup_pending is already
+	 * true and leave the flag set for a later non-button resume. Only the
+	 * fixed power button owns that flag.
+	 *
+	 * Publish suspended == false with a release store, then sample
+	 * wakeup_pending again. A press that arrived after the first sample
+	 * still observed suspended == true and must be reported as KEY_WAKEUP
+	 * before the flag is cleared.
+	 */
 	if (button->type == ACPI_BUTTON_TYPE_POWER) {
+		bool from_button = READ_ONCE(button->wakeup_pending);
+		bool from_fixed = false;
+
+		if (button->adev->device_type == ACPI_BUS_TYPE_POWER_BUTTON)
+			from_fixed = acpi_sleep_pwr_btn_wakeup_pending();
+
+		if (from_button || from_fixed) {
+			input = button->input;
+			input_report_key(input, KEY_WAKEUP, 1);
+			input_sync(input);
+			input_report_key(input, KEY_WAKEUP, 0);
+			input_sync(input);
+		}
+		/* Drop the sample already reported, before publishing resume. */
+		WRITE_ONCE(button->wakeup_pending, false);
+	}
+
+	smp_store_release(&button->suspended, false);
+	smp_mb();
+	if (button->type == ACPI_BUTTON_TYPE_POWER &&
+	    smp_load_acquire(&button->wakeup_pending)) {
 		input = button->input;
 		input_report_key(input, KEY_WAKEUP, 1);
 		input_sync(input);
 		input_report_key(input, KEY_WAKEUP, 0);
 		input_sync(input);
+		WRITE_ONCE(button->wakeup_pending, false);
 	}
+
+	if (button->type == ACPI_BUTTON_TYPE_LID) {
+		button->last_state = !!acpi_lid_evaluate_state(ACPI_HANDLE(dev));
+		button->last_time = ktime_get();
+		acpi_lid_initialize_state(button);
+	}
+
 	return 0;
 }
 #endif
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 7c1fb5b844be..a17318a7a3d6 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -22,6 +22,7 @@
 #include <linux/syscore_ops.h>
 #include <asm/io.h>
 #include <trace/events/power.h>
+#include <acpi/button.h>
 
 #include "internal.h"
 #include "sleep.h"
@@ -105,6 +106,23 @@ u32 acpi_target_system_state(void)
 EXPORT_SYMBOL_GPL(acpi_target_system_state);
 
 static bool pwr_btn_event_pending;
+static bool pwr_btn_wakeup_pending;
+
+/**
+ * acpi_sleep_pwr_btn_wakeup_pending - Consume fixed power-button wake hint.
+ *
+ * Returns true once if acpi_suspend_enter() observed and cleared the fixed
+ * power-button status bit during early S3 resume. Used by the button driver
+ * to report KEY_WAKEUP without sleeping in that IRQ-disabled path.
+ */
+bool acpi_sleep_pwr_btn_wakeup_pending(void)
+{
+	bool pending = READ_ONCE(pwr_btn_wakeup_pending);
+
+	WRITE_ONCE(pwr_btn_wakeup_pending, false);
+	return pending;
+}
+EXPORT_SYMBOL_GPL(acpi_sleep_pwr_btn_wakeup_pending);
 
 /*
  * The ACPI specification wants us to save NVS memory regions during hibernation
@@ -504,12 +522,12 @@ static void acpi_pm_finish(void)
 
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
+	 * via acpi_sleep_pwr_btn_wakeup_pending() / wakeup_pending; do not
+	 * synthesize KEY_POWER here.
+	 */
 	if (!pwr_btn_event_pending)
 		return;
 
@@ -625,14 +643,13 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
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
+	 * so the event does not reach userspace as KEY_POWER. Only set plain
+	 * flags here: this path runs with IRQs disabled, so do not call into
+	 * the button driver (it may take sleeping locks). Button resume later
+	 * consumes pwr_btn_wakeup_pending for KEY_WAKEUP; acpi_pm_finish()
+	 * uses pwr_btn_event_pending for the PM wakeup event.
 	 */
 	if (ACPI_SUCCESS(status) && (acpi_state == ACPI_STATE_S3)) {
 		acpi_event_status pwr_btn_status = ACPI_EVENT_FLAG_DISABLED;
@@ -641,8 +658,8 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 
 		if (pwr_btn_status & ACPI_EVENT_FLAG_STATUS_SET) {
 			acpi_clear_event(ACPI_EVENT_POWER_BUTTON);
-			/* Flag for later */
 			pwr_btn_event_pending = true;
+			WRITE_ONCE(pwr_btn_wakeup_pending, true);
 		}
 	}
 
diff --git a/include/acpi/button.h b/include/acpi/button.h
index af2fce5d2ee3..83f5dd373f39 100644
--- a/include/acpi/button.h
+++ b/include/acpi/button.h
@@ -2,6 +2,8 @@
 #ifndef ACPI_BUTTON_H
 #define ACPI_BUTTON_H
 
+#include <linux/types.h> /* for bool */
+
 #define ACPI_BUTTON_HID_POWER	"PNP0C0C"
 #define ACPI_BUTTON_HID_LID	"PNP0C0D"
 #define ACPI_BUTTON_HID_SLEEP	"PNP0C0E"
@@ -15,4 +17,21 @@ static inline int acpi_lid_open(void)
 }
 #endif /* IS_ENABLED(CONFIG_ACPI_BUTTON) */
 
+/*
+ * Set in acpi_suspend_enter() when the fixed power-button status bit is
+ * observed (IRQ-disabled context). Consumed by the button driver on resume
+ * so KEY_WAKEUP can be reported without calling into the button driver from
+ * that early path. Defined in sleep.c under CONFIG_ACPI_SLEEP. CONFIG_PM_SLEEP
+ * can be enabled without CONFIG_ACPI_SLEEP, so the stub keeps button.o
+ * linkable in that case. Safe when CONFIG_ACPI_BUTTON=m.
+ */
+#if IS_ENABLED(CONFIG_ACPI_SLEEP)
+bool acpi_sleep_pwr_btn_wakeup_pending(void);
+#else
+static inline bool acpi_sleep_pwr_btn_wakeup_pending(void)
+{
+	return false;
+}
+#endif
+
 #endif /* ACPI_BUTTON_H */

base-commit: 0889fa4ceb57abcd36535bd17cfcadce893e6e13
-- 
2.34.1

