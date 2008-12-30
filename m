From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH] : ACPI : Add the MWAIT C-state mask to avoid overflow
Date: Tue, 30 Dec 2008 12:01:09 +0800
Message-ID: <1230609669.4091.92.camel@yakui_zhao.sh.intel.com>
References: <20081031184233.8588.42241.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9791 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752097AbYL3DvA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 29 Dec 2008 22:51:00 -0500
In-Reply-To: <20081031184233.8588.42241.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LenBrown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, venkatesh.pallipadi@intel.com

Subject: ACPI: Add the MWAIT C-state mask to avoid overflow
From: Zhao Yakui <yakui.zhao@intel.com>

Add the MWAIT C-state mask to avoid overflow 

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Acked-by:Venki Pallipadi <venkatesh.pallipadi@intel.com>
---
 arch/x86/kernel/acpi/cstate.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6/arch/x86/kernel/acpi/cstate.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/acpi/cstate.c
+++ linux-2.6/arch/x86/kernel/acpi/cstate.c
@@ -56,6 +56,7 @@ static struct cstate_entry *cpu_cstate_e
 static short mwait_supported[ACPI_PROCESSOR_MAX_POWER];
 
 #define MWAIT_SUBSTATE_MASK	(0xf)
+#define MWAIT_CSTATE_MASK	(0xf)
 #define MWAIT_SUBSTATE_SIZE	(4)
 
 #define CPUID_MWAIT_LEAF (5)
@@ -98,7 +99,8 @@ int acpi_processor_ffh_cstate_probe(unsi
 	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
 
 	/* Check whether this particular cx_type (in CST) is supported or not */
-	cstate_type = (cx->address >> MWAIT_SUBSTATE_SIZE) + 1;
+	cstate_type = ((cx->address >> MWAIT_SUBSTATE_SIZE) &
+			MWAIT_CSTATE_MASK) + 1;
 	edx_part = edx >> (cstate_type * MWAIT_SUBSTATE_SIZE);
 	num_cstate_subtype = edx_part & MWAIT_SUBSTATE_MASK;
 


