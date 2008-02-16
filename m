From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 5/9] ACPI: thinkpad-acpi: make the video
	output feature optional
Date: Sat, 16 Feb 2008 02:17:54 -0200
Message-ID: <1203135478-4813-6-git-send-email-hmh@hmh.eng.br>
References: <1203135478-4813-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1203135478-4813-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The video output port control feature is not very useful on many ThinkPads
(especially when a X server is running), and lately userspace is getting
better and better at it, so it makes sense to allow users to stripe out the
thinkpad-acpi video feature from their kernels and save at least 2KB.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
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
1.5.3.8


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
