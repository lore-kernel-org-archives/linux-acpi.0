From: Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCHv2 0/2] Fixups for mixed pcie_ports=auto and native
Date: Fri,  8 Apr 2016 11:35:49 -0600
Message-ID: <1460136951-28217-1-git-send-email-jonathan.derrick@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:20483 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751707AbcDHRgg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Apr 2016 13:36:36 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net
Cc: Jon Derrick <jonathan.derrick@intel.com>, helgaas@kernel.org, keith.busch@intel.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org

This set introduces a fixup that lets non-acpi pcie ports subscribe to
native port services. The theory is that on an acpi system, native
services will require acpi to release control of the port instance.

Rather than failing on non-acpi devices, we should continue as if they
were native to begin with, and try to subscribe to native services just
the same.

No change from v1 - the emails just didn't reach all of their targets

Jon Derrick (2):
  PCI/ACPI: Do not fail ports without ACPI entries
  PCI/PCIe: Fixups for acpi port setup not being allowed to fail

 drivers/pci/pcie/portdrv.h      | 11 ++++-------
 drivers/pci/pcie/portdrv_acpi.c | 10 ++++------
 drivers/pci/pcie/portdrv_core.c |  8 ++------
 3 files changed, 10 insertions(+), 19 deletions(-)

-- 
1.8.3.1

