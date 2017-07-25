From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v4 0/2] iommu/smmu-v3: Workaround for hisilicon 161010801 erratum(reserve HW MSI)
Date: Tue, 25 Jul 2017 12:17:30 +0100
Message-ID: <20170725111732.41792-1-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([45.249.212.187]:10264 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750851AbdGYLTk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Jul 2017 07:19:40 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lorenzo.pieralisi@arm.com, marc.zyngier@arm.com, sudeep.holla@arm.com, will.deacon@arm.com, robin.murphy@arm.com, hanjun.guo@linaro.org
Cc: gabriele.paoloni@huawei.com, john.garry@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, devel@acpica.org, linuxarm@huawei.com, wangzhou1@hisilicon.com, guohanjun@huawei.com, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

On certain HiSilicon platforms (Hip06/Hip07) the GIC ITS and
PCIe RC deviates from the standard implementation and this breaks
PCIe MSI functionality when SMMU is enabled.

The HiSilicon erratum 161010801 describes this limitation of certain
HiSilicon platforms to support the SMMU mappings for MSI transactions.
On these platforms GICv3 ITS translator is presented with the deviceID
by extending the MSI payload data to 64 bits to include the deviceID.
Hence, the PCIe controller on this platforms has to differentiate the
MSI payload against other DMA payload and has to modify the MSI payload.
This basically makes it difficult for this platforms to have a SMMU
translation for MSI.

To implement this quirk, the following changes are incorporated:

1. Added a generic helper function to IORT code to retrieve and
   reserve the HW ITS address regions.
2. Modified iommu_dma_get_resv_regions() to reserve the hw msi
   regions which means these address regions will not be translated and
   will be excluded from iova allocations.

Thanks,
Shameer

Changelog:

v3 --> v4
Rebased on 4.13-rc1.
Addressed comments from Robin, Will and Lorenzo:
-As suggested by Robin, moved the ITS msi reservation into
 iommu_dma_get_resv_regions().
-Added its_count != resv region failure case(patch #1).

v2 --> v3
Addressed comments from Lorenzo and Robin:
-Removed dev_is_pci() check in smmuV3 driver.
-Don't treat device not having an ITS mapping as an error in
 iort helper function.

v1 --> v2
-patch 2/2: Invoke iort helper fn based on fwnode type(acpi).

RFCv2 -->PATCH
-Incorporated Lorenzo's review comments.

RFC v1 --> RFC v2
Based on Robin's review comments,
-Removed  the generic erratum framework.
-Using IORT/MADT tables to retrieve the ITS base addr instead
 of vendor specific CSRT table.

Shameer Kolothum (2):
  acpi:iort: Add an IORT helper function to reserve HW ITS address
    regions for IOMMU drivers
  iommu/dma: Add HW MSI address regions reservation for IOMMU drivers

 drivers/acpi/arm64/iort.c        | 91 ++++++++++++++++++++++++++++++++++++++--
 drivers/iommu/dma-iommu.c        |  8 +++-
 drivers/irqchip/irq-gic-v3-its.c |  3 +-
 include/linux/acpi_iort.h        |  8 +++-
 4 files changed, 104 insertions(+), 6 deletions(-)

-- 
1.9.1


