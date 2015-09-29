From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v7 06/20] pinctrl: Probe pinctrl devices on demand
Date: Tue, 29 Sep 2015 11:10:44 +0200
Message-ID: <1443517859-30376-7-git-send-email-tomeu.vizoso@collabora.com>
References: <1443517859-30376-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35059 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933417AbbI2JMM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Sep 2015 05:12:12 -0400
In-Reply-To: <1443517859-30376-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Tomeu Vizoso <tomeu.vizoso@collabora.com>

When looking up a pin controller through its OF node, probe it if it
hasn't already.

The goal is to reduce deferred probes to a minimum, as it makes it very
cumbersome to find out why a device failed to probe, and can introduce
very big delays in when a critical device is probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---


 drivers/gpio/gpiolib-of.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 9a439dab7a87..05da9a56608d 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -359,6 +359,8 @@ static int of_gpiochip_add_pin_range(struct gpio_chip *chip)
 		if (ret)
 			break;
 
+		of_device_probe(pinspec.np);
+
 		pctldev = of_pinctrl_get(pinspec.np);
 		if (!pctldev)
 			return -EPROBE_DEFER;
-- 
2.4.3

