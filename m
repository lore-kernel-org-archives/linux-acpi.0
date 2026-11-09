Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794212921;
	b=wUVDCD6cdUdXjZvLs78rKZCrLV8QhBXHp02wFV3dSaj9vC7nhJ0ak0O3PP5Q19lTb/S3
	 FEBgeRruorTJBMtDO6eUCnvuhHESv5bUoAow9Bwckmtn5qStn+/D8udyRPH/E78h08x5+
	 bFkF6rBuLw892dblRr88OIOhQP3YeIMt+5QistR0OFpmdJdzG6ZM307YVoB8amTXCAJxo
	 8n/aQQK2f69p+0MWEbsdI/08NY60TYIRDjMeJ5dQNRoLfdBIsSeGr6uVw34KXwgp3vU8/
	 AJ41tO5jGYDVvCPvpJQ59tSmphx+ilRqHR2mGxIbnQwPE0Hb9aV2OHnVrLtj951AG+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794212921;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
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
	bh=iCrFC58RZBaOgfdpKUueDt5wUMj1Jf/Cv4S1mMUsmFY=;
	b=EP6OXvVb2xNH/7RANO7e+Rgkkvfs3FFf7mnS6D/n2WWGjx1PmgKCH1DnXEI4nGZZrJdH
	 ylCzCUnfLODXrp52vWYQsFnnOeD2cQrlb+fTAuJk4tTqbZ428EEy51oD2P6EdGiCg55X6
	 rfCVWaIVmkKwoDV6fcUAvAOV6+7Dvs0tyxPIFKNGoYj0NvuY2mbVP+cxELOGbfnXFpgxo
	 E+w0VYqQuKApji/UqspXU5B3yuh7VHjleUFadkN0+ORIhe29ey+bIlD2vhns6l3CPasHd
	 O0FW2f5SsYwnViJ9PqAwLzAnoKU9FVKQ4+wni2y6HI2xvErlC7UePnfwcGS8olYC/Sg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CTZN6oBd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.36
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013036.outbound.protection.outlook.com [40.107.201.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661AD606A31C;
	Mon,  9 Nov 2026 08:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 661AD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CTZN6oBd
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NT1p/Az7LXA8Ia2/B5/j2ntjYJ/hBcTN5q3iF981dHctK29QjjXDcG1P6d6r2fiPi1oVfB5jzrEtxTkh7v7sa/tsQORIwC2dtONt9qUL/h/xOmwiU631u5nmjVxahLQQ79VQFQ2/Z0+JdXylPGzNdDfEXatAafLmgHjxRC+QXL3Zp87DnUPyp7GEYtYj2B7NuF/W9fOMGdJprV+VXnmxERDRTr1Q8M5DF4vpXEuLyDlXvBqK/YWyGJKOvschDe2RczhWJ6seAmedKXQ721rsAZaYUxTBJTFDYFNkYhuqGEbN8y1lm+WlzhULU5nByqhqNkUD1l7j3vJBaYsPAz9XQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCrFC58RZBaOgfdpKUueDt5wUMj1Jf/Cv4S1mMUsmFY=;
 b=jWRtYUyi0kobJ5kHgDXS3+9Zydn6ytU/kHvW77sMyXNo73b2Ege01OB8cBHLjQ674ygIiJMc7tiyDK98mTp5FMq+1RGT/P6wcTrBwrAk02L82ozaxCyAihg5vBWFKPcqgRBchByAuk3BUnzc7YS0+iyFOnqrAoqjh+tVyXEoGVosYBD0X3Z9o41YAq34ldR6wqsRJ/CO6tDZNycs5ncP8At28AwR7gsGtRcL6y5vFrszd6MF+cq8x7RcYGZ2ajXIii+3c1hY7+ntxxAdAs94rk2LnbrdOZFW/6I/TIbqE4hqcyxI8WHmvVaAStNioScQ3h5z5dGUqy806v/Ng/eN1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCrFC58RZBaOgfdpKUueDt5wUMj1Jf/Cv4S1mMUsmFY=;
 b=CTZN6oBdGHU+XQeeqszsI9zE36GtlGf9+r5mNkOz3aimt93gdl0/JYxQaINnDszF5O/B2Lu7kCkhw/aSC0VyGAJMIp/WB0c/168k6JblNjLbTJdXAtFTs9kM8JLCMcSg5HAdoGUbt4NGSh68eS83Ga1H2AsQJ2HVjJJkv3n/IDE=
Received: from CH2PR04CA0023.namprd04.prod.outlook.com (2603:10b6:610:52::33)
 by CH0PR12MB8485.namprd12.prod.outlook.com (2603:10b6:610:193::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 08:28:35 +0000
Received: from CH3PEPF0002457F.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::77) by CH2PR04CA0023.outlook.office365.com
 (2603:10b6:610:52::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 08:28:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0002457F.mail.protection.outlook.com (10.167.252.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 08:28:35 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 02:28:35 -0600
Received: from localhost.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 9 Nov 2026 02:28:33 -0600
From: Baorui.Liu <baorliu@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<acpica-devel@lists.linuxfoundation.org>, kernel test robot <lkp@intel.com>,
	Baorui.Liu <baorliu@amd.com>
Subject: [PATCH v7] ACPI: button: Report wakeup key only for power button wakeups
Date: Mon, 9 Nov 2026 16:28:32 +0800
Message-ID: <20261109082832.496-1-baorliu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261102091049.856-1-baorliu@amd.com>
References: <20261102091049.856-1-baorliu@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0002457F:EE_|CH0PR12MB8485:EE_
X-MS-Office365-Filtering-Correlation-Id: c18271f6-3eb7-4cf4-4791-08df3e3b7292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|56012099006|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261026140227099003|261026121527099003|261102130727099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	fMhTFBL5Lz1ZJ/nxq2edhB04CMABArpLOcPIgtusaHxvblFMseSWNLd41dJARIJkKb/MJ7jTHe9Oxuw7LCwxVSKWWVdX2g85PgJ6eTSOVmdJSVChSPtx3tQBkUyo3A2KWz/wKsErVZnnyGlFsvhvzupG/C0CNnR4qDHS1h84oZMz5S4JzJcUiu1Gk92wdVkPjDQr4TtxWQxnB5PQA8/RyHw4w88G3v22NkvuJ+epvldV+tkk+XEYuMtG6oyIaTY7opfYN+RrNcIH3I6mlrFHK6WtnheYB4tbJsRddp7BhBuIUiq/11pmlaSk3QzafKgnlqGVBHKh1CMaKltOfj2wggFhptBYWhGEspb3hpzCj5bt5dPF2lpd3wHZ/02fd3stEq0Vcl1TSZjoaTGfYqR6KL7op1OedwM8GlfGkaYVodFmlOiNjmrgY2jLa8O9dzmWXrt9WnGjOZA2KmfSXcOiaGNDOaEZ/8A7QHbkJXIz5ctn/EpAH+fIr+lwmA+BJRWSeyPgcRc5Sbjf5ERcYyE02bmATbaCig3TU7FeZ5ua4quqrrissenNews1bfYPkNBQQ8wTe9G9JrQ4ji9lHD0juDdBUZQiRJYANJGz6zpGGRoKPSBtCgth1sgQHDpO1rFBQ6DEia55jXhtQpS5bwPVSA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026140227099003)(261026121527099003)(261102130727099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	L1yvDVGUxItgFEthGwi3uKOlST2fMtfcWxGTQJOip2GFPMz7QTvpNJ55sTK8SDt1lQu3oBOV+gb+pwD0pPYyTG8JGS+y9Lp29Rnp3mEq3K+9TniNDRn064Xetuwf5H+EJ0MNq8A5z6b8pUejezu+39Fs9DzvcxaDHALmGdOL8VyfWacLvd8sTysrC9pqt7dQHTHS4vsqSoMxXHwGi+psvzaSeE+Je2C59E7TdHALfuV7p55KJB4Hn7YOQU3E09quwbpOMwSzbivySFXd23mA5n36YVsFOdM+EjITwBtMuGEUSXtzONtQ06sjO3MZhrkWNKqPkz4pK+s2R7B0Q7AOomqqj7GkPFzpxPjcDNNCQ1KaM1BnjEcAHZ4ZgixQEZ9E8tBBj8THkrC+382rp8PzlDprKkRMRbYuEyK/FGkrpSMiC9oxx+uU8gLRKuSQqYgY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 08:28:35.5524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c18271f6-3eb7-4cf4-4791-08df3e3b7292
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0002457F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8485

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
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202611030112.cVsBZFFE-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202611030545.3st9p1ha-lkp@intel.com/
Signed-off-by: Baorui.Liu <baorliu@amd.com>

Changes since v6:
- Include <linux/types.h> in include/acpi/button.h so the bool
  declaration/stub of acpi_sleep_pwr_btn_wakeup_pending() builds when
  the header is included without prior bool typedefs (0day/LKP ERROR
  via nouveau_connector.c on parisc64-defconfig and arm64-randconfig).
---
 drivers/acpi/button.c | 63 ++++++++++++++++++++++++++++++++++++-------
 drivers/acpi/sleep.c  | 47 +++++++++++++++++++++-----------
 include/acpi/button.h | 18 +++++++++++++
 3 files changed, 103 insertions(+), 25 deletions(-)

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
index af2fce5d2ee3..44d5d078aff9 100644
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
@@ -15,4 +17,20 @@ static inline int acpi_lid_open(void)
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

base-commit: ee3b82351a306b559fd132b9b168185fee641a18
-- 
2.34.1

