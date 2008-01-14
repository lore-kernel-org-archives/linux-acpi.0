From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 3/6] sony-laptop: refactor model types
Date: Mon, 14 Jan 2008 18:05:43 +0900
Message-ID: <1200301546-6079-4-git-send-email-malattia@linux.it>
References: <1200301546-6079-1-git-send-email-malattia@linux.it>
 <1200301546-6079-2-git-send-email-malattia@linux.it>
 <1200301546-6079-3-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi14.ns.itscom.net ([219.110.2.184]:50566 "EHLO
	mtoichi14.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857AbYANJMc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Jan 2008 04:12:32 -0500
In-Reply-To: <1200301546-6079-3-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>

Create mini drivers and allow callbacks for each model
to be specified.
Following patches will make use of this feature to handle
specific cases instead of just executing code and hope
not to break other models.

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/misc/sony-laptop.c |  186 ++++++++++++++++++++++++-------------------
 1 files changed, 104 insertions(+), 82 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 7a32b35..a650f25 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -1194,18 +1194,33 @@ struct sony_pic_irq {
 	struct list_head		list;
 };
 
+struct sonypi_eventtypes {
+	u8			data;
+	unsigned long		mask;
+	struct sonypi_event	*events;
+};
+
+struct device_ctrl {
+	int				model;
+	int				(*handle_irq)(void);
+	u16				evport_offset;
+	u8				has_camera;
+	u8				has_bluetooth;
+	u8				has_wwan;
+	struct sonypi_eventtypes	*event_types;
+};
+
 struct sony_pic_dev {
-	int			model;
-	u16			evport_offset;
-	u8			camera_power;
-	u8			bluetooth_power;
-	u8			wwan_power;
+	struct device_ctrl	*control;
 	struct acpi_device	*acpi_dev;
 	struct sony_pic_irq	*cur_irq;
 	struct sony_pic_ioport	*cur_ioport;
 	struct list_head	interrupts;
 	struct list_head	ioports;
 	struct mutex		lock;
+	u8			camera_power;
+	u8			bluetooth_power;
+	u8			wwan_power;
 };
 
 static struct sony_pic_dev spic_dev = {
@@ -1370,74 +1385,92 @@ static struct sonypi_event sonypi_batteryev[] = {
 	{ 0, 0 }
 };
 
-static struct sonypi_eventtypes {
-	int			model;
-	u8			data;
-	unsigned long		mask;
-	struct sonypi_event *	events;
-} sony_pic_eventtypes[] = {
-	{ SONYPI_DEVICE_TYPE1, 0, 0xffffffff, sonypi_releaseev },
-	{ SONYPI_DEVICE_TYPE1, 0x70, SONYPI_MEYE_MASK, sonypi_meyeev },
-	{ SONYPI_DEVICE_TYPE1, 0x30, SONYPI_LID_MASK, sonypi_lidev },
-	{ SONYPI_DEVICE_TYPE1, 0x60, SONYPI_CAPTURE_MASK, sonypi_captureev },
-	{ SONYPI_DEVICE_TYPE1, 0x10, SONYPI_JOGGER_MASK, sonypi_joggerev },
-	{ SONYPI_DEVICE_TYPE1, 0x20, SONYPI_FNKEY_MASK, sonypi_fnkeyev },
-	{ SONYPI_DEVICE_TYPE1, 0x30, SONYPI_BLUETOOTH_MASK, sonypi_blueev },
-	{ SONYPI_DEVICE_TYPE1, 0x40, SONYPI_PKEY_MASK, sonypi_pkeyev },
-	{ SONYPI_DEVICE_TYPE1, 0x30, SONYPI_MEMORYSTICK_MASK, sonypi_memorystickev },
-	{ SONYPI_DEVICE_TYPE1, 0x40, SONYPI_BATTERY_MASK, sonypi_batteryev },
-
-	{ SONYPI_DEVICE_TYPE2, 0, 0xffffffff, sonypi_releaseev },
-	{ SONYPI_DEVICE_TYPE2, 0x38, SONYPI_LID_MASK, sonypi_lidev },
-	{ SONYPI_DEVICE_TYPE2, 0x11, SONYPI_JOGGER_MASK, sonypi_joggerev },
-	{ SONYPI_DEVICE_TYPE2, 0x61, SONYPI_CAPTURE_MASK, sonypi_captureev },
-	{ SONYPI_DEVICE_TYPE2, 0x21, SONYPI_FNKEY_MASK, sonypi_fnkeyev },
-	{ SONYPI_DEVICE_TYPE2, 0x31, SONYPI_BLUETOOTH_MASK, sonypi_blueev },
-	{ SONYPI_DEVICE_TYPE2, 0x08, SONYPI_PKEY_MASK, sonypi_pkeyev },
-	{ SONYPI_DEVICE_TYPE2, 0x11, SONYPI_BACK_MASK, sonypi_backev },
-	{ SONYPI_DEVICE_TYPE2, 0x21, SONYPI_HELP_MASK, sonypi_helpev },
-	{ SONYPI_DEVICE_TYPE2, 0x21, SONYPI_ZOOM_MASK, sonypi_zoomev },
-	{ SONYPI_DEVICE_TYPE2, 0x20, SONYPI_THUMBPHRASE_MASK, sonypi_thumbphraseev },
-	{ SONYPI_DEVICE_TYPE2, 0x31, SONYPI_MEMORYSTICK_MASK, sonypi_memorystickev },
-	{ SONYPI_DEVICE_TYPE2, 0x41, SONYPI_BATTERY_MASK, sonypi_batteryev },
-	{ SONYPI_DEVICE_TYPE2, 0x31, SONYPI_PKEY_MASK, sonypi_pkeyev },
-
-	{ SONYPI_DEVICE_TYPE3, 0, 0xffffffff, sonypi_releaseev },
-	{ SONYPI_DEVICE_TYPE3, 0x21, SONYPI_FNKEY_MASK, sonypi_fnkeyev },
-	{ SONYPI_DEVICE_TYPE3, 0x31, SONYPI_WIRELESS_MASK, sonypi_wlessev },
-	{ SONYPI_DEVICE_TYPE3, 0x31, SONYPI_MEMORYSTICK_MASK, sonypi_memorystickev },
-	{ SONYPI_DEVICE_TYPE3, 0x41, SONYPI_BATTERY_MASK, sonypi_batteryev },
-	{ SONYPI_DEVICE_TYPE3, 0x31, SONYPI_PKEY_MASK, sonypi_pkeyev },
-	{ 0 }
+static struct sonypi_eventtypes type1_events[] = {
+	{ 0, 0xffffffff, sonypi_releaseev },
+	{ 0x70, SONYPI_MEYE_MASK, sonypi_meyeev },
+	{ 0x30, SONYPI_LID_MASK, sonypi_lidev },
+	{ 0x60, SONYPI_CAPTURE_MASK, sonypi_captureev },
+	{ 0x10, SONYPI_JOGGER_MASK, sonypi_joggerev },
+	{ 0x20, SONYPI_FNKEY_MASK, sonypi_fnkeyev },
+	{ 0x30, SONYPI_BLUETOOTH_MASK, sonypi_blueev },
+	{ 0x40, SONYPI_PKEY_MASK, sonypi_pkeyev },
+	{ 0x30, SONYPI_MEMORYSTICK_MASK, sonypi_memorystickev },
+	{ 0x40, SONYPI_BATTERY_MASK, sonypi_batteryev },
+	{ 0 },
+};
+static struct sonypi_eventtypes type2_events[] = {
+	{ 0, 0xffffffff, sonypi_releaseev },
+	{ 0x38, SONYPI_LID_MASK, sonypi_lidev },
+	{ 0x11, SONYPI_JOGGER_MASK, sonypi_joggerev },
+	{ 0x61, SONYPI_CAPTURE_MASK, sonypi_captureev },
+	{ 0x21, SONYPI_FNKEY_MASK, sonypi_fnkeyev },
+	{ 0x31, SONYPI_BLUETOOTH_MASK, sonypi_blueev },
+	{ 0x08, SONYPI_PKEY_MASK, sonypi_pkeyev },
+	{ 0x11, SONYPI_BACK_MASK, sonypi_backev },
+	{ 0x21, SONYPI_HELP_MASK, sonypi_helpev },
+	{ 0x21, SONYPI_ZOOM_MASK, sonypi_zoomev },
+	{ 0x20, SONYPI_THUMBPHRASE_MASK, sonypi_thumbphraseev },
+	{ 0x31, SONYPI_MEMORYSTICK_MASK, sonypi_memorystickev },
+	{ 0x41, SONYPI_BATTERY_MASK, sonypi_batteryev },
+	{ 0x31, SONYPI_PKEY_MASK, sonypi_pkeyev },
+	{ 0 },
+};
+static struct sonypi_eventtypes type3_events[] = {
+	{ 0, 0xffffffff, sonypi_releaseev },
+	{ 0x21, SONYPI_FNKEY_MASK, sonypi_fnkeyev },
+	{ 0x31, SONYPI_WIRELESS_MASK, sonypi_wlessev },
+	{ 0x31, SONYPI_MEMORYSTICK_MASK, sonypi_memorystickev },
+	{ 0x41, SONYPI_BATTERY_MASK, sonypi_batteryev },
+	{ 0x31, SONYPI_PKEY_MASK, sonypi_pkeyev },
+	{ 0 },
 };
 
-static int sony_pic_detect_device_type(void)
+static struct device_ctrl spic_types[] = {
+	{
+		.model = SONYPI_DEVICE_TYPE1,
+		.handle_irq = NULL,
+		.evport_offset = SONYPI_TYPE1_OFFSET,
+		.event_types = type1_events,
+	},
+	{
+		.model = SONYPI_DEVICE_TYPE2,
+		.handle_irq = NULL,
+		.evport_offset = SONYPI_TYPE2_OFFSET,
+		.event_types = type2_events,
+	},
+	{
+		.model = SONYPI_DEVICE_TYPE3,
+		.handle_irq = NULL,
+		.evport_offset = SONYPI_TYPE3_OFFSET,
+		.event_types = type3_events,
+	},
+};
+
+static void sony_pic_detect_device_type(struct sony_pic_dev *dev)
 {
 	struct pci_dev *pcidev;
-	int model = 0;
 
 	if ((pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
 				     PCI_DEVICE_ID_INTEL_82371AB_3, NULL)))
-		model = SONYPI_DEVICE_TYPE1;
+		dev->control = &spic_types[0];
 
 	else if ((pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
 					  PCI_DEVICE_ID_INTEL_ICH6_1, NULL)))
-		model = SONYPI_DEVICE_TYPE3;
+		dev->control = &spic_types[2];
 
 	else if ((pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
 					  PCI_DEVICE_ID_INTEL_ICH7_1, NULL)))
-		model = SONYPI_DEVICE_TYPE3;
+		dev->control = &spic_types[2];
 
 	else
-		model = SONYPI_DEVICE_TYPE2;
+		dev->control = &spic_types[1];
 
 	if (pcidev)
 		pci_dev_put(pcidev);
 
 	printk(KERN_INFO DRV_PFX "detected Type%d model\n",
-			model == SONYPI_DEVICE_TYPE1 ? 1 :
-			model == SONYPI_DEVICE_TYPE2 ? 2 : 3);
-	return model;
+			dev->control->model == SONYPI_DEVICE_TYPE1 ? 1 :
+			dev->control->model == SONYPI_DEVICE_TYPE2 ? 2 : 3);
 }
 
 #define ITERATIONS_LONG		10000
@@ -2263,7 +2296,7 @@ static int sony_pic_enable(struct acpi_device *device,
 	buffer.pointer = resource;
 
 	/* setup Type 1 resources */
-	if (spic_dev.model == SONYPI_DEVICE_TYPE1) {
+	if (spic_dev.control->model == SONYPI_DEVICE_TYPE1) {
 
 		/* setup io resources */
 		resource->res1.type = ACPI_RESOURCE_TYPE_IO;
@@ -2345,39 +2378,42 @@ static irqreturn_t sony_pic_irq(int irq, void *dev_id)
 	if (dev->cur_ioport->io2.minimum)
 		data_mask = inb_p(dev->cur_ioport->io2.minimum);
 	else
-		data_mask = inb_p(dev->cur_ioport->io1.minimum + dev->evport_offset);
+		data_mask = inb_p(dev->cur_ioport->io1.minimum +
+				dev->control->evport_offset);
 
 	dprintk("event ([%.2x] [%.2x]) at port 0x%.4x(+0x%.2x)\n",
-			ev, data_mask, dev->cur_ioport->io1.minimum, dev->evport_offset);
+			ev, data_mask, dev->cur_ioport->io1.minimum,
+			dev->control->evport_offset);
 
 	if (ev == 0x00 || ev == 0xff)
 		return IRQ_HANDLED;
 
-	for (i = 0; sony_pic_eventtypes[i].model; i++) {
+	for (i = 0; dev->control->event_types[i].mask; i++) {
 
-		if (spic_dev.model != sony_pic_eventtypes[i].model)
+		if ((data_mask & dev->control->event_types[i].data) !=
+		    dev->control->event_types[i].data)
 			continue;
 
-		if ((data_mask & sony_pic_eventtypes[i].data) !=
-		    sony_pic_eventtypes[i].data)
+		if (!(mask & dev->control->event_types[i].mask))
 			continue;
 
-		if (!(mask & sony_pic_eventtypes[i].mask))
-			continue;
-
-		for (j = 0; sony_pic_eventtypes[i].events[j].event; j++) {
-			if (ev == sony_pic_eventtypes[i].events[j].data) {
+		for (j = 0; dev->control->event_types[i].events[j].event; j++) {
+			if (ev == dev->control->event_types[i].events[j].data) {
 				device_event =
-					sony_pic_eventtypes[i].events[j].event;
+					dev->control->
+						event_types[i].events[j].event;
 				goto found;
 			}
 		}
 	}
+	dprintk("unknown event ([%.2x] [%.2x]) at port 0x%.4x(+0x%.2x)\n",
+			ev, data_mask, dev->cur_ioport->io1.minimum,
+			dev->control->evport_offset);
 	return IRQ_HANDLED;
 
 found:
 	sony_laptop_report_input_event(device_event);
-	acpi_bus_generate_proc_event(spic_dev.acpi_dev, 1, device_event);
+	acpi_bus_generate_proc_event(dev->acpi_dev, 1, device_event);
 	sonypi_compat_report_event(device_event);
 
 	return IRQ_HANDLED;
@@ -2439,23 +2475,9 @@ static int sony_pic_add(struct acpi_device *device)
 
 	spic_dev.acpi_dev = device;
 	strcpy(acpi_device_class(device), "sony/hotkey");
-	spic_dev.model = sony_pic_detect_device_type();
+	sony_pic_detect_device_type(&spic_dev);
 	mutex_init(&spic_dev.lock);
 
-	/* model specific characteristics */
-	switch(spic_dev.model) {
-		case SONYPI_DEVICE_TYPE1:
-			spic_dev.evport_offset = SONYPI_TYPE1_OFFSET;
-			break;
-		case SONYPI_DEVICE_TYPE3:
-			spic_dev.evport_offset = SONYPI_TYPE3_OFFSET;
-			break;
-		case SONYPI_DEVICE_TYPE2:
-		default:
-			spic_dev.evport_offset = SONYPI_TYPE2_OFFSET;
-			break;
-	}
-
 	/* read _PRS resources */
 	result = sony_pic_possible_resources(device);
 	if (result) {
-- 
1.5.3.7

