From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 5/7] ACPI: thinkpad-acpi: check version of
	hot key firmware
Date: Sat, 22 Sep 2007 22:10:40 -0300
Message-ID: <11905098434014-git-send-email-hmh@hmh.eng.br>
References: <11905098422303-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11905098422303-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Check the HKEY firmware version (HKEY.MHKV handler), and refuse to load if
it is unknown.  Use this instead of the presence of HKEY.DHKV to detect hot
key mask capability.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |   28 +++++++++++++++++++++++-----
 1 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 2155139..9a61140 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -999,6 +999,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 
 	int res, i;
 	int status;
+	int hkeyv;
 
 	vdbg_printk(TPACPI_DBG_INIT, "initializing hotkey subdriver\n");
 
@@ -1024,18 +1025,35 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 			return res;
 
 		/* mask not supported on 570, 600e/x, 770e, 770x, A21e, A2xm/p,
-		   A30, R30, R31, T20-22, X20-21, X22-24 */
-		tp_features.hotkey_mask =
-			acpi_evalf(hkey_handle, NULL, "DHKN", "qv");
+		   A30, R30, R31, T20-22, X20-21, X22-24.  Detected by checking
+		   for HKEY interface version 0x100 */
+		if (acpi_evalf(hkey_handle, &hkeyv, "MHKV", "qd")) {
+			if ((hkeyv >> 8) != 1) {
+				printk(IBM_ERR "unknown version of the "
+				       "HKEY interface: 0x%x\n", hkeyv);
+				printk(IBM_ERR "please report this to %s\n",
+				       IBM_MAIL);
+			} else {
+				/*
+				 * MHKV 0x100 in A31, R40, R40e,
+				 * T4x, X31, and later
+				 * */
+				tp_features.hotkey_mask = 1;
+			}
+		}
 
 		vdbg_printk(TPACPI_DBG_INIT, "hotkey masks are %s\n",
 			str_supported(tp_features.hotkey_mask));
 
 		if (tp_features.hotkey_mask) {
-			/* MHKA available in A31, R40, R40e, T4x, X31, and later */
 			if (!acpi_evalf(hkey_handle, &hotkey_all_mask,
-					"MHKA", "qd"))
+					"MHKA", "qd")) {
+				printk(IBM_ERR
+				       "missing MHKA handler, "
+				       "please report this to %s\n",
+				       IBM_MAIL);
 				hotkey_all_mask = 0x080cU; /* FN+F12, FN+F4, FN+F3 */
+			}
 		}
 
 		res = hotkey_get(&hotkey_orig_status, &hotkey_orig_mask);
-- 
1.5.3.1


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
