From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v3 3/3] serial: amba-pl011: add ACPI support to AMBA probe
Date: Mon, 21 Dec 2015 19:41:38 +0300
Message-ID: <1450716100-13688-4-git-send-email-aleksey.makarov@linaro.org>
References: <1450716100-13688-1-git-send-email-aleksey.makarov@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:36316 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbbLUQn6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Dec 2015 11:43:58 -0500
Received: by mail-lf0-f49.google.com with SMTP id z124so109701626lfa.3
        for <linux-acpi@vger.kernel.org>; Mon, 21 Dec 2015 08:43:57 -0800 (PST)
In-Reply-To: <1450716100-13688-1-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Shannon Zhao <shannon.zhao@linaro.org>, Jiri Slaby <jslaby@suse.com>

From: Graeme Gregory <graeme.gregory@linaro.org>

In ACPI this device is only defined in SBSA mode so
if we are coming from ACPI use this mode.

Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 drivers/tty/serial/amba-pl011.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 899a771..766ce4f 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2368,18 +2368,33 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 	if (!uap)
 		return -ENOMEM;
 
-	uap->clk = devm_clk_get(&dev->dev, NULL);
-	if (IS_ERR(uap->clk))
-		return PTR_ERR(uap->clk);
-
-	uap->vendor = vendor;
-	uap->lcrh_rx = vendor->lcrh_rx;
-	uap->lcrh_tx = vendor->lcrh_tx;
-	uap->fifosize = vendor->get_fifosize(dev);
-	uap->port.irq = dev->irq[0];
-	uap->port.ops = &amba_pl011_pops;
+	/* ACPI only defines SBSA variant */
+	if (ACPI_COMPANION(&dev->dev)) {
+		/*
+		 * According to ARM ARMH0011 is currently the only mapping
+		 * of pl011 in ACPI and it's mapped to SBSA UART mode
+		 */
+		uap->vendor	= &vendor_sbsa;
+		uap->fifosize	= 32;
+		uap->port.ops	= &sbsa_uart_pops;
+		uap->fixed_baud = 115200;
 
-	snprintf(uap->type, sizeof(uap->type), "PL011 rev%u", amba_rev(dev));
+		snprintf(uap->type, sizeof(uap->type), "SBSA");
+	} else {
+		uap->clk = devm_clk_get(&dev->dev, NULL);
+		if (IS_ERR(uap->clk))
+			return PTR_ERR(uap->clk);
+
+		uap->vendor = vendor;
+		uap->lcrh_rx = vendor->lcrh_rx;
+		uap->lcrh_tx = vendor->lcrh_tx;
+		uap->fifosize = vendor->get_fifosize(dev);
+		uap->port.ops = &amba_pl011_pops;
+
+		snprintf(uap->type, sizeof(uap->type), "PL011 rev%u",
+				amba_rev(dev));
+	}
+	uap->port.irq = dev->irq[0];
 
 	ret = pl011_setup_port(&dev->dev, uap, &dev->res, portnr);
 	if (ret)
-- 
2.6.4

