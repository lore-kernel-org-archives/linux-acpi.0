From: Edgar Hucek <hostmaster@ed-soft.at>
Subject: [PATCH 1/1] EFI iounpam fix for acpi_os_unmap_memory
Date: Tue, 21 Feb 2006 00:36:51 +0100
Message-ID: <43FA5293.4070807@ed-soft.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]:29316
	"EHLO mognix.dark-green.com") by vger.kernel.org with ESMTP
	id S1161200AbWBTXgu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Feb 2006 18:36:50 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

When EFI is enabled acpi_os_unmap_memory trys to unmap memory
which was not mapped by acpi_os_map_memory.

This patch for it.

Signed-off-by: Edgar Hucek <hostmaster@ed-soft.at>

diff -uNr linux-2.6.16-rc4.orig/drivers/acpi/osl.c
linux-2.6.16-rc4/drivers/acpi/osl.c
--- linux-2.6.16-rc4.orig/drivers/acpi/osl.c    2006-02-19
18:48:58.000000000 +0100
+++ linux-2.6.16-rc4/drivers/acpi/osl.c 2006-02-20 15:31:44.000000000 +0100
@@ -208,7 +208,13 @@

 void acpi_os_unmap_memory(void __iomem * virt, acpi_size size)
 {
-       iounmap(virt);
+       if(efi_enabled) {
+               if (!(EFI_MEMORY_WB &
efi_mem_attributes(virt_to_phys(virt)))) {
+                       iounmap(virt);
+               }
+       } else {
+               iounmap(virt);
+       }
 }
 EXPORT_SYMBOL_GPL(acpi_os_unmap_memory);
