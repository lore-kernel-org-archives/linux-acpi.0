From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH] Enable bit 11 in _PDC to advertise hw coord
Date: Sun, 8 Feb 2009 11:51:01 -0800
Message-ID: <20090208195101.GA17043@kroah.com>
References: <20090202195717.GA24510@linux-os.sc.intel.com> <20090204085712.GF30821@kernel.dk> <20090204195331.GA905@khazad-dum.debian.net> <1233778002.4286.61.camel@localhost.localdomain> <20090204204036.GB10680@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:56424 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751747AbZBHU3r (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 8 Feb 2009 15:29:47 -0500
Content-Disposition: inline
In-Reply-To: <20090204204036.GB10680@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Jens Axboe <jens.axboe@oracle.com>, stable kernel <stable@kernel.org>, Chris Mason <chris.mason@oracle.com>, Len Brown <lenb@kernel.org>

On Wed, Feb 04, 2009 at 12:40:36PM -0800, Greg KH wrote:
> On Wed, Feb 04, 2009 at 12:06:42PM -0800, Pallipadi, Venkatesh wrote:
> > On Wed, 2009-02-04 at 11:53 -0800, Henrique de Moraes Holschuh wrote:
> > > On Wed, 04 Feb 2009, Jens Axboe wrote:
> > > > On Mon, Feb 02 2009, Pallipadi, Venkatesh wrote:
> > > > > 
> > > > > Bit 11 in intel PDC definitions is meant for OS capability to handle
> > > > > hardware coordination of P-states. In Linux we have always supported
> > > > > hwardware coordination of P-states. Just let the BIOSes know that we
> > > > > support it, by setting this bit.
> > > > > 
> > > > > Some BIOSes use this bit to choose between hardware or software coordination
> > > > > and without this change below, BIOSes switch to software coordination, which
> > > > > is not very optimal in terms of power consumption and extra wakeups from idle.
> > > > 
> > > > I can confirm that this fixes the excessive reschedule ipi count on an
> > > > x60 with the ondemand governor. Can we please get this into 2.6.29?
> > > 
> > > And, after that, -stable?
> > > 
> > 
> > Agreed. This should also go to -stable once it gets into mainline.
> 
> Can someone send stable@kernel.org the git commit id when it goes into
> Linus's tree?

It's d96f94c604453f87fe24154b87e1e9a3a72511f8, I got it now.

thanks,

greg k-h
