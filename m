From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/65] x86, ACPI: default to reboot via ACPI (again)
Date: Fri, 29 May 2009 21:41:39 -0400
Message-ID: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:40197 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbZE3Bmn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:42:43 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF005VDOR9U8M3@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:42:46 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

We've run into systems which do not reboot properly
without using the ACPI reset mechanism.  So lets
try this in linux-next for a while and see
how many existing machines stop rebooting
because they can't handle ACPI reboot.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/reboot.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 724adfc..f72f71c 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -29,7 +29,7 @@ EXPORT_SYMBOL(pm_power_off);
 
 static const struct desc_ptr no_idt = {};
 static int reboot_mode;
-enum reboot_type reboot_type = BOOT_KBD;
+enum reboot_type reboot_type = BOOT_ACPI;
 int reboot_force;
 
 #if defined(CONFIG_X86_32) && defined(CONFIG_SMP)
-- 
1.6.0.6

