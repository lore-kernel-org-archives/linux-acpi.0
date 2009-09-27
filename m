From: Len Brown <lenb@kernel.org>
Subject: [PATCH 5/5] ACPI: IA64=y ACPI=n build fix
Date: Sun, 27 Sep 2009 04:32:45 -0400
Message-ID: <e56d953d190061938b31cabbe01b7f3d76c60bd0.1254040242.git.len.brown@intel.com>
References: <1254040365-18971-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:60112 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753520AbZI0Ics (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Sep 2009 04:32:48 -0400
Received: from localhost.localdomain ([74.104.150.83])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KQM009PUFQRYPW0@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 27 Sep 2009 03:32:52 -0500 (CDT)
In-reply-to: <1254040365-18971-1-git-send-email-lenb@kernel.org>
In-reply-to: <b684a3637e0887683a0a3d6fd471fc41d7c1606a.1254040242.git.len.brown@intel.com>
References: <b684a3637e0887683a0a3d6fd471fc41d7c1606a.1254040242.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

ia64's sim_defconfig uses CONFIG_ACPI=n
which now #define's acpi_disabled in <linux/acpi.h>

So we shouldn't re-define it here in <asm/acpi.h>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/ia64/include/asm/acpi.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/ia64/include/asm/acpi.h b/arch/ia64/include/asm/acpi.h
index 0f82cc2..91df968 100644
--- a/arch/ia64/include/asm/acpi.h
+++ b/arch/ia64/include/asm/acpi.h
@@ -89,10 +89,12 @@ ia64_acpi_release_global_lock (unsigned int *lock)
 #define ACPI_RELEASE_GLOBAL_LOCK(facs, Acq)				\
 	((Acq) = ia64_acpi_release_global_lock(&facs->global_lock))
 
+#ifdef	CONFIG_ACPI
 #define acpi_disabled 0	/* ACPI always enabled on IA64 */
 #define acpi_noirq 0	/* ACPI always enabled on IA64 */
 #define acpi_pci_disabled 0 /* ACPI PCI always enabled on IA64 */
 #define acpi_strict 1	/* no ACPI spec workarounds on IA64 */
+#endif
 #define acpi_processor_cstate_check(x) (x) /* no idle limits on IA64 :) */
 static inline void disable_acpi(void) { }
 
-- 
1.6.0.6

