From: Len Brown <lenb@kernel.org>
Subject: [PATCH 064/112] ACPI: Set _PSD ACPI_PDC_SMP_T_SWCOORD
Date: Thu,  7 Feb 2008 04:34:26 -0500
Message-ID: <3abbd337c60591305cbfeb984ff2922c175be37f.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:18844 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757744AbYBGJgX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:23 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

The ACPI_PDC_SMP_T_SWCOORD bit is set by and OS that is capable of
native ACPI throttling software coordination for mutli-processors
using the _TSD information.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/ia64/kernel/acpi-processor.c |    6 ++++++
 arch/x86/kernel/acpi/processor.c  |    6 ++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/ia64/kernel/acpi-processor.c b/arch/ia64/kernel/acpi-processor.c
index 5a216c0..cbe6cee 100644
--- a/arch/ia64/kernel/acpi-processor.c
+++ b/arch/ia64/kernel/acpi-processor.c
@@ -45,6 +45,12 @@ static void init_intel_pdc(struct acpi_processor *pr)
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
diff --git a/arch/x86/kernel/acpi/processor.c b/arch/x86/kernel/acpi/processor.c
index a25db51..324eb0c 100644
--- a/arch/x86/kernel/acpi/processor.c
+++ b/arch/x86/kernel/acpi/processor.c
@@ -46,6 +46,12 @@ static void init_intel_pdc(struct acpi_processor *pr, struct cpuinfo_x86 *c)
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
 
-- 
1.5.4.23.gef5b9

