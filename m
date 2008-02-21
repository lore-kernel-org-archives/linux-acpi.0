From: Len Brown <lenb@kernel.org>
Subject: [PATCH 14/26] ACPI: thinkpad-acpi: make the video output feature optional
Date: Thu, 21 Feb 2008 04:37:59 -0500
Message-ID: <d7c1d17dfed996e84212fc1ce617b2586dd70ec2.1203586624.git.len.brown@intel.com>
References: <1203586691-1234-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:59966 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753828AbYBUJi6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Feb 2008 04:38:58 -0500
In-Reply-To: <1203586691-1234-1-git-send-email-lenb@kernel.org>
In-Reply-To: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203586624.git.len.brown@intel.com>
References: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203586624.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

The video output port control feature is not very useful on many ThinkPads
(especially when a X server is running), and lately userspace is getting
better and better at it, so it makes sense to allow users to stripe out the
thinkpad-acpi video feature from their kernels and save at least 2KB.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/Kconfig         |   17 +++++++++++++++++
 drivers/misc/thinkpad_acpi.c |   20 +++++++++++++-------
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 1abc95c..982e27b 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -258,6 +258,23 @@ config THINKPAD_ACPI_BAY
 
 	  If you are not sure, say Y here.
 
+config THINKPAD_ACPI_VIDEO
+	bool "Video output control support"
+	depends on THINKPAD_ACPI
+	default y
+	---help---
+	  Allows the thinkpad_acpi driver to provide an interface to control
+	  the various video output ports.
+
+	  This feature often won't work well, depending on ThinkPad model,
+	  display state, video output devices in use, whether there is a X
+	  server running, phase of the moon, and the current mood of
+	  Schroedinger's cat.  If you can use X.org's RandR to control
+	  your ThinkPad's video output ports instead of this feature,
+	  don't think twice: do it and say N here to save some memory.
+
+	  If you are not sure, say Y here.
+
 config THINKPAD_ACPI_HOTKEY_POLL
 	bool "Suport NVRAM polling for hot keys"
 	depends on THINKPAD_ACPI
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 02f9465..4ea3866 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -301,6 +301,13 @@ TPACPI_HANDLE(hkey, ec, "\\_SB.HKEY",	/* 600e/x, 770e, 770x */
 	   "HKEY",		/* all others */
 	   );			/* 570 */
 
+TPACPI_HANDLE(vid, root, "\\_SB.PCI.AGP.VGA",	/* 570 */
+	   "\\_SB.PCI0.AGP0.VID0",	/* 600e/x, 770x */
+	   "\\_SB.PCI0.VID0",	/* 770e */
+	   "\\_SB.PCI0.VID",	/* A21e, G4x, R50e, X30, X40 */
+	   "\\_SB.PCI0.AGP.VID",	/* all others */
+	   );				/* R30, R31 */
+
 
 /*************************************************************************
  * ACPI helpers
@@ -2680,6 +2687,8 @@ static struct ibm_struct wan_driver_data = {
  * Video subdriver
  */
 
+#ifdef CONFIG_THINKPAD_ACPI_VIDEO
+
 enum video_access_mode {
 	TPACPI_VIDEO_NONE = 0,
 	TPACPI_VIDEO_570,	/* 570 */
@@ -2707,13 +2716,6 @@ static int video_orig_autosw;
 static int video_autosw_get(void);
 static int video_autosw_set(int enable);
 
-TPACPI_HANDLE(vid, root, "\\_SB.PCI.AGP.VGA",	/* 570 */
-	   "\\_SB.PCI0.AGP0.VID0",	/* 600e/x, 770x */
-	   "\\_SB.PCI0.VID0",	/* 770e */
-	   "\\_SB.PCI0.VID",	/* A21e, G4x, R50e, X30, X40 */
-	   "\\_SB.PCI0.AGP.VID",	/* all others */
-	   );				/* R30, R31 */
-
 TPACPI_HANDLE(vid2, root, "\\_SB.PCI0.AGPB.VID");	/* G41 */
 
 static int __init video_init(struct ibm_init_struct *iibm)
@@ -3023,6 +3025,8 @@ static struct ibm_struct video_driver_data = {
 	.exit = video_exit,
 };
 
+#endif /* CONFIG_THINKPAD_ACPI_VIDEO */
+
 /*************************************************************************
  * Light (thinklight) subdriver
  */
@@ -5807,10 +5811,12 @@ static struct ibm_init_struct ibms_init[] __initdata = {
 		.init = wan_init,
 		.data = &wan_driver_data,
 	},
+#ifdef CONFIG_THINKPAD_ACPI_VIDEO
 	{
 		.init = video_init,
 		.data = &video_driver_data,
 	},
+#endif
 	{
 		.init = light_init,
 		.data = &light_driver_data,
-- 
1.5.4

