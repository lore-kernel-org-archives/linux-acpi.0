From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 12/12] PM / r8169: Add simplified run-time PM
 support
Date: Sun, 27 Dec 2009 21:01:47 +0100
Message-ID: <20091227200147.GJ11737@elf.ucw.cz>
References: <200911160047.46299.rjw@sisk.pl>
 <200911291644.27288.rjw@sisk.pl>
 <20091215114956.GA1415@ucw.cz>
 <200912272048.37332.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200912272048.37332.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Jesse Barnes <jbarnes@virtuousgeek.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Oliver Neukum <oliver@neukum.org>, Shaohua Li <shaohua.li@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Francois Romieu <romieu@fr.zoreil.com>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sun 2009-12-27 20:48:37, Rafael J. Wysocki wrote:
> On Tuesday 15 December 2009, Pavel Machek wrote:
> > Hi!
> > 
> > > Use the PCI run-time power management framework to add simplified
> > > run-time PM support to the r8169 driver.  Namely, make the driver
> > > suspend the device when the link is off and set it up for generating
> > > wake-up event after the link has been detected again.
> > 
> > Nice!
> > 
> > Do you have any idea how much power it saves?
> 
> No, but there should be a power meter somewhere here ...
> 
> I'll let you know if I can find it.

On notebooks, you can often use

pavel@amd:/data/l/linux-msm/arch/arm/mach-msm$ cat
/proc/acpi/battery/BAT0/state 
present:                 yes
capacity state:          ok
charging state:          charged
present rate:            0 mW
remaining capacity:      71830 mWh
present voltage:         16277 mV

...present rate is often usable-enough.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
