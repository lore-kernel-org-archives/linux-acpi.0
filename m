From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/4] x86: Remove obsolete PM definitions from NMI header
Date: Thu, 12 Jun 2008 10:27:08 +0200
Message-ID: <200806121027.09085.rjw@sisk.pl>
References: <200806121025.24668.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:36987 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754966AbYFLIgv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Jun 2008 04:36:51 -0400
In-Reply-To: <200806121025.24668.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>

From: Rafael J. Wysocki <rjw@sisk.pl>

Remove obsolete and no longer used PM-related definitions from
include/asm-x86/nmi.h .

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/asm-x86/nmi.h |   21 ---------------------
 1 file changed, 21 deletions(-)

Index: linux-2.6/include/asm-x86/nmi.h
===================================================================
--- linux-2.6.orig/include/asm-x86/nmi.h
+++ linux-2.6/include/asm-x86/nmi.h
@@ -15,27 +15,6 @@
  */
 int do_nmi_callback(struct pt_regs *regs, int cpu);
 
-#ifdef CONFIG_PM
-
-/** Replace the PM callback routine for NMI. */
-struct pm_dev *set_nmi_pm_callback(pm_callback callback);
-
-/** Unset the PM callback routine back to the default. */
-void unset_nmi_pm_callback(struct pm_dev *dev);
-
-#else
-
-static inline struct pm_dev *set_nmi_pm_callback(pm_callback callback)
-{
-	return 0;
-}
-
-static inline void unset_nmi_pm_callback(struct pm_dev *dev)
-{
-}
-
-#endif /* CONFIG_PM */
-
 #ifdef CONFIG_X86_64
 extern void default_do_nmi(struct pt_regs *);
 extern void die_nmi(char *str, struct pt_regs *regs, int do_panic);
