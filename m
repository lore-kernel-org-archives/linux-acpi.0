From: Len Brown <lenb@kernel.org>
Subject: [PATCH 17/94] ACPI: disable MPS when NO APIC-table found
Date: Fri, 09 Jan 2009 04:26:19 -0500
Message-ID: <7b37b5fd9ba32c0c5afc3537eed7e7466f2173e2.1231492608.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:40934 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbZAIJ1z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:27:55 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD700LZY6AILD17@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:27:55 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

When ACPI is asked to find an MADT (APIC table)
and fails, then ACPI expects to run in PIC mode.

However, if an MP Table is was found, IRQs will be
registered as if an IOAPIC is being used, even
though ACPI is configuring interrupt links links for PIC mode.

In this scenario, disable MPS so that IRQs
are registered in PIC mode, consistent with ACPI.

http://bugzilla.kernel.org/show_bug.cgi?id=12257

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/acpi/boot.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 4c51a2f..de8ce79 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1359,6 +1359,17 @@ static void __init acpi_process_madt(void)
 			       "Invalid BIOS MADT, disabling ACPI\n");
 			disable_acpi();
 		}
+	} else {
+		/*
+ 		 * ACPI found no MADT, and so ACPI wants UP PIC mode.
+ 		 * In the event an MPS table was found, forget it.
+ 		 * Boot with "acpi=off" to use MPS on such a system.
+ 		 */
+		if (smp_found_config) {
+			printk(KERN_WARNING PREFIX
+				"No APIC-table, disabling MPS\n");
+			smp_found_config = 0;
+		}
 	}
 #endif
 	return;
-- 
1.5.6.6

