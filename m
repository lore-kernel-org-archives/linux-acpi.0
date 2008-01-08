From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: brightness control on thinkpad t61p
Date: Tue, 08 Jan 2008 16:56:37 +0000
Message-ID: <1199811397.6053.55.camel@localhost.localdomain>
References: <20080107013623.GA6667@khazad-dum.debian.net>
	 <20080107194833.GA22506@srcf.ucam.org>
	 <20080108003246.GA15587@khazad-dum.debian.net>
	 <20080108004559.GA27177@srcf.ucam.org>
	 <20080108120653.GA23216@khazad-dum.debian.net>
	 <20080108121819.GA1324@srcf.ucam.org>
	 <20080108124820.GB23216@khazad-dum.debian.net>
	 <1199807102.6053.31.camel@localhost.localdomain>
	 <20080108155401.GA4954@srcf.ucam.org>
	 <1199809771.6053.42.camel@localhost.localdomain>
	 <20080108164928.GA6182@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tim.rpsys.net ([194.106.48.114]:60487 "EHLO tim.rpsys.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762477AbYAHQ5X (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Jan 2008 11:57:23 -0500
In-Reply-To: <20080108164928.GA6182@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Tue, 2008-01-08 at 14:49 -0200, Henrique de Moraes Holschuh wrote:
> On Tue, 08 Jan 2008, Richard Purdie wrote:
> > On Tue, 2008-01-08 at 15:54 +0000, Matthew Garrett wrote:
> > > On Tue, Jan 08, 2008 at 03:45:02PM +0000, Richard Purdie wrote:
> > > 
> > > > I did't get enough context above but I went through the archives and it
> > > > seems this is about linearising backlight values.
> > > 
> > > Indeed. The ACPI spec provides a range of 0-100, without specifying what 
> > > this actually means (it gives brightness and power consumption as two 
> > > different examples). Implementations are only required to support a 
> > > subset of these, with the others being ignored. The current hook into 
> > > the backlight class exports this range but provides no means for an 
> > > application to determine which values are valid - I'd prefer to just 
> > > flatten the range to remove the holes. Given the lack of standardisation 
> > > in the real meaning of the values, I don't think exporting the 0-100 
> > > range buys us anything.
> > 
> > I agree with that. 0-100 actually breaks a useful and valid way the
> > class gets used in the "brightness + 1" case...
> 
> So be it, then.  But my request that we get a way to add the information we
> are losing to the backlight class still stands.

The thing is does this 0-100 value have a use to userspace? Its
extremely device specific and can't be exported from the class in a
generic way suggesting it should really be something exported by the
driver itself. You still have to ask whether userspace actually needs
this value though?

Kernel debugging is the one use I can see. For that you'd probably be
better off with a pr_debug() though. There are hundreds of other
'useful' numbers the kernel has but doesn't export.

Cheers,

Richard


