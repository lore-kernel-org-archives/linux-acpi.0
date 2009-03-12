From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH] ACPI: pass correct parameter to
	acpi_processor_ffh_cstate_probe_cpu()
Date: Thu, 12 Mar 2009 15:45:24 +0800
Message-ID: <20090312074524.GA15992@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:62413 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751497AbZCLHqs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Mar 2009 03:46:48 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@elte.hu>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Len Brown <len.brown@intel.com>, Zhao Yakui <yakui.zhao@intel.com>

This fixes a NULL pointer dereference bug introduced by 6e911954cac.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index 6626e8c..b866b87 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -137,7 +137,7 @@ int acpi_processor_ffh_cstate_probe(unsigned int cpu,
 	/* Run acpi_processor_ffh_cstate_probe_cpu() on the target CPU */
 
 	retval = smp_call_function_single(cpu,
-				acpi_processor_ffh_cstate_probe_cpu, cx, 1);
+				acpi_processor_ffh_cstate_probe_cpu, &cxcc, 1);
 	if (retval == 0) {
 		retval = cxcc.retval;
 		if (retval == 0) {
