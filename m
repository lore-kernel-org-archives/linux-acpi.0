From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] acpi: move thermal trip handling to generic thermal layer
Date: Fri, 20 Feb 2009 11:53:26 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0902201151140.19156@localhost.localdomain>
References: <20081127174813.GA24258@srcf.ucam.org>
 <1229482938.562.29.camel@rzhang-dt> <20081217031215.GC19430@srcf.ucam.org>
 <200901161448.53765.trenn@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:34250 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754724AbZBTRx7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Feb 2009 12:53:59 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KFD00CL8IX44OMI@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Feb 2009 10:53:41 -0600 (CST)
In-reply-to: <200901161448.53765.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Matthew Garrett <mjg@redhat.com>, Zhang Rui <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Thomas, Sujith" <sujith.thomas@intel.com>

On Fri, 16 Jan 2009, Thomas Renninger wrote:

> On Wednesday 17 December 2008 04:12:15 Matthew Garrett wrote:
> > On Wed, Dec 17, 2008 at 11:02:18AM +0800, Zhang Rui wrote:
> > > On Mon, 2008-12-08 at 20:59 +0800, Matthew Garrett wrote:
> > > > They're needed if you want to implement any sort of sensible
> > > > implementation of passive cooling. They might not be expressed in quite
> > > > the same way, but the basic concept is identical.
> > >
> > > Seeing tc1, tc2, tsp under /sys/class/thermal/ is not good because we
> > > don't want to make the generic thermal driver too ACPI specific, before
> > > we've really concluded some basic concepts for passive cooling.
> > > so why not do this after we have another generic thermal user with
> > > passive cooling support?
> >
> > They're not exposed in /sys/class, and I don't think doing so is a
> > sensible thing to do. If you know values for the hardware in question
> > then they should be supplied by the firmware. But even so, the generic
> > thermal layer needs a way of implementing passive cooling. Doing so
> > involves deriving a formula to describe the behaviour of the system
> > around the passive trip level, and the best used implementation of that
> > in Linux at the moment is the one described in the ACPI spec. I don't
> > see any real need to generate new terms to describe well documented
> > concepts, even if other implementations don't use ACPI.
> 
> If others need a specific algorithm, another (set of) callback function(s)
> could be added later which would provide the possibility of
> a platform specific override?

yeah, that is probalby the way to do it.
But until we have a 2nd customer besides ACPI,
we are kidding outselves if we think we can dream up a real "generic"
that will not need later modification...

--
Len Brown, Intel Open Source Technology Center
