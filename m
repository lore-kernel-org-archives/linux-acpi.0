From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: brightness control on thinkpad t61p
Date: Tue, 08 Jan 2008 15:45:02 +0000
Message-ID: <1199807102.6053.31.camel@localhost.localdomain>
References: <20071224073406.GA1018@srcf.ucam.org>
	 <20071226141027.6d1a509f.akpm@linux-foundation.org>
	 <20071226222321.GA32297@srcf.ucam.org>
	 <20071227123358.GB25535@khazad-dum.debian.net>
	 <20080107013623.GA6667@khazad-dum.debian.net>
	 <20080107194833.GA22506@srcf.ucam.org>
	 <20080108003246.GA15587@khazad-dum.debian.net>
	 <20080108004559.GA27177@srcf.ucam.org>
	 <20080108120653.GA23216@khazad-dum.debian.net>
	 <20080108121819.GA1324@srcf.ucam.org>
	 <20080108124820.GB23216@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tim.rpsys.net ([194.106.48.114]:48110 "EHLO tim.rpsys.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755359AbYAHQB6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Jan 2008 11:01:58 -0500
In-Reply-To: <20080108124820.GB23216@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Tue, 2008-01-08 at 10:48 -0200, Henrique de Moraes Holschuh wrote:
> On Tue, 08 Jan 2008, Matthew Garrett wrote:
> > On Tue, Jan 08, 2008 at 10:06:53AM -0200, Henrique de Moraes Holschuh wrote:
> > > Is there a *real* technical reason why we can't just round to the nearest?
> > > That will work well with any firmware, and it will not remove functionality
> > > from any box, while at the same time plugging the current issues nicely.
> > 
> > Yes. Software makes the assumption that writing a value larger than the 
> > current value will result in the value increasing, which isn't 
> > necessarily true if you round it.
> 
> I dare say that such an assumption is broken for the backlight class, there
> is a reason why we have actual_brightness and brightness separate, and it is
> just that one AFAIK.  I am cc'ing the backlight class maintainer to get his
> opinion on the matter.

The reason actual_brightness and brightness are two separate things are
because some hardware exists that will let you request one brightness
but choose one that is different itself. There are also some devices
that have backlight limiting in software for use in emergency low
battery situations (the battery can get low enough that the device
reboots on high backlight but is otherwise usable).

I did't get enough context above but I went through the archives and it
seems this is about linearising backlight values.

You can't just export an interface of 0-100 and hope things will work
since you lose the information about which values do something and which
don't.

I agree something which tells us what those brightness values mean could
be useful though, a kind of brightness value <-> relative brightness
table. The framebuffer layer has something like this already from before
the backlight core was abstracted/standardised. I'd look at that as a
first port of call and try to see if it could be integrated into the
backlight class somehow.

Cheers,

Richard


