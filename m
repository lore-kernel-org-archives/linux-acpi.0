From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 0/4] ACPI: update acpi_bus_register_driver() signature
Date: Mon, 6 Feb 2006 17:16:41 -0700
Message-ID: <200602061716.41470.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:35519 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932387AbWBGAQq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2006 19:16:46 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Karol Kozimor <sziwan@hell.org.pl>, julien.lerouge@free.fr, acpi4asus-user@lists.sourceforge.net, Stelian Pop <stelian@popies.net>, Narayanan R S <nars@kadamba.org>, Andrew Morton <akpm@osdl.org>

Registering a driver makes the driver available for devices, even
devices that may be hot-added later.  So the registration itself
should return only success or failure, not the number of devices
found.

pci_register_driver(), platform_driver_register(), and driver_register()
already work this way.  This series makes acpi_bus_register_driver()
also work that way.
