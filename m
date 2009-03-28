From: Len Brown <lenb@kernel.org>
Subject: [PATCH 82/98] ACPI: remove unused acpi_device_ops .lock and .scan
 methods
Date: Sat, 28 Mar 2009 00:31:57 -0400
Message-ID: <93b3e78a93a2f49415608929f9ffeb60adc8a4a8.1238214620.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:8537 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755615AbZC1Edq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:46 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700EI48O5S1ME@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:42 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

No drivers use the .lock and .scan methods, and the Linux/ACPI
code doesn't even provide a way to invoke them, so remove them.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acpi_bus.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index e9f6574..e3c5a4e 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -88,13 +88,11 @@ struct acpi_device;
 
 typedef int (*acpi_op_add) (struct acpi_device * device);
 typedef int (*acpi_op_remove) (struct acpi_device * device, int type);
-typedef int (*acpi_op_lock) (struct acpi_device * device, int type);
 typedef int (*acpi_op_start) (struct acpi_device * device);
 typedef int (*acpi_op_stop) (struct acpi_device * device, int type);
 typedef int (*acpi_op_suspend) (struct acpi_device * device,
 				pm_message_t state);
 typedef int (*acpi_op_resume) (struct acpi_device * device);
-typedef int (*acpi_op_scan) (struct acpi_device * device);
 typedef int (*acpi_op_bind) (struct acpi_device * device);
 typedef int (*acpi_op_unbind) (struct acpi_device * device);
 typedef int (*acpi_op_shutdown) (struct acpi_device * device);
@@ -117,12 +115,10 @@ struct acpi_bus_ops {
 struct acpi_device_ops {
 	acpi_op_add add;
 	acpi_op_remove remove;
-	acpi_op_lock lock;
 	acpi_op_start start;
 	acpi_op_stop stop;
 	acpi_op_suspend suspend;
 	acpi_op_resume resume;
-	acpi_op_scan scan;
 	acpi_op_bind bind;
 	acpi_op_unbind unbind;
 	acpi_op_shutdown shutdown;
-- 
1.6.0.6

