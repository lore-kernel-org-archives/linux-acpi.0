From: Len Brown <lenb@kernel.org>
Subject: [PATCH 005/112] Revert "speedstep-lib.c: fix frequency multiplier for Pentium4 models 0&1"
Date: Thu,  7 Feb 2008 04:33:27 -0500
Message-ID: <ed9cbcd40004904dbe61ccc16d6106a7de38c998.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:20777 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754314AbYBGJfW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:35:22 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

For P4 model < 2, The MSR_FBC_REGISTER_ID ratio is undefined.
Revert the commit that was added to handle that case,
as it results in random MHz displayed.  Something else will
have to be done to properly handle model < 2.

//commit 3e4159ab35c88aef5e063ba78796b277b762a30a
//Author: matthias.christian <matthias.christian>
//Date:   Sat Feb 5 23:09:38 2005 +0000
//
//    [PATCH] speedstep-lib.c: fix frequency multiplier for Pentium4 models 0&1
//
//    The Pentium4 models 0&1 have a longer MSR_EBC_FREQUENCY_ID register as the
//    models 2&3, so the bit shift must be bigger.
//
//    Signed-off-by: Matthias-Christian Ott <matthias.christian@tiscali.de>
//    Signed-off-by: Dominik Brodowski <linux@brodo.de>
//    Signed-off-by: Andrew Morton <akpm@osdl.org>
//    Signed-off-by: Linus Torvalds <torvalds@osdl.org>
//
//    BKrev: 42055232eWM-NgjhZVir44mp5GXktQ

http://bugzilla.kernel.org/show_bug.cgi?id=7186

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/cpu/cpufreq/speedstep-lib.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/cpufreq/speedstep-lib.c b/arch/x86/kernel/cpu/cpufreq/speedstep-lib.c
index 76c3ab0..98d4fdb 100644
--- a/arch/x86/kernel/cpu/cpufreq/speedstep-lib.c
+++ b/arch/x86/kernel/cpu/cpufreq/speedstep-lib.c
@@ -189,10 +189,7 @@ static unsigned int pentium4_get_frequency(void)
 		printk(KERN_DEBUG "speedstep-lib: couldn't detect FSB speed. Please send an e-mail to <linux@brodo.de>\n");
 
 	/* Multiplier. */
-	if (c->x86_model < 2)
-		mult = msr_lo >> 27;
-	else
-		mult = msr_lo >> 24;
+	mult = msr_lo >> 24;
 
 	dprintk("P4 - FSB %u kHz; Multiplier %u; Speed %u kHz\n", fsb, mult, (fsb * mult));
 
-- 
1.5.4.23.gef5b9

