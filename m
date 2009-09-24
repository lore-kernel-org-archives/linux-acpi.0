From: Roland Dreier <rdreier@cisco.com>
Subject: [PATCH] ACPI: Kill overly verbose "throttling states" log messages
Date: Thu, 24 Sep 2009 14:30:27 -0700
Message-ID: <adaskecyqrw.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sj-iport-6.cisco.com ([171.71.176.117]:31379 "EHLO
	sj-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbZIXVaY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Sep 2009 17:30:24 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

I was recently lucky enough to get a 64-CPU system.  The processors
actually have T-states, so my kernel log ends up with 64 lines like:

    ACPI: Processor [CPU0] (supports xx throttling states)

This is pretty useless clutter because

 - this info is already available after boot from
   /proc/acpi/processor/CPUnn/throttling

 - there's also an ACPI_DEBUG_PRINT() in processor_throttling.c that
   gives the same info on boot for anyone who *really* cares.

So just delete the code that prints the throttling states in
processor_core.c.

Signed-off-by: Roland Dreier <rolandd@cisco.com>
---
 drivers/acpi/processor_core.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index c2d4d6e..c567b46 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -863,13 +863,6 @@ static int acpi_processor_add(struct acpi_device *device)
 		goto err_remove_sysfs;
 	}
 
-	if (pr->flags.throttling) {
-		printk(KERN_INFO PREFIX "%s [%s] (supports",
-		       acpi_device_name(device), acpi_device_bid(device));
-		printk(" %d throttling states", pr->throttling.state_count);
-		printk(")\n");
-	}
-
 	return 0;
 
 err_remove_sysfs:
