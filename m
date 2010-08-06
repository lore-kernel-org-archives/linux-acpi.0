From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/10] ACPI / PCI / PCIe: Rework _OSC handling (v3)
Date: Fri, 6 Aug 2010 03:03:51 +0200
Message-ID: <201008060303.51224.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43664 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934268Ab0HFBRo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 5 Aug 2010 21:17:44 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org

Hi,

This is the 3rd iteration of the patchset based on
https://patchwork.kernel.org/patch/114917/ and the comments I received on that
patch and the previous two iterations of this patchset.

The patches below do not make the intermediate step to put an unconditional
_OSC query into acpi_pci_osc_control_set(), but the final result is quite
similar to the 2nd iteration with https://patchwork.kernel.org/patch/116976/
applied on top.

[1/10] - Introduce acpi_pci_osc_control_query() allowing the caller to get a
         mask of _OSC control bits the BIOS allows the kernel to control
         for a given PCI root bridge.  This version repeats _OSC queries until
         the BIOS doesn't mask any requested bits.

[2/10] - Introduce pci_aer_available() allowing the caller to check if the
         AER service driver should be enabled.

[3/10] - Introduce kernel command line switch pcie_ports=.

[4/10] - Rework the PCIe port driver to request _OSC control for all serives at
         once.

[5/10] - Disable PCIe port services (that might be enabled by the BIOS) during
         initialization.

[6/10] - Remove the PCIe port driver modules exit function.

[7/10] - Make PCI hotplug code query _OSC before requesting control of _OSC
         features.

[8/10] - Rework acpi_pci_osc_control_set() so that it doesn't use cached
        result of a query and remove the fields of struct acpi_pci_root that
        aren't used any more.

[9/10] - Reorder checks in acpi_pci_osc_control_set().

[10/10] - Merge acpi_pci_osc_control_set() with acpi_pci_osc_control_query().

Comments welcome.

Thanks,
Rafael

