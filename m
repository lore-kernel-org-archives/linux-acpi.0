From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 1/4] sony-laptop: remove device_ctrl and the SPIC mini drivers
Date: Wed, 16 Sep 2009 00:05:29 +0900
Message-ID: <1253027132-5903-2-git-send-email-malattia@linux.it>
References: <1253027132-5903-1-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:43823
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754680AbZIOPO0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Sep 2009 11:14:26 -0400
In-Reply-To: <1253027132-5903-1-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>

Having separate drivers for SPIC showed to be useless, only type3 has a
slightly different behaviour than the others and there seem to be no real
conflict between them.

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/platform/x86/sony-laptop.c |  109 +++++++++++++++--------------------
 1 files changed, 47 insertions(+), 62 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index dafaa4a..e283fe9 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -1393,27 +1393,20 @@ struct sonypi_eventtypes {
 	struct sonypi_event	*events;
 };
 
-struct device_ctrl {
+struct sony_pic_dev {
+	struct acpi_device		*acpi_dev;
+	struct sony_pic_irq		*cur_irq;
+	struct sony_pic_ioport		*cur_ioport;
+	struct list_head		interrupts;
+	struct list_head		ioports;
+	struct mutex			lock;
+	struct sonypi_eventtypes	*event_types;
+	int                             (*handle_irq)(const u8, const u8);
 	int				model;
-	int				(*handle_irq)(const u8, const u8);
 	u16				evport_offset;
-	u8				has_camera;
-	u8				has_bluetooth;
-	u8				has_wwan;
-	struct sonypi_eventtypes	*event_types;
-};
-
-struct sony_pic_dev {
-	struct device_ctrl	*control;
-	struct acpi_device	*acpi_dev;
-	struct sony_pic_irq	*cur_irq;
-	struct sony_pic_ioport	*cur_ioport;
-	struct list_head	interrupts;
-	struct list_head	ioports;
-	struct mutex		lock;
-	u8			camera_power;
-	u8			bluetooth_power;
-	u8			wwan_power;
+	u8				camera_power;
+	u8				bluetooth_power;
+	u8				wwan_power;
 };
 
 static struct sony_pic_dev spic_dev = {
@@ -1718,27 +1711,6 @@ static int type3_handle_irq(const u8 data_mask, const u8 ev)
 	return 1;
 }
 
-static struct device_ctrl spic_types[] = {
-	{
-		.model = SONYPI_DEVICE_TYPE1,
-		.handle_irq = NULL,
-		.evport_offset = SONYPI_TYPE1_OFFSET,
-		.event_types = type1_events,
-	},
-	{
-		.model = SONYPI_DEVICE_TYPE2,
-		.handle_irq = NULL,
-		.evport_offset = SONYPI_TYPE2_OFFSET,
-		.event_types = type2_events,
-	},
-	{
-		.model = SONYPI_DEVICE_TYPE3,
-		.handle_irq = type3_handle_irq,
-		.evport_offset = SONYPI_TYPE3_OFFSET,
-		.event_types = type3_events,
-	},
-};
-
 static void sony_pic_detect_device_type(struct sony_pic_dev *dev)
 {
 	struct pci_dev *pcidev;
@@ -1746,48 +1718,63 @@ static void sony_pic_detect_device_type(struct sony_pic_dev *dev)
 	pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
 			PCI_DEVICE_ID_INTEL_82371AB_3, NULL);
 	if (pcidev) {
-		dev->control = &spic_types[0];
+		dev->model = SONYPI_DEVICE_TYPE1;
+		dev->evport_offset = SONYPI_TYPE1_OFFSET;
+		dev->event_types = type1_events;
 		goto out;
 	}
 
 	pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
 			PCI_DEVICE_ID_INTEL_ICH6_1, NULL);
 	if (pcidev) {
-		dev->control = &spic_types[2];
+		dev->model = SONYPI_DEVICE_TYPE2;
+		dev->evport_offset = SONYPI_TYPE2_OFFSET;
+		dev->event_types = type2_events;
 		goto out;
 	}
 
 	pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
 			PCI_DEVICE_ID_INTEL_ICH7_1, NULL);
 	if (pcidev) {
-		dev->control = &spic_types[2];
+		dev->model = SONYPI_DEVICE_TYPE3;
+		dev->handle_irq = type3_handle_irq;
+		dev->evport_offset = SONYPI_TYPE3_OFFSET;
+		dev->event_types = type3_events;
 		goto out;
 	}
 
 	pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
 			PCI_DEVICE_ID_INTEL_ICH8_4, NULL);
 	if (pcidev) {
-		dev->control = &spic_types[2];
+		dev->model = SONYPI_DEVICE_TYPE3;
+		dev->handle_irq = type3_handle_irq;
+		dev->evport_offset = SONYPI_TYPE3_OFFSET;
+		dev->event_types = type3_events;
 		goto out;
 	}
 
 	pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
 			PCI_DEVICE_ID_INTEL_ICH9_1, NULL);
 	if (pcidev) {
-		dev->control = &spic_types[2];
+		dev->model = SONYPI_DEVICE_TYPE3;
+		dev->handle_irq = type3_handle_irq;
+		dev->evport_offset = SONYPI_TYPE3_OFFSET;
+		dev->event_types = type3_events;
 		goto out;
 	}
 
 	/* default */
-	dev->control = &spic_types[1];
+	dev->model = SONYPI_DEVICE_TYPE2;
+	dev->evport_offset = SONYPI_TYPE2_OFFSET;
+	dev->event_types = type2_events;
 
 out:
 	if (pcidev)
 		pci_dev_put(pcidev);
 
 	printk(KERN_INFO DRV_PFX "detected Type%d model\n",
-			dev->control->model == SONYPI_DEVICE_TYPE1 ? 1 :
-			dev->control->model == SONYPI_DEVICE_TYPE2 ? 2 : 3);
+			dev->model == SONYPI_DEVICE_TYPE1 ? 1 :
+			dev->model == SONYPI_DEVICE_TYPE2 ? 2 : 3);
 }
 
 /* camera tests and poweron/poweroff */
@@ -2560,7 +2547,7 @@ static int sony_pic_enable(struct acpi_device *device,
 	buffer.pointer = resource;
 
 	/* setup Type 1 resources */
-	if (spic_dev.control->model == SONYPI_DEVICE_TYPE1) {
+	if (spic_dev.model == SONYPI_DEVICE_TYPE1) {
 
 		/* setup io resources */
 		resource->res1.type = ACPI_RESOURCE_TYPE_IO;
@@ -2643,29 +2630,28 @@ static irqreturn_t sony_pic_irq(int irq, void *dev_id)
 		data_mask = inb_p(dev->cur_ioport->io2.minimum);
 	else
 		data_mask = inb_p(dev->cur_ioport->io1.minimum +
-				dev->control->evport_offset);
+				dev->evport_offset);
 
 	dprintk("event ([%.2x] [%.2x]) at port 0x%.4x(+0x%.2x)\n",
 			ev, data_mask, dev->cur_ioport->io1.minimum,
-			dev->control->evport_offset);
+			dev->evport_offset);
 
 	if (ev == 0x00 || ev == 0xff)
 		return IRQ_HANDLED;
 
-	for (i = 0; dev->control->event_types[i].mask; i++) {
+	for (i = 0; dev->event_types[i].mask; i++) {
 
-		if ((data_mask & dev->control->event_types[i].data) !=
-		    dev->control->event_types[i].data)
+		if ((data_mask & dev->event_types[i].data) !=
+		    dev->event_types[i].data)
 			continue;
 
-		if (!(mask & dev->control->event_types[i].mask))
+		if (!(mask & dev->event_types[i].mask))
 			continue;
 
-		for (j = 0; dev->control->event_types[i].events[j].event; j++) {
-			if (ev == dev->control->event_types[i].events[j].data) {
+		for (j = 0; dev->event_types[i].events[j].event; j++) {
+			if (ev == dev->event_types[i].events[j].data) {
 				device_event =
-					dev->control->
-						event_types[i].events[j].event;
+					dev->event_types[i].events[j].event;
 				goto found;
 			}
 		}
@@ -2673,13 +2659,12 @@ static irqreturn_t sony_pic_irq(int irq, void *dev_id)
 	/* Still not able to decode the event try to pass
 	 * it over to the minidriver
 	 */
-	if (dev->control->handle_irq &&
-			dev->control->handle_irq(data_mask, ev) == 0)
+	if (dev->handle_irq && dev->handle_irq(data_mask, ev) == 0)
 		return IRQ_HANDLED;
 
 	dprintk("unknown event ([%.2x] [%.2x]) at port 0x%.4x(+0x%.2x)\n",
 			ev, data_mask, dev->cur_ioport->io1.minimum,
-			dev->control->evport_offset);
+			dev->evport_offset);
 	return IRQ_HANDLED;
 
 found:
-- 
1.6.3.3

