From: Josh Triplett <josh@joshtriplett.org>
Subject: [PATCHv3 1/4] efi: Add a stub for efi_enter_virtual_mode on non-x86
Date: Sat, 8 Sep 2012 15:06:49 -0700
Message-ID: <993c7f2ee7d53cc480280653a7df500db0882342.1347141698.git.josh@joshtriplett.org>
References: <cover.1347141698.git.josh@joshtriplett.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1347141698.git.josh@joshtriplett.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Len Brown <lenb@kernel.org>, Matt Fleming <matt.fleming@intel.com>, Olof Johansson <olof@lixom.net>, Matthew Garrett <mjg@redhat.com>, David Howells <dhowells@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>, Jim Cromie <jim.cromie@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This eliminates an ifdef in init/main.c.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 include/linux/efi.h |    4 ++++
 init/main.c         |    2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index ec45ccd..52fbedf 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -495,7 +495,11 @@ extern void *efi_get_pal_addr (void);
 extern void efi_map_pal_code (void);
 extern void efi_memmap_walk (efi_freemem_callback_t callback, void *arg);
 extern void efi_gettimeofday (struct timespec *ts);
+#ifdef CONFIG_X86
 extern void efi_enter_virtual_mode (void);	/* switch EFI to virtual mode, if possible */
+#else
+static void efi_enter_virtual_mode(void) {}
+#endif
 extern u64 efi_get_iobase (void);
 extern u32 efi_mem_type (unsigned long phys_addr);
 extern u64 efi_mem_attributes (unsigned long phys_addr);
diff --git a/init/main.c b/init/main.c
index b286730..ebb1ba5 100644
--- a/init/main.c
+++ b/init/main.c
@@ -602,10 +602,8 @@ asmlinkage void __init start_kernel(void)
 	calibrate_delay();
 	pidmap_init();
 	anon_vma_init();
-#ifdef CONFIG_X86
 	if (efi_enabled)
 		efi_enter_virtual_mode();
-#endif
 	thread_info_cache_init();
 	cred_init();
 	fork_init(totalram_pages);
-- 
1.7.10.4
