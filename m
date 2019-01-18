From: Kairui Song <kasong@redhat.com>
Subject: [PATCH v3 3/3] x86, kexec_file_load: make it work with efi=noruntime or efi=old_map
Date: Fri, 18 Jan 2019 19:13:10 +0800
Message-ID: <20190118111310.29589-4-kasong@redhat.com>
References: <20190118111310.29589-1-kasong@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190118111310.29589-1-kasong@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org, dyoung@redhat.com, bhe@redhat.com, kexec@lists.infradead.org, akpm@linux-foundation.org, robert.moore@intel.com, erik.schmauss@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, fanc.fnst@cn.fujitsu.com, linux-acpi@vger.kernel.org, Kairui Song <kasong@redhat.com>
List-Id: linux-acpi@vger.kernel.org

When efi=noruntime or efi=oldmap is used, EFI services won't be available
in the second kernel, therefore the second kernel will not be able to get
the ACPI RSDP address from firmware by calling EFI services and won't
boot. Previously we are expecting the user to set the acpi_rsdp=<addr>
on kernel command line for second kernel as there was no way to pass RSDP
address to second kernel.

After commit e6e094e053af ('x86/acpi, x86/boot: Take RSDP address from
boot params if available'), now it's possible to set an acpi_rsdp_addr
parameter in the boot_params passed to second kernel, this commit makes
use of it, detect and set the RSDP address when it's required for second
kernel to boot.

Tested with an EFI enabled KVM VM with efi=noruntime.

Suggested-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Kairui Song <kasong@redhat.com>
---
 arch/x86/kernel/kexec-bzimage64.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 097f52fb02e3..63101b2194fb 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -20,6 +20,7 @@
 #include <linux/mm.h>
 #include <linux/efi.h>
 #include <linux/verification.h>
+#include <linux/acpi.h>
 
 #include <asm/bootparam.h>
 #include <asm/setup.h>
@@ -255,8 +256,17 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
 	/* Setup EFI state */
 	setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
 			efi_setup_data_offset);
+
+#ifdef CONFIG_ACPI
+	/* Setup ACPI RSDP pointer in case EFI is not available in second kernel */
+	if (!acpi_disabled && (!efi_enabled(EFI_RUNTIME_SERVICES) || efi_enabled(EFI_OLD_MEMMAP))) {
+		params->acpi_rsdp_addr = acpi_os_get_root_pointer_late();
+		if (!params->acpi_rsdp_addr)
+			pr_warn("RSDP is not available for second kernel\n");
+	}
 #endif
 
+#endif
 	/* Setup EDD info */
 	memcpy(params->eddbuf, boot_params.eddbuf,
 				EDDMAXNR * sizeof(struct edd_info));
-- 
2.20.1
