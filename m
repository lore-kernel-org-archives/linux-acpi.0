From: yakui_zhao <yakui.zhao@intel.com>
Subject: [PATCH]: ACPI: Add the module param check for processor.max_cstate
Date: Fri, 24 Apr 2009 10:25:12 +0800
Message-ID: <1240539912.3651.68.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:41051 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752706AbZDXCYd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Apr 2009 22:24:33 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

From: Zhao Yakui <yakui.zhao@intel.com>

When the boot option of "processor.max_cstate=0" is added, the C-state 
won't be configured correctly. In such case the cpu idle function will access
the uninitialized memory region and then kernel panic will happen.

So it is necessary to add the module param check for the processor.max_cstate.
If it is equal to or less than zero, it will be ignored. If it is beyond the
max threshold, it is also ignored.

http://bugzilla.kernel.org/show_bug.cgi?id=13142

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/acpi/processor_idle.c |   27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/processor_idle.c
===================================================================
--- linux-2.6.orig/drivers/acpi/processor_idle.c	2009-04-21 15:48:52.000000000 +0800
+++ linux-2.6/drivers/acpi/processor_idle.c	2009-04-24 10:00:47.000000000 +0800
@@ -70,7 +70,32 @@
 #define PM_TIMER_TICKS_TO_US(p)		(((p) * 1000)/(PM_TIMER_FREQUENCY/1000))
 
 static unsigned int max_cstate __read_mostly = ACPI_PROCESSOR_MAX_POWER;
-module_param(max_cstate, uint, 0000);
+
+static int param_set_max_cstate(const char *val, struct kernel_param *kp)
+{
+	unsigned long cstate = 0;
+	int ret = 0;
+
+	if (!val)
+		return -EINVAL;
+
+	ret = strict_strtoul(val, 10, &cstate);
+	if (ret == -EINVAL || (unsigned int)cstate != cstate)
+		return -EINVAL;
+	/*
+	 * if the value is equal to or less than zero, it will be ingored.
+	 * Of course it will also be ignored if it is bigger than the
+	 * threshold of ACPI_PROCESSOR_MAX_POWER.
+	 */
+	if (cstate <= 0 || cstate > ACPI_PROCESSOR_MAX_POWER)
+		return -EINVAL;
+
+	max_cstate = cstate;
+
+	return 0;
+}
+module_param_call(max_cstate, param_set_max_cstate, NULL,
+		  &max_cstate, 0000);
 static unsigned int nocst __read_mostly;
 module_param(nocst, uint, 0000);
 


