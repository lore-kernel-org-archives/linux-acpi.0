From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] pci: Updates to Rafael's runtime PCI PM patch set
Date: Wed, 11 Nov 2009 21:47:50 +0100
Message-ID: <200911112147.50830.rjw@sisk.pl>
References: <200910090051.50932.rjw@sisk.pl> <200911112058.20331.rjw@sisk.pl> <20091111200503.GA22328@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:37516 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754895AbZKKUqc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Nov 2009 15:46:32 -0500
In-Reply-To: <20091111200503.GA22328@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-pm@lists.linux-foundation.org, jbarnes@virtuousgeek.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, stern@rowland.harvard.edu, shaohua.li@intel.com, bjorn.helgaas@hp.com

On Wednesday 11 November 2009, Matthew Garrett wrote:
> On Wed, Nov 11, 2009 at 08:58:20PM +0100, Rafael J. Wysocki wrote:
> 
> > The PME was supposed to be turned on by pci_prepare_to_sleep().
> > I guess it wasn't in practice?
> 
> Only if the device is set as a wakeup device, which seems messy.

Right.  Plus there was an implicit assumption that devices which could wake up
would also be able to generate PME at run time.  It turns out that that need
not be the case, though.

> Though there may need to be a check there to avoid duplicate PME setup.

Hmm, I need to think about that for a while.

> > Generally, some parts of it belong to the
> > "PCI PM: Run-time callbacks for PCI bus type" patch and the others belong
> > to "PCI / ACPI PM: Platform support for PCI PME wake-up" patch.  Should I fold
> > the changes into them?
> 
> Feel free!

OK, thanks!
