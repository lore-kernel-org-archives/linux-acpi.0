From: =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
Subject: [PATCH 5/7] platform/x86: fujitsu-laptop: do not update ACPI device power status
Date: Fri, 16 Jun 2017 06:40:56 +0200
Message-ID: <20170616044058.30443-6-kernel@kempniu.pl>
References: <20170616044058.30443-1-kernel@kempniu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36103 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751923AbdFPElQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jun 2017 00:41:16 -0400
Received: by mail-wr0-f194.google.com with SMTP id 77so5298867wrb.3
        for <linux-acpi@vger.kernel.org>; Thu, 15 Jun 2017 21:41:15 -0700 (PDT)
In-Reply-To: <20170616044058.30443-1-kernel@kempniu.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Woithe <jwoithe@just42.net>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Calling acpi_bus_update_power() for ACPI devices FUJ02B1 and FUJ02E3 is
pointless as they are not power manageable (neither _PS0 nor _PR0 is
defined for any of them), which causes their power state to be inherited
from their parent devices.  Given the ACPI paths of these two devices
(\_SB.PCI0.LPCB.FJEX, \_SB.FEXT), their parent devices are also not
power manageable.  These parent devices will thus have their power state
initialized to ACPI_STATE_D0, which in turn causes the power state for
both FUJ02B1 and FUJ02E3 to always be ACPI_STATE_D0 ("on").

Remove relevant acpi_bus_update_power() calls along with parts of debug
messages that they were supposed to have an effect on.

Signed-off-by: Michał Kępień <kernel@kempniu.pl>
---
 drivers/platform/x86/fujitsu-laptop.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index 5c0dc2126313..b9f3ede4d567 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -400,7 +400,6 @@ static int fujitsu_backlight_register(struct acpi_device *device)
 static int acpi_fujitsu_bl_add(struct acpi_device *device)
 {
 	struct fujitsu_bl *priv;
-	int state = 0;
 	int error;
 
 	if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
@@ -419,15 +418,8 @@ static int acpi_fujitsu_bl_add(struct acpi_device *device)
 	if (error)
 		return error;
 
-	error = acpi_bus_update_power(device->handle, &state);
-	if (error) {
-		pr_err("Error reading power state\n");
-		return error;
-	}
-
-	pr_info("ACPI: %s [%s] (%s)\n",
-	       acpi_device_name(device), acpi_device_bid(device),
-	       !device->power.state ? "on" : "off");
+	pr_info("ACPI: %s [%s]\n",
+		acpi_device_name(device), acpi_device_bid(device));
 
 	if (acpi_has_method(device->handle, METHOD_NAME__INI)) {
 		vdbg_printk(FUJLAPTOP_DBG_INFO, "Invoking _INI\n");
@@ -788,7 +780,6 @@ static int acpi_fujitsu_laptop_leds_register(struct acpi_device *device)
 static int acpi_fujitsu_laptop_add(struct acpi_device *device)
 {
 	struct fujitsu_laptop *priv;
-	int state = 0;
 	int error;
 	int i;
 
@@ -807,15 +798,8 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
 	if (error)
 		return error;
 
-	error = acpi_bus_update_power(device->handle, &state);
-	if (error) {
-		pr_err("Error reading power state\n");
-		return error;
-	}
-
-	pr_info("ACPI: %s [%s] (%s)\n",
-		acpi_device_name(device), acpi_device_bid(device),
-		!device->power.state ? "on" : "off");
+	pr_info("ACPI: %s [%s]\n",
+		acpi_device_name(device), acpi_device_bid(device));
 
 	if (acpi_has_method(device->handle, METHOD_NAME__INI)) {
 		vdbg_printk(FUJLAPTOP_DBG_INFO, "Invoking _INI\n");
-- 
2.13.1

