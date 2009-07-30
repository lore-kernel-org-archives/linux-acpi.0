From: Roel Kluin <roel.kluin@gmail.com>
Subject: ACPI: Missing test after ioremap()?
Date: Thu, 30 Jul 2009 18:19:00 +0200
Message-ID: <4A71C7F4.9000304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f214.google.com ([209.85.219.214]:62797 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbZG3QQD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Jul 2009 12:16:03 -0400
Received: by ewy10 with SMTP id 10so874126ewy.37
        for <linux-acpi@vger.kernel.org>; Thu, 30 Jul 2009 09:16:02 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org

Isn't a test missing after the ioremap()?
and if so can we error out like this?


diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 7167071..b1eeecc 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -496,6 +496,9 @@ acpi_os_read_memory(acpi_physical_address phys_addr, u32 * value, u32 width)
 	void __iomem *virt_addr;
 
 	virt_addr = ioremap(phys_addr, width);
+	if (virt_addr == NULL)
+		return AE_ERROR;
+
 	if (!value)
 		value = &dummy;
 
@@ -524,6 +527,8 @@ acpi_os_write_memory(acpi_physical_address phys_addr, u32 value, u32 width)
 	void __iomem *virt_addr;
 
 	virt_addr = ioremap(phys_addr, width);
+	if (virt_addr == NULL)
+		return AE_ERROR;
 
 	switch (width) {
 	case 8:
