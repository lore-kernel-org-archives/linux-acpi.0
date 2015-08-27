From: "Kasagar, Srinidhi" <srinidhi.kasagar@intel.com>
Subject: Re: [PATCH] ACPI / LPSS: Ignore 10ms delay for Braswell and Baytrail
Date: Thu, 27 Aug 2015 21:43:21 +0530
Message-ID: <20150827161321.GA9886@intel-desktop>
References: <20150820123805.GG30005@lahna.fi.intel.com>
 <20150821121152.GA26813@intel-desktop>
 <20150821063641.GK30005@lahna.fi.intel.com>
 <20150821132015.GN30005@lahna.fi.intel.com>
 <20150824125147.GA23677@intel-desktop>
 <20150824085959.GO30005@lahna.fi.intel.com>
 <20150824170920.GA32764@intel-desktop>
 <20150824094455.GP30005@lahna.fi.intel.com>
 <20150827143953.GA5095@intel-desktop>
 <20150827071414.GB28428@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:4233 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751888AbbH0IWC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Aug 2015 04:22:02 -0400
Content-Disposition: inline
In-Reply-To: <20150827071414.GB28428@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com, Kumar P Mahesh <mahesh.kumar.p@intel.com>, Heikki Krogerus <heikki.krogerus@intel.com>

On Thu, Aug 27, 2015 at 10:14:14AM +0300, Mika Westerberg wrote:
> On Thu, Aug 27, 2015 at 08:09:55PM +0530, Kasagar, Srinidhi wrote:
> > On Mon, Aug 24, 2015 at 12:44:55PM +0300, Mika Westerberg wrote:
> > > On Mon, Aug 24, 2015 at 10:39:21PM +0530, Kasagar, Srinidhi wrote:
> > > > Ok, then we have two options:
> > > > 
> > > > Let's drop LPSS_NO_D3_DELAY for BYT and duplicate the common devices which
> > > > are shared between Braswell and BYT & keep LPSS_NO_D3_DELAY only for BSW.
> > > 
> > > That sounds the safest option for now.
> > > 
> > > > OR
> > > > Use the cpu id to detect the platform which I believe not a good idea..
> > > > 
> > > > Because of few devices, I do not think it make sense to compromise on
> > > > the significant reduction in the resume delay.
> > > 
> > > I agree.
> > 
> > Refreshed the patch (below) affecting BSW platform alone.
> > 
> > But this does not solve your earlier concern on Broadwell which
> > shares the same acpi ids..
> 
> It does not share IDs:

Oh, Thanks..

> 
>         /* Braswell LPSS devices */
>         { "80862288", LPSS_ADDR(byt_pwm_dev_desc) },
>         { "8086228A", LPSS_ADDR(byt_uart_dev_desc) },
>         { "8086228E", LPSS_ADDR(bsw_spi_dev_desc) },
>         { "808622C1", LPSS_ADDR(byt_i2c_dev_desc) },
> 
> 	/* The following are Broadwell LPSS IDs _not_ Braswell */
>         { "INT3430", LPSS_ADDR(lpt_dev_desc) },
>         { "INT3431", LPSS_ADDR(lpt_dev_desc) },
>         { "INT3432", LPSS_ADDR(lpt_i2c_dev_desc) },
>         { "INT3433", LPSS_ADDR(lpt_i2c_dev_desc) },
>         { "INT3434", LPSS_ADDR(lpt_uart_dev_desc) },
>         { "INT3435", LPSS_ADDR(lpt_uart_dev_desc) },
>         { "INT3436", LPSS_ADDR(lpt_sdio_dev_desc) },
>         { "INT3437", },
> 
> So please make the patch touch only the four 808622* devices above
> unless you have tested this on Broadwell as well.
> 
> Otherwise the patch looks good to me.

Here is the patch..

>From 970c704dbb05aa8392b6e1090ceaf9ed76b6436b Mon Sep 17 00:00:00 2001
From: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
Date: Thu, 27 Aug 2015 21:30:55 +0530
Subject: [PATCH] ACPI / LPSS: Ignore 10ms delay for Braswell

LPSS devices in Braswell does not need the default 10ms
d3_delay imposed by PCI specification. Removing this
unnecessary delay significantly reduces the resume time
approximately upto 200ms on this platform.

Signed-off-by: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
---
 drivers/acpi/acpi_lpss.c |   38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 46b58abb08c5..10020e04f574 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -60,6 +60,7 @@ ACPI_MODULE_NAME("acpi_lpss");
 #define LPSS_CLK_DIVIDER		BIT(2)
 #define LPSS_LTR			BIT(3)
 #define LPSS_SAVE_CTX			BIT(4)
+#define LPSS_NO_D3_DELAY		BIT(5)
 
 struct lpss_private_data;
 
@@ -156,6 +157,10 @@ static const struct lpss_device_desc byt_pwm_dev_desc = {
 	.flags = LPSS_SAVE_CTX,
 };
 
+static const struct lpss_device_desc bsw_pwm_dev_desc = {
+	.flags = LPSS_SAVE_CTX | LPSS_NO_D3_DELAY,
+};
+
 static const struct lpss_device_desc byt_uart_dev_desc = {
 	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_SAVE_CTX,
 	.clk_con_id = "baudclk",
@@ -163,6 +168,14 @@ static const struct lpss_device_desc byt_uart_dev_desc = {
 	.setup = lpss_uart_setup,
 };
 
+static const struct lpss_device_desc bsw_uart_dev_desc = {
+	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_SAVE_CTX
+			| LPSS_NO_D3_DELAY,
+	.clk_con_id = "baudclk",
+	.prv_offset = 0x800,
+	.setup = lpss_uart_setup,
+};
+
 static const struct lpss_device_desc byt_spi_dev_desc = {
 	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_SAVE_CTX,
 	.prv_offset = 0x400,
@@ -178,8 +191,15 @@ static const struct lpss_device_desc byt_i2c_dev_desc = {
 	.setup = byt_i2c_setup,
 };
 
+static const struct lpss_device_desc bsw_i2c_dev_desc = {
+	.flags = LPSS_CLK | LPSS_SAVE_CTX | LPSS_NO_D3_DELAY,
+	.prv_offset = 0x800,
+	.setup = byt_i2c_setup,
+};
+
 static struct lpss_device_desc bsw_spi_dev_desc = {
-	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_SAVE_CTX,
+	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_SAVE_CTX
+			| LPSS_NO_D3_DELAY,
 	.prv_offset = 0x400,
 	.setup = lpss_deassert_reset,
 };
@@ -214,11 +234,12 @@ static const struct acpi_device_id acpi_lpss_device_ids[] = {
 	{ "INT33FC", },
 
 	/* Braswell LPSS devices */
-	{ "80862288", LPSS_ADDR(byt_pwm_dev_desc) },
-	{ "8086228A", LPSS_ADDR(byt_uart_dev_desc) },
+	{ "80862288", LPSS_ADDR(bsw_pwm_dev_desc) },
+	{ "8086228A", LPSS_ADDR(bsw_uart_dev_desc) },
 	{ "8086228E", LPSS_ADDR(bsw_spi_dev_desc) },
-	{ "808622C1", LPSS_ADDR(byt_i2c_dev_desc) },
+	{ "808622C1", LPSS_ADDR(bsw_i2c_dev_desc) },
 
+	/* Broadwell LPSS devices */
 	{ "INT3430", LPSS_ADDR(lpt_dev_desc) },
 	{ "INT3431", LPSS_ADDR(lpt_dev_desc) },
 	{ "INT3432", LPSS_ADDR(lpt_i2c_dev_desc) },
@@ -558,9 +579,14 @@ static void acpi_lpss_restore_ctx(struct device *dev,
 	 * The following delay is needed or the subsequent write operations may
 	 * fail. The LPSS devices are actually PCI devices and the PCI spec
 	 * expects 10ms delay before the device can be accessed after D3 to D0
-	 * transition.
+	 * transition. However some platforms like BSW does not need this delay.
 	 */
-	msleep(10);
+	unsigned int delay = 10;	/* default 10ms delay */
+
+	if (pdata->dev_desc->flags & LPSS_NO_D3_DELAY)
+		delay = 0;
+
+	msleep(delay);
 
 	for (i = 0; i < LPSS_PRV_REG_COUNT; i++) {
 		unsigned long offset = i * sizeof(u32);
-- 
1.7.9.5


