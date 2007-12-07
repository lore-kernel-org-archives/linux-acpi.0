From: Len Brown <lenb@kernel.org>
Subject: Re: [RFC] EC registers - Adding sysfs interface?
Date: Thu, 6 Dec 2007 21:52:56 -0500
Message-ID: <200712062152.56939.lenb@kernel.org>
References: <200711131724.31868.carlos@strangeworlds.co.uk> <200711131903.03018.carlos@strangeworlds.co.uk> <1196267304.23251.165.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:32834 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752474AbXLGCxU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 6 Dec 2007 21:53:20 -0500
In-Reply-To: <1196267304.23251.165.camel@queen.suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, Alexey Starikovskiy <astarikovskiy@suse.de>, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

On Wednesday 28 November 2007 11:28, Thomas Renninger wrote:
> On Tue, 2007-11-13 at 19:03 +0000, Carlos Corbacho wrote:
> > Alexey,
> > 
> > > How about character /dev/ec0?
> > 
> > Yes, that would be fine.
> > 
> > On Tuesday 13 November 2007 18:54:51 Alexey Starikovskiy wrote:
> > > What is the benefit of having acer_acpi in userspace, rather than one more
> > > *-laptop in /devices/misc?
> > 
> > A debate of "would it be easier for me to maintain an in kernel driver (if/ 
> > when I can get it upstream) or a userspace application". At the moment, the 
> > idea of a full blown userspace application is just something I'm toying with 
> > in my head whilst working on WMI userspace.
> 
> I very much like the idea of a general EC debug/devel interface to
> userspace.
> It should be a separate CONFIG, marked "DEBUG", "EXPERIMENTAL" or
> whatever and be per default off.
> It is stupid that everybody who wants to debug a bit on EC registers
> needs to duplicate the IBM EC implementation, this should IMO be moved
> where it belongs to:
> drivers/acpi/ec.c
> 
> The question is whether Len will accept/like it, Len?


It is crazy to poke ioports from user-space when ec.c thinks it owns them.
So if you're going to do so, it would certainly be an improvement
to go through the driver rather than around it.

What other users of this interface would there be other than
a user-space version of acer_acpi?  If a user-space driver
were using the I/F, then we couldn't make it a DEBUG-only feature,
it would have to be enabled all the time.

-Len
