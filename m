From: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: WDRT based watchdog timer
Date: Tue, 14 Oct 2008 22:40:34 +0200
Message-ID: <20081014204034.GF30246@infomag.infomag.iguana.be>
References: <20080926232752.GA6061@cosmic.amd.com> <alpine.LFD.1.10.0810081552220.3041@localhost.localdomain> <20081008204422.GA2932@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailrelay002.isp.belgacom.be ([195.238.6.175]:16836 "EHLO
	mailrelay002.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751860AbYJNUki (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Oct 2008 16:40:38 -0400
Content-Disposition: inline
In-Reply-To: <20081008204422.GA2932@cosmic.amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Marc Brooker <mbrooker@rrsg.ee.uct.ac.za>

Hi Jordan,

> > > Attached is a patch to support watchdog timers as described
> > > by the WDRT (Watch Dog Resource Table).  This has been tested on
> > > the AMD SB600 chipset, but it should work for any chipset / BIOS
> > > that implements the WDRT table.
> > > 
> > > I'm not in love with the name - but I couldn't think of anything
> > > better, so I'm open to suggestions.  I have a limited number of
> > > systems that implement this interface, so I would be very happy
> > > to hear from other users, especially ones not using AMD chipsets.
> > 
> > While this driver depends on ACPI, it actually isn't part of ACPI.
> > 
> > Indeed, here is 100% of the ACPI spec support for this watchdog timer:
> > 
> > "WDRT" Watchdog Resource Table Watchdog Timer Hardware Requirements for
> >                                Windows Server 2003
> >                                http://www.microsoft.com/whdc/system/CEC/
> >                                watchdog.mspx
> > 
> > so while the driver uses ACPI to enumerate the device,
> > the device doesn't use any run-time ACPI support,
> > and the Windows spec above actually defines the hardware.
> > 
> > > drivers/watchdog/acpiwdt.c
> > 
> > I'm not wild about having the string "acpi" be part of the driver name,
> > config option, variable names etc.   Maybe the spec above which actually
> > defines the timer would suggest a better name; or maybe simply
> > name it after its configuration table, wrdt.c?
> 
> yeah - the string 'acpi' concerned as well.  I didn't want to really
> call it win2k3wdt.c, though. :). 

wdrt.c would indeed be better then (I agree with Len's comment about ACPI).
Can you change the code and the documentation (Kconfig) so that it is clear that
this is about the Watchdog Resource Table Watchdog Timer and not about an ACPI
WATCHDOG.

Furthermore:

> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -249,6 +249,16 @@ config BFIN_WDT
> 
>  # X86 (i386 + ia64 + x86_64) Architecture
> 
> +config ACPI_WDT
> +	tristate "ACPI WDRT Watchdog Timer"
> +	depends on X86 && ACPI

The tristate description is what I like to see changed.

> +	---help---
> +	  This driver supports hardware watchdog timer implementations
> +	  described by the Watchdog Resource Table (WDRT) ACPI table.
> +

Ok for me.

> +	  To compile this driver as a module, choose M here: the
> +	  module will be called acpiwdt.

acpiwdt should be wdrt then.

...
> +obj-$(CONFIG_ACPI_WDT) += acpiwdt.o
...

same here.

> diff --git a/drivers/watchdog/acpiwdt.c b/drivers/watchdog/acpiwdt.c
> new file mode 100644
> index 0000000..b6bcd52
> --- /dev/null
> +++ b/drivers/watchdog/acpiwdt.c
> @@ -0,0 +1,338 @@

same here.

> +static u32 wdt_flags;

Can you make this an unsigned long so that we don't get warnings.

> +static void __exit acpiwdt_exit(void)
> +{
> +	iounmap(wdt_ctrl_reg);
> +	iounmap(wdt_count_reg);
> +
> +	misc_deregister(&acpiwdt_miscdev);
> +}

You should do the misc_deregister before the iounmap's (so first disable
user_space access and then unmap the io-area).

I would also add spin_lock'ing for the ping and disable routines.
This to avoid problems with forked children from the same program
that opened /dev/watchdog.

For the rest it seems ok to me.

Kind regards,
Wim.



