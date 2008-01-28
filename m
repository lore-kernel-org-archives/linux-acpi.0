From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH 1/5] ACPI: Set the bif of ACPI_PDC_SMP_T_SWCOORD for _PDC
Date: Mon, 28 Jan 2008 13:53:21 +0800
Message-ID: <1201499601.17068.19.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:26242 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753002AbYA1GLk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Jan 2008 01:11:40 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Subject: ACPI: Set the bif of ACPI_PDC_SMP_T_SWCOORD for _PDC
>From : Zhao Yakui <yakui.zhao@intel.com>

The bit of ACPI_PDC_SMP_T_SWCOORD is set so that OSPM is capable of 
native ACPI throttling software coordination for mutli-processors 
using the _TSD information.


Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 arch/ia64/kernel/acpi-processor.c |    6 ++++++
 arch/x86/kernel/acpi/processor.c  |    6 ++++++
 2 files changed, 12 insertions(+)

Index: linux-2.6/arch/ia64/kernel/acpi-processor.c
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/acpi-processor.c
+++ linux-2.6/arch/ia64/kernel/acpi-processor.c
@@ -45,6 +45,12 @@ static void init_intel_pdc(struct acpi_p
 	buf[0] = ACPI_PDC_REVISION_ID;
 	buf[1] = 1;
 	buf[2] = ACPI_PDC_EST_CAPABILITY_SMP;
+	/*
+	 * The default of PDC_SMP_T_SWCOORD bit is set for IA64 cpu so
+	 * that OSPM is capable of native ACPI throttling software
+	 * coordination using BIOS supplied _TSD info.
+	 */
+	buf[2] |= ACPI_PDC_SMP_T_SWCOORD;
 
 	obj->type = ACPI_TYPE_BUFFER;
 	obj->buffer.length = 12;
Index: linux-2.6/arch/x86/kernel/acpi/processor.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/acpi/processor.c
+++ linux-2.6/arch/x86/kernel/acpi/processor.c
@@ -46,6 +46,12 @@ static void init_intel_pdc(struct acpi_p
 	buf[1] = 1;
 	buf[2] = ACPI_PDC_C_CAPABILITY_SMP;
 
+	/*
+	 * The default of PDC_SMP_T_SWCOORD bit is set for intel x86 cpu so
+	 * that OSPM is capable of native ACPI throttling software
+	 * coordination using BIOS supplied _TSD info.
+	 */
+	buf[2] |= ACPI_PDC_SMP_T_SWCOORD;
 	if (cpu_has(c, X86_FEATURE_EST))
 		buf[2] |= ACPI_PDC_EST_CAPABILITY_SWSMP;
 


