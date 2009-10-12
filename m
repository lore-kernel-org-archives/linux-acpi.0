From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] fujitsu-laptop: Fix tests of acpi_evaluate_integer() return
Date: Mon, 12 Oct 2009 13:14:32 +0200
Message-ID: <4AD30F98.4010904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f208.google.com ([209.85.219.208]:43530 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756156AbZJLLFz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Oct 2009 07:05:55 -0400
Received: by ewy4 with SMTP id 4so2351140ewy.37
        for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2009 04:05:17 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

The wrong test was used acpi_status status is unsigned.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index f35aee5..e3c21ee 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -376,7 +376,7 @@ static int get_lcd_level(void)
 
 	status =
 	    acpi_evaluate_integer(fujitsu->acpi_handle, "GBLL", NULL, &state);
-	if (status < 0)
+	if (ACPI_FAILURE(status))
 		return status;
 
 	fujitsu->brightness_level = state & 0x0fffffff;
@@ -398,7 +398,7 @@ static int get_max_brightness(void)
 
 	status =
 	    acpi_evaluate_integer(fujitsu->acpi_handle, "RBLL", NULL, &state);
-	if (status < 0)
+	if (ACPI_FAILURE(status))
 		return status;
 
 	fujitsu->max_brightness = state;
