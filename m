From: Mathias Krause <minipli@googlemail.com>
Subject: [PATCH 10/12] ACPI / scan: constify ACPI device ids
Date: Sat, 13 Jun 2015 14:26:58 +0200
Message-ID: <1434198420-8519-11-git-send-email-minipli@googlemail.com>
References: <1434198420-8519-1-git-send-email-minipli@googlemail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34591 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419AbbFMM1V (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 Jun 2015 08:27:21 -0400
Received: by wibut5 with SMTP id ut5so37701239wib.1
        for <linux-acpi@vger.kernel.org>; Sat, 13 Jun 2015 05:27:20 -0700 (PDT)
In-Reply-To: <1434198420-8519-1-git-send-email-minipli@googlemail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mathias Krause <minipli@googlemail.com>

Make the button ACPI device ID array static const. Safes us a little bit
of code.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
---
 drivers/acpi/scan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 03141aa4ea95..7d30edc5777c 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1671,7 +1671,7 @@ static int acpi_bus_extract_wakeup_device_power_package(acpi_handle handle,
 
 static void acpi_wakeup_gpe_init(struct acpi_device *device)
 {
-	struct acpi_device_id button_device_ids[] = {
+	static const struct acpi_device_id button_device_ids[] = {
 		{"PNP0C0C", 0},
 		{"PNP0C0D", 0},
 		{"PNP0C0E", 0},
-- 
1.7.10.4

