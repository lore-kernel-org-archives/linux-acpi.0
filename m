From: Stelian Pop <stelian.pop-A5NNTvo2L0pl57MIdRCFDg@public.gmane.org>
Subject: Re: [ACPI] RE: [PATCH] Allow others to use ACPI EC interface
Date: Fri, 22 Nov 2002 14:36:43 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20021122133643.GA2224@tahoe.alcove-fr>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A536@orsmsx119.jf.intel.com>
Reply-To: Stelian Pop <stelian.pop-A5NNTvo2L0pl57MIdRCFDg@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A536-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org, Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Nov 21, 2002 at 06:03:27PM -0800, Grover, Andrew wrote:

> > Well, not directly related to the EC thing but rather to the 
> > ACPI/sonypi
> > integration, but maybe you noticed that the sonypi driver also
> > re-implements some code which is originally defined in the ACPI bios
> > (SRS, DIS methods on "SPIC" ACPI object). 
> > 
> > One day I should really call some ACPI exported function to do this,
> > but last time I looked at this (3 months ago ?), the ACPI API (the one
> > exported to external users) was still changing each day. 
> 
> Yeah I think the interface is settling down. You should be able to look at
> the code in drivers/acpi or drivers/hotplug/acpiphp* for examples.

Ok, thanks.

> >From looking at other Sony ACPI BIOSes I've collected, it appears that SPIC
> has a hardware ID (HID) in the ACPI namespace. It seems analogous to the
> Toshiba Laptop Extras device in drivers/acpi.

Indeed.

> 
> Indeed, I think a sonypi driver that assumes ACPI will be much shorter and
> look quite different from the current one. 

Not so sure about that, because only the sonypi device init/free
make use of ACPI. After that, I still have to use the 'proprietary'
protocol over the sonypi iports.

It will simplify the code a little, especially when dealing with new
models which could have a third initialisation way (we already handle
2 differents Vaio types). 

But once again, the old code is here to stay, until/if ACPI becomes
mandatory.

> But since we have resolved the EC
> contention issues, this need not be addressed immediately.

Agreed, this is a low priority item, I'll take a look at the
existent ACPI drivers when I'll have a slow weekend...

Stelian.
-- 
Stelian Pop <stelian.pop-A5NNTvo2L0pl57MIdRCFDg@public.gmane.org>
Alcove - http://www.alcove.com
