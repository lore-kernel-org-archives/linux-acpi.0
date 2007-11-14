From: Scott Murray <scott@spiteful.org>
Subject: Re: [PATCH 0/5][RFC] Physical PCI slot objects
Date: Wed, 14 Nov 2007 01:00:28 -0500 (EST)
Message-ID: <alpine.LFD.0.9999.0711140030350.6037@godzilla.spiteful.org>
References: <20071113000853.GA13341@ldl.fc.hp.com> <20071113170129.GA20185@kroah.com> <20071113202154.GA22812@ldl.fc.hp.com> <20071113202632.GA3227@kroah.com> <473A2A61.7030303@hp.com> <20071113225605.GA2589@suse.de> <20071113230400.GP17785@parisc-linux.org>
 <20071113230722.GA5506@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tomts12-srv.bellnexxia.net ([209.226.175.56]:47335 "EHLO
	tomts12-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755538AbXKNGqG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Nov 2007 01:46:06 -0500
In-Reply-To: <20071113230722.GA5506@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Matthew Wilcox <matthew@wil.cx>, Rick Jones <rick.jones2@hp.com>, Greg KH <greg@kroah.com>, Alex Chiang <achiang@hp.com>, kristen.c.accardi@intel.com, lenb@kernel.org, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, pcihpd-discuss@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Tue, 13 Nov 2007, Greg KH wrote:

> On Tue, Nov 13, 2007 at 04:04:00PM -0700, Matthew Wilcox wrote:
> > On Tue, Nov 13, 2007 at 02:56:05PM -0800, Greg KH wrote:
> > > Why not just use the code in the linux firmware kit that does this
> > > already today from userspace (thanks to Kristen for pointing this out to
> > > me on irc.)?
> >
> > So then we have something that works on ACPI-based machines.  Who will
> > add support for all the other kinds of firmware and non-firmware based
> > slots?
>
> Well, it seems that the powerpc people do not want this at all, as they
> just have "virtual" slots that they don't want people trying to root
> around and find the real thing.
>
> What other types of machines can export this kind of information?  How
> will you discover non-firmware based slots?

Just to add my 2 cents, I've not seen any CompactPCI gear that had a
way to easily map a PCI peripheral slot to the corresponding physical
slot in the chassis.  In the products I've worked on that use my CPCI
hotplug drivers, we did any required mapping in userspace based on
knowledge of the chassis layout for the particular product.

Scott


-- 
==============================================================================
Scott Murray, scott@spiteful.org

     "Good, bad ... I'm the guy with the gun." - Ash, "Army of Darkness"
