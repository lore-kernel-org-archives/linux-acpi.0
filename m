From: fu.wei@linaro.org
Subject: [PATCH v8 9/9] acpi/arm64: Add SBSA Generic Watchdog support in GTDT driver
Date: Wed, 20 Jul 2016 02:18:04 +0800
Message-ID: <1468952284-28942-10-git-send-email-fu.wei@linaro.org>
References: <1468952284-28942-1-git-send-email-fu.wei@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1468952284-28942-1-git-send-email-fu.wei@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de, marc.zyngier@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, hanjun.guo@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org, timur@codeaurora.org, graeme.gregory@linaro.org, al.stone@linaro.org, jcm@redhat.com, wei@redhat.com, arnd@arndb.de, wim@iguana.be, catalin.marinas@arm.com, will.deacon@arm.com, Suravee.Suthikulpanit@amd.com, leo.duran@amd.com, linux@roeck-us.net, linux-watchdog@vger.kernel.org, Fu Wei <fu.wei@linaro.org>
List-Id: linux-acpi@vger.kernel.org

=46rom: Fu Wei <fu.wei@linaro.org>

This driver adds support for parsing SBSA Generic Watchdog timer
in GTDT, parse all info in SBSA Generic Watchdog Structure in GTDT,
and creating a platform device with that information.

This allows the operating system to obtain device data from the
resource of platform device. The platform device named "sbsa-gwdt"
can be used by the ARM SBSA Generic Watchdog driver.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/arm64/acpi_gtdt.c | 88 ++++++++++++++++++++++++++++++++++=
++++++++
 drivers/watchdog/Kconfig       |  1 +
 2 files changed, 89 insertions(+)

diff --git a/drivers/acpi/arm64/acpi_gtdt.c b/drivers/acpi/arm64/acpi_g=
tdt.c
index b48e443..45ac0f8 100644
--- a/drivers/acpi/arm64/acpi_gtdt.c
+++ b/drivers/acpi/arm64/acpi_gtdt.c
@@ -14,6 +14,7 @@
 #include <linux/acpi.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/platform_device.h>
=20
 #include <clocksource/arm_arch_timer.h>
=20
@@ -222,3 +223,90 @@ int __init gtdt_arch_timer_mem_init(struct gt_bloc=
k_data *data)
=20
 	return index;
 }
+
+/*
+ * Initialize a SBSA generic Watchdog platform device info from GTDT
+ */
+static int __init gtdt_import_sbsa_gwdt(void *platform_timer, int inde=
x)
+{
+	struct platform_device *pdev;
+	struct acpi_gtdt_watchdog *wd =3D platform_timer;
+	int irq =3D map_generic_timer_interrupt(wd->timer_interrupt,
+					      wd->timer_flags);
+	int no_irq =3D 1;
+
+	/*
+	 * According to SBSA specification the size of refresh and control
+	 * frames of SBSA Generic Watchdog is SZ_4K(Offset 0x000 =E2=80=93 0x=
=46FF).
+	 */
+	struct resource res[] =3D {
+		DEFINE_RES_MEM(wd->control_frame_address, SZ_4K),
+		DEFINE_RES_MEM(wd->refresh_frame_address, SZ_4K),
+		DEFINE_RES_IRQ(irq),
+	};
+
+	pr_debug("found a Watchdog (0x%llx/0x%llx gsi:%u flags:0x%x).\n",
+		 wd->refresh_frame_address, wd->control_frame_address,
+		 wd->timer_interrupt, wd->timer_flags);
+
+	if (!(wd->refresh_frame_address && wd->control_frame_address)) {
+		pr_err(FW_BUG "failed to get the Watchdog base address.\n");
+		return -EINVAL;
+	}
+
+	if (!wd->timer_interrupt)
+		pr_warn(FW_BUG "failed to get the Watchdog interrupt.\n");
+	else if (irq <=3D 0)
+		pr_warn("failed to map the Watchdog interrupt.\n");
+	else
+		no_irq =3D 0;
+
+	/*
+	 * Add a platform device named "sbsa-gwdt" to match the platform driv=
er.
+	 * "sbsa-gwdt": SBSA(Server Base System Architecture) Generic Watchdo=
g
+	 * The platform driver (like drivers/watchdog/sbsa_gwdt.c)can get dev=
ice
+	 * info below by matching this name.
+	 */
+	pdev =3D platform_device_register_simple("sbsa-gwdt", index, res,
+					       ARRAY_SIZE(res) - no_irq);
+	if (IS_ERR(pdev)) {
+		acpi_unregister_gsi(wd->timer_interrupt);
+		return PTR_ERR(pdev);
+	}
+
+	return 0;
+}
+
+static int __init gtdt_sbsa_gwdt_init(void)
+{
+	struct acpi_table_header *table;
+	void *platform_timer;
+	int index =3D 0;
+	int ret;
+
+	if (acpi_disabled)
+		return 0;
+
+	if (ACPI_FAILURE(acpi_get_table(ACPI_SIG_GTDT, 0, &table)))
+		return -EINVAL;
+
+	ret =3D acpi_gtdt_init(table);
+	if (ret <=3D 0)
+		return ret;
+
+	for_each_platform_timer(platform_timer) {
+		if (!is_watchdog(platform_timer))
+			continue;
+		ret =3D gtdt_import_sbsa_gwdt(platform_timer, index);
+		if (ret)
+			break;
+		index++;
+	}
+
+	if (index)
+		pr_info("found %d SBSA generic Watchdog(s).\n", index);
+
+	return ret;
+}
+
+device_initcall(gtdt_sbsa_gwdt_init);
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index b4b3e25..4019792 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -206,6 +206,7 @@ config ARM_SBSA_WATCHDOG
 	tristate "ARM SBSA Generic Watchdog"
 	depends on ARM64
 	depends on ARM_ARCH_TIMER
+	depends on ACPI_GTDT || !ACPI
 	select WATCHDOG_CORE
 	help
 	  ARM SBSA Generic Watchdog has two stage timeouts:
--=20
2.5.5
