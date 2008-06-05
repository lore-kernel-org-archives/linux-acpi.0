From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH] ACPI : Disable the C2C3_FFH access mode if MWAIT is
	unsupported
Date: Thu, 05 Jun 2008 14:33:01 +0800
Message-ID: <1212647581.10730.14.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:20268 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751931AbYFEGXO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 5 Jun 2008 02:23:14 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Subject: ACPI: Disable the C2C3_FFH access mode if MWAIT is unsupported
From: Zhao Yakui <yakui.zhao@intel.com>

   After the following commit is merged, C2C3_FFH mode will be enabled and 
passed into the _PDC object. If the BIOS thinks that MWAIT is supported and
the CPU doesn't support MWAIT, the incorrect power states will be returned 
by the _CST object. So it will be better to disable C2C3_FFH access mode 
if MWAIT is unsupported.
 
commit 991528d7348667924176f3e29addea0675298944
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Mon Sep 25 16:28:13 2006 -0700

    ACPI: Processor native C-states using MWAIT

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Li Shaohua <shaohua.li@intel.com>

---
 arch/x86/kernel/acpi/processor.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux-2.6/arch/x86/kernel/acpi/processor.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/acpi/processor.c
+++ linux-2.6/arch/x86/kernel/acpi/processor.c
@@ -43,6 +43,11 @@ static void init_intel_pdc(struct acpi_p
 	buf[0] = ACPI_PDC_REVISION_ID;
 	buf[1] = 1;
 	buf[2] = ACPI_PDC_C_CAPABILITY_SMP;
+	/*
+	 * If mwait/monitor is unsupported, C2/C3_FFH will be disabled.
+	 */
+	if (!cpu_has(c, X86_FEATURE_MWAIT))
+		buf[2] &= ~ACPI_PDC_C_C2C3_FFH;
 
 	/*
 	 * The default of PDC_SMP_T_SWCOORD bit is set for intel x86 cpu so


