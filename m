From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/5] dmaengine: add ACPI DMA helpers and use them in dw_dmac
Date: Tue,  9 Apr 2013 14:05:42 +0300
Message-ID: <1365505547-10552-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, spear-devel <spear-devel@list.st.com>, Vinod Koul <vinod.koul@intel.com>, linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

There is a patch series which introduces ACPI DMA helpers in similar way like
we have for DeviceTree.

In addition it applies this to the first user, namely dw_dmac driver.

Since v1:
 - address one Vinod's comment
 - replace 5/6 & 6/6 by 5/5 from Rafael
 - tested on Intel Lynxpoint system

Andy Shevchenko (4):
  dma: acpi-dma: introduce ACPI DMA helpers
  dmaengine: call acpi_dma_request_slave_channel as well
  dma: acpi-dma: parse CSRT to extract additional resources
  dw_dmac: add ACPI support

Rafael J. Wysocki (1):
  ACPI / LPSS: add support of shared clock

 Documentation/acpi/enumeration.txt     |  77 ++++++
 drivers/acpi/Makefile                  |   1 -
 drivers/acpi/acpi_lpss.c               |  26 +-
 drivers/acpi/csrt.c                    | 159 ------------
 drivers/acpi/internal.h                |   1 -
 drivers/acpi/scan.c                    |   1 -
 drivers/clk/x86/clk-lpt.c              |  15 +-
 drivers/dma/Kconfig                    |   4 +
 drivers/dma/Makefile                   |   1 +
 drivers/dma/acpi-dma.c                 | 445 +++++++++++++++++++++++++++++++++
 drivers/dma/dmaengine.c                |   6 +
 drivers/dma/dw_dmac.c                  |  68 +++--
 drivers/dma/dw_dmac_regs.h             |   1 -
 include/linux/acpi_dma.h               | 120 +++++++++
 include/linux/platform_data/clk-lpss.h |   5 +
 15 files changed, 741 insertions(+), 189 deletions(-)
 delete mode 100644 drivers/acpi/csrt.c
 create mode 100644 drivers/dma/acpi-dma.c
 create mode 100644 include/linux/acpi_dma.h

-- 
1.8.2.rc0.22.gb3600c3
