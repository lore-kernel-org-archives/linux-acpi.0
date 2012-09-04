From: Matt Fleming <matt.fleming@intel.com>
Subject: Re: [PATCH 0/3] Fix ACPI BGRT support for images located in EFI
 boot services memory
Date: Tue, 04 Sep 2012 15:27:20 +0100
Message-ID: <1346768840.4244.52.camel@mfleming-mobl1.ger.corp.intel.com>
References: <cover.1346361959.git.josh@joshtriplett.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:43650 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757207Ab2IDO1b (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Sep 2012 10:27:31 -0400
Received: by pbbrr13 with SMTP id rr13so9562795pbb.19
        for <linux-acpi@vger.kernel.org>; Tue, 04 Sep 2012 07:27:30 -0700 (PDT)
In-Reply-To: <cover.1346361959.git.josh@joshtriplett.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Len Brown <lenb@kernel.org>, Olof Johansson <olof@lixom.net>, Matthew Garrett <mjg@redhat.com>, David Howells <dhowells@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>, Jim Cromie <jim.cromie@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Pawel Moll <pawel.moll@arm.com>, linux-acpi@vger.kernel.org, linux-efi <linux-efi@vger.kernel.org>

On Thu, 2012-08-30 at 14:28 -0700, Josh Triplett wrote:
> The ACPI BGRT lets the OS access the BIOS logo image and its position on the
> screen at boot time, allowing it to maintain that image on the screen until
> ready to display something else, making boot more seamless.  This series fixes
> support for accessing the boot logo image via the BGRT when the BIOS stores it
> in EFI boot services memory, as recommended by the ACPI 5.0 spec.  Linux needs
> to copy the image out of boot services memory before reclaiming boot services
> memory.
> 
> The first patch refactors EFI initialization to defer freeing boot services
> memory until later in the boot process, after we have ACPI available.  The
> second patch adds a helper function to look up existing EFI boot services
> mappings, to avoid re-mapping them.  The third patch moves BGRT initialization
> to before the reclamation of boot services memory, copies the logo at that
> point, and reworks the existing BGRT driver to use that existing copy.

Since we always end up doing a copy anyway, is there no way we could
just copy the boot logo *without* deferring freeing the boot services
code, e.g. move the copy before we do SetVirtualAddressMap()? I wouldn't
be surprised if some implementations got really cranky if we accessed
boot services data after we installed a new virtual memory map.

Besides, if we can avoid moving the efi_free_boot_services() call we can
avoid littering init/main.c with more #ifdef CONFIG_X86 blocks.

