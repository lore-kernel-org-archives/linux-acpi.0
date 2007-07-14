From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: ACPI: thinkpad-acpi: export EV_SW SW_RADIO events
Date: Sat, 14 Jul 2007 11:12:02 -0300
Message-ID: <11844223352643-git-send-email-hmh@hmh.eng.br>
References: <11844223322928-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11844223322928-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
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
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ivo van Doorn <ivdoorn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

The expected user case for the radio slider switch on a ThinkPad includes
interfacing to applications, so that the user gets an offer to find and
associate with a wireless network when the switch is changed from disabled
to enabled (ThinkVantage suite).

Export the information about the switch state, and switch change events as
an EV_SW SW_RADIO event over the input layer.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ivo van Doorn <ivdoorn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 78914bf..cfef218 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -1014,6 +1014,11 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 			}
 		}
 
+		if (tp_features.hotkey_wlsw) {
+			set_bit(EV_SW, tpacpi_inputdev->evbit);
+			set_bit(SW_RADIO, tpacpi_inputdev->swbit);
+		}
+
 #ifdef CONFIG_THINKPAD_ACPI_INPUT_ENABLED
 		dbg_printk(TPACPI_DBG_INIT,
 				"enabling hot key handling\n");
@@ -1062,6 +1067,15 @@ static void tpacpi_input_send_key(unsigned int scancode,
 	}
 }
 
+static void tpacpi_input_send_radiosw(void)
+{
+	int wlsw;
+
+	if (tp_features.hotkey_wlsw && !hotkey_get_wlsw(&wlsw))
+		input_report_switch(tpacpi_inputdev,
+				    SW_RADIO, !!wlsw);
+}
+
 static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 {
 	u32 hkey;
@@ -1096,6 +1110,14 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 						hkey);
 				}
 				break;
+			case 7:
+				/* 0x7000-0x7FFF: misc */
+				if (tp_features.hotkey_wlsw && hkey == 0x7000) {
+						tpacpi_input_send_radiosw();
+						sendacpi = 0;
+					break;
+				}
+				/* fallthrough to default */
 			default:
 				/* case 2: dock-related */
 				/*	0x2305 - T43 waking up due to bay lever eject while aslept */
@@ -1113,6 +1135,11 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 	}
 }
 
+static void hotkey_resume(void)
+{
+	tpacpi_input_send_radiosw();
+}
+
 /*
  * Call with hotkey_mutex held
  */
@@ -1240,6 +1267,7 @@ static struct ibm_struct hotkey_driver_data = {
 	.read = hotkey_read,
 	.write = hotkey_write,
 	.exit = hotkey_exit,
+	.resume = hotkey_resume,
 	.acpi = &ibm_hotkey_acpidriver,
 };
 
-- 
1.5.2.1


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
