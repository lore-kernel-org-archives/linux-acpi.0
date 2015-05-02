From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 1/2 linux-next] PNPACPI: use u8 instead of int in acpi_resource_extended_irq context
Date: Sat,  2 May 2015 17:14:49 +0200
Message-ID: <1430579690-24131-1-git-send-email-fabf@skynet.be>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailrelay112.isp.belgacom.be ([195.238.20.139]:60306 "EHLO
	mailrelay112.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751876AbbEBPPD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 2 May 2015 11:15:03 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Fabian Frederick <fabf@skynet.be>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

acpi_resource_extented_irq variables are all u8.
Use that type for triggering, polarity and shareable.
This fixes gcc warnings of type
"conversion to u8 from int may alter its value"

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/pnp/pnpacpi/rsparser.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index ff0356f..23a08d1 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -28,8 +28,8 @@
 #include "../base.h"
 #include "pnpacpi.h"
 
-static void decode_irq_flags(struct pnp_dev *dev, int flags, int *triggering,
-			     int *polarity, int *shareable)
+static void decode_irq_flags(struct pnp_dev *dev, int flags, u8 *triggering,
+			     u8 *polarity, u8 *shareable)
 {
 	switch (flags & (IORESOURCE_IRQ_LOWLEVEL | IORESOURCE_IRQ_HIGHLEVEL |
 			 IORESOURCE_IRQ_LOWEDGE  | IORESOURCE_IRQ_HIGHEDGE)) {
@@ -654,7 +654,7 @@ static void pnpacpi_encode_irq(struct pnp_dev *dev,
 			       struct resource *p)
 {
 	struct acpi_resource_irq *irq = &resource->data.irq;
-	int triggering, polarity, shareable;
+	u8 triggering, polarity, shareable;
 
 	if (!pnp_resource_enabled(p)) {
 		irq->interrupt_count = 0;
@@ -683,7 +683,7 @@ static void pnpacpi_encode_ext_irq(struct pnp_dev *dev,
 				   struct resource *p)
 {
 	struct acpi_resource_extended_irq *extended_irq = &resource->data.extended_irq;
-	int triggering, polarity, shareable;
+	u8 triggering, polarity, shareable;
 
 	if (!pnp_resource_enabled(p)) {
 		extended_irq->interrupt_count = 0;
-- 
1.9.1

