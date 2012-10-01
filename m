From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv3 1/4] efi: Add a stub for efi_enter_virtual_mode on non-x86
Date: Mon, 1 Oct 2012 20:28:32 +0000
Message-ID: <201210012028.32710.arnd@arndb.de>
References: <cover.1347141698.git.josh@joshtriplett.org> <993c7f2ee7d53cc480280653a7df500db0882342.1347141698.git.josh@joshtriplett.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:64692 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252Ab2JAU2l (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Oct 2012 16:28:41 -0400
In-Reply-To: <993c7f2ee7d53cc480280653a7df500db0882342.1347141698.git.josh@joshtriplett.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Len Brown <lenb@kernel.org>, Matt Fleming <matt.fleming@intel.com>, Olof Johansson <olof@lixom.net>, Matthew Garrett <mjg@redhat.com>, David Howells <dhowells@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>, Jim Cromie <jim.cromie@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-acpi@vger.kernel.org

On Saturday 08 September 2012, Josh Triplett wrote:
> +#ifdef CONFIG_X86
>  extern void efi_enter_virtual_mode (void);     /* switch EFI to virtual mode, if possible */
> +#else
> +static void efi_enter_virtual_mode(void) {}
> +#endif

This has suddenly appeared in linux-next now and is causing warnings.

8<---
efi: fix prototype for API stubs

Some functions in the efi API have recently been added as versions for non-x86,
but are missing an "inline" keyword, which causes these warnings:

include/linux/efi.h:503:13: error: 'efi_enter_virtual_mode' defined but not used [-Werror=unused-function]
include/linux/efi.h:504:13: error: 'efi_late_init' defined but not used [-Werror=unused-function]
include/linux/efi.h:505:13: error: 'efi_free_boot_services' defined but not used [-Werror=unused-function]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 798bd1d..58f31c3 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -500,9 +500,9 @@ extern void efi_enter_virtual_mode (void);	/* switch EFI to virtual mode, if pos
 extern void efi_late_init(void);
 extern void efi_free_boot_services(void);
 #else
-static void efi_enter_virtual_mode(void) {}
-static void efi_late_init(void) {}
-static void efi_free_boot_services(void) {}
+static inline void efi_enter_virtual_mode(void) {}
+static inline void efi_late_init(void) {}
+static inline void efi_free_boot_services(void) {}
 #endif
 extern void __iomem *efi_lookup_mapped_addr(u64 phys_addr);
 extern u64 efi_get_iobase (void);
