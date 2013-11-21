From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 0/6] ACPICA: 20131115 Release
Date: Thu, 21 Nov 2013 12:17:03 +0800
Message-ID: <cover.1384747396.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31738 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750906Ab3KUERa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Nov 2013 23:17:30 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

The 20131115 ACPICA kernel resident system updates is linuxized based on
the pm/linux-next branch.

The patch set has passed a build/boot test on the following machines:
Dell Inspiron Mini 1010 (i386)
HP Compaq 8200 Elite SFF PC (x86-64)
With the following kernel configuration items enabled:
  CONFIG_ACPI
  CONFIG_SFI
  CONFIG_ACPI_AC
  CONFIG_ACPI_BATTERY
  CONFIG_ACPI_BUTTON
  CONFIG_ACPI_VIDEO
  CONFIG_ACPI_FAN
  CONFIG_ACPI_DOCK
  CONFIG_ACPI_PROCESSOR
  CONFIG_ACPI_PROCESSOR_AGGREGATOR
  CONFIG_ACPI_IPMI
  CONFIG_ACPI_THERMAL
  CONFIG_ACPI_CONTAINER
  CONFIG_ACPI_SBS
  CONFIG_ACPI_NUMA
  CONFIG_ACPI_HED
  CONFIG_ACPI_APEI
  CONFIG_ACPI_APEI_GHES
  CONFIG_ACPI_APEI_EINJ
  CONFIG_ACPI_APEI_ERST_DEBUG
  CONFIG_X86_PM_TIMER
  CONFIG_CPU_FREQ
  CONFIG_I2C_SCMI
  CONFIG_DMAR_TABLE
  CONFIG_INTEL_IOMMU
  CONFIG_IRQ_REMAP
  CONFIG_BLK_DEV_IDEACPI
  CONFIG_DRM_I915
  CONFIG_DRM_RADEON
  CONFIG_DRM_NOUVEAU
  CONFIG_SENSORS_ACPI_POWER
  CONFIG_SENSORS_ATK0110
  CONFIG_INPUT_ATLAS_BTNS
  CONFIG_TCG_TPM
  All devices under CONFIG_X86_PLATFORM_DEVICES

Please review.

Bob Moore (3):
  ACPICA: Debug output: Do not emit function nesting level for kernel
    build.
  ACPICA: Add support to delete all objects attached to the root
    namespace node.
  ACPICA: Update version to 20131115.

Lv Zheng (2):
  ACPICA: Tests: Add CHECKSUM_ABORT protection for test utilities.
  ACPICA: Resources: Fix loop termination for the get AML length
    function.

Tomasz Nowicki (1):
  ACPICA: Delete all attached data objects during namespace node
    deletion.

 drivers/acpi/acpica/acresrc.h  |    6 +++---
 drivers/acpi/acpica/nsalloc.c  |   18 ++++++++++++++----
 drivers/acpi/acpica/nsutils.c  |   18 ++++++++++--------
 drivers/acpi/acpica/rscalc.c   |    9 +++++++--
 drivers/acpi/acpica/rscreate.c |   36 +++++++++++++++++-------------------
 drivers/acpi/acpica/rsutils.c  |    2 +-
 drivers/acpi/acpica/utdebug.c  |   31 ++++++++++++++++++++++++-------
 include/acpi/acconfig.h        |    2 ++
 include/acpi/acpixf.h          |    2 +-
 9 files changed, 79 insertions(+), 45 deletions(-)

-- 
1.7.10

