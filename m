From: matthieu castet <castet.matthieu@free.fr>
Subject: [PATCH] check that acpi_wakeup_address is below 1MB
Date: Wed, 06 Feb 2008 23:47:11 +0100
Message-ID: <47AA38EF.6030307@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060503010109060903030800"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2-g19.free.fr ([212.27.42.28]:54260 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760972AbYBFWrM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 Feb 2008 17:47:12 -0500
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id A1C0812BF69
	for <linux-acpi@vger.kernel.org>; Wed,  6 Feb 2008 23:47:11 +0100 (CET)
Received: from [192.168.0.3] (cac94-1-81-57-151-96.fbx.proxad.net [81.57.151.96])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 7C02C12BB99
	for <linux-acpi@vger.kernel.org>; Wed,  6 Feb 2008 23:47:11 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------060503010109060903030800
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

this patch had a check that the memory allocated is in the first 1MB.
The check is similar to the one in smp_alloc_memory.


Signed-off-by: "Matthieu CASTET <castet.matthieu@free.fr>"

--------------060503010109060903030800
Content-Type: text/x-patch;
 name="acpi.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi.diff"

diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index 6bc815c..65ab23c 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -65,6 +65,10 @@ void __init acpi_reserve_bootmem(void)
 	acpi_wakeup_address = (unsigned long)alloc_bootmem_low(PAGE_SIZE*2);
 	if (!acpi_wakeup_address)
 		printk(KERN_ERR "ACPI: Cannot allocate lowmem, S3 disabled.\n");
+
+	/* check if we are in first 1MB of memory */
+	if (__pa(acpi_wakeup_address) >= 1024*1024-PAGE_SIZE*2)
+		BUG();
 }
 
 

--------------060503010109060903030800--
