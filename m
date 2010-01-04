From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 12/12] PM / r8169: Add simplified run-time PM
	support
Date: Mon, 4 Jan 2010 09:31:08 +0100
Message-ID: <20100104083108.GD1372@ucw.cz>
References: <200911160047.46299.rjw@sisk.pl> <201001022149.05553.rjw@sisk.pl> <20100103195544.GC11928@elf.ucw.cz> <201001032201.14087.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201001032201.14087.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Jesse Barnes <jbarnes@virtuousgeek.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Oliver Neukum <oliver@neukum.org>, Shaohua Li <shaohua.li@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Francois Romieu <romieu@fr.zoreil.com>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org


> > > Using /proc/acpi/battery/BAT1/state I measured the energy drawn in 10 minutes
> > > both with the network adapter in D0 and D3hot.  The results were that with the
> > > network adapter in D0 the box drew 2476 mWh, while with the network adapter in
> > > D3hot it drew 2361 mWh.  The difference is 115 mWh, or about 5% on this
> > > particular box.
> > > 
> > > This means about 0.1 Wh in 10 minutes, so we can save about 0.6 Wh per hour.
> > 
> > Which means it saves 0.6W :-). Measuring power in Wh/h is "interesting".
> 
> You can't save power, you can only save energy.  Wh is just an energy unit.

Of course we can save power, you just did :-).

(And in some cases -- data centers, limited cooling -- you are limited
by power, not energy. You are right that on notebooks, energy is more
important.)


									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
