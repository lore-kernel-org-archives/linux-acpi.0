From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 2/3] x86/acpi: take rsdp address for boot params if
 available
Date: Fri, 8 Dec 2017 12:26:43 +0100
Message-ID: <20171208112643.iiov5ztp7eq43hh7@gmail.com>
References: <20171207122821.30158-1-jgross@suse.com>
 <20171207122821.30158-3-jgross@suse.com>
 <20171208070505.25j6dtun555v6ofo@gmail.com>
 <48be541f-bc28-b7e1-3b5b-6ac1cbe62150@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36322 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753280AbdLHL0r (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Dec 2017 06:26:47 -0500
Content-Disposition: inline
In-Reply-To: <48be541f-bc28-b7e1-3b5b-6ac1cbe62150@suse.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, corbet@lwn.net, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org


* Juergen Gross <jgross@suse.com> wrote:

> On 08/12/17 08:05, Ingo Molnar wrote:
> > 
> > * Juergen Gross <jgross@suse.com> wrote:
> 
> ...
> 
> > acpi_physical_address acpi_arch_get_root_pointer(void)
> > {
> > 	return boot_params.hdr.acpi_rsdp_addr;
> > }
> > 
> > 4)
> > 
> > Add this to arch/x86/include/asm/acpi.h:
> > 
> > extern acpi_physical_address acpi_arch_get_root_pointer(void);
> 
> Uuh, this leads to problems for files including <asm/acpi.h> directly:
> acpi_physical_address won't be defined, and including <acpi/actypes.h>
> from arch/x86/include/asm/acpi.h will lead to:
> 
> #error unknown ACPI_MACHINE_WIDTH
> 
> This can only be avoided by including <linux/acpi.h> from <asm/acpi.h>
> which seems to be the wrong layering.
> 
> So I could:
> 
> a) modify the sources including <asm/acpi.h> to use <linux/acpi.h>
>    instead
> b) don't use acpi_physical_address but either u64 or unsigned long.
> c) ?
> 
> What would be your preference?

Would it help if you put the prototype into linux/acpi.h perhaps? It's a generic 
facility in principle, even if only used by x86 at the moment.

Thanks,

	Ingo
