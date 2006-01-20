From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: [RFC] Add lspnp support for sysfs
Date: Thu, 19 Jan 2006 21:47:32 -0500
Message-ID: <20060120024731.GA27435@neo.rr.com>
References: <200601131051.36906.bjorn.helgaas@hp.com> <200601191650.59642.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:36808 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S1161167AbWATCma (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jan 2006 21:42:30 -0500
Content-Disposition: inline
In-Reply-To: <200601191650.59642.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-pcmcia@lists.infradead.org, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Li Shaohua <shaohua.li@intel.com>

On Thu, Jan 19, 2006 at 04:50:59PM -0700, Bjorn Helgaas wrote:
> On Friday 13 January 2006 10:51, Bjorn Helgaas wrote:
> > Add lspnp support for sysfs.  This makes it work with generic PNP
> > (including PNPACPI, PNPBIOS, ISAPNP) instead of just with PNPBIOS.
> > I'm particularly interested in ia64, which never has PNPBIOS, but
> > may have PNPACPI.
> 
> Any more feedback on this?  I'd like to see lspnp work again
> on modern systems, because it's so much easier to tell a user
> to run lspnp than it is to tell him how to grub around in
> /sys/bus/pnp/devices.

Personally, I think this would be really useful, and I agree asking users
to poke around sysfs can be difficult.  I'd like to see it as a
seperate utility from the original lspnp included in pcmcia-cs (which
should actually be called "lspnpbios") as it can be handy for a different
sort of testing.

Thanks,
Adam
