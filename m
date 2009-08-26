From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: PME# for add-on cards
Date: Wed, 26 Aug 2009 23:26:31 +0200
Message-ID: <200908262326.31457.rjw@sisk.pl>
References: <200908240112.39424.rjw@sisk.pl> <1251291000.1791.7.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1251291000.1791.7.camel@maxim-laptop>
Sender: linux-pci-owner@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday 26 August 2009, Maxim Levitsky wrote:
> On Mon, 2009-08-24 at 01:12 +0200, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > Recently we've had a bug report indicating that WoL doesn't work with e100,
> > although the driver does everything needed to support it.  Apparently, the user
> > had to echo PCI0 to /proc/acpi/wakeup to make it work.
> > 
> > After some debugging it turned out that PCI0 is the PCI host bridge
> > (no-bus:pci0000:00), so apparently echoing PCI0 to /proc/acpi/wakeup causes
> > a wake-up GPE to be set up for the host bridge which triggers wake-up once
> > eth0 signals PME#.
> > 
> > So, it looks like we need to set up wake-up GPE for a host bridge for PME#
> > from add-on cards to work, at least on this particular box.
> > 
> > First, I wonder if that's the case in general (anybody knows?).  Second, if
> > that is the case, would it be a good idea to set up the host bridge wake-up GPE
> > by default?
> > 
> > Rafael
> >  
> 
> This is very known problem (at least for me)
> 
> On my desktop, /proc/acpi/wakeup controls all the wakeup sources, and if
> disabled, nether addon cards (ethernet) nor internal devices
> (usb,ethernet) will wake up the system.

Can you please open a Bugzilla entry for that and add my address to the CC list
in there?

> I think that proc/acpi/wakeup should be synced with power/wakeup
> attribute.

In fact proc/acpi/wakeup is going to be removed at one point in future, so
we're moving the functionality to power/wakeup.

> Also, I would be really happy to see bogus (empty) power/wakeup
> attributes be gone.

They are not bogus.  Empty power/wakeup means that the device is not capable
of waking up the system.

> Also, something is broken in regards to PME from addon cards:
> http://www.spinics.net/lists/netdev/msg104460.html

I'll have a look.

Thanks,
Rafael
