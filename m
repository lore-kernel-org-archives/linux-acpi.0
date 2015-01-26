From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 0/2] ACPICA: 201501xx fast path patches.
Date: Mon, 26 Jan 2015 16:58:34 +0800
Message-ID: <cover.1422261662.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:63948 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751623AbbAZI6n (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Jan 2015 03:58:43 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This patchset contains ACPICA 201501xx release patches.
They can be directly merged to the Linux kernel before the ACPICA 201501xx
release.

For PATCH 1, I rebased it on top of recent linux-next branch. Since we may
need to wait for the confirmation from Octavian, I marked it as RFC.

For PATCH 2, build tests are passed against the following configurations:
1. ia64/i386/x86_64 defconfig
2. ia64/i386/x86_64 allyesconfig
3. ia64/i386/x86_64 allnoconfig
4. ia64/i386/x86_64 defconfig & CONFIG_ACPI=n

Lv Zheng (2):
  ACPI: Introduce acpi_unload_parent_table() usages in Linux kernel.
  ACPICA: Resources: Provide common part for struct
    acpi_resource_address structures.

 arch/ia64/kernel/acpi-ext.c       |    6 ++--
 arch/ia64/pci/pci.c               |   14 ++++-----
 arch/x86/pci/acpi.c               |   26 ++++++++--------
 arch/x86/pci/mmconfig-shared.c    |    6 ++--
 drivers/acpi/acpi_memhotplug.c    |    8 ++---
 drivers/acpi/acpica/nsxfobj.c     |   44 ---------------------------
 drivers/acpi/acpica/rsaddr.c      |    9 +++---
 drivers/acpi/acpica/rsdumpinfo.c  |   59 +++++++++++++++++++------------------
 drivers/acpi/acpica/rsxface.c     |   10 +++----
 drivers/acpi/acpica/tbxface.c     |   46 -----------------------------
 drivers/acpi/pci_root.c           |    6 ++--
 drivers/acpi/resource.c           |   24 +++++++--------
 drivers/char/hpet.c               |    4 +--
 drivers/hv/vmbus_drv.c            |    4 +--
 drivers/pci/hotplug/sgi_hotplug.c |   13 ++++----
 drivers/pnp/pnpacpi/rsparser.c    |   16 +++++-----
 drivers/xen/xen-acpi-memhotplug.c |    8 ++---
 include/acpi/acpixf.h             |    6 ----
 include/acpi/acrestyp.h           |   40 +++++++++++++++----------
 19 files changed, 132 insertions(+), 217 deletions(-)

-- 
1.7.10

