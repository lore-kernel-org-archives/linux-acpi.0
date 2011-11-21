From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/2] ACPICA: support Generic Address Structure
	bit_offset in acpi_read/write
Date: Mon, 21 Nov 2011 10:08:24 +0000
Message-ID: <20111121100824.GP9581@n2100.arm.linux.org.uk>
References: <20111111230347.20897.28797.stgit@bhelgaas.mtv.corp.google.com> <201111172127.40664.rjw@sisk.pl> <1321578279.13860.108.camel@yhuang-dev> <201111181025.58650.rjw@sisk.pl> <1321861880.13860.128.camel@yhuang-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52414 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754611Ab1KUKJN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Nov 2011 05:09:13 -0500
Content-Disposition: inline
In-Reply-To: <1321861880.13860.128.camel@yhuang-dev>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Tony Luck <tony.luck@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "bondd@us.ibm.com" <bondd@us.ibm.com>, Myron Stowe <myron.stowe@redhat.com>

On Mon, Nov 21, 2011 at 03:51:20PM +0800, Huang Ying wrote:
> On Fri, 2011-11-18 at 17:25 +0800, Rafael J. Wysocki wrote:
> > On Friday, November 18, 2011, Huang Ying wrote:
> > > Take a look at ARM ioremap implementation.  It appears that RAM can be
> > > ioremaped on ARM.  But this changes should be harmless for ARM too.
> > > Because ioremap implementation is different between different
> > > architecture, maybe we should use #ifdef CONFIG_X86, #endif to enclose
> > > the code?

I think you're wrong there.

void __iomem * __arm_ioremap_pfn_caller(unsigned long pfn,
        unsigned long offset, size_t size, unsigned int mtype, void *caller)
{
...
        /*
         * Don't allow RAM to be mapped - this causes problems with ARMv6+
         */
        if (WARN_ON(pfn_valid(pfn)))
                return NULL;

While we don't exhaustively check, this catches most offenders trying to
use ioremap() on system RAM.

> > Well, that would be a bit hackish, wouldn't it?
> > 
> > If the code is going to work on all architectures that _may_ use it in the
> > future (x86, ARM, ia64 so far), there's no reason to change it.  My question
> > was whether or not you double checked that.
> 
> Take a look at the page_is_ram() implementation and ioremap()
> implementation for ARM and ia64.  It appears that the patch should work
> on these architecture.  Add Tony and Russell to loop to confirm it.

Even though I've not heard of anyone wanting to use ACPI on ARM, I'm not
worried at all about this.  However, it does look harmless for ARM even
if someone wanted to use ACPI (and in any case kmapping RAM is much better
than ioremapping it.)
