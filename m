From: Len Brown <len.brown@intel.com>
Subject: [PATCH 105/105] sonypi: use mutex instead of semaphore
Date: Sun, 29 Apr 2007 00:51:45 -0400
Message-ID: <11778224002762-git-send-email-len.brown@intel.com>
References: <11778223052751-git-send-email-len.brown@intel.com>
 <11778223068-git-send-email-len.brown@intel.com>
 <11778223072296-git-send-email-len.brown@intel.com>
 <11778223083747-git-send-email-len.brown@intel.com>
 <11778223081771-git-send-email-len.brown@intel.com>
 <1177822309524-git-send-email-len.brown@intel.com>
 <1177822310688-git-send-email-len.brown@intel.com>
 <11778223112050-git-send-email-len.brown@intel.com>
 <11778223122850-git-send-email-len.brown@intel.com>
 <11778223131932-git-send-email-len.brown@intel.com>
 <11778223143898-git-send-email-len.brown@intel.com>
 <11778223151972-git-send-email-len.brown@intel.com>
 <11778223152006-git-send-email-len.brown@intel.com>
 <11778223161614-git-send-email-len.brown@intel.com>
 <11778223173663-git-send-email-len.brown@intel.com>
 <11778223183783-git-send-email-len.brown@intel.com>
 <11778223192706-git-send-email-len.brown@intel.com>
 <11778223201940-git-send-email-len.brown@intel.com>
 <11778223212414-git-send-email-len.brown@intel.com>
 <11778223211710-git-send-email-len.brown@intel.com>
 <11778223222525-git-send-email-len.brown@intel.com>
 <11778223233885-git-send-email-len.brown@intel.com>
 <1177822324973-git-send-email-len.brown@intel.com>
 <11778223251849-git-send-email-len.brown@intel.com>
 <1177822326583-git-send-email-len.brown@intel.com>
 <11778223273782-git-send-email-len.brown@intel.com>
 <11778223282154-git-send-email-len.brown@intel.com>
 <11778223282215-git-send-email-len.brown@intel.com>
 <11778223304019-git-send-email-len.brown@intel.com>
 <1177822331727-git-send-email-len.brown@intel.com>
 <117782233197-git-send-email-len.brown@intel.com>
 <11778223331858-git-send-email-len.brown@intel.com>
 <11778223353919-git-send-email-len.brown@intel.com>
 <1177822337332-git-send-email-len.brown@intel.com>
 <11778223382880-git-send-email-len.brown@intel.com>
 <11778223392178-git-send-email-len.brown@intel.com>
 <11778223401417-git-send-email-len.brown@intel.com>
 <11778223411658-git-send-email-len.brown@intel.com>
 <11778223412672-git-send-email-len.brown@intel.com>
 <11778223423-git-send-email-len.brown@intel.com>
 <1177822343712-git-send-email-len.brown@intel.com>
 <11778223442065-git-send-email-len.brown@intel.com>
 <11778223452843-git-send-email-len.brown@intel.com>
 <11778223461282-git-send-email-len.brown@intel.com>
 <11778223472316-git-send-email-len.brown@intel.com>
 <1177822347845-git-send-email-len.brown@intel.com>
 <1177822348546-git-send-email-len.brown@intel.com>
 <11778223493327-git-send-email-len.brown@intel.com>
 <11778223502745-git-send-email-len.brown@intel.com>
 <11778223512990-git-send-email-len.brown@intel.com>
 <1177822352591-git-send-email-len.brown@intel.com>
 <11778223532461-git-send-email-len.brown@intel.com>
 <11778223544100-git-send-email-len.brown@intel.com>
 <11778223553521-git-send-email-len.brown@intel.com>
 <11778223551720-git-send-email-len.brown@intel.com>
 <11778223562656-git-send-email-len.brown@intel.com>
 <11778223571390-git-send-email-len.brown@intel.com>
 <11778223581484-git-send-email-len.brown@intel.com>
 <11778223593048-git-send-email-len.brown@intel.com>
 <11778223602019-git-send-email-len.brown@intel.com>
 <11778223612093-git-send-email-len.brown@intel.com>
 <117782236226-git-send-email-len.brown@intel.com>
 <11778223624095-git-send-email-len.brown@intel.com>
 <11778223633408-git-send-email-len.brown@intel.com>
 <1177822364262-git-send-email-len.brown@intel.com>
 <11778223653391-git-send-email-len.brown@intel.com>
 <11778223663850-git-send-email-len.brown@intel.com>
 <11778223673988-git-send-email-len.brown@intel.com>
 <1177822368767-git-send-email-len.brown@intel.com>
 <1177822368793-git-send-email-len.brown@intel.com>
 <11778223692377-git-send-email-len.brown@intel.com>
 <1177822370442-git-send-email-len.brown@intel.com>
 <1177822371935-git-send-email-len.brown@intel.com>
 <11778223721984-git-send-email-len.brown@intel.com>
 <11778223732286-git-send-email-len.brown@intel.com>
 <11778223733679-git-send-email-len.brown@intel.com>
 <11778223741-git-send-email-len.brown@intel.com>
 <11778223752175-git-send-email-len.brown@intel.com>
 <1177822376123-git-send-email-len.brown@intel.com>
 <11778223771048-git-send-email-len.brown@intel.com>
 <11778223782086-git-send-email-len.brown@intel.com>
 <11778223792074-git-send-email-len.brown@intel.com>
 <11778223802796-git-send-email-len.brown@intel.com>
 <11778223812071-git-send-email-len.brown@intel.com>
 <11778223823637-git-send-email-len.brown@intel.com>
 <117782238310-git-send-email-len.brown@intel.com>
 <11778223843825-git-send-email-len.brown@intel.com>
 <11778223852391-git-send-email-len.brown@intel.com>
 <11778223861983-git-send-email-len.brown@intel.com>
 <11778223872566-git-send-email-len.brown@intel.com>
 <1177822387623-git-send-email-len.brown@intel.com>
 <1177822388542-git-send-email-len.brown@intel.com>
 <1177822389199-git-send-email-len.brown@intel.com>
 <11778223902327-git-send-email-len.brown@intel.com>
 <11778223912498-git-send-email-len.brown@intel.com>
 <11778223921730-git-send-email-len.brown@intel.com>
 <11778223931192-git-send-email-len.brown@intel.com>
 <11778223942367-git-send-email-len.brown@intel.com>
 <11778223942377-git-send-email-len.brown@intel.com>
 <1177822395384-git-send-email-len.brown@intel.com>
 <11778223963095-git-send-email-len.brown@intel.com>
 <11778223972558-git-send-email-len.brown@intel.com>
 <11778223981263-git-send-email-len.brown@intel.com>
 <117782239917-git-send-email-len.brown@intel.com>
 <11778223992559-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:37949 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754589AbXD2ExX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:53:23 -0400
In-Reply-To: <11778223992559-git-send-email-len.brown@intel.com>
Message-Id: <c6c60106b9584f17c55e4c5e0ce9b905a1a6cdb6.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Matthias Kaehlcke <matthias.kaehlcke@gmail.com>, Len Brown <len.brown@intel.com>

From: Matthias Kaehlcke <matthias.kaehlcke@gmail.com>

the Sony Programmable I/O Control driver uses a semaphore as
mutex. use the mutex API instead of the (binary) semaphore

Signed-off-by: Matthias Kaehlcke <matthias.kaehlcke@gmail.com>
Acked-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/char/sonypi.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/char/sonypi.c b/drivers/char/sonypi.c
index b699890..3ef593a 100644
--- a/drivers/char/sonypi.c
+++ b/drivers/char/sonypi.c
@@ -484,7 +484,7 @@ static struct sonypi_device {
 	u16 evtype_offset;
 	int camera_power;
 	int bluetooth_power;
-	struct semaphore lock;
+	struct mutex lock;
 	struct kfifo *fifo;
 	spinlock_t fifo_lock;
 	wait_queue_head_t fifo_proc_list;
@@ -891,7 +891,7 @@ int sonypi_camera_command(int command, u8 value)
 	if (!camera)
 		return -EIO;
 
-	down(&sonypi_device.lock);
+	mutex_lock(&sonypi_device.lock);
 
 	switch (command) {
 	case SONYPI_COMMAND_SETCAMERA:
@@ -926,7 +926,7 @@ int sonypi_camera_command(int command, u8 value)
 		       command);
 		break;
 	}
-	up(&sonypi_device.lock);
+	mutex_unlock(&sonypi_device.lock);
 	return 0;
 }
 
@@ -945,20 +945,20 @@ static int sonypi_misc_fasync(int fd, struct file *filp, int on)
 static int sonypi_misc_release(struct inode *inode, struct file *file)
 {
 	sonypi_misc_fasync(-1, file, 0);
-	down(&sonypi_device.lock);
+	mutex_lock(&sonypi_device.lock);
 	sonypi_device.open_count--;
-	up(&sonypi_device.lock);
+	mutex_unlock(&sonypi_device.lock);
 	return 0;
 }
 
 static int sonypi_misc_open(struct inode *inode, struct file *file)
 {
-	down(&sonypi_device.lock);
+	mutex_lock(&sonypi_device.lock);
 	/* Flush input queue on first open */
 	if (!sonypi_device.open_count)
 		kfifo_reset(sonypi_device.fifo);
 	sonypi_device.open_count++;
-	up(&sonypi_device.lock);
+	mutex_unlock(&sonypi_device.lock);
 	return 0;
 }
 
@@ -1008,7 +1008,7 @@ static int sonypi_misc_ioctl(struct inode *ip, struct file *fp,
 	u8 val8;
 	u16 val16;
 
-	down(&sonypi_device.lock);
+	mutex_lock(&sonypi_device.lock);
 	switch (cmd) {
 	case SONYPI_IOCGBRT:
 		if (sonypi_ec_read(SONYPI_LCD_LIGHT, &val8)) {
@@ -1108,7 +1108,7 @@ static int sonypi_misc_ioctl(struct inode *ip, struct file *fp,
 	default:
 		ret = -EINVAL;
 	}
-	up(&sonypi_device.lock);
+	mutex_unlock(&sonypi_device.lock);
 	return ret;
 }
 
@@ -1363,7 +1363,7 @@ static int __devinit sonypi_probe(struct platform_device *dev)
 	}
 
 	init_waitqueue_head(&sonypi_device.fifo_proc_list);
-	init_MUTEX(&sonypi_device.lock);
+	mutex_init(&sonypi_device.lock);
 	sonypi_device.bluetooth_power = -1;
 
 	if ((pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
-- 
1.5.2.rc0.34.gda94
