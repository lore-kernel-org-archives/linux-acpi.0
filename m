From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH -mm 2/8] AHCI: Speed-up resume
Date: Thu, 10 Jul 2008 01:58:48 +0200
Message-ID: <200807100158.49341.rjw@sisk.pl>
References: <200807100152.17755.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:49038 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755595AbYGJAGg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 Jul 2008 20:06:36 -0400
In-Reply-To: <200807100152.17755.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>, Tejun Heo <tj@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Jeff Garzik <jeff@garzik.org>

From: Zhang Rui <rui.zhang@intel.com>
Subject: AHCI: Speed-up resume

During resume, sleep 1 second to wait for the HBA reset
to finish is a waste of time.

According to the AHCI 1.2 spec,
We should poll the HOST_CTL register,
and return error if the host reset is not
finished within 1 second.

Test results show that the HBA reset can be done quickly(in usecs).
And this patch may save nearly 1 second during resume.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
--
 drivers/ata/ahci.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

Index: linux-next/drivers/ata/ahci.c
===================================================================
--- linux-next.orig/drivers/ata/ahci.c
+++ linux-next/drivers/ata/ahci.c
@@ -1142,12 +1142,15 @@ static int ahci_reset_controller(struct 
 			readl(mmio + HOST_CTL); /* flush */
 		}
 
-		/* reset must complete within 1 second, or
+		/*
+		 * to perform host reset, OS should set HOST_RESET
+		 * and poll until this bit is read to be "0".
+		 * reset must complete within 1 second, or
 		 * the hardware should be considered fried.
 		 */
-		ssleep(1);
+		tmp = ata_wait_register(mmio + HOST_CTL, HOST_RESET,
+					HOST_RESET, 10, 1000);
 
-		tmp = readl(mmio + HOST_CTL);
 		if (tmp & HOST_RESET) {
 			dev_printk(KERN_ERR, host->dev,
 				   "controller reset failed (0x%x)\n", tmp);

