From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v5 09/14] x86/tboot: remove paravirt_enabled()
Date: Fri,  8 Apr 2016 16:58:28 -0700
Message-ID: <1460159908-13386-1-git-send-email-mcgrof@kernel.org>
References: <1460158825-13117-1-git-send-email-mcgrof@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41735 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752736AbcDHX6d (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Apr 2016 19:58:33 -0400
In-Reply-To: <1460158825-13117-1-git-send-email-mcgrof@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, rusty@rustcorp.com.au
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, david.vrabel@citrix.com, konrad.wilk@oracle.com, xen-devel@lists.xensource.com, lguest@lists.ozlabs.org, andriy.shevchenko@linux.intel.com, jlee@suse.com, glin@suse.com, matt@codeblueprint.co.uk, andrew.cooper3@citrix.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, toshi.kani@hp.com, linux-acpi@vger.kernel.org, kozerkov@parallels.com, josh@joshtriplett.org, joro@8bytes.org, tiwai@suse.de, "Luis R. Rodriguez" <mcgrof@kernel.org>

There is already a check for boot_params.tboot_addr prior
to paravirt_enabled(). Both Xen and lguest, which are also the
only ones that set paravirt_enabled to true, never set the
boot_params.tboot_addr. The Xen folks are sure a force disable
to 0 is not needed, we recently forced disabled this on lguest.
With this in place this check is no longer needed.

Xen folks are sure force disable to 0 is not needed because
apm_info lives in .bss, we recently forced disabled this on
lguest, and on the Xen side just to be sure Boris zeroed out
the .bss for PV guests through commit 04b6b4a56884327c1648
("xen/x86: Zero out .bss for PV guests"). With this care taken
into consideration the paravirt_enabled() check is simply not
needed anymore.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 arch/x86/kernel/tboot.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index e72a07f20b05..9b0185fbe3eb 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -74,12 +74,6 @@ void __init tboot_probe(void)
 		return;
 	}
 
-	/* only a natively booted kernel should be using TXT */
-	if (paravirt_enabled()) {
-		pr_warning("non-0 tboot_addr but pv_ops is enabled\n");
-		return;
-	}
-
 	/* Map and check for tboot UUID. */
 	set_fixmap(FIX_TBOOT_BASE, boot_params.tboot_addr);
 	tboot = (struct tboot *)fix_to_virt(FIX_TBOOT_BASE);
-- 
2.7.2

