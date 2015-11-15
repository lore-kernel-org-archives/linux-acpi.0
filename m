From: Christophe Ricard <christophe.ricard@gmail.com>
Subject: [RFC 2/2] ACPI / gpio: Add irq_type when a gpio is used as an interrupt
Date: Sun, 15 Nov 2015 11:15:41 +0100
Message-ID: <1447582541-5630-3-git-send-email-christophe-h.ricard@st.com>
References: <1447582541-5630-1-git-send-email-christophe-h.ricard@st.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35260 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856AbbKOKPt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Nov 2015 05:15:49 -0500
Received: by wmdw130 with SMTP id w130so77274881wmd.0
        for <linux-acpi@vger.kernel.org>; Sun, 15 Nov 2015 02:15:48 -0800 (PST)
In-Reply-To: <1447582541-5630-1-git-send-email-christophe-h.ricard@st.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Christophe Ricard <christophe-h.ricard@st.com>

When a gpio is used as an interrupt, the irq_type was not available for
device driver. It is not align with devicetree probing.

Signed-off-by: Christophe Ricard <christophe-h.ricard@st.com>
---
 drivers/gpio/gpiolib-acpi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index bbcac3a..cff8736 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -416,9 +416,12 @@ static int acpi_find_gpio(struct acpi_resource *ares, void *data)
 		 * GpioIo is used then the only way to set the flag is
 		 * to use _DSD "gpios" property.
 		 */
-		if (lookup->info.gpioint)
+		if (lookup->info.gpioint) {
 			lookup->info.active_low =
 				agpio->polarity == ACPI_ACTIVE_LOW;
+			irq_set_irq_type(gpiod_to_irq(lookup->desc),
+					 acpi_get_irq_type(agpio->triggering, agpio->polarity));
+		}
 	}
 
 	return 1;
-- 
2.1.4

