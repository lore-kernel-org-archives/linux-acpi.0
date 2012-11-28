From: wfp5p@viridian.itc.virginia.edu (Bill Pemberton)
Subject: Re: [PATCH 217/493] acpi: remove use of __devinit
Date: Wed, 28 Nov 2012 14:56:24 -0500
Message-ID: <20121128195624.6CB358016B@viridian.itc.virginia.edu>
References: <2276213.AWNh3gyvGP@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:54932 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753730Ab2K1T4Z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Nov 2012 14:56:25 -0500
In-Reply-To: <2276213.AWNh3gyvGP@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org

Rafael J. Wysocki writes:
> 
> On Wednesday, November 28, 2012 11:00:02 AM Greg KH wrote:
> > On Thu, Nov 22, 2012 at 01:18:09AM +0100, Rafael J. Wysocki wrote:
> > > On Wednesday, November 21, 2012 01:46:36 AM Rafael J. Wysocki wrote:
> > > > On Monday, November 19, 2012 01:22:46 PM Bill Pemberton wrote:
> > > > > CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> > > > > needed.
> > > > 
> > > > Applied to the linux-next branch of the linux-pm.git tree as v3.8 material.
> > > 
> > > And dropped, because it causes build problems to happen in
> > > acpi_pci_root_add() in my tree.
> > 
> > What kind of problems?  If CONFIG_HOTPLUG is enabled __devinit defines
> > away to nothing, so this shouldn't have broken anything.
> 
> It did, because there's a dependency on PCI, so I would need to merge
> the PCI patch along with the ACPI one, but I couldn't find the PCI
> one, so I dropped the ACPI one too.
> 
> And the fact that the author doesn't seem to care is not encouraging.
> 

What?  Of course I care.  I've been trying to address the problems as
they come up.  I apparently didn't jump on this particular one.

-- 
Bill
