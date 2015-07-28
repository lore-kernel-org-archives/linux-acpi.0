From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v2 18/22] pinctrl: Probe pinctrl devices on demand
Date: Tue, 28 Jul 2015 15:19:49 +0200
Message-ID: <1438089593-7696-19-git-send-email-tomeu.vizoso@collabora.com>
References: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:34173 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932253AbbG1NVO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Jul 2015 09:21:14 -0400
In-Reply-To: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-gpio@vger.kernel.org

When looking up a pin controller through its firmware node, probe it if
it hasn't already.

The goal is to reduce deferred probes to a minimum, as it makes it very
cumbersome to find out why a device failed to probe, and can introduce
very big delays in when a critical device is probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v2: None

 drivers/pinctrl/devicetree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
index fe04e748dfe4..490860f6374e 100644
--- a/drivers/pinctrl/devicetree.c
+++ b/drivers/pinctrl/devicetree.c
@@ -112,6 +112,7 @@ static int dt_to_map_one_config(struct pinctrl *p, const char *statename,
 
 	/* Find the pin controller containing np_config */
 	np_pctldev = of_node_get(np_config);
+	fwnode_ensure_device(&np_pctldev->fwnode);
 	for (;;) {
 		np_pctldev = of_get_next_parent(np_pctldev);
 		if (!np_pctldev || of_node_is_root(np_pctldev)) {
-- 
2.4.3

