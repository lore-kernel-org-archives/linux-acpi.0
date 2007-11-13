From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 0/5][RFC] Physical PCI slot objects
Date: Tue, 13 Nov 2007 15:07:22 -0800
Message-ID: <20071113230722.GA5506@suse.de>
References: <20071113000853.GA13341@ldl.fc.hp.com> <20071113170129.GA20185@kroah.com> <20071113202154.GA22812@ldl.fc.hp.com> <20071113202632.GA3227@kroah.com> <473A2A61.7030303@hp.com> <20071113225605.GA2589@suse.de> <20071113230400.GP17785@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40793 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755571AbXKMXHl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 Nov 2007 18:07:41 -0500
Content-Disposition: inline
In-Reply-To: <20071113230400.GP17785@parisc-linux.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Rick Jones <rick.jones2@hp.com>, Greg KH <greg@kroah.com>, Alex Chiang <achiang@hp.com>, kristen.c.accardi@intel.com, lenb@kernel.org, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, pcihpd-discuss@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Tue, Nov 13, 2007 at 04:04:00PM -0700, Matthew Wilcox wrote:
> On Tue, Nov 13, 2007 at 02:56:05PM -0800, Greg KH wrote:
> > Why not just use the code in the linux firmware kit that does this
> > already today from userspace (thanks to Kristen for pointing this out to
> > me on irc.)?
> 
> So then we have something that works on ACPI-based machines.  Who will
> add support for all the other kinds of firmware and non-firmware based
> slots?

Well, it seems that the powerpc people do not want this at all, as they
just have "virtual" slots that they don't want people trying to root
around and find the real thing.

What other types of machines can export this kind of information?  How
will you discover non-firmware based slots?

thanks,

greg k-h
