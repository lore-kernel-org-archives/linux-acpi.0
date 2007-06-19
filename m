From: Jens Axboe <olpc-devel@kernel.dk>
Subject: Re: Power Mangement Interfaces
Date: Tue, 19 Jun 2007 21:17:17 +0200
Message-ID: <20070619191717.GL18863@kernel.dk>
References: <20070330235759.GC4252@cosmic.amd.com> <200703312001.55231.david-b@pacbell.net> <20070401165601.GA13389@cosmic.amd.com> <200704011728.10966.david-b@pacbell.net> <20070619170048.GA342@dmt.media.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from brick.kernel.dk ([80.160.20.94]:26731 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932854AbXFSTRu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Jun 2007 15:17:50 -0400
Content-Disposition: inline
In-Reply-To: <20070619170048.GA342@dmt.media.mit.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marcelo Tosatti <marcelo@kvack.org>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.linux-foundation.org, devel@laptop.org, linux-acpi@vger.kernel.org

On Tue, Jun 19 2007, Marcelo Tosatti wrote:
> > > > I see /sys/devices/acpi_system:00/button_power:00 on this system; and
> > > > /sys/devices/acpi_system:00/device:00/PNP0C0D:00 has path \_SB_.LID_ ...
> > > > such device nodes already exist, even though they're not really hooked
> > > > up to anything much.  Notably, their "wakeup" state is not initialized.
> > > > 
> > > > And while it seems that the three USB controllers on this system show up
> > > > as /sys/devices/acpi_system:00/device:00/PNP0A03:00/device:{01,02,03} I
> > > > have no idea which one is /sys/devices/pci0000:00/0000:00:02.2 versus
> > > > 0000:00:02.1 or 0000:00:02.0 ... I know that USB0 is device:01 and so
> > > > on (by reading "path"), but associating one with a PCI device seems to
> > > > involve pure guesswork.
> > > 
> > > I guess we'll probably have to do something similar for our OLPC PM code
> > > - but thats the sort of platform specific fragmentation thing I was trying
> > > to avoid.
> > 
> > Since OLPC isn't using ACPI,  it can be more like embedded Linux,
> > and just Do The Right Thing ... create platform devices, etc.  :)
> 
> As you know we want user configuration of enabled wakeup events (unlike
> embedded platforms where this is hardcoded). It seems that the current
> interface available for that is /sys/devices/../power/wakeup hook (when
> !ACPI).
> 
> However there are several wakeup capable devices in OLPC which do not
> have drivers, thus no platform devices:
> 
> - power button 
> - lid
> 
> It seems that creating platform devices for these two just for the
> purpose of a having an interface for enabling wakeup events is overkill.

I'll go ahead and disagree with that, I think a platform device is
clearly the best way to go. It's the cleanest approach.

-- 
Jens Axboe

