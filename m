From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] x86 ACPI: Fix resume from suspend to RAM on uniprocessor x86-64
Date: Sat, 5 Jul 2008 00:05:30 +0200
Message-ID: <200807050005.31272.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:49451 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752774AbYGDWDu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Jul 2008 18:03:50 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

Hi Ingo,

This is a regression fix, please push to Linus ASAP.

Thanks,
Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>

Since the trampoline code is now used for ACPI resume from suspend to RAM,
the trampoline page tables have to be fixed up during boot not only on SMP
systems, but also on UP systems that use the trampoline.

Reference: http://bugzilla.kernel.org/show_bug.cgi?id=10923

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/x86/kernel/head_64.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/arch/x86/kernel/head_64.S
===================================================================
--- linux-2.6.orig/arch/x86/kernel/head_64.S
+++ linux-2.6/arch/x86/kernel/head_64.S
@@ -128,7 +128,7 @@ ident_complete:
 	/* Fixup phys_base */
 	addq	%rbp, phys_base(%rip)
 
-#ifdef CONFIG_SMP
+#ifdef CONFIG_X86_TRAMPOLINE
 	addq	%rbp, trampoline_level4_pgt + 0(%rip)
 	addq	%rbp, trampoline_level4_pgt + (511*8)(%rip)
 #endif
