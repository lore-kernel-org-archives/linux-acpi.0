From: ykzhao <yakui.zhao@intel.com>
Subject: [PATCH] ACPI : ACPI: Don't disable ARB_DISABLE on some old cpus
Date: Sun, 27 Sep 2009 13:15:02 +0800
Message-ID: <1254028502.4298.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:63615 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751383AbZI0FPp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 27 Sep 2009 01:15:45 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

From: Zhao Yakui <yakui.zhao@intel.com>

Don't disable ARB_DISABLE when the familary ID is 0x0F.
It is required when it enters the C3 state on the old cpus.

http://bugzilla.kernel.org/show_bug.cgi?id=14211

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 arch/x86/kernel/acpi/cstate.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/arch/x86/kernel/acpi/cstate.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/acpi/cstate.c	2009-09-18 10:28:32.000000000 +0800
+++ linux-2.6/arch/x86/kernel/acpi/cstate.c	2009-09-24 14:59:57.000000000 +0800
@@ -48,7 +48,7 @@
 	 * P4, Core and beyond CPUs
 	 */
 	if (c->x86_vendor == X86_VENDOR_INTEL &&
-	    (c->x86 > 0x6 || (c->x86 == 6 && c->x86_model >= 14)))
+	    (c->x86 > 0xf || (c->x86 == 6 && c->x86_model >= 14)))
 			flags->bm_control = 0;
 }
 EXPORT_SYMBOL(acpi_processor_power_init_bm_check);


