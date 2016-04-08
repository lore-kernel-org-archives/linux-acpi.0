From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v5 01/14] x86/boot: enumerate documentation for the x86 hardware_subarch
Date: Fri,  8 Apr 2016 16:40:12 -0700
Message-ID: <1460158825-13117-2-git-send-email-mcgrof@kernel.org>
References: <1460158825-13117-1-git-send-email-mcgrof@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39707 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759133AbcDHXkq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Apr 2016 19:40:46 -0400
In-Reply-To: <1460158825-13117-1-git-send-email-mcgrof@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, rusty@rustcorp.com.au
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, david.vrabel@citrix.com, konrad.wilk@oracle.com, xen-devel@lists.xensource.com, lguest@lists.ozlabs.org, andriy.shevchenko@linux.intel.com, jlee@suse.com, glin@suse.com, matt@codeblueprint.co.uk, andrew.cooper3@citrix.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, toshi.kani@hp.com, linux-acpi@vger.kernel.org, kozerkov@parallels.com, josh@joshtriplett.org, joro@8bytes.org, tiwai@suse.de, "Luis R. Rodriguez" <mcgrof@kernel.org>

Although hardware_subarch has been in place since the x86 boot
protocol 2.07 it hasn't been used much. Enumerate current possible
values to avoid misuses and help with semantics later at boot
time should this be used further.

These enums should only ever be used by architecture x86 code,
and all that code should be well contained and compartamentalized,
clarify that as well.

v2: updates documentation further -- be a bit more pedantic about
    annotating care and use of these guys.
v3: Use s/SOC/SoC and also anntoate that both domU and dom0 are
    both currently supported through the PV boot path.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 arch/x86/include/uapi/asm/bootparam.h | 37 ++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index 329254373479..bf9fea2f4591 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -157,7 +157,42 @@ struct boot_params {
 	__u8  _pad9[276];				/* 0xeec */
 } __attribute__((packed));
 
-enum {
+/**
+ * enum x86_hardware_subarch - x86 hardware subarchitecture
+ *
+ * The x86 hardware_subarch and hardware_subarch_data were added as of the x86
+ * boot protocol 2.07 to help distinguish and support custom x86 boot
+ * sequences. This enum represents accepted values for the x86
+ * hardware_subarch.  Custom x86 boot sequences (not X86_SUBARCH_PC) do not
+ * have or simply *cannot* make use of natural stubs like BIOS or EFI, the
+ * hardware_subarch can be used on the Linux entry path to revector to a
+ * subarchitecture stub when needed. This subarchitecture stub can be used to
+ * set up Linux boot parameters or for special care to account for nonstandard
+ * handling of page tables.
+ *
+ * These enums should only ever be used by x86 code, and the code that uses
+ * it should be well contained and compartamentalized.
+ *
+ * KVM and Xen HVM do not have a subarch as these are expected to follow
+ * standard x86 boot entries. If there is a genuine need for "hypervisor" type
+ * that should be considered separately in the future. Future guest types
+ * should seriously consider working with standard x86 boot stubs such as
+ * the BIOS or EFI boot stubs.
+ *
+ * @X86_SUBARCH_PC: Should be used if the hardware is enumerable using standard
+ *	PC mechanisms (PCI, ACPI) and doesn't need a special boot flow.
+ * @X86_SUBARCH_LGUEST: Used for x86 hypervisor demo, lguest
+ * @X86_SUBARCH_XEN: Used for Xen guest types which follow the PV boot path,
+ * 	which start at asm startup_xen() entry point and later jump to the C
+ * 	xen_start_kernel() entry point. Both domU and dom0 type of guests are
+ * 	currently supportd through this PV boot path.
+ * @X86_SUBARCH_INTEL_MID: Used for Intel MID (Mobile Internet Device) platform
+ *	systems which do not have the PCI legacy interfaces.
+ * @X86_SUBARCH_CE4100: Used for Intel CE media processor (CE4100) SoC for
+ * 	for settop boxes and media devices, the use of a subarch for CE4100
+ * 	is more of a hack...
+ */
+enum x86_hardware_subarch {
 	X86_SUBARCH_PC = 0,
 	X86_SUBARCH_LGUEST,
 	X86_SUBARCH_XEN,
-- 
2.7.2

