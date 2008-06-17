From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH1/4] ACPI : Disable the C2C3_FFH access mode if MWAIT is
	unsupported
Date: Tue, 17 Jun 2008 14:39:59 +0800
Message-ID: <1213684799.19901.9.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:35893 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751914AbYFQG3K (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jun 2008 02:29:10 -0400
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
 arch/x86/kernel/acpi/processor.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-2.6/arch/x86/kernel/acpi/processor.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/acpi/processor.c
+++ linux-2.6/arch/x86/kernel/acpi/processor.c
@@ -61,6 +61,12 @@ static void init_intel_pdc(struct acpi_p
 	if (cpu_has(c, X86_FEATURE_ACPI))
 		buf[2] |= ACPI_PDC_T_FFH;
 
+	/*
+	 * If mwait/monitor is unsupported, C2/C3_FFH will be disabled
+	 */
+	if (!cpu_has(c, X86_FEATURE_MWAIT))
+		buf[2] &= ~(ACPI_PDC_C_C2C3_FFH);
+
 	obj->type = ACPI_TYPE_BUFFER;
 	obj->buffer.length = 12;
 	obj->buffer.pointer = (u8 *) buf;


