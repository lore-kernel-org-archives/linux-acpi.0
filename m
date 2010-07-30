From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 4/6] ACPI/PCI: ask bios for control of all native services at once
Date: Fri, 30 Jul 2010 14:46:59 +0200
Message-ID: <201007301446.59539.rjw@sisk.pl>
References: <201007282323.56351.rjw@sisk.pl> <4C526E3E.3000600@jp.fujitsu.com> <4C526FDC.6050800@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:47085 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756611Ab0G3MsD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Jul 2010 08:48:03 -0400
In-Reply-To: <4C526FDC.6050800@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, linux-pci@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

On Friday, July 30, 2010, Kenji Kaneshige wrote:
> PCIe port service drivers ask the BIOS, through _OSC, for control of
> the services they handle.  Unfortunately, each of them individually
> asks for control of the PCIe capability structure and if that is
> granted, some BIOSes expect that the other PCIe port services will be
> configured and handled by the kernel as well.  If that is not the
> case (eg. one of the PCIe port service drivers is not loaded), the
> BIOS may be confused and may cause the system as a whole to misbehave
> (eg. on one of such systems enabling the native PCIe PME service
> without loading the native PCIe hot-plug service driver causes a
> storm of ACPI notify requests to appear).
> 
> For this reason rework the PCIe port driver so that (1) it checks
> which native PCIe port services can be enabled, according to the
> BIOS, and (2) it requests control of all these services
> simultaneously.  In particular, this causes pcie_portdrv_probe() to
> fail if the BIOS refuses to grant control of the PCIe capability
> structure, which means that no native PCIe port services can be
> enabled for the PCIe root complex the given port belongs to.
> 
> Make it possible to override this behavior using a new command line
> switch pcie_ports= that can be set to 'auto' (ask the BIOS, the
> default), 'native' (use the PCIe native services regardless of the
> BIOS response to the control request), or 'compat' (do not use the
> PCIe native services at all).
> 
> Accordingly, rework the existing PCIe port service drivers so that
> they don't request control of the services directly.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
> Tested-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

OK, I think I see what you want it to look like.

I'll send my new version later today.

Thanks,
Rafael
