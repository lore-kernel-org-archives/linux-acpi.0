From: yakui_zhao <yakui.zhao@intel.com>
Subject: [PATCH]: ACPI: Skip the power state check in power transition
Date: Tue, 12 May 2009 13:27:40 +0800
Message-ID: <1242106060.3773.216.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:7733 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752120AbZELFZZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 May 2009 01:25:25 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

From: Zhao Yakui <yakui.zhao@intel.com>

Skip the power state check in course of power transition by changing the
default value of acpi_power_nocheck to 1. If so, it is unnecessary to add the
boot option of "acpi.power_nocheck=1" or add it into DMI power check table to
skip the power state check.

Of course the power state check still can be enabled by adding the boot option
of "acpi.power_nocheck=0".

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Acked-by: Matthew Garrett <mjg59@srcf.ucam.org>
---
 drivers/acpi/power.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/power.c
===================================================================
--- linux-2.6.orig/drivers/acpi/power.c	2009-04-16 16:10:24.000000000 +0800
+++ linux-2.6/drivers/acpi/power.c	2009-05-12 13:12:27.000000000 +0800
@@ -54,7 +54,7 @@
 #define ACPI_POWER_RESOURCE_STATE_ON	0x01
 #define ACPI_POWER_RESOURCE_STATE_UNKNOWN 0xFF
 
-int acpi_power_nocheck;
+int acpi_power_nocheck = 1;
 module_param_named(power_nocheck, acpi_power_nocheck, bool, 000);
 
 static int acpi_power_add(struct acpi_device *device);


