From: akpm@osdl.org
Subject: [patch 13/22] ACPI: print wakeup device list on same line as label
Date: Tue, 07 Mar 2006 23:49:39 -0800
Message-ID: <200603080751.k287pSZu000984@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:2466 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932418AbWCHHvp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Mar 2006 02:51:45 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, bjorn.helgaas@hp.com


From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Print the ACPI wakeup device list on the same line as the label to make
"dmesg | grep ACPI" output more useful.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/sleep/wakeup.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/acpi/sleep/wakeup.c~acpi-print-wakeup-device-list-on-same-line-as-label drivers/acpi/sleep/wakeup.c
--- devel/drivers/acpi/sleep/wakeup.c~acpi-print-wakeup-device-list-on-same-line-as-label	2006-03-07 23:47:10.000000000 -0800
+++ devel-akpm/drivers/acpi/sleep/wakeup.c	2006-03-07 23:47:10.000000000 -0800
@@ -155,7 +155,7 @@ static int __init acpi_wakeup_device_ini
 
 	if (acpi_disabled)
 		return 0;
-	printk("ACPI wakeup devices: \n");
+	printk(KERN_INFO PREFIX "wakeup devices: ");
 
 	spin_lock(&acpi_device_lock);
 	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
_
