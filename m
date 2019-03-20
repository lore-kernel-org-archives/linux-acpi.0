From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 00/25] coresight: Support for ACPI bindings
Date: Wed, 20 Mar 2019 18:49:17 +0000
Message-ID: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, coresight@lists.linaro.org, mike.leach@linaro.org, robert.walker@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-acpi@vger.kernel.org

This series adds the support for CoreSight devices on ACPI based
platforms. The device connections are encoded as _DSD graph property[0],
with CoreSight specific extensions to indicate the direction of data
flow as described in [1]. Components attached to CPUs are listed
as child devices of the corresponding CPU, removing explicit links
to the CPU like we do in the DT.

As a prepartion for the ACPI support, we merge the driver for dynamic
and non-programmable replicators. We introduce platform independent
helpers to parse the platform supplied information. Thus we rename
the platform handling code from:
	of_coresight.c  => coresight-platform.c

The CoreSight driver creates shadow devices that appear on the Coresight
bus, in addition to the real devices (e.g, AMBA bus devices). The name
of these devices match the real device. This makes the device name
a bit cryptic for ACPI platform. So this series also introduces a generic
platform agnostic device naming scheme for the shadow Coresight devices.
Towards this we also make changes to the way we lookup devices to resolve
the connections, as we can't use the names to identify the devices. So,
we use the "fwnode_handle" of the real device for the device lookups.
Towards that we clean up the drivers to keep track of the "CoreSight"
device rather than the "real" device. However, all real operations,
like DMA allocation, Power management etc. must be performed on
the real device which is the parent of the shadow device.

Finally we add the support for parsing the ACPI platform data. The power
management support is missing in the ACPI (and this is not specific to
CoreSight). The firmware must ensure that the respective power domains
are turned on.

Applies on v5.1-rc1

Tested on a Juno-r0 board with ACPI bindings patch (Patch 26/25) added on
top of [2]. You would need to make sure that the debug power domain is
turned on before the Linux kernel boots. (e.g, connect the DS-5 to the
Juno board while at UEFI). arm32 code is only compile tested.

[0] ACPI Device Graphs using _DSD (Not available online yet, approved but
    awaiting publish and eventually should be linked at).
    https://uefi.org/sites/default/files/resources/_DSD-implementation-guide-toplevel-1_1.htm
[1] https://developer.arm.com/docs/den0067/latest/acpi-for-coresighttm-10-platform-design-document
[2] https://github.com/tianocore/edk2-platforms.git

Suzuki K Poulose (25):
  coresight: tmc: Report DMA setup failures
  coresight: dynamic-replicator: Clean up error handling
  coresight: replicator: Prepare for merging with dynamic-replicator
  coresight: dynamic-replicator: Prepare for merging with static
    replicator
  coresight: Merge the static and dynamic replicator drivers
  coresight: funnel: Clean up device book keeping
  coresight: replicator: Cleanup device tracking
  coresight: tmc: Clean up device specific data
  coresight: catu: Cleanup device specific data
  coresight: tpiu: Clean up device specific data
  coresight: stm: Cleanup device specific data
  coresight: etm: Clean up device specific data
  coresight: etb10: Clean up device specific data
  coresight: Rename of_coresight to coresight-platform
  coresight: etm3x: Rearrange cp14 access detection
  coresight: stm: Rearrange probing the stimulus area
  coresight: tmc-etr: Rearrange probing default buffer size
  coresight: Introduce generic platform data helper
  coresight: Make device to CPU mapping generic
  coresight: platform: Use fwnode handle for device search
  coresight: Use fwnode handle instead of device names
  coresight: Use platform agnostic names
  coresight: stm: ACPI support for parsing stimulus base
  coresight: Support for ACPI bindings
  coresight: acpi: Support for components

 drivers/acpi/acpi_amba.c                           |   9 +
 drivers/hwtracing/coresight/Kconfig                |   8 -
 drivers/hwtracing/coresight/Makefile               |   4 +-
 drivers/hwtracing/coresight/coresight-catu.c       |  38 +-
 drivers/hwtracing/coresight/coresight-catu.h       |   1 -
 drivers/hwtracing/coresight/coresight-cpu-debug.c  |   3 +-
 .../coresight/coresight-dynamic-replicator.c       | 255 --------
 drivers/hwtracing/coresight/coresight-etb10.c      |  23 +-
 drivers/hwtracing/coresight/coresight-etm3x.c      |  23 +-
 drivers/hwtracing/coresight/coresight-etm4x.c      |  19 +-
 drivers/hwtracing/coresight/coresight-funnel.c     |  27 +-
 drivers/hwtracing/coresight/coresight-platform.c   | 723 +++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-priv.h       |   2 +
 drivers/hwtracing/coresight/coresight-replicator.c | 255 ++++++--
 drivers/hwtracing/coresight/coresight-stm.c        | 119 +++-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |  26 +-
 drivers/hwtracing/coresight/coresight-tmc.c        |  71 +-
 drivers/hwtracing/coresight/coresight-tpiu.c       |  29 +-
 drivers/hwtracing/coresight/coresight.c            |  77 ++-
 drivers/hwtracing/coresight/of_coresight.c         | 297 ---------
 include/linux/coresight.h                          |  43 +-
 21 files changed, 1287 insertions(+), 765 deletions(-)
 delete mode 100644 drivers/hwtracing/coresight/coresight-dynamic-replicator.c
 create mode 100644 drivers/hwtracing/coresight/coresight-platform.c
 delete mode 100644 drivers/hwtracing/coresight/of_coresight.c

ACPI bindings for Juno-r0 (applies on [2] above)

Suzuki K Poulose (1):
  edk2-platform: juno: Update ACPI CoreSight Bindings

 Platform/ARM/JunoPkg/AcpiTables/Dsdt.asl | 241 +++++++++++++++++++++++++++++++
 1 file changed, 241 insertions(+)

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>

-- 
2.7.4
