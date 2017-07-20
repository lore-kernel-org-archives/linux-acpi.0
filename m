From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 0/4] ACPI: DMA ranges management
Date: Thu, 20 Jul 2017 15:45:12 +0100
Message-ID: <20170720144517.32529-1-lorenzo.pieralisi@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55016 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932138AbdGTOnd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 20 Jul 2017 10:43:33 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Will Deacon <will.deacon@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Feng Kan <fkan@apm.com>, Jon Masters <jcm@redhat.com>, Robert Moore <robert.moore@intel.com>, Robin Murphy <robin.murphy@arm.com>, Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nate Watterson <nwatters@codeaurora.org>

As reported in:

http://lkml.kernel.org/r/CAL85gmA_SSCwM80TKdkZqEe+S1beWzDEvdki1kpkmUTDRmSP7g@mail.gmail.com

the bus connecting devices to an IOMMU bus can be smaller in size than
the IOMMU input address bits which results in devices DMA HW bugs in
particular related to IOVA allocation (ie chopping of higher address
bits owing to system bus HW capabilities mismatch with the IOMMU).

Fortunately this problem can be solved through an already present but never
used ACPI 6.2 firmware bindings (ie _DMA object) allowing to define the DMA
window for a specific bus in ACPI and therefore all upstream devices
connected to it.

This small patch series enables _DMA parsing in ACPI core code and
use it in ACPI IORT code in order to detect DMA ranges for devices and
update their data structures to make them work with their related DMA
addressing restrictions.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Feng Kan <fkan@apm.com>
Cc: Jon Masters <jcm@redhat.com>
Cc: Robert Moore <robert.moore@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>

Lorenzo Pieralisi (4):
  ACPI: Allow _DMA method in walk resources
  ACPI: Make acpi_dev_get_resources() method agnostic
  ACPI: Introduce DMA ranges parsing
  ACPI: Make acpi_dma_configure() DMA regions aware

 drivers/acpi/acpica/rsxface.c |  7 ++--
 drivers/acpi/arm64/iort.c     | 27 +++++++++++-
 drivers/acpi/resource.c       | 83 ++++++++++++++++++++++++++++---------
 drivers/acpi/scan.c           | 95 +++++++++++++++++++++++++++++++++++++++----
 include/acpi/acnames.h        |  1 +
 include/acpi/acpi_bus.h       |  2 +
 include/linux/acpi.h          |  8 ++++
 include/linux/acpi_iort.h     |  5 ++-
 8 files changed, 194 insertions(+), 34 deletions(-)

-- 
2.10.0

