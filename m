From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH 2.6.28-rc6] ACPICA: don't cond_resched() when
	irqs_disabled()
Date: Sat, 20 Dec 2008 08:28:42 +0800
Message-ID: <20081220002842.GB5928@localhost>
References: <20081126135508.GA1891@localhost> <alpine.LFD.2.00.0812190016120.6312@localhost.localdomain> <1229670120.3990.11.camel@yakui_zhao.sh.intel.com> <alpine.LFD.2.00.0812190326000.6312@localhost.localdomain> <20081219110145.GA14076@localhost> <alpine.LFD.2.00.0812191322110.3745@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:14568 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751647AbYLTA25 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Dec 2008 19:28:57 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0812191322110.3745@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Zhao, Yakui" <yakui.zhao@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, "Li, Shaohua" <shaohua.li@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Sitsofe Wheeler <sitsofe@yahoo.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, "stable@kernel.org" <stable@kernel.org>


[re-add original CC list]

On Fri, Dec 19, 2008 at 08:24:25PM +0200, Len Brown wrote:
>
> On Fri, 19 Dec 2008, Wu Fengguang wrote:
>
> > Hi Len,
> >
> > FYI: this patch from Lin Ming will generate the following messages:
> >
> > on closing lid =>
> >
> > [ 8993.764829] irq status before SMI: enable
> > [ 8993.768028] irq status after SMI: disable, value: 0xF3
> >
> > on opening lid =>
> >
> > [ 8987.590636] irq status before SMI: enable
> > [ 8987.669829] irq status after SMI: enable, value: 0xF3
> >
> > ---
> >  drivers/acpi/executer/exregion.c |   12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > --- linux-2.6.orig/drivers/acpi/executer/exregion.c
> > +++ linux-2.6/drivers/acpi/executer/exregion.c
> > @@ -300,8 +300,20 @@ acpi_ex_system_io_space_handler(u32 func
> >
> >  	case ACPI_WRITE:
> >
> > +		if (address == 0xB2) {
> > +			printk("irq status before SMI: %s\n",
> > +				irqs_disabled() ? "disable" : "enable");
> > +		}
> > +
> >  		status = acpi_os_write_port((acpi_io_address) address,
> >  					    (u32) * value, bit_width);
> > +
> > +		if (address == 0xB2) {
> > +			printk("irq status after SMI: %s, value: 0x%X\n",
> > +				irqs_disabled() ? "disable" : "enable",
> > +				(u32) *value);
> > +		}
> > +
> >  		break;
> >
> >  	default:
> >
> > We are now exploring how the Windows execution path manages to avoid this bug.
>
> sigh.
>
> It might be prudent for us to WARN_ON() the IRQ state
> being different before and after any IO write -- in case
> others are running into this too.

Sure, so it serves as a internal debug patch.

