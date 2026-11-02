Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793610678;
	b=rQtemRvFQpU4zxeYLGlkcwWNkdTHdcYElDAkIldsrKbSmQ7pT4GF8CS20zFRH1p5dJeo
	 UEY2Z1bKbW0p4p0ZcHmREU7GI19JapGnV7nP4d82rCeDuN7NH9cV8VGI7hsyIl8CX4BVj
	 hZIrtP3GNkWp5pqBNnvBtZJixBM7LksxfmDaqbXGc02xuEgJHMQeNo0DE28ZxciNo/dH/
	 x5R4jw8/Mw1tjdawGW7jDs0Uct/3g2EV9X0hxt1EbSG8UTZxQAZn2wNVVUb2UxpQxiEhE
	 9UHDoBozXdm+PPyPp9JBeDusbN6txo1q0hUb/Go3vGhm8Ut6wXC1gE4MBLqL4gm56DQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793610678;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
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
	bh=brUKus2zFIbYUgWlU6u0z8W/K/KMsHNXY1hx3JS70lk=;
	b=ci27bty5gztb+AIH/05K3agpGnboR1cdK4oq5d1LeBZ+D/v/XjGxPxdwblR2XXkjvSvS
	 r06eY71Byjd+F1h87Uo1fobYF/2qqJ6Ucljg1oJbGcKM31RIgl6hK43afWZPBQXXyNdBg
	 9vWLVA/BzWdL6+FW3KuTudIC4Q6f6RtguE9OtHtBVDWV607Nmu57/ppfZxlkMH75l1nsp
	 Hx/Ks9va1zRSjbbTNvMNZtXIxMK0C+cT3R2s73gq9CYNHqO3EfygPCYHR7LH7E2wOJlat
	 zzf9/QlotjNIXxKGrpOqZh5gl3IPB0YYlFyUrEEL48DwXONHjH5VvTayYX2jG88mg7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=N3pjoXpQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.45
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013045.outbound.protection.outlook.com [40.93.196.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E11606A32C;
	Mon,  2 Nov 2026 09:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03E11606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=N3pjoXpQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRXpR0r4bO1D/PM/JE81u3gstkvdot/cIjwMZtVZbYaA5v81MyBOAjH7slnMPPs14C4fA03j8kvep1+R37i1+8euV6/OClKMYwir+6UIS5FIyCV9eDusHFj42LrY38vaPO6ghMbueGEC4Rx5duabX0ElN0Q++njlX+9we3EvLKo01o6g8oLY4CK4FUcXr4/9FCv+YxeRdawHYSeisCitNu8bhBBqW63xc8szeykfKkT80t5ZuoQBK9I8L6PN6LPsqEmIX+9ehFVxlz5dSqMjvCXHUcYFyj6db92o6/dW4YymzZcB2EFrYXW23KyzlKWXog6lsA+C1BrOeF0TUOAehQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brUKus2zFIbYUgWlU6u0z8W/K/KMsHNXY1hx3JS70lk=;
 b=h9TMQwk7kz1LyrzuW/w3Pizi0mvrN8bahDpWhA+6c+GIm7jN3IDLKj4tz8IdC0zzfD0sjdhdYzHFKgalM+1+uEp58GCexR/y8tfGZjx91S80ozhAKxF2J69FV54xVSsSdSJYJpI70t8XiLZpE9+uoT/pY/bzi0njICA33Jo7IWVAGqR1JIZ03cZpd6dqGu+cnzKwamx1yraAo5vtYh2IqBsnU3GF2LZ2pGMuWsOQftn63NFTzLzRndfNAE6G2OPzScIVWe3sHGdo6nHjdK4HMbmHsSvceow3Hcpv5QCIG2fOEDwmOvW9EGQwD9tJ3PXpFbBd4whhudcEwnI1BtZ6lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brUKus2zFIbYUgWlU6u0z8W/K/KMsHNXY1hx3JS70lk=;
 b=N3pjoXpQIQAWQ9X1PYQrBNInY8nkxTK5pXyAmC70VPwyGbrhNX6YlQiAkwHaCdJ4ZFkMsQkKlEWgxq1lfmxzVGj3sdlmlSsTnSSU6dCx+bOgU4XZSRNSBCNNVQ8BUmmfEap6ygM72h+lNnrwR9O82MmfsLGpIeFzMDJEiWCK+HI=
Received: from CH0PR03CA0232.namprd03.prod.outlook.com (2603:10b6:610:e7::27)
 by IA1PR12MB8539.namprd12.prod.outlook.com (2603:10b6:208:446::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 09:11:10 +0000
Received: from BN7PEPF000000A9.namprd05.prod.outlook.com
 (2603:10b6:610:e7:cafe::31) by CH0PR03CA0232.outlook.office365.com
 (2603:10b6:610:e7::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 09:11:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000A9.mail.protection.outlook.com (10.167.245.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 09:11:10 +0000
Received: from localhost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 2 Nov
 2026 03:11:07 -0600
From: Baorui.Liu <baorliu@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<acpica-devel@lists.linuxfoundation.org>, kernel test robot <lkp@intel.com>,
	"Baorui . Liu" <baorliu@amd.com>
Subject: [PATCH v6] ACPI: button: Report wakeup key only for power button wakeups
Date: Mon, 2 Nov 2026 17:10:49 +0800
Message-ID: <20261102091049.856-1-baorliu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261012060847.486-1-baorliu@amd.com>
References: <20261012060847.486-1-baorliu@amd.com>
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
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A9:EE_|IA1PR12MB8539:EE_
X-MS-Office365-Filtering-Correlation-Id: 16594cc3-62c1-448a-5cde-08df38c13c8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|11063799006|10067099003|56012099006|22082099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	cikeAiATv60cwCwbDeL9cMQTcXigyMq0CynTbCX6OjH5eBn8go04XfSK/fLAXr3/uNi3VHsg2vhGNkdlEX0cuPZSOuRfwYtGvJHeh//ooYyojbSwTSE9j0ml82cbImMC/3jM8oe/cjCcYKyVOm1eVkuuZVopDIT04C5RategH2tr8dmla9YbEGx9OXfBgzfRrxlWQIrl2QGn9QkmiGb94MZCRcDm+zCGO8nrYWf9ExaK3VMEjNHJbKm0YX5rQB/K1AMxbg3vpTzygLbLqaPh+9jDM5Xo1uuWlIb0B+lBKNNGPmc9c80peNONL5AO2xzD3b+upmsYnC2dzFO7YNvMfXlPL6wdyu6CGF8vQTbz0ETDM8rQyvKjiKnAitOyW6/Cf4mW2IZ08PopPEbMyRDlt+hsxeDALezbXa+gzI/UYeKIidaYn6n/qOeuvofMyRpv+dCH1/82/wx82y1BbuUo7bmM3iNh0+wGBtCSF/eBLLnVkH03+b8gSaJcaCEkx4MxUeoaVxgumoriwuvwBS1Xh1Ro4N1K/W/IOvp7wYZNNZzCx28EfD0tPf9BUOKKKZ9F1BxWGfViaNOxYi8VfmOc3cSVHOzoN1Lyxf9Cc6JkWHZdkF5U5ZtQuSV7X6qVzv0UqeUhO9yDxQ/zusGNjiSwgUUQj7VD30urptz6tpDT8nY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mJ5ID6t/L4zWQubDJwl4GQg51sAS4wrAUYxSqbrGCY2cFE5MpzHd9weYwKh59pXkts85+WNKKADXfAFoeRAmGARj+6VWMUZK4nneSPpAf6Y6zVP8MiSwTuEGzMfdnz7UfClwEeWu7Mu7Z107SMUItbhZc+sH8Q/skk/h4FxKKMz90x0lHOGF9uXqw8SjglKJoQXbXJieI1tQYcPOaE+zl5+vtu3F+4d0mI3IAbTQycY3wwFC5W+L4SETkjkjHVTLwLEXp0VDuQXFisIS19L2HLXx50+ee10kXGaUiLP740HsHOKbrqWhKUvLu4gErioV2OympPuSifk/zJYovwnr62cRw+2d6yjvbGVkRFcAJYLXxdpd2rNdjvfie73MdfXCZx6br6cNXvlqvlXpZhJNRJ/idG8QXylbw4EhlQPb2Xl5hzne6VTKYSjQKqmicM2I
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 09:11:10.5019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16594cc3-62c1-448a-5cde-08df38c13c8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8539

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
call into the button driver from that IRQ-disabled path. Also clear
wakeup_pending before setting suspended, with a compiler barrier, and
drain ACPI notify work before clearing suspended on resume. Report
KEY_WAKEUP before clearing suspended so a late notify cannot drop both
KEY_WAKEUP and KEY_POWER.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202609290454.LJrhMCb3-lkp@intel.com/
Signed-off-by: Baorui.Liu <baorliu@amd.com>
---
Changes since v5:
- Do not call into the button driver from acpi_suspend_enter(); keep only
  plain flags there and let button resume consume
  acpi_sleep_pwr_btn_wakeup_pending() (fixes sleep-in-atomic and the
  CONFIG_ACPI_BUTTON=m silent stub).
- Use WRITE_ONCE/barrier()/READ_ONCE around suspended and wakeup_pending,
  and around the sleep.c fixed-button wakeup flag.
- Call acpi_os_wait_events_complete() in button resume, report KEY_WAKEUP
  before clearing suspended, then clear suspended before wakeup_pending
  with a barrier so a late notify cannot lose KEY_WAKEUP or emit KEY_POWER.

 drivers/acpi/button.c | 63 ++++++++++++++++++++++++++++++++++++-------
 drivers/acpi/sleep.c  | 47 +++++++++++++++++++++-----------
 include/acpi/button.h | 16 +++++++++++
 3 files changed, 101 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 34c7173b5a6c..204d5778913d 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -203,6 +203,7 @@ struct acpi_button {
 	bool last_state;
 	ktime_t last_time;
 	bool suspended;
+	bool wakeup_pending;
 	bool lid_state_initialized;
 	bool gpe_enabled;
 };
@@ -488,7 +489,11 @@ static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
 
 	acpi_pm_wakeup_event(button->dev);
 
-	if (button->suspended || event == ACPI_BUTTON_NOTIFY_WAKE)
+	if (button->type == ACPI_BUTTON_TYPE_POWER &&
+	    READ_ONCE(button->suspended))
+		WRITE_ONCE(button->wakeup_pending, true);
+
+	if (READ_ONCE(button->suspended) || event == ACPI_BUTTON_NOTIFY_WAKE)
 		return;
 
 	input = button->input;
@@ -510,6 +515,12 @@ static void acpi_button_notify_run(void *data)
 
 static u32 acpi_button_event(void *data)
 {
+	struct acpi_button *button = data;
+
+	if (button->type == ACPI_BUTTON_TYPE_POWER &&
+	    READ_ONCE(button->suspended))
+		WRITE_ONCE(button->wakeup_pending, true);
+
 	acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_button_notify_run, data);
 	return ACPI_INTERRUPT_HANDLED;
 }
@@ -519,7 +530,15 @@ static int acpi_button_suspend(struct device *dev)
 {
 	struct acpi_button *button = dev_get_drvdata(dev);
 
-	button->suspended = true;
+	/*
+	 * Clear wakeup_pending before marking suspended. Otherwise a power
+	 * button SCI between the two stores could set wakeup_pending and then
+	 * be overwritten here, losing a real wakeup. barrier() prevents the
+	 * compiler from reordering the stores relative to that IRQ handler.
+	 */
+	WRITE_ONCE(button->wakeup_pending, false);
+	barrier();
+	WRITE_ONCE(button->suspended, true);
 	return 0;
 }
 
@@ -527,21 +546,45 @@ static int acpi_button_resume(struct device *dev)
 {
 	struct acpi_button *button = dev_get_drvdata(dev);
 	struct input_dev *input;
+	bool report_wakeup = false;
+
+	/*
+	 * Drain notify work queued while suspended so a late power-button
+	 * notify still observes suspended == true, sets wakeup_pending, and
+	 * does not synthesize KEY_POWER for userspace.
+	 */
+	acpi_os_wait_events_complete();
+
+	/*
+	 * Sample and report KEY_WAKEUP before clearing suspended. Otherwise a
+	 * notify that arrives after sampling but before suspended is cleared
+	 * can set wakeup_pending and then be dropped without KEY_WAKEUP or
+	 * KEY_POWER. Clear suspended before wakeup_pending so a new SCI sees
+	 * suspended == false and takes the normal KEY_POWER path; barrier()
+	 * keeps that store order.
+	 */
+	if (button->type == ACPI_BUTTON_TYPE_POWER) {
+		report_wakeup = READ_ONCE(button->wakeup_pending) ||
+				acpi_sleep_pwr_btn_wakeup_pending();
+		if (report_wakeup) {
+			input = button->input;
+			input_report_key(input, KEY_WAKEUP, 1);
+			input_sync(input);
+			input_report_key(input, KEY_WAKEUP, 0);
+			input_sync(input);
+		}
+	}
+
+	WRITE_ONCE(button->suspended, false);
+	barrier();
+	WRITE_ONCE(button->wakeup_pending, false);
 
-	button->suspended = false;
 	if (button->type == ACPI_BUTTON_TYPE_LID) {
 		button->last_state = !!acpi_lid_evaluate_state(ACPI_HANDLE(dev));
 		button->last_time = ktime_get();
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
index a94bac4422d4..5ef7531c00b8 100644
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
index af2fce5d2ee3..0f652a8e3791 100644
--- a/include/acpi/button.h
+++ b/include/acpi/button.h
@@ -15,4 +15,20 @@ static inline int acpi_lid_open(void)
 }
 #endif /* IS_ENABLED(CONFIG_ACPI_BUTTON) */
 
+/*
+ * Set in acpi_suspend_enter() when the fixed power-button status bit is
+ * observed (IRQ-disabled context). Consumed by the button driver on resume
+ * so KEY_WAKEUP can be reported without calling into the button driver from
+ * that early path. Implemented in sleep.c (built-in); safe when
+ * CONFIG_ACPI_BUTTON=m.
+ */
+#ifdef CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT
+bool acpi_sleep_pwr_btn_wakeup_pending(void);
+#else
+static inline bool acpi_sleep_pwr_btn_wakeup_pending(void)
+{
+	return false;
+}
+#endif
+
 #endif /* ACPI_BUTTON_H */
-- 
2.34.1

