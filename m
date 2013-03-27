From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 5/6] ACPI / LPSS: return no error from register_device_clock in special cases
Date: Wed, 27 Mar 2013 10:58:01 +0200
Message-ID: <1364374682-8547-6-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1364374682-8547-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1364374682-8547-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, spear-devel <spear-devel@list.st.com>, Vinod Koul <vinod.koul@intel.com>, linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

When device uses the fixed clock and has no private space of LTR, we have to
create main LPSS clock and register platform device. This is normally a case
for LPSS DMA controller.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/acpi_lpss.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index b1c9542..4015929 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -95,6 +95,10 @@ static int register_device_clock(struct acpi_device *adev,
 	if (!lpss_clk_dev)
 		lpt_register_clock_device();
 
+	if (!dev_desc->prv_offset && dev_desc->clk_required)
+		/* There is no error when device uses fixed clock */
+		return 0;
+
 	if (!dev_desc->clk_parent || !pdata->mmio_base
 	    || pdata->mmio_size < dev_desc->prv_offset + LPSS_CLK_SIZE)
 		return -ENODATA;
-- 
1.8.2.rc0.22.gb3600c3
