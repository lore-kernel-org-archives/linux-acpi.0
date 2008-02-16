From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 8/9] ACPI: thinkpad-acpi: minor
	hotkey_radio_sw fixes
Date: Sat, 16 Feb 2008 02:17:57 -0200
Message-ID: <1203135478-4813-9-git-send-email-hmh@hmh.eng.br>
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

Fixes some minor points in the radio switch code and docs.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 Documentation/laptops/thinkpad-acpi.txt |    2 +-
 drivers/misc/thinkpad_acpi.c            |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index 91f688c..606af16 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -306,7 +306,7 @@ sysfs notes:
 		The recommended polling frequency is 10Hz.
 
 	hotkey_radio_sw:
-		if the ThinkPad has a hardware radio switch, this
+		If the ThinkPad has a hardware radio switch, this
 		attribute will read 0 if the switch is in the "radios
 		disabled" position, and 1 if the switch is in the
 		"radios enabled" position.
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 3548350..c119cf2 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -1161,15 +1161,15 @@ static void tpacpi_input_send_radiosw(void)
 {
 	int wlsw;
 
-	mutex_lock(&tpacpi_inputdev_send_mutex);
-
 	if (tp_features.hotkey_wlsw && !hotkey_get_wlsw(&wlsw)) {
+		mutex_lock(&tpacpi_inputdev_send_mutex);
+
 		input_report_switch(tpacpi_inputdev,
 				    SW_RADIO, !!wlsw);
 		input_sync(tpacpi_inputdev);
-	}
 
-	mutex_unlock(&tpacpi_inputdev_send_mutex);
+		mutex_unlock(&tpacpi_inputdev_send_mutex);
+	}
 }
 
 static void tpacpi_input_send_tabletsw(unsigned int state)
-- 
1.5.3.8


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
