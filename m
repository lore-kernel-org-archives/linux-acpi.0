From: Len Brown <lenb@kernel.org>
Subject: [PATCH 002/122] ACPI: cpufreq, processor: Detect old BIOS,
 not supporting CPU freq on a recent CPU.
Date: Thu, 23 Oct 2008 02:37:36 -0400
Message-ID: <910dfae298f7b3dae0e9a52736182a3b0559ca35.1224743916.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:46302 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752657AbYJWGjm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:39:42 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9600K82II5SHQ2@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:39:42 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Andi Kleen <ak@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

On Intel CPUs it is rather common and a good hint that BIOSes which do provide
_PPC func, but not the frequencies itself in _PSS function, are old and need
to be updated for CPU freq support.

Tell the user/vendor he has a BIOS/firmware problem.
Make use of FW_BUG interface to give vendors and users the ability to
automatically check with (or let linuxfirmwarekit do that):
dmesg |grep "Firmware Bug"

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_perflib.c |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 80c251e..242f814 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -38,6 +38,7 @@
 
 #include <asm/uaccess.h>
 #endif
+#include <asm/cpufeature.h>
 
 #include <acpi/acpi_bus.h>
 #include <acpi/processor.h>
@@ -334,7 +335,6 @@ static int acpi_processor_get_performance_info(struct acpi_processor *pr)
 	acpi_status status = AE_OK;
 	acpi_handle handle = NULL;
 
-
 	if (!pr || !pr->performance || !pr->handle)
 		return -EINVAL;
 
@@ -347,13 +347,25 @@ static int acpi_processor_get_performance_info(struct acpi_processor *pr)
 
 	result = acpi_processor_get_performance_control(pr);
 	if (result)
-		return result;
+		goto update_bios;
 
 	result = acpi_processor_get_performance_states(pr);
 	if (result)
-		return result;
+		goto update_bios;
 
 	return 0;
+
+	/*
+	 * Having _PPC but missing frequencies (_PSS, _PCT) is a very good hint that
+	 * the BIOS is older than the CPU and does not know its frequencies
+	 */
+ update_bios:
+	if (ACPI_SUCCESS(acpi_get_handle(pr->handle, "_PPC", &handle))){
+		if(boot_cpu_has(X86_FEATURE_EST))
+			printk(KERN_WARNING FW_BUG "BIOS needs update for CPU "
+			       "frequency support\n");
+	}
+	return result;
 }
 
 int acpi_processor_notify_smm(struct module *calling_module)
-- 
1.5.5.1

