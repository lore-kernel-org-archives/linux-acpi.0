From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 1/3] ACPI / utils: Rename acpi_dev_present()
Date: Thu, 24 Mar 2016 13:15:20 +0100
Message-ID: <280ddb44874f3f3567f343337369f28ed124bafc.1458813034.git.lukas@wunner.de>
References: <cover.1458813034.git.lukas@wunner.de>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <cover.1458813034.git.lukas@wunner.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

acpi_dev_present() was originally named after pci_dev_present()
to signify the similarity of the two functions.

However Rafael J. Wysocki pointed out that the exported function
acpi_dev_present() is easily confused with the non-exported
acpi_device_is_present(). Additionally in ACPI parlance the term
"present" usually refers to the "device is present" bit returned
by the _STA control method, yet acpi_dev_present() merely checks
presence in the namespace. It does not invoke _STA at all, let
alone check the "device is present" bit.

As suggested by Rafael, rename the function to acpi_dev_found()
and adjust all existing call sites.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/acpi/utils.c                         | 6 +++---
 include/acpi/acpi_bus.h                      | 2 +-
 include/linux/apple-gmux.h                   | 2 +-
 sound/pci/hda/thinkpad_helper.c              | 2 +-
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 2 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c      | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index f12a724..70ca1ab 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -707,7 +707,7 @@ bool acpi_check_dsm(acpi_handle handle, const u8 *uuid, int rev, u64 funcs)
 EXPORT_SYMBOL(acpi_check_dsm);
 
 /**
- * acpi_dev_present - Detect presence of a given ACPI device in the system.
+ * acpi_dev_found - Detect presence of a given ACPI device in the namespace.
  * @hid: Hardware ID of the device.
  *
  * Return %true if the device was present at the moment of invocation.
@@ -719,7 +719,7 @@ EXPORT_SYMBOL(acpi_check_dsm);
  * instead). Calling from module_init() is fine (which is synonymous
  * with device_initcall()).
  */
-bool acpi_dev_present(const char *hid)
+bool acpi_dev_found(const char *hid)
 {
 	struct acpi_device_bus_id *acpi_device_bus_id;
 	bool found = false;
@@ -734,7 +734,7 @@ bool acpi_dev_present(const char *hid)
 
 	return found;
 }
-EXPORT_SYMBOL(acpi_dev_present);
+EXPORT_SYMBOL(acpi_dev_found);
 
 /*
  * acpi_backlight= handling, this is done here rather then in video_detect.c
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 14362a8..a84fd15 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -87,7 +87,7 @@ acpi_evaluate_dsm_typed(acpi_handle handle, const u8 *uuid, int rev, int func,
 	  .package.elements = (eles)			\
 	}
 
-bool acpi_dev_present(const char *hid);
+bool acpi_dev_found(const char *hid);
 
 #ifdef CONFIG_ACPI
 
diff --git a/include/linux/apple-gmux.h b/include/linux/apple-gmux.h
index b2d32e0..714186d 100644
--- a/include/linux/apple-gmux.h
+++ b/include/linux/apple-gmux.h
@@ -35,7 +35,7 @@
  */
 static inline bool apple_gmux_present(void)
 {
-	return acpi_dev_present(GMUX_ACPI_HID);
+	return acpi_dev_found(GMUX_ACPI_HID);
 }
 
 #else  /* !CONFIG_APPLE_GMUX */
diff --git a/sound/pci/hda/thinkpad_helper.c b/sound/pci/hda/thinkpad_helper.c
index 59ab6ce..f0955fd 100644
--- a/sound/pci/hda/thinkpad_helper.c
+++ b/sound/pci/hda/thinkpad_helper.c
@@ -13,7 +13,7 @@ static void (*old_vmaster_hook)(void *, int);
 static bool is_thinkpad(struct hda_codec *codec)
 {
 	return (codec->core.subsystem_id >> 16 == 0x17aa) &&
-	       (acpi_dev_present("LEN0068") || acpi_dev_present("IBM0068"));
+	       (acpi_dev_found("LEN0068") || acpi_dev_found("IBM0068"));
 }
 
 static void update_tpacpi_mute_led(void *private_data, int enabled)
diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index e609f08..ac60b04 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -296,7 +296,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	if (!drv)
 		return -ENOMEM;
 
-	drv->ts3a227e_present = acpi_dev_present("104C227E");
+	drv->ts3a227e_present = acpi_dev_found("104C227E");
 	if (!drv->ts3a227e_present) {
 		/* no need probe TI jack detection chip */
 		snd_soc_card_cht.aux_dev = NULL;
diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index 2a6f808..3f2c1ea 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -357,7 +357,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	for (i = 0; i < ARRAY_SIZE(snd_soc_cards); i++) {
-		if (acpi_dev_present(snd_soc_cards[i].codec_id)) {
+		if (acpi_dev_found(snd_soc_cards[i].codec_id)) {
 			dev_dbg(&pdev->dev,
 				"found codec %s\n", snd_soc_cards[i].codec_id);
 			card = snd_soc_cards[i].soc_card;
-- 
2.8.0.rc3
