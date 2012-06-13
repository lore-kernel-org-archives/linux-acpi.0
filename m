From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: [RFC PATCH v4] ARM: imx: Add basic imx6q thermal management
Date: Wed, 13 Jun 2012 10:46:31 +0200
Message-ID: <4FD85367.5000302@de.bosch.com>
References: <1326940051-31016-1-git-send-email-rob.lee@linaro.org>
 <1326940051-31016-2-git-send-email-rob.lee@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1326940051-31016-2-git-send-email-rob.lee@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robert Lee <rob.lee@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Philipp Ahmann <pahmann@de.adit-jv.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "amit.kachhap@linaro.org" <amit.kachhap@linaro.org>, Ying-Chun Liu <paul.liu@linaro.org>, "shawn.guo@freescale.com" <shawn.guo@freescale.com>, "lenb@kernel.org" <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 19.01.2012 03:27, Robert Lee wrote:
> Adds support for temperature sensor readings, registers with common
> thermal framework, and uses the new common cpu_cooling interface.
> 
> Signed-off-by: Robert Lee <rob.lee@linaro.org>
> ---
>  arch/arm/boot/dts/imx6q.dtsi    |    1 +
>  drivers/thermal/Kconfig         |    6 +
>  drivers/thermal/Makefile        |    1 +
>  drivers/thermal/imx6q_thermal.c |  540 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 548 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/thermal/imx6q_thermal.c
...
> +static int __init imx6q_thermal_init(void)
> +{
> +       struct device_node *np_ocotp, *np_anatop;
> +       unsigned int fuse_data;
> +       int ret;
> +
> +       np_ocotp = of_find_compatible_node(NULL, NULL, "fsl,imx6q-ocotp");
> +       np_anatop = of_find_compatible_node(NULL, NULL, "fsl,imx6q-anatop");
> +
> +       if (!(np_ocotp && np_anatop))
> +               return -ENXIO; /* not a compatible platform */
> +
> +       ocotp_base = of_iomap(np_ocotp, 0);
> +
> +       if (!ocotp_base) {
> +               pr_err("Could not retrieve ocotp-base\n");
> +               ret = -ENXIO;
> +               goto err_unregister;
> +       }
> +
> +       anatop_base = of_iomap(np_anatop, 0);
> +
> +       if (!anatop_base) {
> +               pr_err("Could not retrieve anantop-base\n");
> +               ret = -ENXIO;
> +               goto err_unregister;
> +       }
> +
> +       fuse_data = readl_relaxed(ocotp_base + HW_OCOTP_ANA1);

To be able to use this on non-calibrated sample devices, we had to add [1].

Best regards

Dirk

[1]

From: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
Subject: [PATCH] ARM: imx6: thermal: Add workaround for missing 
calibration data

Sample devices not calibrated in the production don't have the fuses 
containing
the calibration data. Hardcode this value if the fuse data read is zero 
to be able
to use the thermal functinality on these sample devices, too.

Signed-off-by: Ying-Chun Liu <paul.liu@linaro.org>
Signed-off-by: Philipp Ahmann <pahmann@de.adit-jv.com>
---
  drivers/thermal/imx6q_thermal.c |    2 ++
  1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/thermal/imx6q_thermal.c 
b/drivers/thermal/imx6q_thermal.c
index 76b7ba1..543cd75 100644
--- a/drivers/thermal/imx6q_thermal.c
+++ b/drivers/thermal/imx6q_thermal.c
@@ -446,6 +446,8 @@ static int __init imx6q_thermal_init(void)
  	}

  	fuse_data = readl_relaxed(ocotp_base + HW_OCOTP_ANA1);
+	if (fuse_data == 0)
+		fuse_data = 0x5704c67d;

  	th_zone = kzalloc(sizeof(struct imx6q_thermal_zone), GFP_KERNEL);
  	if (!th_zone) {
-- 
1.7.0.4
