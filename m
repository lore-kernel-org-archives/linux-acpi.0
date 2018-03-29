From: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
Subject: [RFC PATCH 0/2] driver core: add new dl device status DL_DEV_PROBE_FAILED
Date: Thu, 29 Mar 2018 03:00:58 -0700
Message-ID: <1522317660-11080-1-git-send-email-dongsheng.wang@hxt-semitech.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lorenzo.pieralisi@arm.com
Cc: gregkh@linuxfoundation.org, hanjun.guo@linaro.org, sudeep.holla@arm.com, yu.zheng@hxt-semitech.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
List-Id: linux-acpi@vger.kernel.org

Recently we found the master of SMMU retries to probe endlessly.

[    3.658956] pci 0000:00:00.0: Retrying from deferred list
[    3.658969] pci 0000:00:00.0: Added to deferred list
[    3.658987] pci 0004:00:00.0: Retrying from deferred list
[    3.658994] pci 0004:00:00.0: Added to deferred list
[    3.659003] pci 0005:00:00.0: Retrying from deferred list
[    3.659010] pci 0005:00:00.0: Added to deferred list
[    3.659019] pci 0004:01:00.0: Retrying from deferred list
[    3.659029] pci 0004:01:00.0: Added to deferred list

The retrying should only happen when the IOMMU instance hasn't been
probed yet.
However, dma_configure() simply return -EPROBE_DEFER when failed to get
an IOMMU instance even if the IOMMU instance is failed to probe.

This patchset tries to fix the issue by distinguishing probe failures and
haven't-been-probed-yet state.

Wang Dongsheng (2):
  driver core: add new dl device status DL_DEV_PROBE_FAILED
  ACPI/IORT: use swiotlb_dma_ops when smmu probe failed

 Documentation/driver-api/device_link.rst |  2 +-
 drivers/acpi/arm64/iort.c                | 39 +++++++++++++++++++++++++++-----
 drivers/base/base.h                      |  2 +-
 drivers/base/core.c                      | 22 ++++++++++++++++--
 drivers/base/dd.c                        |  2 +-
 include/linux/device.h                   |  1 +
 6 files changed, 57 insertions(+), 11 deletions(-)

-- 
2.7.4
