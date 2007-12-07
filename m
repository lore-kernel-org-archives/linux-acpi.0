From: Thomas Renninger <trenn@suse.de>
Subject: Re: [RFC] EC registers - Adding sysfs interface?
Date: Fri, 07 Dec 2007 09:53:04 +0100
Message-ID: <1197017584.28990.98.camel@queen.suse.de>
References: <200711131724.31868.carlos@strangeworlds.co.uk>
	 <200711131903.03018.carlos@strangeworlds.co.uk>
	 <1196267304.23251.165.camel@queen.suse.de>
	 <200712062152.56939.lenb@kernel.org>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:58494 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752071AbXLGIxH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Dec 2007 03:53:07 -0500
In-Reply-To: <200712062152.56939.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, Alexey Starikovskiy <astarikovskiy@suse.de>, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

On Thu, 2007-12-06 at 21:52 -0500, Len Brown wrote:
> On Wednesday 28 November 2007 11:28, Thomas Renninger wrote:
> > On Tue, 2007-11-13 at 19:03 +0000, Carlos Corbacho wrote:
> > > Alexey,
> > > 
> > > > How about character /dev/ec0?
> > > 
> > > Yes, that would be fine.
> > > 
> > > On Tuesday 13 November 2007 18:54:51 Alexey Starikovskiy wrote:
> > > > What is the benefit of having acer_acpi in userspace, rather than one more
> > > > *-laptop in /devices/misc?
> > > 
> > > A debate of "would it be easier for me to maintain an in kernel driver (if/ 
> > > when I can get it upstream) or a userspace application". At the moment, the 
> > > idea of a full blown userspace application is just something I'm toying with 
> > > in my head whilst working on WMI userspace.
> > 
> > I very much like the idea of a general EC debug/devel interface to
> > userspace.
> > It should be a separate CONFIG, marked "DEBUG", "EXPERIMENTAL" or
> > whatever and be per default off.
> > It is stupid that everybody who wants to debug a bit on EC registers
> > needs to duplicate the IBM EC implementation, this should IMO be moved
> > where it belongs to:
> > drivers/acpi/ec.c
> > 
> > The question is whether Len will accept/like it, Len?
> 
> 
> It is crazy to poke ioports from user-space when ec.c thinks it owns them.
> So if you're going to do so, it would certainly be an improvement
> to go through the driver rather than around it.
> 
> What other users of this interface would there be other than
> a user-space version of acer_acpi?
> If a user-space driver
> were using the I/F, then we couldn't make it a DEBUG-only feature,
> it would have to be enabled all the time.

I see the "danger" of applications misusing this as an interface and
implementing workarounds for unsupported ACPI parts and (this is the
real problem) stop working on the real problems or a proper
implementation.

Especially because this option should be compiled in e.g. OpenSUSE
versions, for better remote debugging (comparing EC register values with
DSDT Embedded Controller variable implementations on a related problem
could help a lot, without the need of digging in the dark for weeks...).

>From your comments above, I read out that you tend to accept such an
interface as suggested by Alexey?
Making it read-only by default, would mainly help debugging purposes and
should avoid any workaround implementations.

   Thomas

