From: Mathias Krause <minipli@googlemail.com>
Subject: [PATCH resend] ACPI / PNP: constify device IDs
Date: Sat,  2 Jan 2016 11:30:09 +0100
Message-ID: <1451730609-2722-1-git-send-email-minipli@googlemail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36280 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990AbcABKaZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 2 Jan 2016 05:30:25 -0500
Received: by mail-wm0-f44.google.com with SMTP id l65so118609965wmf.1
        for <linux-acpi@vger.kernel.org>; Sat, 02 Jan 2016 02:30:24 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Instead of re-creating the array on the stack each time
is_cmos_rtc_device() gets called, make the array 'static const'.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
---
This is a resend of patch 4/12 of [1], in case it got forgotten
in the meantime.

[1] http://thread.gmane.org/gmane.linux.acpi.devel/76528

 drivers/acpi/acpi_pnp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
index ff6d8adc9cda..9d20ba66d33b 100644
--- a/drivers/acpi/acpi_pnp.c
+++ b/drivers/acpi/acpi_pnp.c
@@ -368,7 +368,7 @@ static struct acpi_scan_handler acpi_pnp_handler = {
  */
 static int is_cmos_rtc_device(struct acpi_device *adev)
 {
-	struct acpi_device_id ids[] = {
+	static const struct acpi_device_id ids[] = {
 		{ "PNP0B00" },
 		{ "PNP0B01" },
 		{ "PNP0B02" },
-- 
1.7.10.4

