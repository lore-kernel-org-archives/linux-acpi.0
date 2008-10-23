From: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Subject: [PATCH] Fix compile warning CONFIG_I7300_IDLE_IOAT_CHANNEL not defined
Date: Thu, 23 Oct 2008 15:39:06 -0700
Message-ID: <20081023223906.GA26918@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:19892 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751483AbYJWWjU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Oct 2008 18:39:20 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>


When I7300_idle driver is not configured, there is a compile time
warning about IDLE_IOAT_CHANNEL not defined. Fix it.

Reported-by: Suresh Siddha <suresh.b.siddha@intel.com>

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

---
 drivers/dma/ioat_dma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/dma/ioat_dma.c
===================================================================
--- linux-2.6.orig/drivers/dma/ioat_dma.c	2008-10-23 15:27:43.000000000 -0700
+++ linux-2.6/drivers/dma/ioat_dma.c	2008-10-23 15:28:03.000000000 -0700
@@ -171,7 +171,7 @@ static int ioat_dma_enumerate_channels(s
 	xfercap_scale = readb(device->reg_base + IOAT_XFERCAP_OFFSET);
 	xfercap = (xfercap_scale == 0 ? -1 : (1UL << xfercap_scale));
 
-#if CONFIG_I7300_IDLE_IOAT_CHANNEL
+#ifdef CONFIG_I7300_IDLE_IOAT_CHANNEL
 	device->common.chancnt--;
 #endif
 	for (i = 0; i < device->common.chancnt; i++) {
