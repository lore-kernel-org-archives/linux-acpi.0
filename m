From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 1/7] ACPI: thinkpad-acpi: minor refactor on
	radio switch init
Date: Mon, 21 Jul 2008 09:42:14 -0300
Message-ID: <1216644140-13284-1-git-send-email-hmh@hmh.eng.br>
References: <20080721122935.GA12972@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080721122935.GA12972-ZGHd14iZgfaRjzvQDGKj+xxZW9W5cXbT@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Change the code of hotkey_init, wan_init and bluetooth_init a bit to make it
much easier to add some Kconfig-selected debugging code later.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |   49 ++++++++++++++++++++++-------------------
 1 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index b596929..c800855 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -2167,9 +2167,10 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		printk(TPACPI_INFO
 			"radio switch found; radios are %s\n",
 			enabled(status, 0));
+	}
+	if (tp_features.hotkey_wlsw)
 		res = add_to_attr_set(hotkey_dev_attributes,
 				&dev_attr_hotkey_radio_sw.attr);
-	}
 
 	/* For X41t, X60t, X61t Tablets... */
 	if (!res && acpi_evalf(hkey_handle, &status, "MHKG", "qd")) {
@@ -2646,18 +2647,19 @@ static int __init bluetooth_init(struct ibm_init_struct *iibm)
 		str_supported(tp_features.bluetooth),
 		status);
 
+	if (tp_features.bluetooth &&
+	    !(status & TP_ACPI_BLUETOOTH_HWPRESENT)) {
+		/* no bluetooth hardware present in system */
+		tp_features.bluetooth = 0;
+		dbg_printk(TPACPI_DBG_INIT,
+			   "bluetooth hardware not installed\n");
+	}
+
 	if (tp_features.bluetooth) {
-		if (!(status & TP_ACPI_BLUETOOTH_HWPRESENT)) {
-			/* no bluetooth hardware present in system */
-			tp_features.bluetooth = 0;
-			dbg_printk(TPACPI_DBG_INIT,
-				   "bluetooth hardware not installed\n");
-		} else {
-			res = sysfs_create_group(&tpacpi_pdev->dev.kobj,
-					&bluetooth_attr_group);
-			if (res)
-				return res;
-		}
+		res = sysfs_create_group(&tpacpi_pdev->dev.kobj,
+				&bluetooth_attr_group);
+		if (res)
+			return res;
 	}
 
 	return (tp_features.bluetooth)? 0 : 1;
@@ -2818,18 +2820,19 @@ static int __init wan_init(struct ibm_init_struct *iibm)
 		str_supported(tp_features.wan),
 		status);
 
+	if (tp_features.wan &&
+	    !(status & TP_ACPI_WANCARD_HWPRESENT)) {
+		/* no wan hardware present in system */
+		tp_features.wan = 0;
+		dbg_printk(TPACPI_DBG_INIT,
+			   "wan hardware not installed\n");
+	}
+
 	if (tp_features.wan) {
-		if (!(status & TP_ACPI_WANCARD_HWPRESENT)) {
-			/* no wan hardware present in system */
-			tp_features.wan = 0;
-			dbg_printk(TPACPI_DBG_INIT,
-				   "wan hardware not installed\n");
-		} else {
-			res = sysfs_create_group(&tpacpi_pdev->dev.kobj,
-					&wan_attr_group);
-			if (res)
-				return res;
-		}
+		res = sysfs_create_group(&tpacpi_pdev->dev.kobj,
+				&wan_attr_group);
+		if (res)
+			return res;
 	}
 
 	return (tp_features.wan)? 0 : 1;
-- 
1.5.6.2


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
