From: Juergen Gross <jgross@suse.com>
Subject: [PATCH] acpi: don't register acpi_pad driver if running as xen dom0
Date: Wed, 12 Oct 2016 13:11:45 +0200
Message-ID: <1476270705-16209-1-git-send-email-jgross@suse.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54175 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751171AbcJLLLw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Oct 2016 07:11:52 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, xen-devel@lists.xen.org, linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, rjw@rjwysocki.net, Juergen Gross <jgross@suse.com>

When running as Xen dom0 a special processor_aggregator driver is
needed. Don't register the standard driver in this case.

Without that check an error message:

"Error: Driver 'processor_aggregator' is already registered,
aborting..."

will be displayed.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/acpi/acpi_pad.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 8ea8211..1c3be12 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/acpi.h>
 #include <asm/mwait.h>
+#include <xen/xen.h>
 
 #define ACPI_PROCESSOR_AGGREGATOR_CLASS	"acpi_pad"
 #define ACPI_PROCESSOR_AGGREGATOR_DEVICE_NAME "Processor Aggregator"
@@ -477,6 +478,10 @@ static struct acpi_driver acpi_pad_driver = {
 
 static int __init acpi_pad_init(void)
 {
+	/* Xen acpi pad is responsible when running as Xen Dom0. */
+	if (xen_initial_domain())
+		return -ENODEV;
+
 	power_saving_mwait_init();
 	if (power_saving_mwait_eax == 0)
 		return -EINVAL;
-- 
2.6.6

