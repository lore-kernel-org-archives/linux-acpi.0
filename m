From: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Subject: Re: [Xen-devel] [PATCH 2/3] x86/acpi: take rsdp address for boot
 params if available
Date: Tue, 28 Nov 2017 10:48:38 +0000
Message-ID: <20171128104838.yke4zlgs45gieprj@MacBook-Pro-de-Roger.local>
References: <20171128094400.25955-1-jgross@suse.com>
 <20171128094400.25955-3-jgross@suse.com>
 <20171128101834.fmiqygqpfh6wxrvv@MacBook-Pro-de-Roger.local>
 <072e88ef-dd61-8b7d-026a-5966b13ffed9@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <072e88ef-dd61-8b7d-026a-5966b13ffed9@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, corbet@lwn.net, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, boris.ostrovsky@oracle.com, tglx@linutronix.de, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 28, 2017 at 11:30:15AM +0100, Juergen Gross wrote:
> On 28/11/17 11:18, Roger Pau Monné wrote:
> > On Tue, Nov 28, 2017 at 10:43:59AM +0100, Juergen Gross wrote:
> >> In case the rsdp address in struct boot_params is specified don't try
> >> to find the table by searching, but take the address directly as set
> >> by the boot loader.
> >>
> >> Signed-off-by: Juergen Gross <jgross@suse.com>
> >> ---
> >>  drivers/acpi/osl.c | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >>
> >> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> >> index 3bb46cb24a99..3b25e2ad7d75 100644
> >> --- a/drivers/acpi/osl.c
> >> +++ b/drivers/acpi/osl.c
> >> @@ -45,6 +45,10 @@
> >>  #include <linux/uaccess.h>
> >>  #include <linux/io-64-nonatomic-lo-hi.h>
> >>  
> >> +#ifdef CONFIG_X86
> >> +#include <asm/setup.h>
> >> +#endif
> >> +
> >>  #include "internal.h"
> >>  
> >>  #define _COMPONENT		ACPI_OS_SERVICES
> >> @@ -195,6 +199,10 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
> >>  	if (acpi_rsdp)
> >>  		return acpi_rsdp;
> >>  #endif
> >> +#ifdef CONFIG_X86
> >> +	if (boot_params.hdr.acpi_rsdp_addr)
> >> +		return boot_params.hdr.acpi_rsdp_addr;
> >> +#endif
> > 
> > I'm struggling to figure out how was PVH getting the RSDP previously,
> > because that should be removed now that it's in the zero-page.
> 
> I don't think it should be removed, because this was the legacy case
> (searching through memory). It was pure luck that Xen put it at the
> right location.

Oh, right. This is working out of pure luck then.

Thanks, Roger.
