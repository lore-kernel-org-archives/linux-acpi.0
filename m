From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 12/12] PM / r8169: Add simplified run-time PM support
Date: Sat, 2 Jan 2010 21:49:05 +0100
Message-ID: <201001022149.05553.rjw@sisk.pl>
References: <200911160047.46299.rjw@sisk.pl> <200912272048.37332.rjw@sisk.pl> <20091227200147.GJ11737@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:49349 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751475Ab0ABUsq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 2 Jan 2010 15:48:46 -0500
In-Reply-To: <20091227200147.GJ11737@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Jesse Barnes <jbarnes@virtuousgeek.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Oliver Neukum <oliver@neukum.org>, Shaohua Li <shaohua.li@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Francois Romieu <romieu@fr.zoreil.com>, Len Brown <lenb@kernel.org>

On Sunday 27 December 2009, Pavel Machek wrote:
> On Sun 2009-12-27 20:48:37, Rafael J. Wysocki wrote:
> > On Tuesday 15 December 2009, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > Use the PCI run-time power management framework to add simplified
> > > > run-time PM support to the r8169 driver.  Namely, make the driver
> > > > suspend the device when the link is off and set it up for generating
> > > > wake-up event after the link has been detected again.
> > > 
> > > Nice!
> > > 
> > > Do you have any idea how much power it saves?
> > 
> > No, but there should be a power meter somewhere here ...
> > 
> > I'll let you know if I can find it.

Well, I found it, but it has a watt resolution and measures energy in kWh,
so it's not very useful in this case (the box draws 14 - 20 W total at full
power).

> On notebooks, you can often use
> 
> pavel@amd:/data/l/linux-msm/arch/arm/mach-msm$ cat
> /proc/acpi/battery/BAT0/state 
> present:                 yes
> capacity state:          ok
> charging state:          charged
> present rate:            0 mW
> remaining capacity:      71830 mWh
> present voltage:         16277 mV
> 
> ...present rate is often usable-enough.

Using /proc/acpi/battery/BAT1/state I measured the energy drawn in 10 minutes
both with the network adapter in D0 and D3hot.  The results were that with the
network adapter in D0 the box drew 2476 mWh, while with the network adapter in
D3hot it drew 2361 mWh.  The difference is 115 mWh, or about 5% on this
particular box.

This means about 0.1 Wh in 10 minutes, so we can save about 0.6 Wh per hour.

Rafael
