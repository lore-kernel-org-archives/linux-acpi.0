From: Len Brown <lenb@kernel.org>
Subject: [PATCH 32/70] ACPI: fix checkpatch.pl complaints in scan.c
Date: Fri, 20 Jun 2008 03:43:34 -0400
Message-ID: <ad7f0d9feee6980a3ab3ea806854f56817d1da8e.1213947350.git.len.brown@intel.com>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:53337 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbYFTHoh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 03:44:37 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2R0076H3V4DMR3@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 02:37:53 -0500 (CDT)
In-reply-to: <1213947852-10924-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alok N Kataria <akataria@vmware.com>, Len Brown <len.brown@intel.com>

From: Alok N Kataria <akataria@vmware.com>

http://bugzilla.kernel.org/show_bug.cgi?id=9772

Signed-off-by: Alok N Kataria <akataria@vmware.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/scan.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 00ba4af..fb0c07e 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -6,7 +6,8 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/acpi.h>
-#include <asm/signal.h>
+#include <linux/signal.h>
+#include <linux/kthread.h>
 
 #include <acpi/acpi_drivers.h>
 #include <acpi/acinterp.h>	/* for acpi_ex_eisa_id_to_string() */
@@ -154,6 +155,7 @@ acpi_eject_store(struct device *d, struct device_attribute *attr,
 	acpi_status status;
 	acpi_object_type type = 0;
 	struct acpi_device *acpi_device = to_acpi_device(d);
+	struct task_struct *task;
 
 	if ((!count) || (buf[0] != '1')) {
 		return -EINVAL;
@@ -171,9 +173,11 @@ acpi_eject_store(struct device *d, struct device_attribute *attr,
 	}
 
 	/* remove the device in another thread to fix the deadlock issue */
-	ret = kernel_thread(acpi_bus_hot_remove_device,
-				acpi_device->handle, SIGCHLD);
-      err:
+	task = kthread_run(acpi_bus_hot_remove_device,
+				acpi_device->handle, "acpi_hot_remove_device");
+	if (IS_ERR(task))
+		ret = PTR_ERR(task);
+err:
 	return ret;
 }
 
-- 
1.5.6

