From: yakui.zhao@intel.com
Subject: [Resend PATCH] acpi: Use the ARB_DISABLE for the CPU which model id is less than 0x0f.
Date: Fri, 11 Dec 2009 15:17:20 +0800
Message-ID: <1260515840-4728-1-git-send-email-yakui.zhao@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:36263 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933619AbZLKHTE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Dec 2009 02:19:04 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Zhao Yakui <yakui.zhao@intel.com>, stable@kernel.org

From: Zhao Yakui <yakui.zhao@intel.com>

ARB_DISABLE is a NOP on all of the recent Intel platforms. For such platforms,
reduce contention on c3_lock by skipping the fake ARB_DISABLE.

The cpu model id on one laptop is 14. If we disable ARB_DISABLE on this box,
the box can't be booted correctly. But if we still enable ARB_DISABLE on this
box, the box can be booted correctly.

So we still use the ARB_DISABLE for the cpu which mode id is less than 0x0f.

http://bugzilla.kernel.org/show_bug.cgi?id=14700

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Acked-by: Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com>
cc: stable@kernel.org
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
1.5.4.5

