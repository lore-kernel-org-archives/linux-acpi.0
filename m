From: Len Brown <len.brown@intel.com>
Subject: [PATCH 53/77] ACPI: thinkpad-acpi: export EV_SW SW_RADIO events
Date: Sun, 22 Jul 2007 05:14:38 -0400
Message-ID: <11850957571080-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
 <11850957073494-git-send-email-len.brown@intel.com>
 <1185095708928-git-send-email-len.brown@intel.com>
 <11850957093360-git-send-email-len.brown@intel.com>
 <11850957102641-git-send-email-len.brown@intel.com>
 <11850957111797-git-send-email-len.brown@intel.com>
 <11850957123807-git-send-email-len.brown@intel.com>
 <11850957131802-git-send-email-len.brown@intel.com>
 <1185095714699-git-send-email-len.brown@intel.com>
 <1185095715506-git-send-email-len.brown@intel.com>
 <11850957162801-git-send-email-len.brown@intel.com>
 <11850957173842-git-send-email-len.brown@intel.com>
 <11850957181201-git-send-email-len.brown@intel.com>
 <11850957192175-git-send-email-len.brown@intel.com>
 <1185095721166-git-send-email-len.brown@intel.com>
 <1185095721760-git-send-email-len.brown@intel.com>
 <11850957232745-git-send-email-len.brown@intel.com>
 <11850957242656-git-send-email-len.brown@intel.com>
 <11850957252722-git-send-email-len.brown@intel.com>
 <11850957262869-git-send-email-len.brown@intel.com>
 <11850957272369-git-send-email-len.brown@intel.com>
 <11850957282082-git-send-email-len.brown@intel.com>
 <11850957292555-git-send-email-len.brown@intel.com>
 <11850957302782-git-send-email-len.brown@intel.com>
 <11850957311269-git-send-email-len.brown@intel.com>
 <11850957323059-git-send-email-len.brown@intel.com>
 <11850957332171-git-send-email-len.brown@intel.com>
 <11850957342584-git-send-email-len.brown@intel.com>
 <11850957362476-git-send-email-len.brown@intel.com>
 <11850957361736-git-send-email-len.brown@intel.com>
 <1185095737422-git-send-email-len.brown@intel.com>
 <11850957384004-git-send-email-len.brown@intel.com>
 <1185095739370-git-send-email-len.brown@intel.com>
 <11850957403722-git-send-email-len.brown@intel.com>
 <11850957413607-git-send-email-len.brown@intel.com>
 <11850957432095-git-send-email-len.brown@intel.com>
 <11850957443711-git-send-email-len.brown@intel.com>
 <11850957451942-git-send-email-len.brown@intel.com>
 <11850957462109-git-send-email-len.brown@intel.com>
 <11850957471828-git-send-email-len.brown@intel.com>
 <11850957482671-git-send-email-len.brown@intel.com>
 <11850957491254-git-send-email-len.brown@intel.com>
 <11850957503243-git-send-email-len.brown@intel.com>
 <1185095751279-git-send-email-len.brown@intel.com>
 <11850957522609-git-send-email-len.brown@intel.com>
 <11850957531914-git-send-email-len.brown@intel.com>
 <11850957541879-git-send-email-len.brown@intel.com>
 <11850957552824-git-send-email-len.brown@intel.com>
 <11850957561003-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:35331 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763969AbXGVJP7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:59 -0400
In-Reply-To: <11850957561003-git-send-email-len.brown@intel.com>
Message-Id: <5c29d58f471099401513e2e567f6c28001bb0f13.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ivo van Doorn <ivdoorn@gmail.com>, Richard Hughes <hughsient@gmail.com>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

The expected user case for the radio slider switch on a ThinkPad includes
interfacing to applications, so that the user gets an offer to find and
associate with a wireless network when the switch is changed from disabled
to enabled (ThinkVantage suite).

Export the information about the switch state, and switch change events as
an EV_SW SW_RADIO event over the input layer.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ivo van Doorn <ivdoorn@gmail.com>
Cc: Richard Hughes <hughsient@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.5.3.rc2.22.g69a9b
