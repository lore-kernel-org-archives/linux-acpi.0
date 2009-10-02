From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2.6.31.stable] ACPI: fix Compaq Evo N800c (Pentium 4m) boot
 hang regression
Date: Fri, 02 Oct 2009 09:59:41 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0910020956440.25240@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:35431 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032AbZJBN7w (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Oct 2009 09:59:52 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: stable@kernel.org
Cc: linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Zhao Yakui <yakui.zhao@intel.com>

ACPI: fix Compaq Evo N800c (Pentium 4m) boot hang regression

Don't disable ARB_DISABLE when the familary ID is 0x0F.

http://bugzilla.kernel.org/show_bug.cgi?id=14211

This was a 2.6.31 regression, and so this patch
needs to be applied to 2.6.31.stable

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index 8c44c23..59cdfa4 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -48,7 +48,7 @@ void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
 	 * P4, Core and beyond CPUs
 	 */
 	if (c->x86_vendor == X86_VENDOR_INTEL &&
-	    (c->x86 > 0x6 || (c->x86 == 6 && c->x86_model >= 14)))
+	    (c->x86 > 0xf || (c->x86 == 6 && c->x86_model >= 14)))
 			flags->bm_control = 0;
 }
 EXPORT_SYMBOL(acpi_processor_power_init_bm_check);
