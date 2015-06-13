From: Mathias Krause <minipli@googlemail.com>
Subject: [PATCH 04/12] ACPI / PNP: constify device IDs
Date: Sat, 13 Jun 2015 14:26:52 +0200
Message-ID: <1434198420-8519-5-git-send-email-minipli@googlemail.com>
References: <1434198420-8519-1-git-send-email-minipli@googlemail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:34554 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958AbbFMM1Q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 Jun 2015 08:27:16 -0400
Received: by wibut5 with SMTP id ut5so37700077wib.1
        for <linux-acpi@vger.kernel.org>; Sat, 13 Jun 2015 05:27:15 -0700 (PDT)
In-Reply-To: <1434198420-8519-1-git-send-email-minipli@googlemail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mathias Krause <minipli@googlemail.com>

Instead of re-creating the array on the stack each time
is_cmos_rtc_device() gets called, make the array 'static const'.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
---
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

