From: Chew Chiau Ee <chiau.ee.chew@intel.com>
Subject: [PATCH] ACPI / LPSS: Add BYT ACPI mode PWM
Date: Tue, 21 Jan 2014 03:12:02 +0800
Message-ID: <1390245122-18907-1-git-send-email-chiau.ee.chew@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:62324 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751991AbaATLK3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Jan 2014 06:10:29 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

From: Chew, Chiau Ee <chiau.ee.chew@intel.com>

Intel BayTrail LPSS consists of two PWM controllers which can
be enumerated from ACPI namespace.

Signed-off-by: Chew, Chiau Ee <chiau.ee.chew@intel.com>
---
 drivers/acpi/acpi_lpss.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 6745fe1..8c2bae9 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -102,6 +102,16 @@ static struct lpss_device_desc lpt_sdio_dev_desc = {
 	.ltr_required = true,
 };
 
+static struct lpss_shared_clock pwm_clock = {
+	.name = "pwm_clk",
+	.rate = 25000000,
+};
+
+static struct lpss_device_desc byt_pwm_dev_desc = {
+	.clk_required = true,
+	.shared_clock = &pwm_clock,
+};
+
 static struct lpss_shared_clock uart_clock = {
 	.name = "uart_clk",
 	.rate = 44236800,
@@ -157,6 +167,7 @@ static const struct acpi_device_id acpi_lpss_device_ids[] = {
 	{ "INT33C7", },
 
 	/* BayTrail LPSS devices */
+	{ "80860F09", (unsigned long)&byt_pwm_dev_desc },
 	{ "80860F0A", (unsigned long)&byt_uart_dev_desc },
 	{ "80860F0E", (unsigned long)&byt_spi_dev_desc },
 	{ "80860F14", (unsigned long)&byt_sdio_dev_desc },
-- 
1.7.4.4

