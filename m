From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 03/20] ACPI: thinkpad-acpi: rename module
	glue
Date: Sat, 21 Apr 2007 11:08:27 -0300
Message-ID: <1177164526992-git-send-email-hmh@hmh.eng.br>
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

Rename module init and exit functions, now that we are not called ibm-acpi
anymore.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |   12 ++++++------
 drivers/misc/thinkpad_acpi.h |    4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 4b43486..80ef195 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -2707,7 +2707,7 @@ IBM_PARAM(brightness);
 IBM_PARAM(volume);
 IBM_PARAM(fan);
 
-static int __init acpi_ibm_init(void)
+static int __init thinkpad_acpi_module_init(void)
 {
 	int ret, i;
 
@@ -2754,7 +2754,7 @@ static int __init acpi_ibm_init(void)
 	proc_dir = proc_mkdir(IBM_DIR, acpi_root_dir);
 	if (!proc_dir) {
 		printk(IBM_ERR "unable to create proc dir %s", IBM_DIR);
-		acpi_ibm_exit();
+		thinkpad_acpi_module_exit();
 		return -ENODEV;
 	}
 	proc_dir->owner = THIS_MODULE;
@@ -2764,7 +2764,7 @@ static int __init acpi_ibm_init(void)
 		if (ret >= 0 && *ibms[i].param)
 			ret = ibms[i].write(ibms[i].param);
 		if (ret < 0) {
-			acpi_ibm_exit();
+			thinkpad_acpi_module_exit();
 			return ret;
 		}
 	}
@@ -2772,7 +2772,7 @@ static int __init acpi_ibm_init(void)
 	return 0;
 }
 
-static void acpi_ibm_exit(void)
+static void thinkpad_acpi_module_exit(void)
 {
 	int i;
 
@@ -2786,5 +2786,5 @@ static void acpi_ibm_exit(void)
 		kfree(ibm_thinkpad_ec_found);
 }
 
-module_init(acpi_ibm_init);
-module_exit(acpi_ibm_exit);
+module_init(thinkpad_acpi_module_init);
+module_exit(thinkpad_acpi_module_exit);
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index b86e574..8b2fd1a 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -115,8 +115,8 @@ static int experimental;
 static char *ibm_thinkpad_ec_found;
 
 static char* check_dmi_for_ec(void);
-static int acpi_ibm_init(void);
-static void acpi_ibm_exit(void);
+static int thinkpad_acpi_module_init(void);
+static void thinkpad_acpi_module_exit(void);
 
 
 /****************************************************************************
-- 
1.5.1


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
