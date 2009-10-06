From: Len Brown <lenb@kernel.org>
Subject: Re: Regression in ACPI in 2.6.31-rc5
Date: Mon, 05 Oct 2009 23:17:04 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0910052312140.309@localhost.localdomain>
References: <200908072333.24631.storm@sys49152.net>
 <alpine.LFD.2.00.0908122350560.22946@localhost.localdomain>
 <200908160400.03391.storm@sys49152.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756005AbZJFDSF@vger.kernel.org>
In-reply-to: <200908160400.03391.storm@sys49152.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Ricardo Jorge da Fonseca Marques Ferreira <storm@sys49152.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Yannick Roehlly <yannick.roehlly@free.fr>, Yinghai Lu <yinghai@kernel.org>, Jesse Barnes <jesse.barnes@intel.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Ingo Molnar <mingo@elte.hu>, x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

From: Len Brown <len.brown@intel.com>
Subject: [PATCH] Revert "x86/pci: remove rounding quirk from e820_setup_gap()"

This reverts commit 5d423ccd7ba4285f1084e91b26805e1d0ae978ed.

because it caused multiple regressions in 2.6.31-rc1

http://bugzilla.kernel.org/show_bug.cgi?id=13940

Signed-off-by: Len Brown <len.brown@intel.com>
---

Yinghai,
is there a reason we should not revert the offending patch, per below?

thanks,
-Len

 arch/x86/kernel/e820.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 85419bb..b322e30 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -617,7 +617,7 @@ __init int e820_search_gap(unsigned long *gapstart, unsigned long *gapsize,
  */
 __init void e820_setup_gap(void)
 {
-	unsigned long gapstart, gapsize;
+	unsigned long gapstart, gapsize, round;
 	int found;
 
 	gapstart = 0x10000000;
@@ -634,9 +634,14 @@ __init void e820_setup_gap(void)
 #endif
 
 	/*
-	 * e820_reserve_resources_late protect stolen RAM already
+	 * See how much we want to round up: start off with
+	 * rounding to the next 1MB area.
 	 */
-	pci_mem_start = gapstart;
+	round = 0x100000;
+	while ((gapsize >> 4) > round)
+		round += round;
+	/* Fun with two's complement */
+	pci_mem_start = (gapstart + round) & -round;
 
 	printk(KERN_INFO
 	       "Allocating PCI resources starting at %lx (gap: %lx:%lx)\n",
-- 
1.6.5.rc2.17.gdbc1b
