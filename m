From: Len Brown <len.brown@intel.com>
Subject: [PATCH 19/20] ACPI: video: Fix spelling and grammar mistakes
Date: Fri,  9 Mar 2007 22:49:37 -0500
Message-ID: <1173498594985-git-send-email-len.brown@intel.com>
References: <11734985781377-git-send-email-len.brown@intel.com> <11734985791126-git-send-email-len.brown@intel.com> <1173498580364-git-send-email-len.brown@intel.com> <11734985813852-git-send-email-len.brown@intel.com> <11734985822692-git-send-email-len.brown@intel.com> <11734985822425-git-send-email-len.brown@intel.com> <11734985831806-git-send-email-len.brown@intel.com> <11734985842575-git-send-email-len.brown@intel.com> <1173498585454-git-send-email-len.brown@intel.com> <11734985862291-git-send-email-len.brown@intel.com> <11734985863491-git-send-email-len.brown@intel.com> <1173498587849-git-send-email-len.brown@intel.com> <11734985882949-git-send-email-len.brown@intel.com> <11734985891723-git-send-email-len.brown@intel.com> <11734985892382-git-send-email-len.brown@intel.com> <11734985901640-git-send-email-len.brown@intel.com> <11734985912054-git-send-email-len.brown@intel.com> <117349
 85922550-git-send-email-len.brown@intel.com> <117349859382-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:7573 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965847AbXCJDt4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Mar 2007 22:49:56 -0500
In-Reply-To: <117349859382-git-send-email-len.brown@intel.com>
Message-Id: <98fb8fe10f4b88170f578d8c33eaa2315d73b4f7.1173498420.git.len.brown@intel.com>
In-Reply-To: <7292576043666ff39946dee14641fe719ba8c7e8.1173498420.git.len.brown@intel.com>
References: <7292576043666ff39946dee14641fe719ba8c7e8.1173498420.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Julius Volz <julius.volz@s2003.tu-chemnitz.de>, Julius Volz <juliusrv@gmail.com>, Len Brown <len.brown@intel.com>

From: Julius Volz <julius.volz@s2003.tu-chemnitz.de>

Correct some of the most obvious spelling and grammar
mistakes in drivers/acpi/video.c (comments and printk output).

Signed-off-by: Julius Volz <juliusrv@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |   38 +++++++++++++++++++-------------------
 1 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 0771b43..00d25b3 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -102,9 +102,9 @@ struct acpi_video_bus_cap {
 
 struct acpi_video_device_attrib {
 	u32 display_index:4;	/* A zero-based instance of the Display */
-	u32 display_port_attachment:4;	/*This field differenates displays type */
+	u32 display_port_attachment:4;	/*This field differentiates the display type */
 	u32 display_type:4;	/*Describe the specific type in use */
-	u32 vendor_specific:4;	/*Chipset Vendor Specifi */
+	u32 vendor_specific:4;	/*Chipset Vendor Specific */
 	u32 bios_can_detect:1;	/*BIOS can detect the device */
 	u32 depend_on_vga:1;	/*Non-VGA output device whose power is related to 
 				   the VGA device. */
@@ -484,16 +484,16 @@ acpi_video_bus_POST_options(struct acpi_video_bus *video,
  *		0.	The system BIOS should NOT automatically switch(toggle)
  *			the active display output.
  *		1.	The system BIOS should automatically switch (toggle) the
- *			active display output. No swich event.
+ *			active display output. No switch event.
  *		2.	The _DGS value should be locked.
  *		3.	The system BIOS should not automatically switch (toggle) the
  *			active display output, but instead generate the display switch
  *			event notify code.
  *	lcd_flag	:
  *		0.	The system BIOS should automatically control the brightness level
- *			of the LCD, when the power changes from AC to DC
+ *			of the LCD when the power changes from AC to DC
  *		1. 	The system BIOS should NOT automatically control the brightness 
- *			level of the LCD, when the power changes from AC to DC.
+ *			level of the LCD when the power changes from AC to DC.
  * Return Value:
  * 		-1	wrong arg.
  */
@@ -525,7 +525,7 @@ acpi_video_bus_DOS(struct acpi_video_bus *video, int bios_flag, int lcd_flag)
  *  Return Value:
  *  	None
  *
- *  Find out all required AML method defined under the output
+ *  Find out all required AML methods defined under the output
  *  device.
  */
 
@@ -636,7 +636,7 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
  *  Return Value:
  *  	None
  *
- *  Find out all required AML method defined under the video bus device.
+ *  Find out all required AML methods defined under the video bus device.
  */
 
 static void acpi_video_bus_find_cap(struct acpi_video_bus *video)
@@ -681,19 +681,19 @@ static int acpi_video_bus_check(struct acpi_video_bus *video)
 	 * to check well known required nodes.
 	 */
 
-	/* Does this device able to support video switching ? */
+	/* Does this device support video switching? */
 	if (video->cap._DOS) {
 		video->flags.multihead = 1;
 		status = 0;
 	}
 
-	/* Does this device able to retrieve a retrieve a video ROM ? */
+	/* Does this device support retrieving a video ROM? */
 	if (video->cap._ROM) {
 		video->flags.rom = 1;
 		status = 0;
 	}
 
-	/* Does this device able to configure which video device to POST ? */
+	/* Does this device support configuring which video device to POST? */
 	if (video->cap._GPD && video->cap._SPD && video->cap._VPO) {
 		video->flags.post = 1;
 		status = 0;
@@ -860,7 +860,7 @@ acpi_video_device_write_brightness(struct file *file,
 	if (level > 100)
 		return -EFAULT;
 
-	/* validate though the list of available levels */
+	/* validate through the list of available levels */
 	for (i = 0; i < dev->brightness->count; i++)
 		if (level == dev->brightness->levels[i]) {
 			if (ACPI_SUCCESS
@@ -1065,10 +1065,10 @@ static int acpi_video_bus_POST_info_seq_show(struct seq_file *seq, void *offset)
 			printk(KERN_WARNING PREFIX
 			       "The motherboard VGA device is not listed as a possible POST device.\n");
 			printk(KERN_WARNING PREFIX
-			       "This indicate a BIOS bug.  Please contact the manufacturer.\n");
+			       "This indicates a BIOS bug. Please contact the manufacturer.\n");
 		}
 		printk("%lx\n", options);
-		seq_printf(seq, "can POST: <intgrated video>");
+		seq_printf(seq, "can POST: <integrated video>");
 		if (options & 2)
 			seq_printf(seq, " <PCI video>");
 		if (options & 4)
@@ -1102,7 +1102,7 @@ static int acpi_video_bus_POST_seq_show(struct seq_file *seq, void *offset)
 		seq_printf(seq, "<not supported>\n");
 		goto end;
 	}
-	seq_printf(seq, "device posted is <%s>\n", device_decode[id & 3]);
+	seq_printf(seq, "device POSTed is <%s>\n", device_decode[id & 3]);
 
       end:
 	return 0;
@@ -1156,7 +1156,7 @@ acpi_video_bus_write_POST(struct file *file,
 	if (opt > 3)
 		return -EFAULT;
 
-	/* just in case an OEM 'forget' the motherboard... */
+	/* just in case an OEM 'forgot' the motherboard... */
 	options |= 1;
 
 	if (options & (1ul << opt)) {
@@ -1527,13 +1527,13 @@ static int acpi_video_device_enumerate(struct acpi_video_bus *video)
 /*
  *  Arg:
  *  	video	: video bus device 
- *  	event	: Nontify Event
+ *  	event	: notify event
  *
  *  Return:
  *  	< 0	: error
  *  
  *	1. Find out the current active output device.
- *	2. Identify the next output device to switch
+ *	2. Identify the next output device to switch to.
  *	3. call _DSS to do actual switch.
  */
 
@@ -1723,12 +1723,12 @@ static void acpi_video_bus_notify(acpi_handle handle, u32 event, void *data)
 	device = video->device;
 
 	switch (event) {
-	case ACPI_VIDEO_NOTIFY_SWITCH:	/* User request that a switch occur,
+	case ACPI_VIDEO_NOTIFY_SWITCH:	/* User requested a switch,
 					 * most likely via hotkey. */
 		acpi_bus_generate_event(device, event, 0);
 		break;
 
-	case ACPI_VIDEO_NOTIFY_PROBE:	/* User plug or remove a video
+	case ACPI_VIDEO_NOTIFY_PROBE:	/* User plugged in or removed a video
 					 * connector. */
 		acpi_video_device_enumerate(video);
 		acpi_video_device_rebind(video);
-- 
1.5.0.3.310.g05ef5
