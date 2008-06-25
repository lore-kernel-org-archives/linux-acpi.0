From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/11] PCI PM: Handling of PCI devices wake-up functionality
Date: Thu, 26 Jun 2008 00:24:13 +0200
Message-ID: <200806260024.13721.rjw@sisk.pl>
References: <200806231934.08565.rjw@sisk.pl> <200806251505.08603.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54815 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752736AbYFYWWa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jun 2008 18:22:30 -0400
In-Reply-To: <200806251505.08603.jbarnes@virtuousgeek.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Len Brown <lenb@kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Thursday, 26 of June 2008, Jesse Barnes wrote:
> On Monday, June 23, 2008 10:34 am Rafael J. Wysocki wrote:
> > Hi,
> >
> > The purpose of the following series of patches is to rework the power
> > management of PCI devices so that the handling of their wake-up
> > functionality is consistent with the other PM operations and so that the
> > user space can manage the wake-up functionality of PCI devices using the
> > /sys/devices/.../power/wakeup interface regardless of whether the wake-up
> > function is based on the native PCI mechanism (PME#), or it is handled by
> > the platform (eg. ACPI).
> >
> > Apart from the ACPI and PCI changes necessary for this purpose, the series
> > includes some clean-ups that are not strictly required, but make the code
> > more straightforward and (IMHO) easier to follow.
> >
> > Please review.
> 
> This patchset looks really nice, and makes pci_enable_wake and such much more 
> readable, IMO.

Thanks!

> How much testing has it seen? 

A little.  I've been using it on my HP nx6325 for some days with no visible
problems.

> Do you think it's appropriate for 2.6.27?

Well, I think the patches need to be modified to handle the case of devices
that can wake up both through PME# and the ACPI-based mechanism.
Also, I need to make ACPI enable the wake-up GPEs for PCI devices that are
supposed to be handled by it.

For this reasons I'm not sure they will be sufficiently tested before the
2.6.27 merge window.  Perhaps it's better to target the patchset at 2.6.28 and
make sure it gets some serious testing during the .27 cycle.

Thanks,
Rafael
