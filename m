From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 4/7] ACPI / LPSS: override power state for LPSS DMA device
Date: Thu, 26 Nov 2015 17:19:10 +0200
Message-ID: <1448551153-84719-5-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1448551153-84719-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448551153-84719-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

This is a third approach to workaround long standing issue with LPSS on
BayTrail. First one [1] was reverted since it didn't resolve the issue
comprehensively. Second one [2] was rejected by internal review.

The LPSS DMA controller does not have neither _PS0 nor _PS3 method. Moreover it
can be powered off automatically whenever the last LPSS device goes down. In
case of no power any access to the DMA controller will hang the system. The
behaviour is reproduced on some HP laptops based on Intel BayTrail [3,4] as
well as on ASuS T100TA transformer.

Power on the LPSS island through the registers accessible in a specific way.

[1] http://www.spinics.net/lists/linux-acpi/msg53963.html
[2] https://bugzilla.redhat.com/attachment.cgi?id=1066779&action=diff
[3] https://bugzilla.redhat.com/show_bug.cgi?id=1184273
[4] http://www.spinics.net/lists/dmaengine/msg01514.html

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/Kconfig                |   3 +-
 arch/x86/include/asm/iosf_mbi.h |   2 +
 drivers/acpi/acpi_lpss.c        | 152 ++++++++++++++++++++++++++++++++++++++--
 3 files changed, 149 insertions(+), 8 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 324ac56..7fab0b9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -535,9 +535,10 @@ config X86_INTEL_QUARK
 
 config X86_INTEL_LPSS
 	bool "Intel Low Power Subsystem Support"
-	depends on ACPI
+	depends on X86 && ACPI
 	select COMMON_CLK
 	select PINCTRL
+	select IOSF_MBI
 	---help---
 	  Select to build support for Intel Low Power Subsystem such as
 	  found on Intel Lynxpoint PCH. Selecting this option enables
diff --git a/arch/x86/include/asm/iosf_mbi.h b/arch/x86/include/asm/iosf_mbi.h
index cdc5f63..b41ee16 100644
--- a/arch/x86/include/asm/iosf_mbi.h
+++ b/arch/x86/include/asm/iosf_mbi.h
@@ -19,6 +19,8 @@
 /* IOSF SB read/write opcodes */
 #define MBI_MMIO_READ		0x00
 #define MBI_MMIO_WRITE		0x01
+#define MBI_CFG_READ		0x04
+#define MBI_CFG_WRITE		0x05
 #define MBI_CR_READ		0x06
 #define MBI_CR_WRITE		0x07
 #define MBI_REG_READ		0x10
diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index a155dec..49d954b 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -15,11 +15,16 @@
 #include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/clk-lpss.h>
 #include <linux/pm_runtime.h>
 #include <linux/delay.h>
 
+#include <asm/cpu_device_id.h>
+#include <asm/iosf_mbi.h>
+#include <asm/pmc_atom.h>
+
 #include "internal.h"
 
 ACPI_MODULE_NAME("acpi_lpss");
@@ -71,7 +76,7 @@ struct lpss_device_desc {
 	void (*setup)(struct lpss_private_data *pdata);
 };
 
-static struct lpss_device_desc lpss_dma_desc = {
+static const struct lpss_device_desc lpss_dma_desc = {
 	.flags = LPSS_CLK,
 };
 
@@ -84,6 +89,105 @@ struct lpss_private_data {
 	u32 prv_reg_ctx[LPSS_PRV_REG_COUNT];
 };
 
+/* LPSS run time quirks */
+static unsigned int lpss_quirks;
+static DEFINE_MUTEX(lpss_iosf_mutex);
+
+/*
+ * LPSS_QUIRK_ALWAYS_POWER_ON: override power state for LPSS DMA device.
+ *
+ * The LPSS DMA controller does not have neither _PS0 nor _PS3 method. Moreover
+ * it can be powered off automatically whenever the last LPSS device goes down.
+ * In case of no power any access to the DMA controller will hang the system.
+ * The behaviour is reproduced on some HP laptops based on Intel BayTrail as
+ * well as on ASuS T100TA transformer.
+ *
+ * This quirk overrides power state of entire LPSS island to keep DMA powered
+ * on whenever we have at least one other device in use.
+ */
+#define LPSS_QUIRK_ALWAYS_POWER_ON	BIT(0)
+
+/* IOSF SB for LPSS island */
+#define LPSS_IOSF_UNIT_LPIOEP		0xA0
+#define LPSS_IOSF_UNIT_LPIO1		0xAB
+#define LPSS_IOSF_UNIT_LPIO2		0xAC
+
+#define LPSS_IOSF_PMCSR			0x84
+#define LPSS_PMCSR_D0			0
+#define LPSS_PMCSR_D3hot		3
+#define LPSS_PMCSR_Dx_MASK		GENMASK(1, 0)
+
+#define LPSS_IOSF_GPIODEF0		0x154
+#define LPSS_GPIODEF0_DMA1_D3		BIT(2)
+#define LPSS_GPIODEF0_DMA2_D3		BIT(3)
+#define LPSS_GPIODEF0_DMA_D3_MASK	GENMASK(3, 2)
+
+static void lpss_iosf_enter_d3_state(void)
+{
+	u32 value1 = 0;
+	u32 mask1 = LPSS_GPIODEF0_DMA_D3_MASK;
+	u32 value2 = LPSS_PMCSR_D3hot;
+	u32 mask2 = LPSS_PMCSR_Dx_MASK;
+	/*
+	 * PMC provides an information about actual status of the LPSS devices.
+	 * Here we read the values related to LPSS power island, i.e. LPSS
+	 * devices, excluding both LPSS DMA controllers, along with SCC domain.
+	 */
+	u32 func_dis, d3_sts_0, pmc_status, pmc_mask = 0xfe000ffe;
+	int ret;
+
+	ret = pmc_atom_read(PMC_FUNC_DIS, &func_dis);
+	if (ret)
+		return;
+
+	mutex_lock(&lpss_iosf_mutex);
+
+	ret = pmc_atom_read(PMC_D3_STS_0, &d3_sts_0);
+	if (ret)
+		goto exit;
+
+	/*
+	 * Get the status of entire LPSS power island per device basis.
+	 * Shutdown both LPSS DMA controllers if and only if all other devices
+	 * are already in D3hot.
+	 */
+	pmc_status = (~(d3_sts_0 | func_dis)) & pmc_mask;
+	if (pmc_status)
+		goto exit;
+
+	iosf_mbi_modify(LPSS_IOSF_UNIT_LPIO1, MBI_CFG_WRITE,
+			LPSS_IOSF_PMCSR, value2, mask2);
+
+	iosf_mbi_modify(LPSS_IOSF_UNIT_LPIO2, MBI_CFG_WRITE,
+			LPSS_IOSF_PMCSR, value2, mask2);
+
+	iosf_mbi_modify(LPSS_IOSF_UNIT_LPIOEP, MBI_CR_WRITE,
+			LPSS_IOSF_GPIODEF0, value1, mask1);
+exit:
+	mutex_unlock(&lpss_iosf_mutex);
+}
+
+static void lpss_iosf_exit_d3_state(void)
+{
+	u32 value1 = LPSS_GPIODEF0_DMA1_D3 | LPSS_GPIODEF0_DMA2_D3;
+	u32 mask1 = LPSS_GPIODEF0_DMA_D3_MASK;
+	u32 value2 = LPSS_PMCSR_D0;
+	u32 mask2 = LPSS_PMCSR_Dx_MASK;
+
+	mutex_lock(&lpss_iosf_mutex);
+
+	iosf_mbi_modify(LPSS_IOSF_UNIT_LPIOEP, MBI_CR_WRITE,
+			LPSS_IOSF_GPIODEF0, value1, mask1);
+
+	iosf_mbi_modify(LPSS_IOSF_UNIT_LPIO2, MBI_CFG_WRITE,
+			LPSS_IOSF_PMCSR, value2, mask2);
+
+	iosf_mbi_modify(LPSS_IOSF_UNIT_LPIO1, MBI_CFG_WRITE,
+			LPSS_IOSF_PMCSR, value2, mask2);
+
+	mutex_unlock(&lpss_iosf_mutex);
+}
+
 /* UART Component Parameter Register */
 #define LPSS_UART_CPR			0xF4
 #define LPSS_UART_CPR_AFCE		BIT(4)
@@ -196,13 +300,21 @@ static const struct lpss_device_desc bsw_i2c_dev_desc = {
 	.setup = byt_i2c_setup,
 };
 
-static struct lpss_device_desc bsw_spi_dev_desc = {
+static const struct lpss_device_desc bsw_spi_dev_desc = {
 	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_SAVE_CTX
 			| LPSS_NO_D3_DELAY,
 	.prv_offset = 0x400,
 	.setup = lpss_deassert_reset,
 };
 
+#define ICPU(model)	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
+
+static const struct x86_cpu_id lpss_cpu_ids[] = {
+	ICPU(0x37),	/* Valleyview, Bay Trail */
+	ICPU(0x4c),	/* Braswell, Cherry Trail */
+	{}
+};
+
 #else
 
 #define LPSS_ADDR(desc) (0UL)
@@ -645,7 +757,17 @@ static int acpi_lpss_runtime_suspend(struct device *dev)
 	if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
 		acpi_lpss_save_ctx(dev, pdata);
 
-	return acpi_dev_runtime_suspend(dev);
+	ret = acpi_dev_runtime_suspend(dev);
+
+	/*
+	 * This call must be last in the sequence, otherwise PMC will return
+	 * wrong status for devices being about to be powered off. See
+	 * lpss_iosf_enter_d3_state() for further information.
+	 */
+	if (lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
+		lpss_iosf_enter_d3_state();
+
+	return ret;
 }
 
 static int acpi_lpss_runtime_resume(struct device *dev)
@@ -653,6 +775,13 @@ static int acpi_lpss_runtime_resume(struct device *dev)
 	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
 	int ret;
 
+	/*
+	 * This call is kept first to be in symmetry with
+	 * acpi_lpss_runtime_suspend() one.
+	 */
+	if (lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
+		lpss_iosf_exit_d3_state();
+
 	ret = acpi_dev_runtime_resume(dev);
 	if (ret)
 		return ret;
@@ -766,10 +895,19 @@ static struct acpi_scan_handler lpss_handler = {
 
 void __init acpi_lpss_init(void)
 {
-	if (!lpt_clk_init()) {
-		bus_register_notifier(&platform_bus_type, &acpi_lpss_nb);
-		acpi_scan_add_handler(&lpss_handler);
-	}
+	const struct x86_cpu_id *id;
+	int ret;
+
+	ret = lpt_clk_init();
+	if (ret)
+		return;
+
+	id = x86_match_cpu(lpss_cpu_ids);
+	if (id)
+		lpss_quirks |= LPSS_QUIRK_ALWAYS_POWER_ON;
+
+	bus_register_notifier(&platform_bus_type, &acpi_lpss_nb);
+	acpi_scan_add_handler(&lpss_handler);
 }
 
 #else
-- 
2.6.2
