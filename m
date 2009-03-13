From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: patch for video.c driver
Date: Fri, 13 Mar 2009 18:11:18 +0100
Message-ID: <200903131811.19209.rjw@sisk.pl>
References: <20090312154741.GA1055@hygelac> <1236910092.2807.103.camel@rzhang-dt> <20090313030030.GA23571@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:37797 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761248AbZCMRLQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Mar 2009 13:11:16 -0400
In-Reply-To: <20090313030030.GA23571@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Terence Ripperda <tripperda@nvidia.com>, "lenb@kernel.org" <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Friday 13 March 2009, Matthew Garrett wrote:
> On Fri, Mar 13, 2009 at 10:08:12AM +0800, Zhang Rui wrote:
> > On Thu, 2009-03-12 at 23:47 +0800, Terence Ripperda wrote:
> > >  The intent was to follow the same architecture that the
> > > video.ko driver already follows and to make the support generic enough for
> > > many different users. For example, above I mentioned that both NVIDIA and
> > > other vendors have ACPI extension methods, the support we're adding would be
> > > usable by all such vendors.
> > 
> > Makes sense, although the other vendors usually offers a platform
> > specific device rather than a platform specific control method.
> 
> Mm. I don't see any reason for video output switching to be handled in 
> kernel. It's fundamentally behaviour that depends on the user's 
> preferences, so the logical way to handle this is for the event to be 
> sent to userland (as it is currently) and for a userspace agent to then 
> turn this into an xrandr event. The only thing that currently prevents 
> this from working with the binary nvidia drivers is the fact that they 
> don't appear to support xrandr for output control. I'd prefer it if we 
> didn't work around X driver shortcomings by adding interfaces to the 
> kernel.

FWIW, agreed.

Thanks,
Rafael
