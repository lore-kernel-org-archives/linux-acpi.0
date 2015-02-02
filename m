From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v8 08/21] dt / chosen: Add linux,uefi-stub-generated-dtb property
Date: Mon,  2 Feb 2015 20:45:36 +0800
Message-ID: <1422881149-8177-9-git-send-email-hanjun.guo@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:43109 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932271AbbBBMs6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Feb 2015 07:48:58 -0500
Received: by mail-pa0-f45.google.com with SMTP id et14so82067547pad.4
        for <linux-acpi@vger.kernel.org>; Mon, 02 Feb 2015 04:48:58 -0800 (PST)
In-Reply-To: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles.Garcia-Tobin@arm.com, phoenix.liyi@huawei.com, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, Mark Langsdorf <mlangsdo@redhat.com>, wangyijing@huawei.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Leif

When system supporting both DT and ACPI but firmware providing
no dtb, we can use this linux,uefi-stub-generated-dtb property
to let kernel know that we can try ACPI configuration data even
if no "acpi=force" is passed in early parameters.

CC: Mark Rutland <mark.rutland@arm.com>
CC: Jonathan Corbet <corbet@lwn.net>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
CC: Leif Lindholm <leif.lindholm@linaro.org>
CC: Grant Likely <grant.likely@linaro.org>
CC: Matt Fleming <matt.fleming@intel.com>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 Documentation/arm/uefi.txt         |  3 +++
 arch/arm64/include/asm/acpi.h      |  1 +
 arch/arm64/kernel/setup.c          | 30 ++++++++++++++++++++++++++++++
 drivers/firmware/efi/libstub/fdt.c |  8 ++++++++
 4 files changed, 42 insertions(+)

diff --git a/Documentation/arm/uefi.txt b/Documentation/arm/uefi.txt
index d60030a..5f86eae 100644
--- a/Documentation/arm/uefi.txt
+++ b/Documentation/arm/uefi.txt
@@ -60,5 +60,8 @@ linux,uefi-mmap-desc-ver  | 32-bit | Version of the mmap descriptor format.
 --------------------------------------------------------------------------------
 linux,uefi-stub-kern-ver  | string | Copy of linux_banner from build.
 --------------------------------------------------------------------------------
+linux,uefi-stub-generated-dtb  | bool | Indication for no DTB provided by
+			       |      | firmware.
+--------------------------------------------------------------------------------
 
 For verbose debug messages, specify 'uefi_debug' on the kernel command line.
diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 496c33b..9fcf632 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -49,6 +49,7 @@ static inline void arch_fix_phys_package_id(int num, u32 slot) { }
 
 #else
 static inline void disable_acpi(void) { }
+static inline void enable_acpi(void) { }
 #endif /* CONFIG_ACPI */
 
 #endif /*_ASM_ACPI_H*/
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index fc4fb7b..510a681 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -371,6 +371,29 @@ static void __init request_standard_resources(void)
 	}
 }
 
+static int __init dt_scan_chosen(unsigned long node, const char *uname,
+			int depth, void *data)
+{
+	const char *p;
+
+	if (depth != 1 || !data || (strcmp(uname, "chosen") != 0))
+		return 0;
+
+	p = of_get_flat_dt_prop(node, "linux,uefi-stub-generated-dtb", NULL);
+	*(bool *)data = p ? true : false;
+
+	return 1;
+}
+
+static bool __init is_uefi_stub_generated_dtb(void)
+{
+	bool flag = false;
+
+	of_scan_flat_dt(dt_scan_chosen, &flag);
+
+	return flag;
+}
+
 u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
 
 void __init setup_arch(char **cmdline_p)
@@ -399,6 +422,13 @@ void __init setup_arch(char **cmdline_p)
 	parse_early_param();
 
 	/*
+	 * If no dtb provided by firmware, enable ACPI and give system a
+	 * chance to boot with ACPI configuration data
+	 */
+	if (is_uefi_stub_generated_dtb() && acpi_disabled)
+		enable_acpi();
+
+	/*
 	 *  Unmask asynchronous aborts after bringing up possible earlycon.
 	 * (Report possible System Errors once we can report this occurred)
 	 */
diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index c846a96..3777d50 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -154,6 +154,14 @@ efi_status_t update_fdt(efi_system_table_t *sys_table, void *orig_fdt,
 	if (status)
 		goto fdt_set_fail;
 
+	/* Add a property to show the dtb is generated by uefi stub */
+	if (!orig_fdt) {
+		status = fdt_setprop(fdt, node,
+				     "linux,uefi-stub-generated-dtb", NULL, 0);
+		if (status)
+			goto fdt_set_fail;
+	}
+
 	return EFI_SUCCESS;
 
 fdt_set_fail:
-- 
1.9.1

