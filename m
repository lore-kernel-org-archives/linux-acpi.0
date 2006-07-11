From: Greg KH <gregkh@suse.de>
Subject: Re: 2.6.18-rc1-mm1
Date: Tue, 11 Jul 2006 12:37:42 -0700
Message-ID: <20060711193742.GD32146@suse.de>
References: <20060709021106.9310d4d1.akpm@osdl.org> <44B0E6E6.6070904@reub.net> <20060709052252.8c95202a.akpm@osdl.org> <20060709183538.GB88036@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:54450 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932100AbWGKTmU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Jul 2006 15:42:20 -0400
Content-Disposition: inline
In-Reply-To: <20060709183538.GB88036@muc.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>, Reuben Farrelly <reuben-lkml@reub.net>, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, linux-acpi@vger.kernel.org, rdunlap@xenotime.net, greg@kroah.com, john stultz <johnstul@us.ibm.com>

On Sun, Jul 09, 2006 at 08:35:38PM +0200, Andi Kleen wrote:
> On Sun, Jul 09, 2006 at 05:22:52AM -0700, Andrew Morton wrote:
> > > ACPI: bus type pci registered
> > > PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved
> > > PCI: Not using MMCONFIG.
> > > PCI: Using configuration type 1
> > > ACPI: Interpreter enabled
> > > 
> > > Is there any way to verify that there really is a BIOS bug there?  If it is, is 
> > > there anyone within Intel or are there any known contacts who can push and poke 
> > > to get this looked at/fixed?  (It's a new Intel board, I'd hope they could get 
> > > it right..).
> > > 
> > > Plus we're not using MMCONFIG - even though I have it enabled.
> > 
> > Andi stuff.
> 
> Greg has patches to relax the checking a bit. 
> 
> I don't know when he intends to merge them.

I think they are all merged into 2.6.18-rc1, as I do't see any MMCONFIG
patches in my tree right now, nor in my queue.

thanks,

greg k-h
