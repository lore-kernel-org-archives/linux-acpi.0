From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 2/3] x86/acpi: take rsdp address for boot params if
 available
Date: Fri, 8 Dec 2017 08:05:05 +0100
Message-ID: <20171208070505.25j6dtun555v6ofo@gmail.com>
References: <20171207122821.30158-1-jgross@suse.com>
 <20171207122821.30158-3-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35323 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751068AbdLHHFK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Dec 2017 02:05:10 -0500
Content-Disposition: inline
In-Reply-To: <20171207122821.30158-3-jgross@suse.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, corbet@lwn.net, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org


* Juergen Gross <jgross@suse.com> wrote:

> In case the rsdp address in struct boot_params is specified don't try
> to find the table by searching, but take the address directly as set
> by the boot loader.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  drivers/acpi/osl.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 3bb46cb24a99..3b25e2ad7d75 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -45,6 +45,10 @@
>  #include <linux/uaccess.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  
> +#ifdef CONFIG_X86
> +#include <asm/setup.h>
> +#endif
> +
>  #include "internal.h"
>  
>  #define _COMPONENT		ACPI_OS_SERVICES
> @@ -195,6 +199,10 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
>  	if (acpi_rsdp)
>  		return acpi_rsdp;
>  #endif
> +#ifdef CONFIG_X86
> +	if (boot_params.hdr.acpi_rsdp_addr)
> +		return boot_params.hdr.acpi_rsdp_addr;
> +#endif

Argh, that's typical short sighted hackery, layering violations and general 
eyesore combined into a single patch ...

Those #ifdefs are a disgrace, plus why should generic ACPI code include platform 
details like boot_params.hdr/acpi_rsdp_addr? It's also not very extensible to 
non-x86 - so someone will have to redo this work for ARM64 as well in the future 
...

So how about doing it right:

1)

Add a __weak acpi_arch_get_root_pointer() __weak function to drivers/acpi/osl.c:


__weak acpi_physical_address acpi_arch_get_root_pointer(void)
{
	return 0;
}

2)

use it in acpi_os_get_root_pointer():

	...
	pa = acpi_arch_get_root_pointer();
	if (pa)
		return pa;
	...

3)

Override the default variant in x86's acpi.c via something like:

acpi_physical_address acpi_arch_get_root_pointer(void)
{
	return boot_params.hdr.acpi_rsdp_addr;
}

4)

Add this to arch/x86/include/asm/acpi.h:

extern acpi_physical_address acpi_arch_get_root_pointer(void);

5)

Add #include <asm/acpi.h> to drivers/acpi/osl.c.


That looks much cleaner, has no layering violations and is infinitely more 
extensible, right?

Thanks,

	Ingo
