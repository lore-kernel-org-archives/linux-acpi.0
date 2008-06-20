From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 0/3] PCI PM: Rework pci_set_power_state
Date: Fri, 20 Jun 2008 12:20:37 +0200
Message-ID: <200806201220.37840.rjw@sisk.pl>
References: <200806170206.26616.rjw@sisk.pl> <alpine.LFD.1.10.0806200143250.22284@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54442 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751566AbYFTKTj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Jun 2008 06:19:39 -0400
In-Reply-To: <alpine.LFD.1.10.0806200143250.22284@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>

On Friday, 20 of June 2008, Len Brown wrote:
> 
> > I've recently discovered that pci_set_power_state() calls the platform
> > callback intended for changing the state of the device after it has done
> > that using the native PCI mechanism.  In my opinion this is not correct,
> > because, for example, if the device is being put into D0 from a low power
> > state, it may require some platform-controlled power resources to be turned
> > on before that (in theory).
> > 
> > The following series of patches changes this function so that the platform
> > callback is performed first and then the native mechanism is used.
> > Additionally, however, it checks if the devices is power manageable by the
> > platform and only in that case the platform callback is invoked.  For this
> > purpose, I needed to add an ACPI function allowing PCI to check the power
> > manageability of given device.
> 
> We have 3 cases
> 1. device has PCI PM only
> 2. device has ACPI PM only
> 3. device has both PCI and ACPI PM
> 
> For #1 and #2, order is moot.
> For #3, how can we be sure that the new order is better than the old 
> order?  Is this a theoretical patch, or is there a failure case?

This was a theoretical patch, but please see the new series posted.

The difference is that in the new series the order is only changed for
transitions to D0.

Thanks,
Rafael
