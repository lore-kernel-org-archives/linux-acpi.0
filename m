From: matthieu castet <castet.matthieu@free.fr>
Subject: [PATCH] check that acpi_wakeup_address is below 1MB v2
Date: Thu, 10 Apr 2008 23:33:36 +0200
Message-ID: <47FE87B0.7080709@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010008000402080405050709"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2-g19.free.fr ([212.27.42.28]:33379 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753740AbYDJVdi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Apr 2008 17:33:38 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 5E9CC12B6D8
	for <linux-acpi@vger.kernel.org>; Thu, 10 Apr 2008 23:33:37 +0200 (CEST)
Received: from [192.168.0.3] (cac94-1-81-57-151-96.fbx.proxad.net [81.57.151.96])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 041A612B6F5
	for <linux-acpi@vger.kernel.org>; Thu, 10 Apr 2008 23:33:36 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------010008000402080405050709
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

this patch add a check that the memory allocated for s3 wakeup is in the 
first 1MB as required by acpi spec.


Signed-off-by: "Matthieu CASTET <castet.matthieu@free.fr>"


--------------010008000402080405050709
Content-Type: text/x-diff;
 name="acpi_alloc_s3_mem.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi_alloc_s3_mem.diff"

diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index 6bc815c..6636859 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -65,6 +65,13 @@ void __init acpi_reserve_bootmem(void)
 	acpi_wakeup_address = (unsigned long)alloc_bootmem_low(PAGE_SIZE*2);
 	if (!acpi_wakeup_address)
 		printk(KERN_ERR "ACPI: Cannot allocate lowmem, S3 disabled.\n");
+	/* check if we are in first 1MB of memory */
+	if (__pa(acpi_wakeup_address) >= 1024*1024-PAGE_SIZE*2) {
+		printk(KERN_ERR "ACPI: Cannot allocate lowmem in first 1MB,"
+				"S3 disabled.\n");
+		free_bootmem(acpi_wakeup_address, PAGE_SIZE*2);
+		acpi_wakeup_address = 0;
+	}
 }
 
 

--------------010008000402080405050709--
