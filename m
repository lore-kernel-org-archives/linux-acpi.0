From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/10] ACPI / PCI / PCIe: Rework _OSC handling (v4)
Date: Sat, 21 Aug 2010 01:49:39 +0200
Message-ID: <201008210149.39576.rjw@sisk.pl>
References: <201008060303.51224.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:59481 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750843Ab0HUABc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Aug 2010 20:01:32 -0400
In-Reply-To: <201008060303.51224.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: linux-pm@lists.linux-foundation.org, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg@redhat.com>

Hi,
 
This is the 4th iteration of the patchset based on
https://patchwork.kernel.org/patch/114917/ and the comments I received on that
patch and the previous three iterations of this patchset.
 
[1/10] - Introduce pci_aer_available() allowing the caller to check if the
         AER service driver should be enabled.
 
[2/10] - Introduce kernel command line switch pcie_ports=.
 
[3/10] - Reorder checks in acpi_pci_osc_control_set().

[4/10] - Make acpi_pci_query_osc() return control bits obtained from the BIOS.

[5/10] - Do not cache _OSC query results.

[6/10] - Negotiate _OSC control bits before requesting control from the BIOS.

[7/10] - Rework the PCIe port driver to request _OSC control for all serives at
          once (that also affects ASPM now, Matthew please check).

[8/10] - Disable PCIe port services (that might be enabled by the BIOS) during
          initialization.

[9/10] - Move the PCIe PME code to drivers/pci/pcie/.

[10/10] - Remove the PCIe port driver modules exit function.

Comments welcome.
 
Thanks,
Rafael

