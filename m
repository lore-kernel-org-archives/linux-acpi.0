From: Kairui Song <kasong@redhat.com>
Subject: [PATCH v3 1/3] x86, kexec_file_load: Don't setup EFI info if EFI runtime is not enabled
Date: Fri, 18 Jan 2019 19:13:08 +0800
Message-ID: <20190118111310.29589-2-kasong@redhat.com>
References: <20190118111310.29589-1-kasong@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190118111310.29589-1-kasong@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org, dyoung@redhat.com, bhe@redhat.com, kexec@lists.infradead.org, akpm@linux-foundation.org, robert.moore@intel.com, erik.schmauss@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, fanc.fnst@cn.fujitsu.com, linux-acpi@vger.kernel.org, Kairui Song <kasong@redhat.com>
List-Id: linux-acpi@vger.kernel.org

Currently with "efi=noruntime" in kernel command line, calling
kexec_file_load will raise below problem:

[   97.967067] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
[   97.967894] #PF error: [normal kernel read fault]
...
[   97.980456] Call Trace:
[   97.980724]  efi_runtime_map_copy+0x28/0x30
[   97.981267]  bzImage64_load+0x688/0x872
[   97.981794]  arch_kexec_kernel_image_load+0x6d/0x70
[   97.982441]  kimage_file_alloc_init+0x13e/0x220
[   97.983035]  __x64_sys_kexec_file_load+0x144/0x290
[   97.983586]  do_syscall_64+0x55/0x1a0
[   97.983962]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

When efi runtime is not enabled, efi memmap is not mapped, so just skip
EFI info setup.

Suggested-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Kairui Song <kasong@redhat.com>
---
 arch/x86/kernel/kexec-bzimage64.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 2c007abd3d40..097f52fb02e3 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -167,6 +167,9 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
 	struct efi_info *current_ei = &boot_params.efi_info;
 	struct efi_info *ei = &params->efi_info;
 
+	if (!efi_enabled(EFI_RUNTIME_SERVICES))
+		return 0;
+
 	if (!current_ei->efi_memmap_size)
 		return 0;
 
-- 
2.20.1
