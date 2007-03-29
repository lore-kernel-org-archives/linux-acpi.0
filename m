From: Len Brown <lenb@kernel.org>
Subject: Re: WMI vs Linux
Date: Wed, 28 Mar 2007 22:49:55 -0400
Message-ID: <200703282249.55965.lenb@kernel.org>
References: <AD1781A3B7BFE44DA675CBF72E984D9902D1E144@daebe102.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45567 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965914AbXC2CvV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Mar 2007 22:51:21 -0400
In-Reply-To: <AD1781A3B7BFE44DA675CBF72E984D9902D1E144@daebe102.NOE.Nokia.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: jamey.hicks@nokia.com, linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>

On Wednesday 28 March 2007 17:55, Jamey wrote:
> 
> The patch was designed for the HP TC1100 tablet computer. It has a
> builtin Wifi module whose power supply is controlled via WMI. The state
> is persistent across reboots, but I was not happy needing to have a
> Windows partition just to turn Wifi and Bluetooth on and off. Actually,
> I did not care about Bluetooth but I wanted to ensure Wifi was on. That
> part of the driver seems to work.
>
> Also, I could not find a good way to detect that it was a TC1100.

yeah, this is a problem -- as it stands (stood) the driver binds
as a generic WMI driver...

> Perhaps it should probe for PNP0C14 and the WACF005 and unload itself if
> those are not both present. Given the total lack of response I got when
> I sent that patch to LKML, I was quite amused to find it running on all
> sorts of machines because it was picked up by some distributions (e.g.,
> Mandrake, Ubuntu).

It is no longer possible to shock me with what some distros ship...

> And because of the aforementioned lack of 
> identifiers, the driver stays loaded on all sorts of machines.
> Fortunately it is rather small. If you have any suggestions, I'm willing
> to update it.
> 
> I would pretty much have to agree that WMI is unfriendly.  I had the
> spec for WMI for some of the HP laptops, NC4000 I think, but I couldn't
> really do much with it. The NC4000 ACPI seemed to be totally different
> from the TC1100 one.
> 
> But I guess this driver is one instance where Linux is able to use the
> WMI stuff.

Well, you did more with WMI than I thought would be possible on Linux.

I think at a minimum, we should have a small driver upstream that
binds on PNP0C14, spits out a message that the system has Windows
proprietary firmware extensions, and acts as a place where folks
who care about WMI them can try to hack together something useful...

> Matthew wrote:

> It would be helpful to export as much WMI information as possible - we 
> can supply information to utilise it via HAL, which would at least 
> provide support for doing things like poking the wireless and bluetooth 
> hardware on the old HP tablets.
> 
> I agree that WMI functionality is generally a bad sign, but where we can 
> drive it I think we probably should be.

Well, if you think you can do something useful with it...
My only request is that the source not live in drivers/acpi/ --
I'd rather it live with the platform specific drivers that use ACPI,
eg. drivers/misc/wmi.c  You think?
 
> > ps. while you're at it, what is the WACF005 Wacom Digitizer device also in the patch --
> > I don't see that upstream either.
> 
> It's handled by 8250_pnp.c now.

good to know.

So, do we have a volunteer to cobble together an upstream wmi.c?

thanks,
-Len




