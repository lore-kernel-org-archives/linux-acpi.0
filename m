From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2.6.24-stable] pnpacpi: reduce printk severity for "pnpacpi: exceeded the max number of ..."
Date: Tue, 15 Apr 2008 03:16:56 -0400
Message-ID: <200804150316.56814.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:52827 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753210AbYDOHRK (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Tue, 15 Apr 2008 03:17:10 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: stable@kernel.org, Linux-acpi@vger.kernel.org

From: Len Brown <len.brown@intel.com>

We have been printing these messages at KERN_ERR since 2.6.24,
per http://bugzilla.kernel.org/show_bug.cgi?id=9535

But KERN_ERR pops up on a console booted with "quiet"
and causes users to get alarmed and file bugs
about the message itself:
https://bugzilla.redhat.com/show_bug.cgi?id=436589

So reduce the severity of these messages to
KERN_WARNING, which is not printed by "quiet".

This message will still be seen without "quiet",
but a lot of messages are printed in that mode
and it will be less likely to cause undue alarm.

We could go all the way to KERN_DEBUG, but this
is a real warning after all, so it seems prudent
not to require "debug" to see it.

Signed-off-by: Len Brown <len.brown@intel.com>
---

upsptream commit 33fd7afd66ffdc6addf1b085fe6403b6af532f8e 

 drivers/pnp/pnpacpi/rsparser.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index 6aa231e..2dcd196 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -85,7 +85,7 @@ static void pnpacpi_parse_allocated_irqresource(struct pnp_resource_table *res,
 	       i < PNP_MAX_IRQ)
 		i++;
 	if (i >= PNP_MAX_IRQ && !warned) {
-		printk(KERN_ERR "pnpacpi: exceeded the max number of IRQ "
+		printk(KERN_WARNING "pnpacpi: exceeded the max number of IRQ "
 				"resources: %d \n", PNP_MAX_IRQ);
 		warned = 1;
 		return;
@@ -187,7 +187,7 @@ static void pnpacpi_parse_allocated_dmaresource(struct pnp_resource_table *res,
 		res->dma_resource[i].start = dma;
 		res->dma_resource[i].end = dma;
 	} else if (!warned) {
-		printk(KERN_ERR "pnpacpi: exceeded the max number of DMA "
+		printk(KERN_WARNING "pnpacpi: exceeded the max number of DMA "
 				"resources: %d \n", PNP_MAX_DMA);
 		warned = 1;
 	}
@@ -213,7 +213,7 @@ static void pnpacpi_parse_allocated_ioresource(struct pnp_resource_table *res,
 		res->port_resource[i].start = io;
 		res->port_resource[i].end = io + len - 1;
 	} else if (!warned) {
-		printk(KERN_ERR "pnpacpi: exceeded the max number of IO "
+		printk(KERN_WARNING "pnpacpi: exceeded the max number of IO "
 				"resources: %d \n", PNP_MAX_PORT);
 		warned = 1;
 	}
@@ -241,7 +241,7 @@ static void pnpacpi_parse_allocated_memresource(struct pnp_resource_table *res,
 		res->mem_resource[i].start = mem;
 		res->mem_resource[i].end = mem + len - 1;
 	} else if (!warned) {
-		printk(KERN_ERR "pnpacpi: exceeded the max number of mem "
+		printk(KERN_WARNING "pnpacpi: exceeded the max number of mem "
 				"resources: %d\n", PNP_MAX_MEM);
 		warned = 1;
 	}
-- 
1.5.5.49.gf43e2

