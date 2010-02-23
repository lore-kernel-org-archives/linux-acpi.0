From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/8] PCI PM: Add function for checking PME status of devices
Date: Tue, 23 Feb 2010 20:56:35 +0100
Message-ID: <201002232056.35526.rjw@sisk.pl>
References: <201002172335.47703.rjw@sisk.pl> <201002172336.58766.rjw@sisk.pl> <20100222162142.06095230@jbarnes-piketon>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:40124 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753174Ab0BWT4D (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Feb 2010 14:56:03 -0500
In-Reply-To: <20100222162142.06095230@jbarnes-piketon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linux PCI <linux-pci@vger.kernel.org>, Shaohua Li <shaohua.li@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Oliver Neukum <oliver@neukum.org>, Matthew Garrett <mjg@redhat.com>, LKML <linux-kernel@vger.kernel.org>, Gary Hade <garyhade@us.ibm.com>

On Tuesday 23 February 2010, Jesse Barnes wrote:
> On Wed, 17 Feb 2010 23:36:58 +0100
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Add function pci_check_pme_status() that will check the PME status
> > bit of given device and clear it along with the PME enable bit.  It
> > will be necessary for PCI run-time power management.
> > 
> > Based on a patch from Shaohua Li <shaohua.li@intel.com>
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> 
> Applied this series and dropped the old patches, thanks Rafael.

Great, thanks Jesse.
