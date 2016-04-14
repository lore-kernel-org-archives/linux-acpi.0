From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v6 11/16] pnpbios: replace paravirt_enabled() check with legacy device check
Date: Wed, 13 Apr 2016 17:04:41 -0700
Message-ID: <1460592286-300-12-git-send-email-mcgrof@kernel.org>
References: <1460592286-300-1-git-send-email-mcgrof@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460592286-300-1-git-send-email-mcgrof@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, rusty@rustcorp.com.au
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, jgross@suse.com, david.vrabel@citrix.com, konrad.wilk@oracle.com, xen-devel@lists.xensource.com, lguest@lists.ozlabs.org, andriy.shevchenko@linux.intel.com, jlee@suse.com, glin@suse.com, matt@codeblueprint.co.uk, andrew.cooper3@citrix.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, toshi.kani@hp.com, linux-acpi@vger.kernel.org, kozerkov@parallels.com, josh@joshtriplett.org, bigeasy@linutronix.de, ffainelli@freebox.fr, george.dunlap@citrix.com, julien.grall@linaro.org, mbizon@freebox.fr, tiwai@suse.de, "Luis R. Rodriguez" <mcgrof@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Since we are removing paravirt_enabled() replace it with a
logical equivalent. Even though PNPBIOS is x86 specific we
add an arch-specific type call, which can be implemented by
any architecture to show how other legacy attribute devices
can later be also checked for with other ACPI legacy attribute
flags.

This implicates the first ACPI 5.2.9.3 IA-PC Boot Architecture
ACPI_FADT_LEGACY_DEVICES flag device, and shows how to add more.

The reason pnpbios gets a defined structure and as such uses
a different approach than the RTC legacy quirk is that ACPI
has a respective RTC flag, while pnpbios does not. We fold
the pnpbios quirk under ACPI_FADT_LEGACY_DEVICES ACPI flag
use case, and use a struct of possible devices to enable
future extensions of this.

As per 0-day, this bumps the vmlinux size using i386-tinyconfig as
follows:

TOTAL   TEXT   init.text   x86_early_init_platform_quirks()
+32     +28    +28         +28

That's 4 byte overhead total, the rest is cleared out on init
as its all __init text.

v2: split out subarch handlng on switch to make it easier
    later to add other subarchs. The 'fall-through' switch
    handling can be confusing and we'll remove it later
    when we add handling for X86_SUBARCH_CE4100.
v3: document vmlinux size impact as per 0-day, and also
    explain why pnpbios is treated differently than the
    RTC legacy feature.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 arch/x86/include/asm/x86_init.h   | 26 ++++++++++++++++++++++++++
 arch/x86/kernel/platform-quirks.c | 11 +++++++++++
 drivers/pnp/pnpbios/core.c        |  3 ++-
 include/linux/pnp.h               |  2 ++
 4 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 89d9d57e145d..4dcdf74dfed8 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -142,15 +142,41 @@ struct x86_cpuinit_ops {
 struct timespec;
 
 /**
+ * struct x86_legacy_devices - legacy x86 devices
+ *
+ * @pnpbios: this platform can have a PNPBIOS. If this is disabled the platform
+ * 	is known to never have a PNPBIOS.
+ *
+ * These are devices known to require LPC or ISA bus. The definition of legacy
+ * devices adheres to the ACPI 5.2.9.3 IA-PC Boot Architecture flag
+ * ACPI_FADT_LEGACY_DEVICES. These devices consist of user visible devices on
+ * the LPC or ISA bus. User visible devices are devices that have end-user
+ * accessible connectors (for example, LPT parallel port). Legacy devices on
+ * the LPC bus consist for example of serial and parallel ports, PS/2 keyboard
+ * / mouse, and the floppy disk controller. A system that lacks all known
+ * legacy devices can assume all devices can be detected exclusively via
+ * standard device enumeration mechanisms including the ACPI namespace.
+ *
+ * A system which has does not have ACPI_FADT_LEGACY_DEVICES enabled must not
+ * have any of the legacy devices enumerated below present.
+ */
+struct x86_legacy_devices {
+	int pnpbios;
+};
+
+/**
  * struct x86_legacy_features - legacy x86 features
  *
  * @rtc: this device has a CMOS real-time clock present
  * @ebda_search: it's safe to search for the EBDA signature in the hardware's
  * 	low RAM
+ * @devices: legacy x86 devices, refer to struct x86_legacy_devices
+ * 	documentation for further details.
  */
 struct x86_legacy_features {
 	int rtc;
 	int ebda_search;
+	struct x86_legacy_devices devices;
 };
 
 /**
diff --git a/arch/x86/kernel/platform-quirks.c b/arch/x86/kernel/platform-quirks.c
index 01b159781d96..ab643825a7aa 100644
--- a/arch/x86/kernel/platform-quirks.c
+++ b/arch/x86/kernel/platform-quirks.c
@@ -8,6 +8,7 @@ void __init x86_early_init_platform_quirks(void)
 {
 	x86_platform.legacy.rtc = 1;
 	x86_platform.legacy.ebda_search = 0;
+	x86_platform.legacy.devices.pnpbios = 1;
 
 	switch (boot_params.hdr.hardware_subarch) {
 	case X86_SUBARCH_PC:
@@ -15,6 +16,9 @@ void __init x86_early_init_platform_quirks(void)
 		break;
 	case X86_SUBARCH_XEN:
 	case X86_SUBARCH_LGUEST:
+		x86_platform.legacy.devices.pnpbios = 0;
+		x86_platform.legacy.rtc = 0;
+		break;
 	case X86_SUBARCH_INTEL_MID:
 		x86_platform.legacy.rtc = 0;
 		break;
@@ -23,3 +27,10 @@ void __init x86_early_init_platform_quirks(void)
 	if (x86_platform.set_legacy_features)
 		x86_platform.set_legacy_features();
 }
+
+#if defined(CONFIG_PNPBIOS)
+bool __init arch_pnpbios_disabled(void)
+{
+	return x86_platform.legacy.devices.pnpbios == 0;
+}
+#endif
diff --git a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
index facd43b8516c..81603d99082b 100644
--- a/drivers/pnp/pnpbios/core.c
+++ b/drivers/pnp/pnpbios/core.c
@@ -521,10 +521,11 @@ static int __init pnpbios_init(void)
 	int ret;
 
 	if (pnpbios_disabled || dmi_check_system(pnpbios_dmi_table) ||
-	    paravirt_enabled()) {
+	    arch_pnpbios_disabled()) {
 		printk(KERN_INFO "PnPBIOS: Disabled\n");
 		return -ENODEV;
 	}
+
 #ifdef CONFIG_PNPACPI
 	if (!acpi_disabled && !pnpacpi_disabled) {
 		pnpbios_disabled = 1;
diff --git a/include/linux/pnp.h b/include/linux/pnp.h
index 5df733b8f704..2588ca6a9028 100644
--- a/include/linux/pnp.h
+++ b/include/linux/pnp.h
@@ -337,9 +337,11 @@ extern struct mutex pnp_res_mutex;
 
 #ifdef CONFIG_PNPBIOS
 extern struct pnp_protocol pnpbios_protocol;
+extern bool arch_pnpbios_disabled(void);
 #define pnp_device_is_pnpbios(dev) ((dev)->protocol == (&pnpbios_protocol))
 #else
 #define pnp_device_is_pnpbios(dev) 0
+#define arch_pnpbios_disabled()	false
 #endif
 
 #ifdef CONFIG_PNPACPI
-- 
2.7.2
