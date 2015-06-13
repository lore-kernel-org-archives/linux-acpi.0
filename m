From: Mathias Krause <minipli@googlemail.com>
Subject: [PATCH 03/12] ACPI / processor: remove bogus __refdata annotation
Date: Sat, 13 Jun 2015 14:26:51 +0200
Message-ID: <1434198420-8519-4-git-send-email-minipli@googlemail.com>
References: <1434198420-8519-1-git-send-email-minipli@googlemail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:34550 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504AbbFMM1Q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 Jun 2015 08:27:16 -0400
Received: by wibut5 with SMTP id ut5so37699922wib.1
        for <linux-acpi@vger.kernel.org>; Sat, 13 Jun 2015 05:27:14 -0700 (PDT)
In-Reply-To: <1434198420-8519-1-git-send-email-minipli@googlemail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mathias Krause <minipli@googlemail.com>

The processor_handler structure does not reference any __init / __exit
code or data. Therefore the __refdata annotation is not needed.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
---
 drivers/acpi/acpi_processor.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 58f335ca2e75..92cee1580600 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -487,7 +487,7 @@ static const struct acpi_device_id processor_device_ids[] = {
 	{ }
 };
 
-static struct acpi_scan_handler __refdata processor_handler = {
+static struct acpi_scan_handler processor_handler = {
 	.ids = processor_device_ids,
 	.attach = acpi_processor_add,
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
-- 
1.7.10.4

