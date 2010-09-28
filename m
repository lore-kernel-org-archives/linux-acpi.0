From: Len Brown <lenb@kernel.org>
Subject: [PATCH] ACPI: acpi_pad: simplify code to avoid false gcc build warning
Date: Tue, 28 Sep 2010 16:53:12 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009281652110.32026@localhost.localdomain>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1863258042-1285707193=:32026"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:60748 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786Ab0I1Uxe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Sep 2010 16:53:34 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L9H009CG60RWTH1@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 28 Sep 2010 15:53:16 -0500 (CDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-acpi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1863258042-1285707193=:32026
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT

From: Len Brown <len.brown@intel.com>

acpi_pad.c:432: warning: ¡num_cpus¢ may be used uninitialized in this function

gcc 4.4.4 was unable to notice that num_cpus is always set.
Re-arrange the code to un-confuse gcc, and also make
it easier for humans to read....

Signed-off-by: Len Brown <len.browns@intel.com>
---
 drivers/acpi/acpi_pad.c |   34 ++++++++++++++++++----------------
 1 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index b76848c..6b115f6 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -382,31 +382,32 @@ static void acpi_pad_remove_sysfs(struct acpi_device *device)
 	device_remove_file(&device->dev, &dev_attr_rrtime);
 }
 
-/* Query firmware how many CPUs should be idle */
-static int acpi_pad_pur(acpi_handle handle, int *num_cpus)
+/*
+ * Query firmware how many CPUs should be idle
+ * return -1 on failure
+ */
+static int acpi_pad_pur(acpi_handle handle)
 {
 	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
 	union acpi_object *package;
-	int rev, num, ret = -EINVAL;
+	int num = -1;
 
 	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_PUR", NULL, &buffer)))
-		return -EINVAL;
+		return num;
 
 	if (!buffer.length || !buffer.pointer)
-		return -EINVAL;
+		return num;
 
 	package = buffer.pointer;
-	if (package->type != ACPI_TYPE_PACKAGE || package->package.count != 2)
-		goto out;
-	rev = package->package.elements[0].integer.value;
-	num = package->package.elements[1].integer.value;
-	if (rev != 1 || num < 0)
-		goto out;
-	*num_cpus = num;
-	ret = 0;
-out:
+
+	if (package->type == ACPI_TYPE_PACKAGE &&
+		package->package.count == 2 &&
+		package->package.elements[0].integer.value == 1) /* rev 1 */
+
+		num = package->package.elements[1].integer.value;
+
 	kfree(buffer.pointer);
-	return ret;
+	return num;
 }
 
 /* Notify firmware how many CPUs are idle */
@@ -433,7 +434,8 @@ static void acpi_pad_handle_notify(acpi_handle handle)
 	uint32_t idle_cpus;
 
 	mutex_lock(&isolated_cpus_lock);
-	if (acpi_pad_pur(handle, &num_cpus)) {
+	num_cpus = acpi_pad_pur(handle);
+	if (num_cpus < 0) {
 		mutex_unlock(&isolated_cpus_lock);
 		return;
 	}
-- 
1.7.3.2.g9027fa

--8323328-1863258042-1285707193=:32026--
