From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/7] PCI / PCIe: Ask BIOS for control of all native services at once (v5)
Date: Mon, 2 Aug 2010 16:15:51 +0200
Message-ID: <201008021615.51753.rjw@sisk.pl>
References: <201007310020.56546.rjw@sisk.pl> <201007310032.48643.rjw@sisk.pl> <4C568DD2.6050400@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:56321 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751776Ab0HBOQz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 2 Aug 2010 10:16:55 -0400
In-Reply-To: <4C568DD2.6050400@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-pci@vger.kernel.org, linux-pm@lists.linux-foundation.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Monday, August 02, 2010, Hidetoshi Seto wrote:
> (2010/07/31 7:32), Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > PCIe port service drivers ask the BIOS, through _OSC, for control of
> > the services they handle.  Unfortunately, each of them individually
> > asks for control of the PCIe capability structure and if that is
> > granted, some BIOSes expect that the other PCIe port services will be
> > configured and handled by the kernel as well.  If that is not the
> > case (eg. one of the PCIe port service drivers is not loaded), the
> > BIOS may be confused and may cause the system as a whole to misbehave
> > (eg. on one of such systems enabling the native PCIe PME service
> > without loading the native PCIe hot-plug service driver causes a
> > storm of ACPI notify requests to appear).
> > 
> > For this reason rework the PCIe port driver so that (1) it checks
> > which native PCIe port services can be enabled, according to the
> > BIOS, and (2) it requests control of all these services
> > simultaneously.  In particular, this causes pcie_portdrv_probe() to
> > fail if the BIOS refuses to grant control of the PCIe capability
> > structure, which means that no native PCIe port services can be
> > enabled for the PCIe root complex the given port belongs to.
> > 
> > Make it possible to override this behavior using a new command line
> > switch pcie_ports= that can be set to 'auto' (ask the BIOS, the
> > default), 'native' (use the PCIe native services regardless of the
> > BIOS response to the control request), or 'compat' (do not use the
> > PCIe native services at all).
> > 
> > Accordingly, rework the existing PCIe port service drivers so that
> > they don't request control of the services directly.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> 
> It seems that this patch still have more than one logical changes.
> 
> I think that "pcie_ports=compat" has an independent function, so
> it could be in a separated patch.
> 
> Maybe we can have 2 patches (at least) before this change:
>  [1] aerdrv: introduce pci_aer_available()
>  [2] portdrv: introduce pcie_ports=
>       'compat' to disable all port services
>  [3] (this patch)

I can do that, but I'm not sure if that really is going to make things better.

The introduction of pcie_ports=, for example, is only necessary because of the
other changes in the $subject patch, so why do you want it to be separate?

Thanks,
Rafael
