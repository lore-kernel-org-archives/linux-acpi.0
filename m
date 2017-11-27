From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 3/3] pinctrl: cannonlake: Align GPIO number space with Windows
Date: Mon, 27 Nov 2017 16:54:44 +0300
Message-ID: <20171127135444.66735-4-mika.westerberg@linux.intel.com>
References: <20171127135444.66735-1-mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:55539 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752182AbdK0Nys (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 27 Nov 2017 08:54:48 -0500
In-Reply-To: <20171127135444.66735-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hans de Goede <hdegoede@redhat.com>, Takashi Iwai <tiwai@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

The Cannon Lake Windows GPIO driver always exposes 32 pins per "bank"
regardless of whether the hardware actually has that many pins in a pad
group. This means that there are gaps in the GPIO number space even if
such gaps do not exist in the real hardware. To make things worse the
BIOS is also using the same scheme, so for example on Cannon Lake-LP
vGPIO 39 (vSD3_CD_B) the ACPI GpioInt resource has number 231 instead of
the expected 180 (which would be the hardware number).

To make SD card detection and other GPIOs working properly in Linux we
align the pinctrl-cannonlake GPIO numbering to follow the Windows GPIO
driver numbering taking advantage of the gpio_base field introduced in
the previous patch.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-cannonlake.c | 65 ++++++++++++++++--------------
 1 file changed, 34 insertions(+), 31 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cannonlake.c b/drivers/pinctrl/intel/pinctrl-cannonlake.c
index e130599be571..6243e7d95e7e 100644
--- a/drivers/pinctrl/intel/pinctrl-cannonlake.c
+++ b/drivers/pinctrl/intel/pinctrl-cannonlake.c
@@ -23,13 +23,16 @@
 #define CNL_HOSTSW_OWN	0x0b0
 #define CNL_GPI_IE	0x120
 
-#define CNL_GPP(r, s, e)				\
+#define CNL_GPP(r, s, e, g)				\
 	{						\
 		.reg_num = (r),				\
 		.base = (s),				\
 		.size = ((e) - (s) + 1),		\
+		.gpio_base = (g),			\
 	}
 
+#define CNL_NO_GPIO	-1
+
 #define CNL_COMMUNITY(b, s, e, g)			\
 	{						\
 		.barno = (b),				\
@@ -363,32 +366,32 @@ static const struct pinctrl_pin_desc cnlh_pins[] = {
 };
 
 static const struct intel_padgroup cnlh_community0_gpps[] = {
-	CNL_GPP(0, 0, 24),	/* GPP_A */
-	CNL_GPP(1, 25, 50),	/* GPP_B */
+	CNL_GPP(0, 0, 24, 0),			/* GPP_A */
+	CNL_GPP(1, 25, 50, 32),			/* GPP_B */
 };
 
 static const struct intel_padgroup cnlh_community1_gpps[] = {
-	CNL_GPP(0, 51, 74),	/* GPP_C */
-	CNL_GPP(1, 75, 98),	/* GPP_D */
-	CNL_GPP(2, 99, 106),	/* GPP_G */
-	CNL_GPP(3, 107, 114),	/* AZA */
-	CNL_GPP(4, 115, 146),	/* vGPIO_0 */
-	CNL_GPP(5, 147, 154),	/* vGPIO_1 */
+	CNL_GPP(0, 51, 74, 64),			/* GPP_C */
+	CNL_GPP(1, 75, 98, 96),			/* GPP_D */
+	CNL_GPP(2, 99, 106, 128),		/* GPP_G */
+	CNL_GPP(3, 107, 114, CNL_NO_GPIO),	/* AZA */
+	CNL_GPP(4, 115, 146, 160),		/* vGPIO_0 */
+	CNL_GPP(5, 147, 154, CNL_NO_GPIO),	/* vGPIO_1 */
 };
 
 static const struct intel_padgroup cnlh_community3_gpps[] = {
-	CNL_GPP(0, 155, 178),	/* GPP_K */
-	CNL_GPP(1, 179, 202),	/* GPP_H */
-	CNL_GPP(2, 203, 215),	/* GPP_E */
-	CNL_GPP(3, 216, 239),	/* GPP_F */
-	CNL_GPP(4, 240, 248),	/* SPI */
+	CNL_GPP(0, 155, 178, 192),		/* GPP_K */
+	CNL_GPP(1, 179, 202, 224),		/* GPP_H */
+	CNL_GPP(2, 203, 215, 258),		/* GPP_E */
+	CNL_GPP(3, 216, 239, 288),		/* GPP_F */
+	CNL_GPP(4, 240, 248, CNL_NO_GPIO),	/* SPI */
 };
 
 static const struct intel_padgroup cnlh_community4_gpps[] = {
-	CNL_GPP(0, 249, 259),	/* CPU */
-	CNL_GPP(1, 260, 268),	/* JTAG */
-	CNL_GPP(2, 269, 286),	/* GPP_I */
-	CNL_GPP(3, 287, 298),	/* GPP_J */
+	CNL_GPP(0, 249, 259, CNL_NO_GPIO),	/* CPU */
+	CNL_GPP(1, 260, 268, CNL_NO_GPIO),	/* JTAG */
+	CNL_GPP(2, 269, 286, 320),		/* GPP_I */
+	CNL_GPP(3, 287, 298, 352),		/* GPP_J */
 };
 
 static const unsigned int cnlh_spi0_pins[] = { 40, 41, 42, 43 };
@@ -785,25 +788,25 @@ static const struct intel_function cnllp_functions[] = {
 };
 
 static const struct intel_padgroup cnllp_community0_gpps[] = {
-	CNL_GPP(0, 0, 24),	/* GPP_A */
-	CNL_GPP(1, 25, 50),	/* GPP_B */
-	CNL_GPP(2, 51, 58),	/* GPP_G */
-	CNL_GPP(3, 59, 67),	/* SPI */
+	CNL_GPP(0, 0, 24, 0),			/* GPP_A */
+	CNL_GPP(1, 25, 50, 32),			/* GPP_B */
+	CNL_GPP(2, 51, 58, 64),			/* GPP_G */
+	CNL_GPP(3, 59, 67, CNL_NO_GPIO),	/* SPI */
 };
 
 static const struct intel_padgroup cnllp_community1_gpps[] = {
-	CNL_GPP(0, 68, 92),	/* GPP_D */
-	CNL_GPP(1, 93, 116),	/* GPP_F */
-	CNL_GPP(2, 117, 140),	/* GPP_H */
-	CNL_GPP(3, 141, 172),	/* vGPIO */
-	CNL_GPP(4, 173, 180),	/* vGPIO */
+	CNL_GPP(0, 68, 92, 96),			/* GPP_D */
+	CNL_GPP(1, 93, 116, 128),		/* GPP_F */
+	CNL_GPP(2, 117, 140, 160),		/* GPP_H */
+	CNL_GPP(3, 141, 172, 192),		/* vGPIO */
+	CNL_GPP(4, 173, 180, 224),		/* vGPIO */
 };
 
 static const struct intel_padgroup cnllp_community4_gpps[] = {
-	CNL_GPP(0, 181, 204),	/* GPP_C */
-	CNL_GPP(1, 205, 228),	/* GPP_E */
-	CNL_GPP(2, 229, 237),	/* JTAG */
-	CNL_GPP(3, 238, 243),	/* HVCMOS */
+	CNL_GPP(0, 181, 204, 256),		/* GPP_C */
+	CNL_GPP(1, 205, 228, 288),		/* GPP_E */
+	CNL_GPP(2, 229, 237, CNL_NO_GPIO),	/* JTAG */
+	CNL_GPP(3, 238, 243, CNL_NO_GPIO),	/* HVCMOS */
 };
 
 static const struct intel_community cnllp_communities[] = {
-- 
2.15.0

