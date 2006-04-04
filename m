From: Stephen Hemminger <shemminger@osdl.org>
Subject: [PATCH] acpi: eliminate section mismatch warning
Date: Tue, 4 Apr 2006 11:26:33 -0700
Message-ID: <20060404112633.05fc15fa@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:58530 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750787AbWDDS0h (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Apr 2006 14:26:37 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

Fix the linker warning (noise) from section mismatch in ACPI caused
because the function acpi_processor_power_init's references can't be
evaluated at compile time. It uses "first_run" flag and therefore
changes behaviour after first use, and compiler/linker can't see that.

This does cost slightly more dead data.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

--- test-2.6.orig/drivers/acpi/processor_idle.c
+++ test-2.6/drivers/acpi/processor_idle.c
@@ -94,9 +94,11 @@ static int set_max_cstate(struct dmi_sys
 	return 0;
 }
 
-/* Actually this shouldn't be __cpuinitdata, would be better to fix the
-   callers to only run once -AK */
-static struct dmi_system_id __cpuinitdata processor_power_dmi_table[] = {
+/* This used to be __cpuinitdata but then linker would complain about
+   section mismatch because of the first_run flag;
+   would be better to fix thecallers to only run once
+ */
+static struct dmi_system_id processor_power_dmi_table[] = {
 	{ set_max_cstate, "IBM ThinkPad R40e", {
 	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
 	  DMI_MATCH(DMI_BIOS_VERSION,"1SET60WW")}, (void *)1},
