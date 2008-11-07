From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/10] x86, ACPI: default to reboot via ACPI (again)
Date: Thu, 06 Nov 2008 23:45:32 -0500
Message-ID: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1226032943.git.len.brown@intel.com>
References: <1226033132-16034-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:42489 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbYKGEpj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 23:45:39 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9Y00K8956G3PU1@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 Nov 2008 22:44:41 -0600 (CST)
In-reply-to: <1226033132-16034-1-git-send-email-lenb@kernel.org>
In-reply-to: <007e7d616a5d1c2e16ad627d03f8b97799445e71.1226032943.git.len.brown@intel.com>
References: <007e7d616a5d1c2e16ad627d03f8b97799445e71.1226032943.git.len.brown@intel.com>
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
1.5.6.5

