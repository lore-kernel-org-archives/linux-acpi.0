From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 12/12] PM / r8169: Add simplified run-time PM support
Date: Sun, 3 Jan 2010 22:01:14 +0100
Message-ID: <201001032201.14087.rjw@sisk.pl>
References: <200911160047.46299.rjw@sisk.pl> <201001022149.05553.rjw@sisk.pl> <20100103195544.GC11928@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20100103195544.GC11928@elf.ucw.cz>
Sender: linux-pci-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Jesse Barnes <jbarnes@virtuousgeek.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Oliver Neukum <oliver@neukum.org>, Shaohua Li <shaohua.li@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Francois Romieu <romieu@fr.zoreil.com>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sunday 03 January 2010, Pavel Machek wrote:
> 
> > > On notebooks, you can often use
> > > 
> > > pavel@amd:/data/l/linux-msm/arch/arm/mach-msm$ cat
> > > /proc/acpi/battery/BAT0/state 
> > > present:                 yes
> > > capacity state:          ok
> > > charging state:          charged
> > > present rate:            0 mW
> > > remaining capacity:      71830 mWh
> > > present voltage:         16277 mV
> > > 
> > > ...present rate is often usable-enough.
> > 
> > Using /proc/acpi/battery/BAT1/state I measured the energy drawn in 10 minutes
> > both with the network adapter in D0 and D3hot.  The results were that with the
> > network adapter in D0 the box drew 2476 mWh, while with the network adapter in
> > D3hot it drew 2361 mWh.  The difference is 115 mWh, or about 5% on this
> > particular box.
> > 
> > This means about 0.1 Wh in 10 minutes, so we can save about 0.6 Wh per hour.
> 
> Which means it saves 0.6W :-). Measuring power in Wh/h is "interesting".

You can't save power, you can only save energy.  Wh is just an energy unit.

> Ok, that's consistent with my experiments, ethernet transciever was around 1W... Thanks.

No big deal.

Rafael
