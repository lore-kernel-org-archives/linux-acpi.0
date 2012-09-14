From: Matt Fleming <matt.fleming@intel.com>
Subject: Re: [PATCHv3 0/4] Fix ACPI BGRT support for images located in EFI
 boot services memory
Date: Fri, 14 Sep 2012 13:46:32 +0100
Message-ID: <1347626792.14222.1.camel@mfleming-mobl1.ger.corp.intel.com>
References: <cover.1347141698.git.josh@joshtriplett.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:5548 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752335Ab2INMqo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 14 Sep 2012 08:46:44 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so3509128wgb.1
        for <linux-acpi@vger.kernel.org>; Fri, 14 Sep 2012 05:46:43 -0700 (PDT)
In-Reply-To: <cover.1347141698.git.josh@joshtriplett.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Len Brown <lenb@kernel.org>, Olof Johansson <olof@lixom.net>, Matthew Garrett <mjg@redhat.com>, David Howells <dhowells@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-acpi@vger.kernel.org

On Sat, 2012-09-08 at 15:06 -0700, Josh Triplett wrote:
> The ACPI BGRT lets the OS access the BIOS logo image and its position on the
> screen at boot time, allowing it to maintain that image on the screen until
> ready to display something else, making boot more seamless.  This series fixes
> support for accessing the boot logo image via the BGRT when the BIOS stores it
> in EFI boot services memory, as recommended by the ACPI 5.0 spec.  Linux needs
> to copy the image out of boot services memory before reclaiming boot services
> memory.
> 
> The first patch cleans up the existing x86-specific efi_enter_virtual_mode
> function to have a stub version on non-x86 platforms, to eliminate an ifdef in
> init/main.c.   The second patch refactors EFI initialization to defer freeing
> boot services memory until much later in the boot process, and in particular
> until after we have ACPI available.  The third patch adds a helper function to
> look up existing EFI boot services mappings, to avoid re-mapping them.  The
> fourth patch moves BGRT initialization to before the reclamation of boot
> services memory, copies the logo at that point, and reworks the existing BGRT
> driver to use that existing copy.
> 
> v2: Made the new internal function efi_unmap_memmap static.  Incorporated
>     feedback from H. Peter Anvin and Matt Fleming: added stubs for
>     x86-specific EFI functions called from init/main.c to eliminate the
>     corresponding ifdefs in start_kernel; deferred
>     efi_free_boot_services even later, to just before free_initmem.
> 
> v3: Moved efi_free_boot_services back to right after EFI initialization, to
>     avoid a WARN from check_early_ioremap_leak about not calling
>     early_iounmap soon enough.
> 
> Josh Triplett (4):
>   efi: Add a stub for efi_enter_virtual_mode on non-x86
>   efi: Defer freeing boot services memory until after ACPI init
>   efi: Add a function to look up existing IO memory mappings
>   efi: Fix the ACPI BGRT driver for images located in EFI boot services
>     memory

I thought I'd replied to this but I can't find it anywhere. I think my
MUA ate my ACK.

Acked-by: Matt Fleming <matt.fleming@intel.com>

