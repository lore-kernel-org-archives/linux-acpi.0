From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 7/7] Fix event reading in sony-laptop
Date: Mon, 16 Jul 2007 02:34:39 +0900
Message-ID: <1184520880267-git-send-email-malattia@linux.it>
References: <1184520879452-git-send-email-malattia@linux.it>
 <1184520879991-git-send-email-malattia@linux.it>
 <11845208793336-git-send-email-malattia@linux.it>
 <11845208793678-git-send-email-malattia@linux.it>
 <11845208794064-git-send-email-malattia@linux.it>
 <11845208791511-git-send-email-malattia@linux.it>
 <11845208801817-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi13.ns.itscom.net ([219.110.2.183]:40452 "EHLO
	mtoichi13.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759243AbXGORfF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Jul 2007 13:35:05 -0400
In-Reply-To: <11845208801817-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, Mattia Dongili <malattia@linux.it>, Andrei Paskevich <andrei@capet.iut-fbleau.fr>

The rewritten event reading code from sonypi was absolutely wrong,
this patche makes things functional for type2 and type1 models.

Cc: Andrei Paskevich <andrei@capet.iut-fbleau.fr>
Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/misc/sony-laptop.c |   30 ++++++++++++++++++++++--------
 1 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 6909714..4831e72 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -1086,7 +1086,9 @@ static struct acpi_driver sony_nc_driver = {
 #define SONYPI_DEVICE_TYPE2	0x00000002
 #define SONYPI_DEVICE_TYPE3	0x00000004
 
-#define SONY_PIC_EV_MASK	0xff
+#define SONYPI_TYPE1_OFFSET	0x04
+#define SONYPI_TYPE2_OFFSET	0x12
+#define SONYPI_TYPE3_OFFSET	0x12
 
 struct sony_pic_ioport {
 	struct acpi_resource_io	io;
@@ -1100,6 +1102,7 @@ struct sony_pic_irq {
 
 struct sony_pic_dev {
 	int			model;
+	u16			evport_offset;
 	u8			camera_power;
 	u8			bluetooth_power;
 	u8			wwan_power;
@@ -2176,20 +2179,17 @@ end:
 static irqreturn_t sony_pic_irq(int irq, void *dev_id)
 {
 	int i, j;
-	u32 port_val = 0;
 	u8 ev = 0;
 	u8 data_mask = 0;
 	u8 device_event = 0;
 
 	struct sony_pic_dev *dev = (struct sony_pic_dev *) dev_id;
 
-	acpi_os_read_port(dev->cur_ioport->io.minimum, &port_val,
-			dev->cur_ioport->io.address_length);
-	ev = port_val & SONY_PIC_EV_MASK;
-	data_mask = 0xff & (port_val >> (dev->cur_ioport->io.address_length - 8));
+	ev = inb_p(dev->cur_ioport->io.minimum);
+	data_mask = inb_p(dev->cur_ioport->io.minimum + dev->evport_offset);
 
-	dprintk("event (0x%.8x [%.2x] [%.2x]) at port 0x%.4x\n",
-			port_val, ev, data_mask, dev->cur_ioport->io.minimum);
+	dprintk("event ([%.2x] [%.2x]) at port 0x%.4x(+0x%.2x)\n",
+			ev, data_mask, dev->cur_ioport->io.minimum, dev->evport_offset);
 
 	if (ev == 0x00 || ev == 0xff)
 		return IRQ_HANDLED;
@@ -2280,6 +2280,20 @@ static int sony_pic_add(struct acpi_device *device)
 	spic_dev.model = sony_pic_detect_device_type();
 	mutex_init(&spic_dev.lock);
 
+	/* model specific characteristics */
+	switch(spic_dev.model) {
+		case SONYPI_DEVICE_TYPE1:
+			spic_dev.evport_offset = SONYPI_TYPE1_OFFSET;
+			break;
+		case SONYPI_DEVICE_TYPE3:
+			spic_dev.evport_offset = SONYPI_TYPE3_OFFSET;
+			break;
+		case SONYPI_DEVICE_TYPE2:
+		default:
+			spic_dev.evport_offset = SONYPI_TYPE2_OFFSET;
+			break;
+	}
+
 	/* read _PRS resources */
 	result = sony_pic_possible_resources(device);
 	if (result) {
-- 
1.5.2.3

