From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 10/20] ACPI: thinkpad-acpi: improve
	thinkpad detection
Date: Sat, 21 Apr 2007 11:08:34 -0300
Message-ID: <11771645271484-git-send-email-hmh@hmh.eng.br>
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

Improve the detection of ThinkPads, so as to reduce the chances of false
positives.

Since this could potentially add false negatives on the very old models,
add a module parameter to force the detection of a thinkpad.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 Documentation/thinkpad-acpi.txt |    7 +++++++
 drivers/misc/thinkpad_acpi.c    |   13 +++++++++++++
 drivers/misc/thinkpad_acpi.h    |    1 +
 3 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index 20d5ec3..1a42b77 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -716,3 +716,10 @@ to enable more than one output class, just add their values.
 
 There is also a kernel build option to enable more debugging
 information, which may be necessary to debug driver problems.
+
+Force loading of module
+-----------------------
+
+If thinkpad-acpi refuses to detect your ThinkPad, you can try to specify
+the module parameter force_load=1.  Regardless of whether this works or
+not, please contact ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org with a report.
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 5611268..cddf81b 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -2881,6 +2881,16 @@ static int __init probe_for_thinkpad(void)
 		return -ENODEV;
 	}
 
+	/*
+	 * Risks a regression on very old machines, but reduces potential
+	 * false positives a damn great deal
+	 */
+	if (!is_thinkpad)
+		is_thinkpad = dmi_name_in_vendors("IBM");
+
+	if (!is_thinkpad && !force_load)
+		return -ENODEV;
+
 	return 0;
 }
 
@@ -2986,6 +2996,9 @@ module_param(experimental, int, 0);
 static u32 dbg_level;
 module_param_named(debug, dbg_level, uint, 0);
 
+static int force_load;
+module_param(force_load, int, 0);
+
 #define IBM_PARAM(feature) \
 	module_param_call(feature, set_ibm_param, NULL, NULL, 0)
 
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index 97467b7..2020398 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -128,6 +128,7 @@ static char *next_cmd(char **cmds);
 /* Module */
 static int experimental;
 static u32 dbg_level;
+static int force_load;
 static char *ibm_thinkpad_ec_found;
 
 static char* check_dmi_for_ec(void);
-- 
1.5.1


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
