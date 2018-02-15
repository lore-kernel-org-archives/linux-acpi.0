From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 0/5] PCI: Fixes for native PCIe and ACPI hotplug
Date: Thu, 15 Feb 2018 17:39:54 +0300
Message-ID: <20180215144000.60456-1-mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:42984 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033435AbeBOOkG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 15 Feb 2018 09:40:06 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com, Michael Jamet <michael.jamet@intel.com>, Yehezkel Bernat <yehezkel.bernat@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org

Hi,

When Thunderbolt controller is configured to be in native enumeration mode
it actually includes two slightly different modes. First there is non-RTD3
mode where the Thunderbolt host controller is only present when there is a
device connected. The second one is RTD3 mode where the controller is
always present.

In non-RTD3 mode the Thunderbolt host controller (NHI) and USB host (xHCI)
controller are not hotplugged using native PCIe hotplug but instead they
will be hotplugged via BIOS triggered ACPI Notify() to the root port. This
is done to preserve resources since the NHI and xHCI only need 1 MB of MMIO
space and no additional buses. Currently Linux does not support this very
well and ends up failing the hotplug in one way or another. More detailed
explanation is in changelog of patch [4/5].

This series fixes this issue and in addition includes fixes for few other
issues found during testing on a system that has Thunderbolt controller in
non-RTD3 native PCIe enumeration mode. However, the fixes here are not in
any way Thunderbolt specific and should be applicable to other systems as
well.

The previous version of the patch series can be found here:

  https://www.spinics.net/lists/linux-acpi/msg80607.html

Changes from the previous version:

  - Drop 'cmax - max ?: 1' and use similar construct than we use in second
    pass loop in patch [1/5].
  - Drop unnecessary parentheses in patch [1/5].
  - Added Rafael's tag to patches [2-5/5].

[ I'm sending this updated patch series now because my vacation starts
  tomorrow and I'll be away whole next week. If any further changes are
  needed, I'll do those when I'm back. ]

Mika Westerberg (5):
  PCI: Make sure all bridges reserve at least one bus number
  PCI: Take bridge window alignment into account when distributing resources
  PCI: pciehp: Clear Presence Detect and Data Link Layer Status Changed on resume
  ACPI / hotplug / PCI: Do not scan all bridges when native PCIe hotplug is used
  ACPI / hotplug / PCI: Mark stale PCI devices disconnected

 drivers/pci/hotplug/acpiphp.h      |  1 +
 drivers/pci/hotplug/acpiphp_glue.c | 78 ++++++++++++++++++++++++++++++--------
 drivers/pci/hotplug/pciehp.h       |  2 +-
 drivers/pci/hotplug/pciehp_core.c  |  2 +-
 drivers/pci/hotplug/pciehp_hpc.c   | 13 ++++++-
 drivers/pci/probe.c                | 11 ++++--
 drivers/pci/setup-bus.c            | 41 +++++++++++++++++++-
 7 files changed, 126 insertions(+), 22 deletions(-)

-- 
2.15.1

