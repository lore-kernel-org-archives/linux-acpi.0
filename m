From: Len Brown <lenb@kernel.org>
Subject: [PATCH 49/84] ACPI: Disable the C2C3_FFH access mode HW has no MWAIT
 support
Date: Sat, 28 Jun 2008 01:43:53 -0400
Message-ID: <e794422f7a76039bc400bb00aa7d48b7ad53956f.1214631214.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:61962 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752881AbYF1FpT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:45:19 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K3500DJPRZG26UL@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:45:17 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Li Shaohua <shaohua.li@intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

991528d7348667924176f3e29addea0675298944
(ACPI: Processor native C-states using MWAIT)
started passing C2C3_FFH to _PDC to tell the BIOS
that Linux supports MWAIT for deep C-states.

However, we should first double check with the hardware
that it actually supports MWAIT before potentially exposing
a BIOS bug of an MWAIT _CST on HW that doesn't support MWAIT.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Li Shaohua <shaohua.li@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/acpi/processor.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/acpi/processor.c b/arch/x86/kernel/acpi/processor.c
index de2d2e4..7c074ee 100644
--- a/arch/x86/kernel/acpi/processor.c
+++ b/arch/x86/kernel/acpi/processor.c
@@ -56,6 +56,12 @@ static void init_intel_pdc(struct acpi_processor *pr, struct cpuinfo_x86 *c)
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
-- 
1.5.6.1.89.gd544

