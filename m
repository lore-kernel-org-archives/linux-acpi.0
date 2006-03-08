From: akpm@osdl.org
Subject: [patch 15/22] HPET: fix ACPI memory range length handling
Date: Tue, 07 Mar 2006 23:49:41 -0800
Message-ID: <200603080751.k287pUUE000990@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:2722 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932424AbWCHHvp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Mar 2006 02:51:45 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, bjorn.helgaas@hp.com


From: Bjorn Helgaas <bjorn.helgaas@hp.com>

ACPI address space descriptors contain _MIN, _MAX, and _LEN.  _MIN and _MAX
are the bounds within which the region can be moved (this is clarified in
Table 6-38 of the ACPI 3.0 spec).  We should use _LEN to determine the size
of the region, not _MAX - _MIN + 1.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/char/hpet.c |    5 +----
 1 files changed, 1 insertion(+), 4 deletions(-)

diff -puN drivers/char/hpet.c~hpet-fix-acpi-memory-range-length-handling drivers/char/hpet.c
--- devel/drivers/char/hpet.c~hpet-fix-acpi-memory-range-length-handling	2006-03-07 23:47:10.000000000 -0800
+++ devel-akpm/drivers/char/hpet.c	2006-03-07 23:47:10.000000000 -0800
@@ -925,11 +925,8 @@ static acpi_status hpet_resources(struct
 	status = acpi_resource_to_address64(res, &addr);
 
 	if (ACPI_SUCCESS(status)) {
-		unsigned long size;
-
-		size = addr.maximum - addr.minimum + 1;
 		hdp->hd_phys_address = addr.minimum;
-		hdp->hd_address = ioremap(addr.minimum, size);
+		hdp->hd_address = ioremap(addr.minimum, addr.address_length);
 
 		if (hpet_is_known(hdp)) {
 			printk(KERN_DEBUG "%s: 0x%lx is busy\n",
_
