From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 217/493] acpi: remove use of __devinit
Date: Wed, 28 Nov 2012 12:47:15 -0800
Message-ID: <20121128204715.GA2757@kroah.com>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <2276213.AWNh3gyvGP@vostro.rjw.lan>
 <20121128193824.GA21682@kroah.com>
 <2392824.ONCP6PcqvX@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:34436 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756077Ab2K1UrR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Nov 2012 15:47:17 -0500
Content-Disposition: inline
In-Reply-To: <2392824.ONCP6PcqvX@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Bill Pemberton <wfp5p@virginia.edu>, linux-acpi@vger.kernel.org

On Wed, Nov 28, 2012 at 09:08:56PM +0100, Rafael J. Wysocki wrote:
> On Wednesday, November 28, 2012 11:38:24 AM Greg KH wrote:
> > On Wed, Nov 28, 2012 at 08:34:43PM +0100, Rafael J. Wysocki wrote:
> > > On Wednesday, November 28, 2012 11:00:02 AM Greg KH wrote:
> > > > On Thu, Nov 22, 2012 at 01:18:09AM +0100, Rafael J. Wysocki wrote:
> > > > > On Wednesday, November 21, 2012 01:46:36 AM Rafael J. Wysocki wrote:
> > > > > > On Monday, November 19, 2012 01:22:46 PM Bill Pemberton wrote:
> > > > > > > CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> > > > > > > needed.
> > > > > > 
> > > > > > Applied to the linux-next branch of the linux-pm.git tree as v3.8 material.
> > > > > 
> > > > > And dropped, because it causes build problems to happen in
> > > > > acpi_pci_root_add() in my tree.
> > > > 
> > > > What kind of problems?  If CONFIG_HOTPLUG is enabled __devinit defines
> > > > away to nothing, so this shouldn't have broken anything.
> > > 
> > > It did, because there's a dependency on PCI, so I would need to merge
> > > the PCI patch along with the ACPI one, but I couldn't find the PCI
> > > one, so I dropped the ACPI one too.
> > 
> > Ah, ok, that makes sense.  I will be including the PCI ones in my tree
> > soon, once I get Bjorn's ack.
> 
> So perhaps you can take this one too? :-)

I will be glad to do so.

> Please regard it as acked.

Thanks, will do.

greg k-h
