From: Len Brown <lenb@kernel.org>
Subject: [PATCH 060/103] ACPI: Use the ARB_DISABLE for the CPU which model id
 is less than 0x0f.
Date: Wed, 16 Dec 2009 03:36:11 -0500
Message-ID: <03a05ed1152944000151d57b71000de287a1eb02.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:47186 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762003AbZLPLGA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 06:06:00 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KUQ00BZPS5OJK34@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 05:05:55 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, stable@kernel.org, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

Currently, ARB_DISABLE is a NOP on all of the recent Intel platforms.
For such platforms, reduce contention on c3_lock by skipping the fake
ARB_DISABLE.

The cpu model id on one laptop is 14. If we disable ARB_DISABLE on this box,
the box can't be booted correctly. But if we still enable ARB_DISABLE on this
box, the box can be booted correctly.

So we still use the ARB_DISABLE for the cpu which mode id is less than 0x0f.

http://bugzilla.kernel.org/show_bug.cgi?id=14700

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Acked-by: Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com>
cc: stable@kernel.org
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/acpi/cstate.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index 59cdfa4..2e837f5 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -48,7 +48,7 @@ void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
 	 * P4, Core and beyond CPUs
 	 */
 	if (c->x86_vendor == X86_VENDOR_INTEL &&
-	    (c->x86 > 0xf || (c->x86 == 6 && c->x86_model >= 14)))
+	    (c->x86 > 0xf || (c->x86 == 6 && c->x86_model >= 0x0f)))
 			flags->bm_control = 0;
 }
 EXPORT_SYMBOL(acpi_processor_power_init_bm_check);
-- 
1.6.0.6

