From: David Hinds <dhinds@sonic.net>
Subject: Re: [RFC] Add lspnp support for sysfs
Date: Tue, 31 Jan 2006 21:59:11 -0800
Message-ID: <20060201055911.GA13540@sonic.net>
References: <200601131051.36906.bjorn.helgaas@hp.com> <200601311007.07379.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from b.mail.sonic.net ([64.142.19.5]:54492 "EHLO b.mail.sonic.net")
	by vger.kernel.org with ESMTP id S1030408AbWBAGAx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Feb 2006 01:00:53 -0500
Content-Disposition: inline
In-Reply-To: <200601311007.07379.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-pcmcia@lists.infradead.org, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Adam Belay <ambx1@neo.rr.com>, Matthieu Castet <castet.matthieu@free.fr>, Li Shaohua <shaohua.li@intel.com>

On Tue, Jan 31, 2006 at 10:07:07AM -0700, Bjorn Helgaas wrote:
> On Friday 13 January 2006 10:51, Bjorn Helgaas wrote:
> > Add lspnp support for sysfs.  This makes it work with generic PNP
> > (including PNPACPI, PNPBIOS, ISAPNP) instead of just with PNPBIOS.
> > I'm particularly interested in ia64, which never has PNPBIOS, but
> > may have PNPACPI.
> 
> Ping.  I think we have two votes in favor of this, at least in
> concept (mine and Adam's).  We had a couple tangential questions.
> Nobody seemed really opposed.
> 
> What can I do to either advance this or come to the conclusion
> that it's not worth the effort?  David, are you the pcmcia-cs
> maintainer?  Are you interested in this at all?

I think it would be good for lspnp to live somewhere other than
pcmcia-cs.  It really doesn't belong there, and now that pcmcia-cs is
essentially deprecated, it makes even less sense.

-- Dave

