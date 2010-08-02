From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/8] ACPI / PCI / PCIe: Rework _OSC handling (v2)
Date: Mon, 2 Aug 2010 23:51:31 +0200
Message-ID: <201008022351.31406.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57748 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755365Ab0HBWCv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 2 Aug 2010 18:02:51 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, linux-pm@lists.linux-foundation.org, linux-pci@vger.kernel.org, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Matthew Garrett <mjg59@srcf.ucam.org>

Hi,

This is the second iteration of the patchset based on
https://patchwork.kernel.org/patch/114917/ and the comments I received on that
patch.  Hopefully, I took all of the comments into account this time.

[1/8] - Introduce acpi_pci_osc_control_query() allowing the caller to get a
        mask of _OSC control bits the BIOS allows the kernel to control
        for a given PCI root bridge.

[2/8] - Introduce pci_aer_available() allowing the caller to check if the
        AER service driver should be enabled.

[3/8] - Introduce kernel command line switch pcie_ports=.

[4/8] - Rework the PCIe port driver to request _OSC control for all serives at
        once.

[5/8] - Disable PCIe port services (that might be enabled by the BIOS) during
        initialization.

[6/8] - Remove the PCIe port driver modules exit function.

[7/8] - Rework acpi_pci_osc_control_set() so that it doesn't use cached
        result of a query and remove the fields of struct acpi_pci_root that
       aren't used any more.

[8/8] - Reorder checks in acpi_pci_osc_control_set()

Thanks,
Rafael

