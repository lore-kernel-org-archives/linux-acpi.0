From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/5] ACPI: fix Compaq Evo N800c (Pentium 4m) boot hang
 regression
Date: Sun, 27 Sep 2009 04:32:43 -0400
Message-ID: <3e2ada5867b7e9fa0b296d30fa8f3726ebd0a8b7.1254040242.git.len.brown@intel.com>
References: <1254040365-18971-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:40771 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519AbZI0Icr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Sep 2009 04:32:47 -0400
Received: from localhost.localdomain ([74.104.150.83])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KQM009ZFFQQG9KK@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 27 Sep 2009 03:32:51 -0500 (CDT)
In-reply-to: <1254040365-18971-1-git-send-email-lenb@kernel.org>
In-reply-to: <b684a3637e0887683a0a3d6fd471fc41d7c1606a.1254040242.git.len.brown@intel.com>
References: <b684a3637e0887683a0a3d6fd471fc41d7c1606a.1254040242.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

Don't disable ARB_DISABLE when the familary ID is 0x0F.

http://bugzilla.kernel.org/show_bug.cgi?id=14211

This was a 2.6.31 regression, and so this patch
needs to be applied to 2.6.31.stable

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/acpi/cstate.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

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
-- 
1.6.0.6

