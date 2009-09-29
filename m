From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] acpi: pci_root: fix NULL pointer deref after resume from suspend
Date: Wed, 30 Sep 2009 01:31:14 +0200
Message-ID: <200909300131.15046.rjw@sisk.pl>
References: <1254119480-9730-1-git-send-email-dfeng@redhat.com> <200909292208.18203.rjw@sisk.pl> <20090929204948.GA31574@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:45052 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752180AbZI2X3w (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Sep 2009 19:29:52 -0400
In-Reply-To: <20090929204948.GA31574@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
Cc: Danny Feng <dfeng@redhat.com>, lenb@kernel.org, bjorn.helgaas@hp.com, andrew.patterson@hp.com, jbarnes@virtuousgeek.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 29 September 2009, Alex Chiang wrote:
> * Rafael J. Wysocki <rjw@sisk.pl>:
> > On Tuesday 29 September 2009, Danny Feng wrote:
> > > Is there any cases that pdev->subordinate is NULL while pdev is bridge 
> > > device?
> > >  From pci_slot.c::walk_p2p_bridge, there's code like following:
> > > 
> > >          dev = pci_get_slot(pci_bus, PCI_DEVFN(device, function));
> > >          if (!dev || !dev->subordinate)
> > >                  goto out;
> > > 
> > > It looks like dev->subordinate can be NULL even if in p2p
> > > bridge, right?
> 
> In the code you post above, that results from doing an ACPI
> namespace walk, which will definitely find non-bridge devices.
>  
> > Right, in general, but in this particular case each device we
> > inspect is supposed to be a parent of another device, which
> > implies that there's a bus below it (given that it's a PCI
> > device).
> 
> Right, that's why I'm surprised that my assumption broke. But now
> that I see that a dock device is involved, maybe that's not so
> surprising.

Yeah.  Still, I'd like to know the root cause.

Thanks,
Rafael
