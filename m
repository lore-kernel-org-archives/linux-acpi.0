From: Yu Luming <luming.yu@gmail.com>
Subject: [patch 5/6] fix comments style in acpi video.c
Date: Thu, 2 Nov 2006 13:29:17 +0000 (UTC)
Message-ID: <200611042127.54947.luming.yu__23804.5211336159$1162474157$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752873AbWKBN2P@vger.kernel.org>
Date: Sat, 4 Nov 2006 21:27:54 +0800
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, len.brown@intel.com, Matt Domsch <Matt_Domsch@dell.com>, Alessandro Guido <alessandro.guido@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr, Richard Hughes <hughsient@gmail.com>
List-Id: linux-acpi@vger.kernel.org

fix comments style in acpi video.c

signed-off-by   Luming.yu@gmail.com
--
[patch 5/6] fix comments style in acpi video.c
 video.c |   44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index ace21e2..4ad109f 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -89,26 +89,26 @@ struct acpi_video_bus_flags {
 };
 
 struct acpi_video_bus_cap {
-	u8 _DOS:1;		/*Enable/Disable output switching */
-	u8 _DOD:1;		/*Enumerate all devices attached to display adapter */
-	u8 _ROM:1;		/*Get ROM Data */
-	u8 _GPD:1;		/*Get POST Device */
-	u8 _SPD:1;		/*Set POST Device */
-	u8 _VPO:1;		/*Video POST Options */
+	u8 _DOS:1;		/* Enable/Disable output switching */
+	u8 _DOD:1;		/* Enumerate all devices attached to display adapter */
+	u8 _ROM:1;		/* Get ROM Data */
+	u8 _GPD:1;		/* Get POST Device */
+	u8 _SPD:1;		/* Set POST Device */
+	u8 _VPO:1;		/* Video POST Options */
 	u8 reserved:2;
 };
 
 struct acpi_video_device_attrib {
 	u32 display_index:4;	/* A zero-based instance of the Display */
-	u32 display_port_attachment:4;	/*This field differenates displays type */
-	u32 display_type:4;	/*Describe the specific type in use */
-	u32 vendor_specific:4;	/*Chipset Vendor Specifi */
-	u32 bios_can_detect:1;	/*BIOS can detect the device */
-	u32 depend_on_vga:1;	/*Non-VGA output device whose power is related to 
-				   the VGA device. */
-	u32 pipe_id:3;		/*For VGA multiple-head devices. */
-	u32 reserved:10;	/*Must be 0 */
-	u32 device_id_scheme:1;	/*Device ID Scheme */
+	u32 display_port_attachment:4;	/* differenates displays type */
+	u32 display_type:4;	/* Describe the specific type in use */
+	u32 vendor_specific:4;	/* Chipset Vendor Specifi */
+	u32 bios_can_detect:1;	/* BIOS can detect the device */
+	u32 depend_on_vga:1;	/* Non-VGA output device whose power */
+				/* is related to the VGA device. */
+	u32 pipe_id:3;		/* For VGA multiple-head devices. */
+	u32 reserved:10;	/* Must be 0 */
+	u32 device_id_scheme:1;	/* Device ID Scheme */
 };
 
 struct acpi_video_enumerated_device {
@@ -141,14 +141,14 @@ struct acpi_video_device_flags {
 };
 
 struct acpi_video_device_cap {
-	u8 _ADR:1;		/*Return the unique ID */
-	u8 _BCL:1;		/*Query list of brightness control levels supported */
-	u8 _BCM:1;		/*Set the brightness level */
+	u8 _ADR:1;		/* Return the unique ID */
+	u8 _BCL:1;		/* Query brightness control levels supported */
+	u8 _BCM:1;		/* Set the brightness level */
 	u8 _BQC:1;		/* Get current brightness level */
-	u8 _DDC:1;		/*Return the EDID for this device */
-	u8 _DCS:1;		/*Return status of output device */
-	u8 _DGS:1;		/*Query graphics state */
-	u8 _DSS:1;		/*Device state set */
+	u8 _DDC:1;		/* Return the EDID for this device */
+	u8 _DCS:1;		/* Return status of output device */
+	u8 _DGS:1;		/* Query graphics state */
+	u8 _DSS:1;		/* Device state set */
 };
 
 struct acpi_video_device_brightness {
