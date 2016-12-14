From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 0/4] ACPI / osl: Cleans up acpi_get_table_with_size()/early_acpi_os_unmap_memory()
Date: Wed, 14 Dec 2016 15:04:13 +0800
Message-ID: <cover.1481698041.git.lv.zheng@intel.com>
References: <cover.1480490191.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46685 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753199AbcLNHEZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 14 Dec 2016 02:04:25 -0500
In-Reply-To: <cover.1480490191.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

acpi_get_table_with_size() is invented to be a replacement of
acpi_get_table() during the early stage so that the early mapped pointer
will not be stored in ACPICA core (acpi_get_table() forces to do so) and
thus the late stage acpi_get_table() won't return a wrong stored pointer.

Since there is early_acpi_os_unmap_memory() required to be invoked as a
reversal of acpi_get_table_with_size(), ACPICA can provide acpi_put_table()
to achieve the same purpose. As long as all early stage acpi_get_table()
calls are paired by early stage acpi_put_table() calls, mappings should be
released before entering the late stage. And the late stage
acpi_get_table() calls will map the table using a late stage ioremap
mechanism.

This patchset cleans up the old APIs and reduces divergences between Linux
and ACPICA upstream.

Lv Zheng (4):
  ACPICA: Tables: Back port acpi_get_table_with_size() and
    early_acpi_os_unmap_memory() from Linux kernel
  ACPICA: Tables: Allow FADT to be customized with virtual address
  ACPI / osl: Remove
    acpi_get_table_with_size()/early_acpi_os_unmap_memory() users
  ACPI / osl: Remove deprecated
    acpi_get_table_with_size()/early_acpi_os_unmap_memory()

 arch/arm64/include/asm/acpi.h            |    2 +-
 arch/arm64/kernel/acpi.c                 |    7 +-
 drivers/acpi/acpica/actables.h           |    6 ++
 drivers/acpi/acpica/tbfadt.c             |   14 ++--
 drivers/acpi/acpica/tbutils.c            |   85 +++++++++++++++++++
 drivers/acpi/acpica/tbxface.c            |  130 +++++++++++++++++++-----------
 drivers/acpi/bus.c                       |    2 +-
 drivers/acpi/nfit/core.c                 |    3 +-
 drivers/acpi/osl.c                       |   15 ++--
 drivers/acpi/processor_core.c            |    8 +-
 drivers/acpi/spcr.c                      |    8 +-
 drivers/acpi/tables.c                    |   17 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c |    3 +-
 drivers/gpu/drm/radeon/radeon_bios.c     |    3 +-
 drivers/iommu/amd_iommu_init.c           |   10 +--
 drivers/iommu/dmar.c                     |    7 +-
 drivers/mailbox/pcc.c                    |    5 +-
 include/acpi/acpi_io.h                   |    2 +
 include/acpi/acpixf.h                    |   17 ++--
 include/acpi/actbl.h                     |    1 +
 include/acpi/platform/aclinuxex.h        |    1 -
 21 files changed, 224 insertions(+), 122 deletions(-)

-- 
1.7.10

