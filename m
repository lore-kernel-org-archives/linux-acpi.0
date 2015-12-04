From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 4/9] ACPI / LPSS: power on when probe() and otherwise when remove()
Date: Fri,  4 Dec 2015 23:49:20 +0200
Message-ID: <1449265765-9393-5-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1449265765-9393-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449265765-9393-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

When LPSS drivers are compiled as a module, which is usually the case, the
second probe of that driver may fail because the driver is written in an
assumption that device is powered on. That is not the case for all drivers.
Moreover we would like not drain power in vain.

Implement ->activate() and ->dismiss() callbacks in the ACPI LPSS custom power
domain.

-------- 8< -------- 8< -------- 8< -------- 8< -------- 8< --------

Case 1: The I2C probe() repeat.

/sys/bus/platform/devices/808622C1:00 \_SB_.PCI0.I2C1 [D3hot]
/sys/bus/platform/devices/808622C1:01 \_SB_.PCI0.I2C2 [D3hot]
/sys/bus/platform/devices/808622C1:02 \_SB_.PCI0.I2C3 [D3hot]
/sys/bus/platform/devices/808622C1:03 \_SB_.PCI0.I2C4 [D3hot]
/sys/bus/platform/devices/808622C1:05 \_SB_.PCI0.I2C6 [D3hot]
/sys/bus/platform/devices/808622C1:06 \_SB_.PCI0.I2C7 [D3hot]

% modprobe i2c-designware-platform
    i2c_designware 808622C1:00: Unknown Synopsys component type: 0xffffffff
    i2c_designware 808622C1:01: Unknown Synopsys component type: 0xffffffff
    i2c_designware 808622C1:02: Unknown Synopsys component type: 0xffffffff
    i2c_designware 808622C1:03: Unknown Synopsys component type: 0xffffffff
    i2c_designware 808622C1:05: Unknown Synopsys component type: 0xffffffff
    i2c_designware 808622C1:06: Unknown Synopsys component type: 0xffffffff

Case 2: The power drain in case of SDHCI.

/sys/bus/platform/devices/80860F14:00 \_SB_.PCI0.SDHA [D3hot]
/sys/bus/platform/devices/80860F14:01 \_SB_.PCI0.SDHC [D3hot]

% modprobe -r sdhci-acpi
    mmc0: card 0001 removed

/sys/bus/platform/devices/80860F14:00 \_SB_.PCI0.SDHA [D0]
/sys/bus/platform/devices/80860F14:01 \_SB_.PCI0.SDHC [D0]

-------- 8< -------- 8< -------- 8< -------- 8< -------- 8< --------

Patch fixes above problems.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/acpi_lpss.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 6263939..c5f12f3 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -596,6 +596,34 @@ static void acpi_lpss_restore_ctx(struct device *dev,
 	}
 }
 
+static int acpi_lpss_activate(struct device *dev)
+{
+	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
+	int ret;
+
+	ret = acpi_dev_runtime_resume(dev);
+	if (ret)
+		return ret;
+
+	acpi_lpss_d3_to_d0_delay(pdata);
+
+	/*
+	 * This is called only on ->probe() stage where a device is either in
+	 * known state defined by BIOS or most likely powered off. Due to this
+	 * we have to deassert reset line to be sure that ->probe() will
+	 * recognize the device.
+	 */
+	if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
+		lpss_deassert_reset(pdata);
+
+	return 0;
+}
+
+static void acpi_lpss_dismiss(struct device *dev)
+{
+	acpi_dev_runtime_suspend(dev);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int acpi_lpss_suspend_late(struct device *dev)
 {
@@ -660,6 +688,10 @@ static int acpi_lpss_runtime_resume(struct device *dev)
 #endif /* CONFIG_PM */
 
 static struct dev_pm_domain acpi_lpss_pm_domain = {
+#ifdef CONFIG_PM
+	.activate = acpi_lpss_activate,
+	.dismiss = acpi_lpss_dismiss,
+#endif
 	.ops = {
 #ifdef CONFIG_PM
 #ifdef CONFIG_PM_SLEEP
-- 
2.6.2
