From: Len Brown <len.brown@intel.com>
Subject: [PATCH 062/105] ACPI: thinkpad-acpi: cleanup video subdriver
Date: Sun, 29 Apr 2007 00:51:02 -0400
Message-ID: <11778223624095-git-send-email-len.brown@intel.com>
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
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:54971 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756144AbXD2Ewo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:52:44 -0400
In-Reply-To: <117782236226-git-send-email-len.brown@intel.com>
Message-Id: <83f34724643a3b0ec9322490b9ad9f1b60170a6c.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Cleanup video subdriver for sysfs conversion, and properly check
result status of acpi_evalf.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.5.2.rc0.34.gda94
