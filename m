From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 0/2] dma: support Lynxpoint DMA
Date: Wed,  8 May 2013 11:55:47 +0300
Message-ID: <1368003349-12204-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, spear-devel <spear-devel@list.st.com>, Vinod Koul <vinod.koul@intel.com>, linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

This is the rest of patch series related to ACPI DMA helpers and Lynxpoint DMAC.
Patches are rebased against current Linus' tree and Vinod's branch for-linus.

Since v2:
 - remove patches that are already in the Vinod's tree
 - rebase on top of today's origin/master and Vinod's for-linus branch
 - fix description in patch 2/2

I will be on vacation next week. Mika promised to help if anything happens to
these patches.

Andy Shevchenko (1):
  dma: acpi-dma: parse CSRT to extract additional resources

Rafael J. Wysocki (1):
  ACPI / LPSS: register clock device for Lynxpoint DMA properly

 drivers/acpi/Makefile                  |    1 -
 drivers/acpi/acpi_lpss.c               |   26 ++++-
 drivers/acpi/csrt.c                    |  159 -----------------------------
 drivers/acpi/internal.h                |    1 -
 drivers/acpi/scan.c                    |    1 -
 drivers/clk/x86/clk-lpt.c              |   15 ++-
 drivers/dma/acpi-dma.c                 |  172 +++++++++++++++++++++++++++++++-
 include/linux/acpi_dma.h               |    4 +
 include/linux/platform_data/clk-lpss.h |    5 +
 9 files changed, 211 insertions(+), 173 deletions(-)
 delete mode 100644 drivers/acpi/csrt.c

-- 
1.7.10.4
