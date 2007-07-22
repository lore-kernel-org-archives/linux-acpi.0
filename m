From: Len Brown <len.brown@intel.com>
Subject: [PATCH 70/77] sony-laptop: Fix event reading in sony-laptop
Date: Sun, 22 Jul 2007 05:14:55 -0400
Message-ID: <1185095775978-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
 <11850957073494-git-send-email-len.brown@intel.com>
 <1185095708928-git-send-email-len.brown@intel.com>
 <11850957093360-git-send-email-len.brown@intel.com>
 <11850957102641-git-send-email-len.brown@intel.com>
 <11850957111797-git-send-email-len.brown@intel.com>
 <11850957123807-git-send-email-len.brown@intel.com>
 <11850957131802-git-send-email-len.brown@intel.com>
 <1185095714699-git-send-email-len.brown@intel.com>
 <1185095715506-git-send-email-len.brown@intel.com>
 <11850957162801-git-send-email-len.brown@intel.com>
 <11850957173842-git-send-email-len.brown@intel.com>
 <11850957181201-git-send-email-len.brown@intel.com>
 <11850957192175-git-send-email-len.brown@intel.com>
 <1185095721166-git-send-email-len.brown@intel.com>
 <1185095721760-git-send-email-len.brown@intel.com>
 <11850957232745-git-send-email-len.brown@intel.com>
 <11850957242656-git-send-email-len.brown@intel.com>
 <11850957252722-git-send-email-len.brown@intel.com>
 <11850957262869-git-send-email-len.brown@intel.com>
 <11850957272369-git-send-email-len.brown@intel.com>
 <11850957282082-git-send-email-len.brown@intel.com>
 <11850957292555-git-send-email-len.brown@intel.com>
 <11850957302782-git-send-email-len.brown@intel.com>
 <11850957311269-git-send-email-len.brown@intel.com>
 <11850957323059-git-send-email-len.brown@intel.com>
 <11850957332171-git-send-email-len.brown@intel.com>
 <11850957342584-git-send-email-len.brown@intel.com>
 <11850957362476-git-send-email-len.brown@intel.com>
 <11850957361736-git-send-email-len.brown@intel.com>
 <1185095737422-git-send-email-len.brown@intel.com>
 <11850957384004-git-send-email-len.brown@intel.com>
 <1185095739370-git-send-email-len.brown@intel.com>
 <11850957403722-git-send-email-len.brown@intel.com>
 <11850957413607-git-send-email-len.brown@intel.com>
 <11850957432095-git-send-email-len.brown@intel.com>
 <11850957443711-git-send-email-len.brown@intel.com>
 <11850957451942-git-send-email-len.brown@intel.com>
 <11850957462109-git-send-email-len.brown@intel.com>
 <11850957471828-git-send-email-len.brown@intel.com>
 <11850957482671-git-send-email-len.brown@intel.com>
 <11850957491254-git-send-email-len.brown@intel.com>
 <11850957503243-git-send-email-len.brown@intel.com>
 <1185095751279-git-send-email-len.brown@intel.com>
 <11850957522609-git-send-email-len.brown@intel.com>
 <11850957531914-git-send-email-len.brown@intel.com>
 <11850957541879-git-send-email-len.brown@intel.com>
 <11850957552824-git-send-email-len.brown@intel.com>
 <11850957561003-git-send-email-len.brown@intel.com>
 <11850957571080-git-send-email-len.brown@intel.com>
 <11850957591101-git-send-email-len.brown@intel.com>
 <11850957601664-git-send-email-len.brown@intel.com>
 <1185095761326-git-send-email-len.brown@intel.com>
 <11850957621605-git-send-email-len.brown@intel.com>
 <11850957633613-git-send-email-len.brown@intel.com>
 <11850957641697-git-send-email-len.brown@intel.com>
 <11850957651127-git-send-email-len.brown@intel.com>
 <1185095766274-git-send-email-len.brown@intel.com>
 <1185095767879-git-send-email-len.brown@intel.com>
 <1185095768376-git-send-email-len.brown@intel.com>
 <11850957691561-git-send-email-len.brown@intel.com>
 <11850957703097-git-send-email-len.brown@intel.com>
 <11850957712166-git-send-email-len.brown@intel.com>
 <11850957721285-git-send-email-len.brown@intel.com>
 <11850957721315-git-send-email-len.brown@intel.com>
 <11850957741937-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6024 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764557AbXGVJQR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:16:17 -0400
In-Reply-To: <11850957741937-git-send-email-len.brown@intel.com>
Message-Id: <22a17780584173635dae11bb83884952b00e5181.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Mattia Dongili <malattia@linux.it>, Andrei Paskevich <andrei@capet.iut-fbleau.fr>, Len Brown <len.brown@intel.com>

From: Mattia Dongili <malattia@linux.it>

The rewritten event reading code from sonypi was absolutely wrong,
this patche makes things functional for type2 and type1 models.

Cc: Andrei Paskevich <andrei@capet.iut-fbleau.fr>
Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/sony-laptop.c |   30 ++++++++++++++++++++++--------
 1 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 85969c8..303e48c 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -1142,7 +1142,9 @@ static struct acpi_driver sony_nc_driver = {
 #define SONYPI_DEVICE_TYPE2	0x00000002
 #define SONYPI_DEVICE_TYPE3	0x00000004
 
-#define SONY_PIC_EV_MASK	0xff
+#define SONYPI_TYPE1_OFFSET	0x04
+#define SONYPI_TYPE2_OFFSET	0x12
+#define SONYPI_TYPE3_OFFSET	0x12
 
 struct sony_pic_ioport {
 	struct acpi_resource_io	io;
@@ -1156,6 +1158,7 @@ struct sony_pic_irq {
 
 struct sony_pic_dev {
 	int			model;
+	u16			evport_offset;
 	u8			camera_power;
 	u8			bluetooth_power;
 	u8			wwan_power;
@@ -2233,20 +2236,17 @@ end:
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
@@ -2337,6 +2337,20 @@ static int sony_pic_add(struct acpi_device *device)
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
1.5.3.rc2.22.g69a9b
