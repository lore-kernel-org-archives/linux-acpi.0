From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/84] create sysfs link from acpi device to sysdev for cpu
Date: Sat, 28 Jun 2008 01:43:07 -0400
Message-ID: <89d675d0f987534139d330eb2689ec53fab9404e.1214631213.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:34360 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479AbYF1Fox (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:44:53 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K3500DOMRMVV3D3@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:37:44 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Sys I/F under acpi device node and sysdev device node are both
needed for cpu hot-removal. User space need this link so that
they know they are poking the sys I/F for the same cpu.
http://bugzilla.kernel.org/show_bug.cgi?id=9772

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_core.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 3f90965..e8f82d6 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -622,7 +622,7 @@ static int __cpuinit acpi_processor_start(struct acpi_device *device)
 	int result = 0;
 	acpi_status status = AE_OK;
 	struct acpi_processor *pr;
-
+	struct sys_device *sysdev;
 
 	pr = acpi_driver_data(device);
 
@@ -653,6 +653,10 @@ static int __cpuinit acpi_processor_start(struct acpi_device *device)
 	if (result)
 		goto end;
 
+	sysdev = get_cpu_sysdev(pr->id);
+	if (sysfs_create_link(&device->dev.kobj, &sysdev->kobj, "sysdev"))
+		return -EFAULT;
+
 	status = acpi_install_notify_handler(pr->handle, ACPI_DEVICE_NOTIFY,
 					     acpi_processor_notify, pr);
 
@@ -812,6 +816,8 @@ static int acpi_processor_remove(struct acpi_device *device, int type)
 	status = acpi_remove_notify_handler(pr->handle, ACPI_DEVICE_NOTIFY,
 					    acpi_processor_notify);
 
+	sysfs_remove_link(&device->dev.kobj, "sysdev");
+
 	acpi_processor_remove_fs(device);
 
 	if (pr->cdev) {
-- 
1.5.6.1.89.gd544

