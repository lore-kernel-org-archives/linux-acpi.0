From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v5 02/14] x86/xen: use X86_SUBARCH_XEN for PV guest boots
Date: Fri,  8 Apr 2016 16:57:05 -0700
Message-ID: <1460159825-13212-1-git-send-email-mcgrof@kernel.org>
References: <1460158825-13117-1-git-send-email-mcgrof@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41431 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759277AbcDHX5L (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Apr 2016 19:57:11 -0400
In-Reply-To: <1460158825-13117-1-git-send-email-mcgrof@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, rusty@rustcorp.com.au
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, david.vrabel@citrix.com, konrad.wilk@oracle.com, xen-devel@lists.xensource.com, lguest@lists.ozlabs.org, andriy.shevchenko@linux.intel.com, jlee@suse.com, glin@suse.com, matt@codeblueprint.co.uk, andrew.cooper3@citrix.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, toshi.kani@hp.com, linux-acpi@vger.kernel.org, kozerkov@parallels.com, josh@joshtriplett.org, joro@8bytes.org, tiwai@suse.de, "Luis R. Rodriguez" <mcgrof@kernel.org>

The use of subarch should have no current effect on Xen
PV guests, as such this should have no current functional
effects.

Reviewed-by: David Vrabel <david.vrabel@citrix.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 arch/x86/xen/enlighten.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 9b8f1eacc110..40487f1ecb4c 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -1661,6 +1661,7 @@ asmlinkage __visible void __init xen_start_kernel(void)
 	boot_params.hdr.ramdisk_image = initrd_start;
 	boot_params.hdr.ramdisk_size = xen_start_info->mod_len;
 	boot_params.hdr.cmd_line_ptr = __pa(xen_start_info->cmd_line);
+	boot_params.hdr.hardware_subarch = X86_SUBARCH_XEN;
 
 	if (!xen_initial_domain()) {
 		add_preferred_console("xenboot", 0, NULL);
-- 
2.7.2

