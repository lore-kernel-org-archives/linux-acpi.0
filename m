From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 20/21] ACPI: ibm-acpi: style fixes and
	cruft removal
Date: Sat, 25 Nov 2006 18:48:37 -0200
Message-ID: <20061125204837.6604.66058.stgit@thorin.khazad-dum.debian.net>
References: <20061125204155.6604.35338.stgit@thorin.khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20061125204155.6604.35338.stgit-H32KNTuDSMjdPi8JTuvWk31TOOPCyuNQ5NbjCUgZEJk@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>

This patch just fixes style, move some #defines to enums, and removes some
old cruft.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---

 drivers/acpi/ibm_acpi.c |  100 ++++++++++++++++++++---------------------------
 1 files changed, 43 insertions(+), 57 deletions(-)

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index 649db29..549c834 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -78,9 +78,11 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/string.h>
+
 #include <linux/proc_fs.h>
 #include <linux/backlight.h>
 #include <asm/uaccess.h>
+
 #include <linux/dmi.h>
 #include <linux/jiffies.h>
 #include <linux/workqueue.h>
@@ -121,28 +123,6 @@ static acpi_handle root_handle = NULL;
 	static char        *object##_path;			\
 	static char        *object##_paths[] = { paths }
 
-/*
- * The following models are supported to various degrees:
- *
- * 570, 600e, 600x, 770e, 770x
- * A20m, A21e, A21m, A21p, A22p, A30, A30p, A31, A31p
- * G40, G41
- * R30, R31, R32, R40, R40e, R50, R50e, R50p, R51
- * T20, T21, T22, T23, T30, T40, T40p, T41, T41p, T42, T42p, T43
- * X20, X21, X22, X23, X24, X30, X31, X40
- *
- * The following models have no supported features:
- *
- * 240, 240x, i1400
- *
- * Still missing DSDTs for the following models:
- *
- * A20p, A22e, A22m
- * R52
- * S31
- * T43p
- */
-
 IBM_HANDLE(ec, root, "\\_SB.PCI0.ISA.EC0",	/* 240, 240x */
 	   "\\_SB.PCI.ISA.EC",	/* 570 */
 	   "\\_SB.PCI0.ISA0.EC0",	/* 600e/x, 770e, 770x */
@@ -785,12 +765,15 @@ static int wan_write(char *buf)
 	return 0;
 }
 
-static int video_supported;
-static int video_orig_autosw;
+enum video_access_mode {
+	IBMACPI_VIDEO_NONE = 0,
+	IBMACPI_VIDEO_570,	/* 570 */
+	IBMACPI_VIDEO_770,	/* 600e/x, 770e, 770x */
+	IBMACPI_VIDEO_NEW,	/* all others */
+};
 
-#define VIDEO_570 1
-#define VIDEO_770 2
-#define VIDEO_NEW 3
+static enum video_access_mode video_supported;
+static int video_orig_autosw;
 
 static int video_init(void)
 {
@@ -802,16 +785,16 @@ static int video_init(void)
 
 	if (!vid_handle)
 		/* video switching not supported on R30, R31 */
-		video_supported = 0;
+		video_supported = IBMACPI_VIDEO_NONE;
 	else if (acpi_evalf(vid_handle, &video_orig_autosw, "SWIT", "qd"))
 		/* 570 */
-		video_supported = VIDEO_570;
+		video_supported = IBMACPI_VIDEO_570;
 	else if (acpi_evalf(vid_handle, &video_orig_autosw, "^VADL", "qd"))
 		/* 600e/x, 770e, 770x */
-		video_supported = VIDEO_770;
+		video_supported = IBMACPI_VIDEO_770;
 	else
 		/* all others */
-		video_supported = VIDEO_NEW;
+		video_supported = IBMACPI_VIDEO_NEW;
 
 	return 0;
 }
@@ -821,15 +804,15 @@ static int video_status(void)
 	int status = 0;
 	int i;
 
-	if (video_supported == VIDEO_570) {
+	if (video_supported == IBMACPI_VIDEO_570) {
 		if (acpi_evalf(NULL, &i, "\\_SB.PHS", "dd", 0x87))
 			status = i & 3;
-	} else if (video_supported == VIDEO_770) {
+	} else if (video_supported == IBMACPI_VIDEO_770) {
 		if (acpi_evalf(NULL, &i, "\\VCDL", "d"))
 			status |= 0x01 * i;
 		if (acpi_evalf(NULL, &i, "\\VCDC", "d"))
 			status |= 0x02 * i;
-	} else if (video_supported == VIDEO_NEW) {
+	} else if (video_supported == IBMACPI_VIDEO_NEW) {
 		acpi_evalf(NULL, NULL, "\\VUPS", "vd", 1);
 		if (acpi_evalf(NULL, &i, "\\VCDC", "d"))
 			status |= 0x02 * i;
@@ -848,9 +831,10 @@ static int video_autosw(void)
 {
 	int autosw = 0;
 
-	if (video_supported == VIDEO_570)
+	if (video_supported == IBMACPI_VIDEO_570)
 		acpi_evalf(vid_handle, &autosw, "SWIT", "d");
-	else if (video_supported == VIDEO_770 || video_supported == VIDEO_NEW)
+	else if (video_supported == IBMACPI_VIDEO_770 ||
+		 video_supported == IBMACPI_VIDEO_NEW)
 		acpi_evalf(vid_handle, &autosw, "^VDEE", "d");
 
 	return autosw & 1;
@@ -870,12 +854,12 @@ static int video_read(char *p)
 	len += sprintf(p + len, "status:\t\tsupported\n");
 	len += sprintf(p + len, "lcd:\t\t%s\n", enabled(status, 0));
 	len += sprintf(p + len, "crt:\t\t%s\n", enabled(status, 1));
-	if (video_supported == VIDEO_NEW)
+	if (video_supported == IBMACPI_VIDEO_NEW)
 		len += sprintf(p + len, "dvi:\t\t%s\n", enabled(status, 3));
 	len += sprintf(p + len, "auto:\t\t%s\n", enabled(autosw, 0));
 	len += sprintf(p + len, "commands:\tlcd_enable, lcd_disable\n");
 	len += sprintf(p + len, "commands:\tcrt_enable, crt_disable\n");
-	if (video_supported == VIDEO_NEW)
+	if (video_supported == IBMACPI_VIDEO_NEW)
 		len += sprintf(p + len, "commands:\tdvi_enable, dvi_disable\n");
 	len += sprintf(p + len, "commands:\tauto_enable, auto_disable\n");
 	len += sprintf(p + len, "commands:\tvideo_switch, expand_toggle\n");
@@ -890,7 +874,7 @@ static int video_switch(void)
 
 	if (!acpi_evalf(vid_handle, NULL, "_DOS", "vd", 1))
 		return -EIO;
-	ret = video_supported == VIDEO_570 ?
+	ret = video_supported == IBMACPI_VIDEO_570 ?
 	    acpi_evalf(ec_handle, NULL, "_Q16", "v") :
 	    acpi_evalf(vid_handle, NULL, "VSWT", "v");
 	acpi_evalf(vid_handle, NULL, "_DOS", "vd", autosw);
@@ -900,9 +884,9 @@ static int video_switch(void)
 
 static int video_expand(void)
 {
-	if (video_supported == VIDEO_570)
+	if (video_supported == IBMACPI_VIDEO_570)
 		return acpi_evalf(ec_handle, NULL, "_Q17", "v");
-	else if (video_supported == VIDEO_770)
+	else if (video_supported == IBMACPI_VIDEO_770)
 		return acpi_evalf(vid_handle, NULL, "VEXP", "v");
 	else
 		return acpi_evalf(NULL, NULL, "\\VEXP", "v");
@@ -912,10 +896,10 @@ static int video_switch2(int status)
 {
 	int ret;
 
-	if (video_supported == VIDEO_570) {
+	if (video_supported == IBMACPI_VIDEO_570) {
 		ret = acpi_evalf(NULL, NULL,
 				 "\\_SB.PHS2", "vdd", 0x8b, status | 0x80);
-	} else if (video_supported == VIDEO_770) {
+	} else if (video_supported == IBMACPI_VIDEO_770) {
 		int autosw = video_autosw();
 		if (!acpi_evalf(vid_handle, NULL, "_DOS", "vd", 1))
 			return -EIO;
@@ -951,10 +935,10 @@ static int video_write(char *buf)
 			enable |= 0x02;
 		} else if (strlencmp(cmd, "crt_disable") == 0) {
 			disable |= 0x02;
-		} else if (video_supported == VIDEO_NEW &&
+		} else if (video_supported == IBMACPI_VIDEO_NEW &&
 			   strlencmp(cmd, "dvi_enable") == 0) {
 			enable |= 0x08;
-		} else if (video_supported == VIDEO_NEW &&
+		} else if (video_supported == IBMACPI_VIDEO_NEW &&
 			   strlencmp(cmd, "dvi_disable") == 0) {
 			disable |= 0x08;
 		} else if (strlencmp(cmd, "auto_enable") == 0) {
@@ -1253,26 +1237,28 @@ static int cmos_write(char *buf)
 	return 0;
 }
 
-static int led_supported;
-
-#define LED_570 1
-#define LED_OLD 2
-#define LED_NEW 3
+enum led_access_mode {
+	IBMACPI_LED_NONE = 0,
+	IBMACPI_LED_570,	/* 570 */
+	IBMACPI_LED_OLD,	/* 600e/x, 770e, 770x, A21e, A2xm/p, T20-22, X20-21 */
+	IBMACPI_LED_NEW,	/* all others */
+};
+static enum led_access_mode led_supported;
 
 static int led_init(void)
 {
 	if (!led_handle)
 		/* led not supported on R30, R31 */
-		led_supported = 0;
+		led_supported = IBMACPI_LED_NONE;
 	else if (strlencmp(led_path, "SLED") == 0)
 		/* 570 */
-		led_supported = LED_570;
+		led_supported = IBMACPI_LED_570;
 	else if (strlencmp(led_path, "SYSL") == 0)
 		/* 600e/x, 770e, 770x, A21e, A2xm/p, T20-22, X20-21 */
-		led_supported = LED_OLD;
+		led_supported = IBMACPI_LED_OLD;
 	else
 		/* all others */
-		led_supported = LED_NEW;
+		led_supported = IBMACPI_LED_NEW;
 
 	return 0;
 }
@@ -1289,7 +1275,7 @@ static int led_read(char *p)
 	}
 	len += sprintf(p + len, "status:\t\tsupported\n");
 
-	if (led_supported == LED_570) {
+	if (led_supported == IBMACPI_LED_570) {
 		/* 570 */
 		int i, status;
 		for (i = 0; i < 8; i++) {
@@ -1338,13 +1324,13 @@ static int led_write(char *buf)
 		} else
 			return -EINVAL;
 
-		if (led_supported == LED_570) {
+		if (led_supported == IBMACPI_LED_570) {
 			/* 570 */
 			led = 1 << led;
 			if (!acpi_evalf(led_handle, NULL, NULL, "vdd",
 					led, led_sled_arg1[ind]))
 				return -EIO;
-		} else if (led_supported == LED_OLD) {
+		} else if (led_supported == IBMACPI_LED_OLD) {
 			/* 600e/x, 770e, 770x, A21e, A2xm/p, T20-22, X20 */
 			led = 1 << led;
 			ret = ec_write(EC_HLMS, led);

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
