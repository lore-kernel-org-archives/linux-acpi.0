From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v5 12/14] x86, ACPI: parse ACPI_FADT_LEGACY_DEVICES
Date: Fri,  8 Apr 2016 16:40:23 -0700
Message-ID: <1460158825-13117-13-git-send-email-mcgrof@kernel.org>
References: <1460158825-13117-1-git-send-email-mcgrof@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460158825-13117-1-git-send-email-mcgrof@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, rusty@rustcorp.com.au
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, david.vrabel@citrix.com, konrad.wilk@oracle.com, xen-devel@lists.xensource.com, lguest@lists.ozlabs.org, andriy.shevchenko@linux.intel.com, jlee@suse.com, glin@suse.com, matt@codeblueprint.co.uk, andrew.cooper3@citrix.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, toshi.kani@hp.com, linux-acpi@vger.kernel.org, kozerkov@parallels.com, josh@joshtriplett.org, joro@8bytes.org, tiwai@suse.de, "Luis R. Rodriguez" <mcgrof@kernel.org>
List-Id: linux-acpi@vger.kernel.org

ACPI 5.2.9.3 IA-PC Boot Architecture flag ACPI_FADT_LEGACY_DEVICES
can be used to determine if a system has legacy devices LPC or
ISA devices. The x86 platform already has a struct which lists
known associated legacy devices, we start off careful only
by disabling root devices we should not regress with. The struct
and device list can be expanded with time to cover more root
legacy components.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 arch/x86/kernel/acpi/boot.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 8c9c2bdba092..c9a06e573fa5 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -913,6 +913,11 @@ late_initcall(hpet_insert_resource);
 
 static int __init acpi_parse_fadt(struct acpi_table_header *table)
 {
+	if (!(acpi_gbl_FADT.boot_flags & ACPI_FADT_LEGACY_DEVICES)) {
+		pr_debug("ACPI: no legacy devices present\n");
+		x86_platform.legacy.devices.pnpbios = 0;
+	}
+
 	if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_CMOS_RTC) {
 		pr_debug("ACPI: not registering RTC platform device\n");
 		x86_platform.legacy.rtc = 0;
-- 
2.7.2
