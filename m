From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 1/2] RFC: Prepare PAD for native and xen platform
Date: Sun, 26 Feb 2012 12:34:58 -0500
Message-ID: <20120226173458.GB18098@phenom.dumpdata.com>
References: <DE8DF0795D48FD4CA783C40EC82923350AD088@SHSMSX101.ccr.corp.intel.com>
 <4F46530B020000780007F751@nat28.tlf.novell.com>
 <DE8DF0795D48FD4CA783C40EC82923350AD9BB@SHSMSX101.ccr.corp.intel.com>
 <DE8DF0795D48FD4CA783C40EC82923350B2013@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:49068 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838Ab2BZRii (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 26 Feb 2012 12:38:38 -0500
Content-Disposition: inline
In-Reply-To: <DE8DF0795D48FD4CA783C40EC82923350B2013@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Liu, Jinsong" <jinsong.liu@intel.com>
Cc: Jan Beulich <jbeulich@suse.com>, "keir.xen@gmail.com" <keir.xen@gmail.com>, "Brown, Len" <len.brown@intel.com>, "Li, Shaohua" <shaohua.li@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sun, Feb 26, 2012 at 08:25:41AM +0000, Liu, Jinsong wrote:
> Liu, Jinsong wrote:
> > Jan Beulich wrote:
> >>>>> "Liu, Jinsong" <jinsong.liu@intel.com> 02/23/12 2:29 PM >>>
> >>> --- a/drivers/acpi/Kconfig
> >>> +++ b/drivers/acpi/Kconfig
> >>> @@ -213,10 +213,11 @@ config ACPI_HOTPLUG_CPU
> >>>    default y
> >>  >
> >>> config ACPI_PROCESSOR_AGGREGATOR
> >>> -    tristate "Processor Aggregator"
> >>> +    bool "Processor Aggregator"
> >> 
> >> There must be ways to address whatever strange problem you see
> >> without making this piece of code non-modular.
> >> 
> > 
> > Yes, another approach is x86_init approach, defining acpi_pad_ops at
> > x86_init.c and overwritten when xen_start_kernel. This patch is just
> > a RFC patch, to evaluate which approch is more reasonable :-) 
> > 
> 
> Have a more think about it, x86_init approach still need to disable acpi_pad module.
> Seems we have to set acpi_pad as bool, as long as it need to hook to native acpi_pad fucs/variables.

What about the other approach I suggested where there are some function
overrides in osl.c? Something similar to https://lkml.org/lkml/2012/1/17/401,
specifically https://lkml.org/lkml/2012/1/17/403 - that way you are not turning
the modules into being built in, but intead have the function table already in
the kernel (as some form of EXPORT_SYMBOL_GPL or a registration function).

Instead of just one function being over-ridden it could have some more. However
I am not sure if the osl.c is the place for this either. Perhaps Len might
have some better ideas?

