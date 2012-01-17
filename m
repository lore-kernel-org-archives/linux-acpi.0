From: Rob Lee <rob.lee@linaro.org>
Subject: Re: [RFC PATCH v2] ARM: imx: Add basic imx6q thermal management
Date: Mon, 16 Jan 2012 23:11:42 -0600
Message-ID: <CAMXH7KFdBQmh9eQYXU4Hzg=M9cxyJWzDKouYsGUp+POw0FRXqQ@mail.gmail.com>
References: <1326775136-32115-1-git-send-email-rob.lee@linaro.org>
	<CAMXH7KEhv9LgvvJ-FnLfaFZNgvJu2gOhFDwpYHDzN9iCDXHjJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:56427 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158Ab2AQFLm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2012 00:11:42 -0500
Received: by qcsf13 with SMTP id f13so1880790qcs.19
        for <linux-acpi@vger.kernel.org>; Mon, 16 Jan 2012 21:11:42 -0800 (PST)
In-Reply-To: <CAMXH7KEhv9LgvvJ-FnLfaFZNgvJu2gOhFDwpYHDzN9iCDXHjJw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux@arm.linux.org.uk, s.hauer@pengutronix.de, shawn.guo@freescale.com
Cc: amit.kachhap@linaro.org, amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, linux-acpi@vger.kernel.org, lenb@kernel.org

Arrrrgh, just noticed I sent the wrong patch.  Here is the correct one:

Adds support for temperature sensor readings, registers with common
thermal framework, and uses the new common cpu_cooling interface.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 arch/arm/boot/dts/imx6q.dtsi    |    1 +
 drivers/thermal/Kconfig         |    6 +
 drivers/thermal/Makefile        |    1 +
 drivers/thermal/imx6q_thermal.c |  547 +++++++++++++++++++++++++++++++=
++++++++
 4 files changed, 555 insertions(+), 0 deletions(-)
 create mode 100644 drivers/thermal/imx6q_thermal.c

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dts=
i
index 7dda599..d62b88d 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -508,6 +508,7 @@
 			};

 			ocotp@021bc000 {
+				compatible =3D "fsl,imx6q-ocotp";
 				reg =3D <0x021bc000 0x4000>;
 			};

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 298c1cd..dd8cede 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -29,3 +29,9 @@ config CPU_THERMAL
 	  This will be useful for platforms using the generic thermal interfa=
ce
 	  and not the ACPI interface.
 	  If you want this support, you should say Y or M here.
+
+config IMX6Q_THERMAL
+	bool "IMX6Q Thermal interface support"
+	depends on THERMAL && CPU_THERMAL
+	help
+	  Adds thermal management for IMX6Q.
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 655cbc4..e2bcffe 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -4,3 +4,4 @@

 obj-$(CONFIG_THERMAL)		+=3D thermal_sys.o
 obj-$(CONFIG_CPU_THERMAL)	+=3D cpu_cooling.o
+obj-$(CONFIG_IMX6Q_THERMAL)	+=3D imx6q_thermal.o
diff --git a/drivers/thermal/imx6q_thermal.c b/drivers/thermal/imx6q_th=
ermal.c
new file mode 100644
index 0000000..c7174b5
--- /dev/null
+++ b/drivers/thermal/imx6q_thermal.c
@@ -0,0 +1,547 @@
+/*
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ * Copyright 2012 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/* i.MX6Q Thermal Implementation */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/dmi.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/types.h>
+#include <linux/thermal.h>
+#include <linux/io.h>
+#include <linux/syscalls.h>
+#include <linux/cpufreq.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/smp.h>
+#include <linux/cpu_cooling.h>
+#include <linux/platform_device.h>
+
+/* register define of anatop */
+#define HW_ANADIG_ANA_MISC0			0x00000150
+#define HW_ANADIG_ANA_MISC0_SET			0x00000154
+#define HW_ANADIG_ANA_MISC0_CLR			0x00000158
+#define HW_ANADIG_ANA_MISC0_TOG			0x0000015c
+#define BM_ANADIG_ANA_MISC0_REFTOP_SELBIASOFF	0x00000008
+
+#define HW_ANADIG_TEMPSENSE0			0x00000180
+#define HW_ANADIG_TEMPSENSE0_SET		0x00000184
+#define HW_ANADIG_TEMPSENSE0_CLR		0x00000188
+#define HW_ANADIG_TEMPSENSE0_TOG		0x0000018c
+
+#define BP_ANADIG_TEMPSENSE0_TEMP_VALUE		8
+#define BM_ANADIG_TEMPSENSE0_TEMP_VALUE		0x000FFF00
+#define BM_ANADIG_TEMPSENSE0_FINISHED		0x00000004
+#define BM_ANADIG_TEMPSENSE0_MEASURE_TEMP	0x00000002
+#define BM_ANADIG_TEMPSENSE0_POWER_DOWN		0x00000001
+
+#define HW_ANADIG_TEMPSENSE1			0x00000190
+#define HW_ANADIG_TEMPSENSE1_SET		0x00000194
+#define HW_ANADIG_TEMPSENSE1_CLR		0x00000198
+#define BP_ANADIG_TEMPSENSE1_MEASURE_FREQ	0
+#define BM_ANADIG_TEMPSENSE1_MEASURE_FREQ	0x0000FFFF
+
+#define HW_OCOTP_ANA1				0x000004E0
+
+#define IMX6Q_THERMAL_POLLING_FREQUENCY_MS 10000
+#define IMX6Q_THERMAL_ACT_TRP_PTS 3
+/* assumption: always one critical trip point */
+#define IMX6Q_THERMAL_TOTAL_TRP_PTS (IMX6Q_THERMAL_ACT_TRP_PTS + 1)
+
+struct th_sys_trip_point {
+	u32 temp; /* in celcius */
+	enum thermal_trip_type type;
+};
+
+struct imx6q_thermal_data {
+	struct th_sys_trip_point trp_pts[IMX6Q_THERMAL_TOTAL_TRP_PTS];
+	struct freq_pctg_table freq_tab[IMX6Q_THERMAL_ACT_TRP_PTS];
+};
+
+struct imx6q_sensor_data {
+	int	c1, c2;
+	char	*name;
+	bool	was_suspended;
+};
+
+struct imx6q_thermal_zone {
+	struct thermal_zone_device *therm_dev;
+	struct thermal_cooling_device *cool_dev;
+	struct imx6q_sensor_data sensor_data;
+	struct imx6q_thermal_data *thermal_data;
+};
+
+/*
+ * This data defines the various trip points that will trigger action
+ * when crossed.
+ */
+static struct imx6q_thermal_data thermal_data =3D {
+	.trp_pts[0] =3D {
+		.temp	 =3D 85000,
+		.type	 =3D THERMAL_TRIP_STATE_ACTIVE,
+	},
+	.freq_tab[0] =3D {
+		.freq_clip_pctg[0] =3D 25,
+	},
+	.trp_pts[1] =3D {
+		.temp	 =3D 90000,
+		.type	 =3D THERMAL_TRIP_STATE_ACTIVE,
+	},
+	.freq_tab[1] =3D {
+		.freq_clip_pctg[0] =3D 65,
+	},
+	.trp_pts[2] =3D {
+		.temp	 =3D 95000,
+		.type	 =3D THERMAL_TRIP_STATE_ACTIVE,
+	},
+	.freq_tab[2] =3D {
+		.freq_clip_pctg[0] =3D 99,
+	},
+	.trp_pts[3] =3D {
+		.temp	 =3D 100000,
+		.type	 =3D THERMAL_TRIP_CRITICAL,
+	},
+};
+
+static int th_sys_get_temp(struct thermal_zone_device *thermal,
+				  unsigned long *temp);
+
+static struct platform_device		*dev;
+static struct imx6q_thermal_zone	*th_zone;
+static void __iomem			*anatop_base;
+
+static inline int imx6q_get_temp(int *temp)
+{
+	unsigned int n_meas;
+	unsigned int reg;
+	struct imx6q_sensor_data *p =3D &th_zone->sensor_data;
+
+	/*
+	 * For now we only using single measure.  Every time we measure
+	 * the temperature, we will power on/down the anadig module
+	 */
+	writel_relaxed(BM_ANADIG_TEMPSENSE0_POWER_DOWN,
+		anatop_base + HW_ANADIG_TEMPSENSE0_CLR);
+
+	writel_relaxed(BM_ANADIG_TEMPSENSE0_FINISHED,
+		anatop_base + HW_ANADIG_TEMPSENSE0_CLR);
+
+	p->was_suspended =3D false;
+
+	writel_relaxed(BM_ANADIG_TEMPSENSE0_MEASURE_TEMP,
+		anatop_base + HW_ANADIG_TEMPSENSE0_SET);
+
+	/*
+	 * According to SoC designers, it may require up to ~17us to complete
+	 * a measurement.  But we have a 'finished' status bit, so we
+	 * check it just in case the designers are liars.
+	 */
+	do {
+		msleep(1);
+
+		/*
+		 * if system was possibly suspended while measurement
+		 * was being taken, we take another measurement to make
+		 * sure the measurement is valid.
+		 */
+		if (p->was_suspended) {
+			writel_relaxed(BM_ANADIG_TEMPSENSE0_MEASURE_TEMP,
+				anatop_base + HW_ANADIG_TEMPSENSE0_CLR);
+
+			writel_relaxed(BM_ANADIG_TEMPSENSE0_FINISHED,
+				anatop_base + HW_ANADIG_TEMPSENSE0_CLR);
+
+			p->was_suspended =3D false;
+
+			writel_relaxed(BM_ANADIG_TEMPSENSE0_MEASURE_TEMP,
+				anatop_base + HW_ANADIG_TEMPSENSE0_SET);
+
+			continue;
+		}
+	} while (!(readl_relaxed(anatop_base + HW_ANADIG_TEMPSENSE0)
+		& BM_ANADIG_TEMPSENSE0_FINISHED));
+
+	reg =3D readl_relaxed(anatop_base + HW_ANADIG_TEMPSENSE0);
+
+	n_meas =3D (reg & BM_ANADIG_TEMPSENSE0_TEMP_VALUE)
+			>> BP_ANADIG_TEMPSENSE0_TEMP_VALUE;
+
+	writel_relaxed(BM_ANADIG_TEMPSENSE0_MEASURE_TEMP,
+		anatop_base + HW_ANADIG_TEMPSENSE0_CLR);
+
+	writel_relaxed(BM_ANADIG_TEMPSENSE0_POWER_DOWN,
+			anatop_base + HW_ANADIG_TEMPSENSE0_SET);
+
+	/* See imx6q_thermal_process_fuse_data for forumla derivation. */
+	*temp =3D p->c2 + (p->c1 * n_meas);
+
+	pr_debug("Temperature: %d\n", *temp / 1000);
+
+	return 0;
+}
+
+static int th_sys_get_temp(struct thermal_zone_device *thermal,
+				  unsigned long *temp)
+{
+	int tmp =3D 0;
+
+	imx6q_get_temp(&tmp);
+
+	/*
+	 * The thermal framework code stores temperature in unsigned long. Al=
so,
+	 * it has references to "millicelcius" which limits the lowest
+	 * temperature possible (compared to Kelvin).
+	 */
+	if (likely(tmp > 0))
+		*temp =3D tmp;
+	else
+		*temp =3D 0;
+
+	return 0;
+}
+
+static int th_sys_get_mode(struct thermal_zone_device *thermal,
+			    enum thermal_device_mode *mode)
+{
+	*mode =3D THERMAL_DEVICE_ENABLED;
+	return 0;
+}
+
+static int th_sys_get_trip_type(struct thermal_zone_device *thermal, i=
nt trip,
+				 enum thermal_trip_type *type)
+{
+	if (trip >=3D IMX6Q_THERMAL_TOTAL_TRP_PTS)
+		return -EINVAL;
+
+	*type =3D th_zone->thermal_data->trp_pts[trip].type;
+
+	return 0;
+}
+
+static int th_sys_get_trip_temp(struct thermal_zone_device *thermal, i=
nt trip,
+				 unsigned long *temp)
+{
+	if (trip >=3D IMX6Q_THERMAL_TOTAL_TRP_PTS)
+		return -EINVAL;
+
+	*temp =3D th_zone->thermal_data->trp_pts[trip].temp;
+	return 0;
+}
+
+static int th_sys_get_crit_temp(struct thermal_zone_device *thermal,
+				 unsigned long *temp)
+{
+
+	*temp =3D th_zone->thermal_data->trp_pts[
+		IMX6Q_THERMAL_TOTAL_TRP_PTS - 1].temp;
+	return 0;
+}
+
+static int th_sys_bind(struct thermal_zone_device *thermal,
+			struct thermal_cooling_device *cdev)
+{
+	int i;
+
+	/* if the cooling device is the one from imx6 bind it */
+	if (cdev !=3D th_zone->cool_dev)
+		return 0;
+
+	for (i =3D 0; i < IMX6Q_THERMAL_ACT_TRP_PTS; i++) {
+		if (thermal_zone_bind_cooling_device(thermal, i, cdev)) {
+			pr_err("error binding cooling dev\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int th_sys_unbind(struct thermal_zone_device *thermal,
+			  struct thermal_cooling_device *cdev)
+{
+	int i;
+
+	if (cdev !=3D th_zone->cool_dev)
+		return 0;
+
+	for (i =3D 0; i < IMX6Q_THERMAL_ACT_TRP_PTS; i++) {
+		if (thermal_zone_unbind_cooling_device(thermal, i, cdev)) {
+			pr_err("error unbinding cooling dev\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static struct thermal_zone_device_ops imx6q_dev_ops =3D {
+	.bind =3D th_sys_bind,
+	.unbind =3D th_sys_unbind,
+	.get_temp =3D th_sys_get_temp,
+	.get_mode =3D th_sys_get_mode,
+	.get_trip_type =3D th_sys_get_trip_type,
+	.get_trip_temp =3D th_sys_get_trip_temp,
+	.get_crit_temp =3D th_sys_get_crit_temp,
+};
+
+static int imx6q_thermal_process_fuse_data(unsigned int fuse_data)
+{
+	int t1, t2, n1, n2;
+	struct imx6q_sensor_data *p =3D &th_zone->sensor_data;
+
+	if (fuse_data =3D=3D 0 || fuse_data =3D=3D 0xffffffff)
+		return -EINVAL;
+
+	/*
+	 * Fuse data layout:
+	 * [31:20] sensor value @ 25C
+	 * [19:8] sensor value of hot
+	 * [7:0] hot temperature value
+	 */
+	n1 =3D fuse_data >> 20;
+	n2 =3D (fuse_data & 0xfff00) >> 8;
+	t2 =3D fuse_data & 0xff;
+	t1 =3D 25; /* t1 always 25C */
+
+	pr_debug(" -- temperature sensor calibration data --\n");
+	pr_debug("HW_OCOTP_ANA1: %x\n", fuse_data);
+	pr_debug("n1: %d\nn2: %d\nt1: %d\nt2: %d\n", n1, n2, t1, t2);
+
+	/*
+	 * From reference manual (derived from linear interpolation),
+	 * Tmeas =3D T2 + (Nmeas - N2) * (T1 - T2) / (N1 - N2)
+	 * We want to reduce this down to the minimum computation necessary
+	 * for each temperature read.  Also, we want Tmeas in millicelcius
+	 * and we don't want to lose precision from integer division. So...
+	 * milli_Tmeas =3D 1000 * T2 + 1000 * (Nmeas - N2) * (T1 - T2) / (N1 =
- N2)
+	 * Let constant c1 =3D 1000 * (T1 - T2) / (N1 - N2)
+	 * milli_Tmeas =3D (1000 * T2) + c1 * (Nmeas - N2)
+	 * milli_Tmeas =3D (1000 * T2) + (c1 * Nmeas) - (c1 * N2)
+	 * Let constant c2 =3D (1000 * T2) - (c1 * N2)
+	 * milli_Tmeas =3D c2 + (c1 * Nmeas)
+	 */
+	p->c1 =3D (1000 * (t1 - t2)) / (n1 - n2);
+	p->c2 =3D (1000 * t2) - (p->c1 * n2);
+
+	pr_debug("c1: %i\n", p->c1);
+	pr_debug("c2: %i\n", p->c2);
+
+	return 0;
+}
+
+
+static int imx6q_thermal_probe(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int imx6q_thermal_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int imx6q_thermal_suspend(struct platform_device *pdev,
+						pm_message_t state)
+{
+	/*
+	 * according to imx6q thermal sensor designers, system problems will
+	 * not occur if low power modes are entered while temp_sensor is acti=
ve,
+	 * so do nothing here.
+	 */
+	return 0;
+}
+
+static int imx6q_thermal_resume(struct platform_device *pdev)
+{
+	th_zone->sensor_data.was_suspended =3D true;
+	return 0;
+}
+
+void imx6q_unregister_thermal(void)
+{
+	if (th_zone && th_zone->cool_dev)
+		cpufreq_cooling_unregister();
+
+	if (th_zone && th_zone->therm_dev)
+		thermal_zone_device_unregister(th_zone->therm_dev);
+
+	kfree(th_zone);
+
+	pr_info("i.MX6Q: Kernel Thermal management unregistered\n");
+}
+
+static int __init imx6q_thermal_register(void)
+{
+	void __iomem *ocotp_base;
+	struct device_node *np;
+	unsigned int fuse_data;
+	int ret;
+
+	np =3D of_find_compatible_node(NULL, NULL, "fsl,imx6q-ocotp");
+	ocotp_base =3D of_iomap(np, 0);
+
+	if (!ocotp_base) {
+		pr_err("Could not retrieve ocotp-base\n");
+		ret =3D -EINVAL;
+		goto err_unregister;
+	}
+
+	np =3D of_find_compatible_node(NULL, NULL, "fsl,imx6q-anatop");
+	anatop_base =3D of_iomap(np, 0);
+
+	if (!anatop_base) {
+		pr_err("Could not retrieve anantop-base\n");
+		ret =3D -EINVAL;
+		goto err_unregister;
+	}
+
+	fuse_data =3D readl_relaxed(ocotp_base + HW_OCOTP_ANA1);
+
+	th_zone =3D kzalloc(sizeof(struct imx6q_thermal_zone), GFP_KERNEL);
+
+	if (!th_zone) {
+		ret =3D -ENOMEM;
+		goto err_unregister;
+	}
+
+	th_zone->sensor_data.name =3D "imx6q-temp_sens",
+
+	ret =3D imx6q_thermal_process_fuse_data(fuse_data);
+
+	if (ret) {
+		pr_err("Invalid temperature calibration data.\n");
+		goto err_unregister;
+	}
+
+	/* Make sure sensor is in known good state for measurements */
+	writel_relaxed(BM_ANADIG_TEMPSENSE0_POWER_DOWN,
+			anatop_base + HW_ANADIG_TEMPSENSE0_CLR);
+	writel_relaxed(BM_ANADIG_TEMPSENSE0_MEASURE_TEMP,
+		anatop_base + HW_ANADIG_TEMPSENSE0_CLR);
+	writel_relaxed(BM_ANADIG_TEMPSENSE1_MEASURE_FREQ,
+		anatop_base + HW_ANADIG_TEMPSENSE1_CLR);
+	writel_relaxed(BM_ANADIG_ANA_MISC0_REFTOP_SELBIASOFF,
+			anatop_base + HW_ANADIG_ANA_MISC0_SET);
+	writel_relaxed(BM_ANADIG_TEMPSENSE0_POWER_DOWN,
+			anatop_base + HW_ANADIG_TEMPSENSE0_SET);
+
+	th_zone->thermal_data =3D &thermal_data;
+	if (!th_zone->thermal_data) {
+		pr_err("Temperature sensor data not initialised\n");
+		ret =3D -EINVAL;
+		goto err_unregister;
+	}
+
+	th_zone->cool_dev =3D cpufreq_cooling_register(
+		(struct freq_pctg_table *)th_zone->thermal_data->freq_tab,
+		IMX6Q_THERMAL_ACT_TRP_PTS, cpumask_of(0));
+
+	if (IS_ERR(th_zone->cool_dev)) {
+		pr_err("Failed to register cpufreq cooling device\n");
+		ret =3D -EINVAL;
+		goto err_unregister;
+	}
+
+	th_zone->therm_dev =3D thermal_zone_device_register(
+		th_zone->sensor_data.name, IMX6Q_THERMAL_TOTAL_TRP_PTS,
+		NULL, &imx6q_dev_ops, 0, 0, 0,
+		IMX6Q_THERMAL_POLLING_FREQUENCY_MS);
+
+	if (IS_ERR(th_zone->therm_dev)) {
+		pr_err("Failed to register thermal zone device\n");
+		ret =3D -EINVAL;
+		goto err_unregister;
+	}
+
+	return 0;
+
+err_unregister:
+	imx6q_unregister_thermal();
+	return ret;
+}
+
+static struct platform_driver imx6q_thermal_driver =3D {
+	.probe		=3D imx6q_thermal_probe,
+	.remove		=3D imx6q_thermal_remove,
+	.suspend	=3D imx6q_thermal_suspend,
+	.resume		=3D imx6q_thermal_resume,
+	.driver		=3D {
+			.name	=3D "imx6q-thermal",
+			.owner	=3D THIS_MODULE,
+			},
+};
+
+static int imx6q_th_platform_register(void)
+{
+	int ret;
+
+	ret =3D platform_driver_register(&imx6q_thermal_driver);
+	if (ret)
+		return ret;
+
+	dev =3D platform_device_alloc("imx6q-thermal-cpu", -1);
+
+	if (!dev) {
+		ret =3D -ENOMEM;
+		goto err_device_alloc;
+	}
+	ret =3D platform_device_add(dev);
+	if (ret)
+		goto err_device_add;
+
+	return ret;
+
+err_device_add:
+	platform_device_put(dev);
+err_device_alloc:
+	platform_driver_unregister(&imx6q_thermal_driver);
+
+	return ret;
+}
+
+static int __init imx6q_thermal_init(void)
+{
+	int ret;
+
+	ret =3D imx6q_th_platform_register();
+	if (ret)
+		goto err;
+
+	ret =3D imx6q_thermal_register();
+	if (ret)
+		goto err;
+
+	pr_info("i.MX Thermal management enabled.\n");
+	return ret;
+
+err:
+	pr_info("WARNING: Thermal management NOT enabled due to errors.\n");
+	return ret;
+}
+
+static void __exit imx6q_thermal_driver_exit(void)
+{
+	imx6q_unregister_thermal();
+	platform_device_unregister(dev);
+	platform_driver_unregister(&imx6q_thermal_driver);
+}
+
+module_init(imx6q_thermal_init);
+module_exit(imx6q_thermal_driver_exit);
+
+MODULE_AUTHOR("Freescale Semiconductor");
+MODULE_DESCRIPTION("i.MX6Q SoC thermal driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:imx6q-thermal");
--=20
1.7.1


---------- Forwarded message ----------
=46rom: Rob Lee <rob.lee@linaro.org>
Date: Mon, Jan 16, 2012 at 10:51 PM
Subject: Re: [RFC PATCH v2] ARM: imx: Add basic imx6q thermal managemen=
t
To: linux@arm.linux.org.uk, s.hauer@pengutronix.de, shawn.guo@freescale=
=2Ecom
Cc: amit.kachhap@linaro.org, amit.kucheria@linaro.org,
linux-arm-kernel@lists.infradead.org, patches@linaro.org,
linux-acpi@vger.kernel.org, lenb@kernel.org


link to v1 submission:

http://www.spinics.net/lists/arm-kernel/msg155111.html

Based on v3.2 plus recently submitted cpu_cooling functionality here:

http://www.spinics.net/lists/linux-pm/msg26500.html

Changes since v1:
1. Cleaned up some style issue pointed out in v1
2. Made various other code cleanup and re-organizing
3. Added temperature sensor calibration
4. Created platform driver and device to hook into pm suspend.

Performed some basic testing to ensure proper cooling operating. =A0If
you want to test this, full testing requires imx6q cpufreq
implementation (not yet in v3.2) and requires an imx6q part that has
temperature sensor calibration fuse correctly burned.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
