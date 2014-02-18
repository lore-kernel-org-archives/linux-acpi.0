From: Chew Chiau Ee <chiau.ee.chew@intel.com>
Subject: [PATCH v2] ACPI / LPSS: Add Intel BayTrail ACPI mode PWM
Date: Wed, 19 Feb 2014 02:24:29 +0800
Message-ID: <1392747869-31435-1-git-send-email-chiau.ee.chew@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-acpi@vger.kernel.org

From: Chew, Chiau Ee <chiau.ee.chew@intel.com>

Intel BayTrail LPSS consists of two PWM controllers which can
be enumerated from ACPI namespace. This change will cause
platform device objects to be created for Intel BayTrail PWM
controllers which will allow the pwm-lpss driver to bind to them
and handle those devices.

Signed-off-by: Chew, Chiau Ee <chiau.ee.chew@intel.com>
---
 drivers/acpi/acpi_lpss.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 2428857..9e22c13 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -96,6 +96,16 @@ static struct lpss_device_desc lpt_sdio_dev_desc = {
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
@@ -151,6 +161,7 @@ static const struct acpi_device_id acpi_lpss_device_ids[] = {
 	{ "INT33C7", },
 
 	/* BayTrail LPSS devices */
+	{ "80860F09", (unsigned long)&byt_pwm_dev_desc },
 	{ "80860F0A", (unsigned long)&byt_uart_dev_desc },
 	{ "80860F0E", (unsigned long)&byt_spi_dev_desc },
 	{ "80860F14", (unsigned long)&byt_sdio_dev_desc },
-- 
1.7.4.4
