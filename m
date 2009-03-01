From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] ACPI: unsigned cannot be less than 0.
Date: Sun, 01 Mar 2009 23:22:25 +0100
Message-ID: <49AB0AA1.1090207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f177.google.com ([209.85.219.177]:52562 "EHLO
	mail-ew0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956AbZCAWW1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 1 Mar 2009 17:22:27 -0500
Received: by ewy25 with SMTP id 25so1881467ewy.37
        for <linux-acpi@vger.kernel.org>; Sun, 01 Mar 2009 14:22:24 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: carlos@strangeworlds.co.uk
Cc: linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

include/linux/pci-acpi.h:74:
typedef u32                 acpi_status;
------------------------------>8-------------8<---------------------------------
result is unsigned, so an error returned by acpi_bus_register_driver() will not
be noticed.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 8a8b377..2f269e1 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -708,7 +708,7 @@ static int __init acpi_wmi_add(struct acpi_device *device)
 
 static int __init acpi_wmi_init(void)
 {
-	acpi_status result;
+	int result;
 
 	INIT_LIST_HEAD(&wmi_blocks.list);
 
