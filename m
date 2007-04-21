From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 17/20] ACPI: thinkpad-acpi: cleanup video
	subdriver
Date: Sat, 21 Apr 2007 11:08:41 -0300
Message-ID: <11771645291327-git-send-email-hmh@hmh.eng.br>
References: <11771645253042-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11771645253042-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Cleanup video subdriver for sysfs conversion, and properly check
result status of acpi_evalf.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |  262 ++++++++++++++++++++++++++++--------------
 drivers/misc/thinkpad_acpi.h |   25 +++-
 2 files changed, 197 insertions(+), 90 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index a77368f..19c14bb 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -935,111 +935,194 @@ static int __init video_init(struct ibm_init_struct *iibm)
 
 static void video_exit(void)
 {
-	dbg_printk(TPACPI_DBG_EXIT, "restoring original video autoswitch mode\n");
-	acpi_evalf(vid_handle, NULL, "_DOS", "vd", video_orig_autosw);
+	dbg_printk(TPACPI_DBG_EXIT,
+		   "restoring original video autoswitch mode\n");
+	if (video_autosw_set(video_orig_autosw))
+		printk(IBM_ERR "error while trying to restore original "
+			"video autoswitch mode\n");
 }
 
-static int video_status(void)
+static int video_outputsw_get(void)
 {
 	int status = 0;
 	int i;
 
-	if (video_supported == TPACPI_VIDEO_570) {
-		if (acpi_evalf(NULL, &i, "\\_SB.PHS", "dd", 0x87))
-			status = i & 3;
-	} else if (video_supported == TPACPI_VIDEO_770) {
-		if (acpi_evalf(NULL, &i, "\\VCDL", "d"))
-			status |= 0x01 * i;
-		if (acpi_evalf(NULL, &i, "\\VCDC", "d"))
-			status |= 0x02 * i;
-	} else if (video_supported == TPACPI_VIDEO_NEW) {
-		acpi_evalf(NULL, NULL, "\\VUPS", "vd", 1);
-		if (acpi_evalf(NULL, &i, "\\VCDC", "d"))
-			status |= 0x02 * i;
-
-		acpi_evalf(NULL, NULL, "\\VUPS", "vd", 0);
-		if (acpi_evalf(NULL, &i, "\\VCDL", "d"))
-			status |= 0x01 * i;
-		if (acpi_evalf(NULL, &i, "\\VCDD", "d"))
-			status |= 0x08 * i;
+	switch (video_supported) {
+	case TPACPI_VIDEO_570:
+		if (!acpi_evalf(NULL, &i, "\\_SB.PHS", "dd",
+				 TP_ACPI_VIDEO_570_PHSCMD))
+			return -EIO;
+		status = i & TP_ACPI_VIDEO_570_PHSMASK;
+		break;
+	case TPACPI_VIDEO_770:
+		if (!acpi_evalf(NULL, &i, "\\VCDL", "d"))
+			return -EIO;
+		if (i)
+			status |= TP_ACPI_VIDEO_S_LCD;
+		if (!acpi_evalf(NULL, &i, "\\VCDC", "d"))
+			return -EIO;
+		if (i)
+			status |= TP_ACPI_VIDEO_S_CRT;
+		break;
+	case TPACPI_VIDEO_NEW:
+		if (!acpi_evalf(NULL, NULL, "\\VUPS", "vd", 1) ||
+		    !acpi_evalf(NULL, &i, "\\VCDC", "d"))
+			return -EIO;
+		if (i)
+			status |= TP_ACPI_VIDEO_S_CRT;
+
+		if (!acpi_evalf(NULL, NULL, "\\VUPS", "vd", 0) ||
+		    !acpi_evalf(NULL, &i, "\\VCDL", "d"))
+			return -EIO;
+		if (i)
+			status |= TP_ACPI_VIDEO_S_LCD;
+		if (!acpi_evalf(NULL, &i, "\\VCDD", "d"))
+			return -EIO;
+		if (i)
+			status |= TP_ACPI_VIDEO_S_DVI;
+		break;
+	default:
+		return -ENOSYS;
 	}
 
 	return status;
 }
 
-static int video_autosw(void)
+static int video_outputsw_set(int status)
 {
-	int autosw = 0;
+	int autosw;
+	int res = 0;
 
-	if (video_supported == TPACPI_VIDEO_570)
-		acpi_evalf(vid_handle, &autosw, "SWIT", "d");
-	else if (video_supported == TPACPI_VIDEO_770 ||
-		 video_supported == TPACPI_VIDEO_NEW)
-		acpi_evalf(vid_handle, &autosw, "^VDEE", "d");
+	switch (video_supported) {
+	case TPACPI_VIDEO_570:
+		res = acpi_evalf(NULL, NULL,
+				 "\\_SB.PHS2", "vdd",
+				 TP_ACPI_VIDEO_570_PHS2CMD,
+				 status | TP_ACPI_VIDEO_570_PHS2SET);
+		break;
+	case TPACPI_VIDEO_770:
+		autosw = video_autosw_get();
+		if (autosw < 0)
+			return autosw;
 
-	return autosw & 1;
+		res = video_autosw_set(1);
+		if (res)
+			return res;
+		res = acpi_evalf(vid_handle, NULL,
+				 "ASWT", "vdd", status * 0x100, 0);
+		if (!autosw && video_autosw_set(autosw)) {
+			printk(IBM_ERR "video auto-switch left enabled due to error\n");
+			return -EIO;
+		}
+		break;
+	case TPACPI_VIDEO_NEW:
+		res = acpi_evalf(NULL, NULL, "\\VUPS", "vd", 0x80) &&
+			acpi_evalf(NULL, NULL, "\\VSDS", "vdd", status, 1);
+		break;
+	default:
+		return -ENOSYS;
+	}
+
+	return (res)? 0 : -EIO;
 }
 
-static int video_switch(void)
+static int video_autosw_get(void)
 {
-	int autosw = video_autosw();
-	int ret;
+	int autosw = 0;
 
-	if (!acpi_evalf(vid_handle, NULL, "_DOS", "vd", 1))
-		return -EIO;
-	ret = video_supported == TPACPI_VIDEO_570 ?
-	    acpi_evalf(ec_handle, NULL, "_Q16", "v") :
-	    acpi_evalf(vid_handle, NULL, "VSWT", "v");
-	acpi_evalf(vid_handle, NULL, "_DOS", "vd", autosw);
+	switch (video_supported) {
+	case TPACPI_VIDEO_570:
+		if (!acpi_evalf(vid_handle, &autosw, "SWIT", "d"))
+			return -EIO;
+		break;
+	case TPACPI_VIDEO_770:
+	case TPACPI_VIDEO_NEW:
+		if (!acpi_evalf(vid_handle, &autosw, "^VDEE", "d"))
+			return -EIO;
+		break;
+	default:
+		return -ENOSYS;
+	}
 
-	return ret;
+	return autosw & 1;
 }
 
-static int video_expand(void)
+static int video_autosw_set(int enable)
 {
-	if (video_supported == TPACPI_VIDEO_570)
-		return acpi_evalf(ec_handle, NULL, "_Q17", "v");
-	else if (video_supported == TPACPI_VIDEO_770)
-		return acpi_evalf(vid_handle, NULL, "VEXP", "v");
-	else
-		return acpi_evalf(NULL, NULL, "\\VEXP", "v");
+	if (!acpi_evalf(vid_handle, NULL, "_DOS", "vd", (enable)? 1 : 0))
+		return -EIO;
+	return 0;
 }
 
-static int video_switch2(int status)
+static int video_outputsw_cycle(void)
 {
-	int ret;
-
-	if (video_supported == TPACPI_VIDEO_570) {
-		ret = acpi_evalf(NULL, NULL,
-				 "\\_SB.PHS2", "vdd", 0x8b, status | 0x80);
-	} else if (video_supported == TPACPI_VIDEO_770) {
-		int autosw = video_autosw();
-		if (!acpi_evalf(vid_handle, NULL, "_DOS", "vd", 1))
-			return -EIO;
+	int autosw = video_autosw_get();
+	int res;
 
-		ret = acpi_evalf(vid_handle, NULL,
-				 "ASWT", "vdd", status * 0x100, 0);
+	if (autosw < 0)
+		return autosw;
 
-		acpi_evalf(vid_handle, NULL, "_DOS", "vd", autosw);
-	} else {
-		ret = acpi_evalf(NULL, NULL, "\\VUPS", "vd", 0x80) &&
-		    acpi_evalf(NULL, NULL, "\\VSDS", "vdd", status, 1);
+	switch (video_supported) {
+	case TPACPI_VIDEO_570:
+		res = video_autosw_set(1);
+		if (res)
+			return res;
+		res = acpi_evalf(ec_handle, NULL, "_Q16", "v");
+		break;
+	case TPACPI_VIDEO_770:
+	case TPACPI_VIDEO_NEW:
+		res = video_autosw_set(1);
+		if (res)
+			return res;
+		res = acpi_evalf(vid_handle, NULL, "VSWT", "v");
+		break;
+	default:
+		return -ENOSYS;
+	}
+	if (!autosw && video_autosw_set(autosw)) {
+		printk(IBM_ERR "video auto-switch left enabled due to error\n");
+		return -EIO;
 	}
 
-	return ret;
+	return (res)? 0 : -EIO;
+}
+
+static int video_expand_toggle(void)
+{
+	switch (video_supported) {
+	case TPACPI_VIDEO_570:
+		return acpi_evalf(ec_handle, NULL, "_Q17", "v")?
+			0 : -EIO;
+	case TPACPI_VIDEO_770:
+		return acpi_evalf(vid_handle, NULL, "VEXP", "v")?
+			0 : -EIO;
+	case TPACPI_VIDEO_NEW:
+		return acpi_evalf(NULL, NULL, "\\VEXP", "v")?
+			0 : -EIO;
+	default:
+		return -ENOSYS;
+	}
+	/* not reached */
 }
 
 static int video_read(char *p)
 {
-	int status = video_status();
-	int autosw = video_autosw();
+	int status, autosw;
 	int len = 0;
 
-	if (!video_supported) {
+	if (video_supported == TPACPI_VIDEO_NONE) {
 		len += sprintf(p + len, "status:\t\tnot supported\n");
 		return len;
 	}
 
+	status = video_outputsw_get();
+	if (status < 0)
+		return status;
+
+	autosw = video_autosw_get();
+	if (autosw < 0)
+		return autosw;
+
 	len += sprintf(p + len, "status:\t\tsupported\n");
 	len += sprintf(p + len, "lcd:\t\t%s\n", enabled(status, 0));
 	len += sprintf(p + len, "crt:\t\t%s\n", enabled(status, 1));
@@ -1060,47 +1143,56 @@ static int video_write(char *buf)
 {
 	char *cmd;
 	int enable, disable, status;
+	int res;
 
-	if (!video_supported)
+	if (video_supported == TPACPI_VIDEO_NONE)
 		return -ENODEV;
 
-	enable = disable = 0;
+	enable = 0;
+	disable = 0;
 
 	while ((cmd = next_cmd(&buf))) {
 		if (strlencmp(cmd, "lcd_enable") == 0) {
-			enable |= 0x01;
+			enable |= TP_ACPI_VIDEO_S_LCD;
 		} else if (strlencmp(cmd, "lcd_disable") == 0) {
-			disable |= 0x01;
+			disable |= TP_ACPI_VIDEO_S_LCD;
 		} else if (strlencmp(cmd, "crt_enable") == 0) {
-			enable |= 0x02;
+			enable |= TP_ACPI_VIDEO_S_CRT;
 		} else if (strlencmp(cmd, "crt_disable") == 0) {
-			disable |= 0x02;
+			disable |= TP_ACPI_VIDEO_S_CRT;
 		} else if (video_supported == TPACPI_VIDEO_NEW &&
 			   strlencmp(cmd, "dvi_enable") == 0) {
-			enable |= 0x08;
+			enable |= TP_ACPI_VIDEO_S_DVI;
 		} else if (video_supported == TPACPI_VIDEO_NEW &&
 			   strlencmp(cmd, "dvi_disable") == 0) {
-			disable |= 0x08;
+			disable |= TP_ACPI_VIDEO_S_DVI;
 		} else if (strlencmp(cmd, "auto_enable") == 0) {
-			if (!acpi_evalf(vid_handle, NULL, "_DOS", "vd", 1))
-				return -EIO;
+			res = video_autosw_set(1);
+			if (res)
+				return res;
 		} else if (strlencmp(cmd, "auto_disable") == 0) {
-			if (!acpi_evalf(vid_handle, NULL, "_DOS", "vd", 0))
-				return -EIO;
+			res = video_autosw_set(0);
+			if (res)
+				return res;
 		} else if (strlencmp(cmd, "video_switch") == 0) {
-			if (!video_switch())
-				return -EIO;
+			res = video_outputsw_cycle();
+			if (res)
+				return res;
 		} else if (strlencmp(cmd, "expand_toggle") == 0) {
-			if (!video_expand())
-				return -EIO;
+			res = video_expand_toggle();
+			if (res)
+				return res;
 		} else
 			return -EINVAL;
 	}
 
 	if (enable || disable) {
-		status = (video_status() & 0x0f & ~disable) | enable;
-		if (!video_switch2(status))
-			return -EIO;
+		status = video_outputsw_get();
+		if (status < 0)
+			return status;
+		res = video_outputsw_set((status & ~disable) | enable);
+		if (res)
+			return res;
 	}
 
 	return 0;
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index e06bad5..3a8718a 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -446,17 +446,32 @@ enum video_access_mode {
 	TPACPI_VIDEO_NEW,	/* all others */
 };
 
+enum {	/* video status flags, based on VIDEO_570 */
+	TP_ACPI_VIDEO_S_LCD = 0x01,	/* LCD output enabled */
+	TP_ACPI_VIDEO_S_CRT = 0x02,	/* CRT output enabled */
+	TP_ACPI_VIDEO_S_DVI = 0x08,	/* DVI output enabled */
+};
+
+enum {  /* TPACPI_VIDEO_570 constants */
+	TP_ACPI_VIDEO_570_PHSCMD = 0x87,	/* unknown magic constant :( */
+	TP_ACPI_VIDEO_570_PHSMASK = 0x03,	/* PHS bits that map to
+						 * video_status_flags */
+	TP_ACPI_VIDEO_570_PHS2CMD = 0x8b,	/* unknown magic constant :( */
+	TP_ACPI_VIDEO_570_PHS2SET = 0x80,	/* unknown magic constant :( */
+};
+
 static enum video_access_mode video_supported;
 static int video_orig_autosw;
 static acpi_handle vid_handle, vid2_handle;
 
 static int video_init(struct ibm_init_struct *iibm);
 static void video_exit(void);
-static int video_status(void);
-static int video_autosw(void);
-static int video_switch(void);
-static int video_switch2(int status);
-static int video_expand(void);
+static int video_outputsw_get(void);
+static int video_outputsw_set(int status);
+static int video_autosw_get(void);
+static int video_autosw_set(int enable);
+static int video_outputsw_cycle(void);
+static int video_expand_toggle(void);
 static int video_read(char *p);
 static int video_write(char *buf);
 
-- 
1.5.1


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
