From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 217/493] acpi: remove use of __devinit
Date: Wed, 28 Nov 2012 20:34:43 +0100
Message-ID: <2276213.AWNh3gyvGP@vostro.rjw.lan>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu> <11689359.E4tRqmmlBk@vostro.rjw.lan> <20121128190002.GA30743@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:35388 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752508Ab2K1T37 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Nov 2012 14:29:59 -0500
In-Reply-To: <20121128190002.GA30743@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Bill Pemberton <wfp5p@virginia.edu>, linux-acpi@vger.kernel.org

On Wednesday, November 28, 2012 11:00:02 AM Greg KH wrote:
> On Thu, Nov 22, 2012 at 01:18:09AM +0100, Rafael J. Wysocki wrote:
> > On Wednesday, November 21, 2012 01:46:36 AM Rafael J. Wysocki wrote:
> > > On Monday, November 19, 2012 01:22:46 PM Bill Pemberton wrote:
> > > > CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> > > > needed.
> > > 
> > > Applied to the linux-next branch of the linux-pm.git tree as v3.8 material.
> > 
> > And dropped, because it causes build problems to happen in
> > acpi_pci_root_add() in my tree.
> 
> What kind of problems?  If CONFIG_HOTPLUG is enabled __devinit defines
> away to nothing, so this shouldn't have broken anything.

It did, because there's a dependency on PCI, so I would need to merge
the PCI patch along with the ACPI one, but I couldn't find the PCI
one, so I dropped the ACPI one too.

And the fact that the author doesn't seem to care is not encouraging.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
