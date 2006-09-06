From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC][PATCH 2/2] ACPI: handle timer ticks proactively
Date: Wed, 6 Sep 2006 12:54:15 +0200
Message-ID: <20060906105415.GG4987@atrey.karlin.mff.cuni.cz>
References: <20060904131027.GD6279@ucw.cz> <20060905082855.GC5082@elf.ucw.cz> <20060905085319.GA2237@elf.ucw.cz> <20060905090328.GA4888@elf.ucw.cz> <1157469360.3420.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:14992 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1750779AbWIFKyK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 Sep 2006 06:54:10 -0400
Content-Disposition: inline
In-Reply-To: <1157469360.3420.14.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adam Belay <abelay@novell.com>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux@dominikbrodowski.net, arjan@linux.intel.com

Hi!

> > > Okay, just to get you some feedback:
> > > 
> > > It seems to change things a _lot_. Power consumption with usb modules
> > > loaded went from 14315mW to 13800mW -- that is huge
> > > deal. Unfortunately something strange is going on: with stock kernel,
> > > power consumption is mostly constant. With your patch, it varies a
> > > lot, at 2 second timescale.
> > > 
> > > Power consumption with usb unloaded (only way to get reasonable power
> > > on x60) went from stable 10450mW to  something rapidly changing, and
> > > probably even worse than original:
> > 
> > I also noticed that with your patch, bus master activity tends to be constant?!
> 
> Is this the case even when userspace touches the disk?  On my hardware I
> see a constant flow of short BM activity bursts.

Disk was active (like once 5 seconds some small access)...
									Pavel
-- 
Thanks, Sharp!
