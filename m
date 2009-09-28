From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] acpi: pci_root: fix NULL pointer deref after resume from suspend
Date: Mon, 28 Sep 2009 23:05:56 +0200
Message-ID: <200909282305.56102.rjw@sisk.pl>
References: <1254119480-9730-1-git-send-email-dfeng@redhat.com> <20090928173819.GA2441@ldl.fc.hp.com> <200909282243.44226.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:38593 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751575AbZI1VEh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Sep 2009 17:04:37 -0400
In-Reply-To: <200909282243.44226.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
Cc: Xiaotian Feng <dfeng@redhat.com>, lenb@kernel.org, bjorn.helgaas@hp.com, andrew.patterson@hp.com, jbarnes@virtuousgeek.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 28 September 2009, Rafael J. Wysocki wrote:
> On Monday 28 September 2009, Alex Chiang wrote:
> > Hi Xiaotian,
> > 
> > Thanks for the bug report.
> > 
> > * Xiaotian Feng <dfeng@redhat.com>:
> > > commit 275582 introduces acpi_get_pci_dev(), but pdev->subordinate
> > > can be NULL, then a NULL was passed to pci_get_slot, this results
> > > the kernel oops when resume from suspend.
> > > 
> > > This patch resolves following kernel oops:
> > > BUG: unable to handle kernel NULL pointer dereference at 0000000000000028
> > > IP: [<ffffffff812217e7>] pci_get_slot+0x4c/0x8c
> > > 
> > > Signed-off-by: Xiaotian Feng <dfeng@redhat.com>
> > > ---
> > >  drivers/acpi/pci_root.c |    6 +++++-
> > >  1 files changed, 5 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> > > index 3112221..3c35144 100644
> > > --- a/drivers/acpi/pci_root.c
> > > +++ b/drivers/acpi/pci_root.c
> > > @@ -387,7 +387,11 @@ struct pci_dev *acpi_get_pci_dev(acpi_handle handle)
> > >  		if (!pdev || hnd == handle)
> > >  			break;
> > >  
> > > -		pbus = pdev->subordinate;
> > > +		if (pdev->subordinate)
> > > +			pbus = pdev->subordinate;
> > > +		else
> > > +			pbus = pdev->bus;
> > > +
> > 
> > I'm a little confused by this. If we start from the PCI root
> > bridge and walk back down the hierarchy, shouldn't everything
> > between the root and the device be a P2P bridge?
> 
> Well, if my reading of the code is correct, there's no guarantee that
> pci_get_slot() will always return either the right device or a bridge.

I should have been more precise.

If devfn of node happens to be the same as devfn of a non-bridge device on
pbus, the pci_get_slot() will return a valid pointer to it, but
pdev->subordinate will be NULL.  Is it impossible for some reason?

Thanks,
Rafael
