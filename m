Return-Path: <SRS0=Un1Q=UL=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88E5C31E46
	for <linux-acpi@archiver.kernel.org>; Wed, 12 Jun 2019 10:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66482080A
	for <linux-acpi@archiver.kernel.org>; Wed, 12 Jun 2019 10:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406059AbfFLKHG (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 12 Jun 2019 06:07:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:6365 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405946AbfFLKHG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Jun 2019 06:07:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 03:07:05 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jun 2019 03:07:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CFD81146; Wed, 12 Jun 2019 13:07:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] ACPI / sleep: Switch to use acpi_dev_get_first_match_dev()
Date:   Wed, 12 Jun 2019 13:07:02 +0300
Message-Id: <20190612100702.53736-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Switch the acpi_pm_finish() to use acpi_dev_get_first_match_dev() instead of
custom approach.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/sleep.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 8ff08e531443..a94519207dc8 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -452,14 +452,6 @@ static int acpi_pm_prepare(void)
 	return error;
 }
 
-static int find_powerf_dev(struct device *dev, void *data)
-{
-	struct acpi_device *device = to_acpi_device(dev);
-	const char *hid = acpi_device_hid(device);
-
-	return !strcmp(hid, ACPI_BUTTON_HID_POWERF);
-}
-
 /**
  *	acpi_pm_finish - Instruct the platform to leave a sleep state.
  *
@@ -468,7 +460,7 @@ static int find_powerf_dev(struct device *dev, void *data)
  */
 static void acpi_pm_finish(void)
 {
-	struct device *pwr_btn_dev;
+	struct acpi_device *pwr_btn_adev;
 	u32 acpi_state = acpi_target_sleep_state;
 
 	acpi_ec_unblock_transactions();
@@ -499,11 +491,11 @@ static void acpi_pm_finish(void)
 		return;
 
 	pwr_btn_event_pending = false;
-	pwr_btn_dev = bus_find_device(&acpi_bus_type, NULL, NULL,
-				      find_powerf_dev);
-	if (pwr_btn_dev) {
-		pm_wakeup_event(pwr_btn_dev, 0);
-		put_device(pwr_btn_dev);
+	pwr_btn_adev = acpi_dev_get_first_match_dev(ACPI_BUTTON_HID_POWERF,
+						    NULL, -1);
+	if (pwr_btn_adev) {
+		pm_wakeup_event(&pwr_btn_adev->dev, 0);
+		acpi_dev_put(pwr_btn_adev);
 	}
 }
 
-- 
2.20.1

