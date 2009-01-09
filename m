From: Len Brown <lenb@kernel.org>
Subject: [PATCH 90/94] ACPI: Avoid array address overflow when _CST MWAIT hint
 bits are set
Date: Fri, 09 Jan 2009 04:27:32 -0500
Message-ID: <13b40a1a065824d2d4e55c8b48ea9f3f9d162929.1231492614.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:51782 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754130AbZAIJ2r (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:47 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KD700A0I6BSW5W9@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:42 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

The Cx Register address obtained from the _CST object is used as the MWAIT
hints if the register type is FFixedHW. And it is used to check whether
the Cx type is supported or not.

On some boxes the following Cx state package is obtained from _CST object:
    >{
                ResourceTemplate ()
                {
                    Register (FFixedHW,
                        0x01,               // Bit Width
                        0x02,               // Bit Offset
                        0x0000000000889759, // Address
                        0x03,               // Access Size
                        )
                },

                0x03,
                0xF5,
                0x015E }

   In such case we should use the bit[7:4] of Cx address to check whether
the Cx type is supported or not.

mask the MWAIT hint to avoid array address overflow

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Acked-by:Venki Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/acpi/cstate.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index c2502eb..a4805b3 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -56,6 +56,7 @@ static struct cstate_entry *cpu_cstate_entry;	/* per CPU ptr */
 static short mwait_supported[ACPI_PROCESSOR_MAX_POWER];
 
 #define MWAIT_SUBSTATE_MASK	(0xf)
+#define MWAIT_CSTATE_MASK	(0xf)
 #define MWAIT_SUBSTATE_SIZE	(4)
 
 #define CPUID_MWAIT_LEAF (5)
@@ -98,7 +99,8 @@ int acpi_processor_ffh_cstate_probe(unsigned int cpu,
 	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
 
 	/* Check whether this particular cx_type (in CST) is supported or not */
-	cstate_type = (cx->address >> MWAIT_SUBSTATE_SIZE) + 1;
+	cstate_type = ((cx->address >> MWAIT_SUBSTATE_SIZE) &
+			MWAIT_CSTATE_MASK) + 1;
 	edx_part = edx >> (cstate_type * MWAIT_SUBSTATE_SIZE);
 	num_cstate_subtype = edx_part & MWAIT_SUBSTATE_MASK;
 
-- 
1.5.6.6

