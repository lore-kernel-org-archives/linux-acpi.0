From: "Luming Yu" <luming.yu@gmail.com>
Subject: [RFC PATCH] report acpi video hot key event through input device
Date: Sun, 29 Jul 2007 12:40:16 -0400
Message-ID: <3877989d0707290940k3afa94d5x863599ac7c64662b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_6678_8218357.1185727216312"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:2410 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbXG2QkS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 Jul 2007 12:40:18 -0400
Received: by rv-out-0910.google.com with SMTP id k20so285346rvb
        for <linux-acpi@vger.kernel.org>; Sun, 29 Jul 2007 09:40:17 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

------=_Part_6678_8218357.1185727216312
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

report acpi video hot key event through input device

Signed-off-by: Luming Yu <Luming.yu@intel.com>
--
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 00d25b3..03d84db 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -31,6 +31,7 @@
 #include <linux/list.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/input.h>

 #include <linux/backlight.h>
 #include <asm/uaccess.h>
@@ -131,6 +132,8 @@ struct acpi_video_bus {
 	struct semaphore sem;
 	struct list_head video_device_list;
 	struct proc_dir_entry *dir;
+	struct input_dev *input;
+	char phys[32];			/* for input device */
 };

 struct acpi_video_device_flags {
@@ -1714,6 +1717,8 @@ static void acpi_video_bus_notify(acpi_h
 {
 	struct acpi_video_bus *video = data;
 	struct acpi_device *device = NULL;
+	struct input_dev *input;
+	int keycode;

 	printk("video bus notify\n");

@@ -1721,11 +1726,13 @@ static void acpi_video_bus_notify(acpi_h
 		return;

 	device = video->device;
+	input = video->input;

 	switch (event) {
 	case ACPI_VIDEO_NOTIFY_SWITCH:	/* User requested a switch,
 					 * most likely via hotkey. */
 		acpi_bus_generate_event(device, event, 0);
+		keycode = KEY_UNKNOWN;
 		break;

 	case ACPI_VIDEO_NOTIFY_PROBE:	/* User plugged in or removed a video
@@ -1734,21 +1741,37 @@ static void acpi_video_bus_notify(acpi_h
 		acpi_video_device_rebind(video);
 		acpi_video_switch_output(video, event);
 		acpi_bus_generate_event(device, event, 0);
+		keycode = KEY_UNKNOWN;
 		break;

 	case ACPI_VIDEO_NOTIFY_CYCLE:	/* Cycle Display output hotkey pressed. */
+		acpi_video_switch_output(video, event);
+		acpi_bus_generate_event(device, event, 0);
+		keycode = KEY_UNKNOWN;
+		break;
 	case ACPI_VIDEO_NOTIFY_NEXT_OUTPUT:	/* Next Display output hotkey pressed. */
+		acpi_video_switch_output(video, event);
+		acpi_bus_generate_event(device, event, 0);
+		keycode = KEY_VIDEO_NEXT;
+		break;
 	case ACPI_VIDEO_NOTIFY_PREV_OUTPUT:	/* previous Display output
hotkey pressed. */
 		acpi_video_switch_output(video, event);
 		acpi_bus_generate_event(device, event, 0);
+		keycode = KEY_VIDEO_PREV;
 		break;

 	default:
+		keycode = KEY_UNKNOWN;
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Unsupported event [0x%x]\n", event));
 		break;
 	}

+	input_report_key(input, keycode, 1);
+	input_sync(input);
+	input_report_key(input, keycode, 0);
+	input_sync(input);
+
 	return;
 }

@@ -1756,30 +1779,60 @@ static void acpi_video_device_notify(acp
 {
 	struct acpi_video_device *video_device = data;
 	struct acpi_device *device = NULL;
+	struct acpi_video_bus *bus;
+	struct input_dev *input;
+	int keycode;

 	if (!video_device)
 		return;

 	device = video_device->dev;
+	bus = video_device->video;
+	input = bus->input;

 	switch (event) {
 	case ACPI_VIDEO_NOTIFY_SWITCH:	/* change in status (cycle output device) */
 	case ACPI_VIDEO_NOTIFY_PROBE:	/* change in status (output device status) */
 		acpi_bus_generate_event(device, event, 0);
+		keycode = KEY_UNKNOWN;
 		break;
 	case ACPI_VIDEO_NOTIFY_CYCLE_BRIGHTNESS:	/* Cycle brightness */
+		acpi_video_switch_brightness(video_device, event);
+		acpi_bus_generate_event(device, event, 0);
+		keycode = KEY_UNKNOWN;
+		break;
 	case ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS:	/* Increase brightness */
+		acpi_video_switch_brightness(video_device, event);
+		acpi_bus_generate_event(device, event, 0);
+		keycode = KEY_BRIGHTNESS_UP;
+		break;
 	case ACPI_VIDEO_NOTIFY_DEC_BRIGHTNESS:	/* Decrease brightness */
+		acpi_video_switch_brightness(video_device, event);
+		acpi_bus_generate_event(device, event, 0);
+		keycode = KEY_BRIGHTNESS_DOWN;
+		break;
 	case ACPI_VIDEO_NOTIFY_ZERO_BRIGHTNESS:	/* zero brightnesss */
+		acpi_video_switch_brightness(video_device, event);
+		acpi_bus_generate_event(device, event, 0);
+		keycode = KEY_BRIGHTNESS_ZERO;
+		break;
 	case ACPI_VIDEO_NOTIFY_DISPLAY_OFF:	/* display device off */
 		acpi_video_switch_brightness(video_device, event);
 		acpi_bus_generate_event(device, event, 0);
+		keycode = KEY_BRIGHTNESS_OFF;
 		break;
 	default:
+		keycode = KEY_UNKNOWN;
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Unsupported event [0x%x]\n", event));
 		break;
 	}
+
+	input_report_key(input, keycode, 1);
+	input_sync(input);
+	input_report_key(input, keycode, 0);
+	input_sync(input);
+
 	return;
 }

@@ -1788,7 +1841,7 @@ static int acpi_video_bus_add(struct acp
 	int result = 0;
 	acpi_status status = 0;
 	struct acpi_video_bus *video = NULL;
-
+	struct input_dev *input;

 	if (!device)
 		return -EINVAL;
@@ -1830,7 +1883,18 @@ static int acpi_video_bus_add(struct acp
 		result = -ENODEV;
 		goto end;
 	}
-
+	
+	video->input = input = input_allocate_device();
+
+	snprintf(video->phys, sizeof(video->phys),
+		 "%s/video/input0", acpi_device_bid(video->device));
+
+	input->name = acpi_device_name(video->device);
+	input->phys = video->phys;
+	input->id.bustype = BUS_HOST;
+	input->id.product = 0x06;
+	input->evbit[0] = BIT(EV_KEY);
+	input_register_device(input);
 	printk(KERN_INFO PREFIX "%s [%s] (multi-head: %s  rom: %s  post: %s)\n",
 	       ACPI_VIDEO_DEVICE_NAME, acpi_device_bid(device),
 	       video->flags.multihead ? "yes" : "no",
@@ -1863,7 +1927,7 @@ static int acpi_video_bus_remove(struct

 	acpi_video_bus_put_devices(video);
 	acpi_video_bus_remove_fs(device);
-
+	input_unregister_device(video->input);
 	kfree(video->attached_array);
 	kfree(video);

diff --git a/include/linux/input.h b/include/linux/input.h
index be2bf3a..2ccdb50 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -544,6 +544,13 @@ struct input_absinfo {
 #define KEY_BRL_DOT7		0x1f7
 #define KEY_BRL_DOT8		0x1f8

+#define KEY_VIDEO_NEXT		0x1f9
+#define KEY_VIDEO_PREV		0x1fa
+#define KEY_BRIGHTNESS_UP	0x1fb
+#define KEY_BRIGHTNESS_DOWN	0x1fc
+#define KEY_BRIGHTNESS_ZERO	0x1fd
+#define KEY_BRIGHTNESS_OFF	0x1fe
+
 /* We avoid low common keys in module aliases so they don't get huge. */
 #define KEY_MIN_INTERESTING	KEY_MUTE
 #define KEY_MAX			0x1ff

------=_Part_6678_8218357.1185727216312
Content-Type: text/x-patch; name=ev.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f4qg3g4a
Content-Disposition: attachment; filename="ev.patch"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS92aWRlby5jIGIvZHJpdmVycy9hY3BpL3ZpZGVvLmMK
aW5kZXggMDBkMjViMy4uMDNkODRkYiAxMDA2NDQKLS0tIGEvZHJpdmVycy9hY3BpL3ZpZGVvLmMK
KysrIGIvZHJpdmVycy9hY3BpL3ZpZGVvLmMKQEAgLTMxLDYgKzMxLDcgQEAKICNpbmNsdWRlIDxs
aW51eC9saXN0Lmg+CiAjaW5jbHVkZSA8bGludXgvcHJvY19mcy5oPgogI2luY2x1ZGUgPGxpbnV4
L3NlcV9maWxlLmg+CisjaW5jbHVkZSA8bGludXgvaW5wdXQuaD4KIAogI2luY2x1ZGUgPGxpbnV4
L2JhY2tsaWdodC5oPgogI2luY2x1ZGUgPGFzbS91YWNjZXNzLmg+CkBAIC0xMzEsNiArMTMyLDgg
QEAgc3RydWN0IGFjcGlfdmlkZW9fYnVzIHsKIAlzdHJ1Y3Qgc2VtYXBob3JlIHNlbTsKIAlzdHJ1
Y3QgbGlzdF9oZWFkIHZpZGVvX2RldmljZV9saXN0OwogCXN0cnVjdCBwcm9jX2Rpcl9lbnRyeSAq
ZGlyOworCXN0cnVjdCBpbnB1dF9kZXYgKmlucHV0OworCWNoYXIgcGh5c1szMl07CQkJLyogZm9y
IGlucHV0IGRldmljZSAqLwogfTsKIAogc3RydWN0IGFjcGlfdmlkZW9fZGV2aWNlX2ZsYWdzIHsK
QEAgLTE3MTQsNiArMTcxNyw4IEBAIHN0YXRpYyB2b2lkIGFjcGlfdmlkZW9fYnVzX25vdGlmeShh
Y3BpX2gKIHsKIAlzdHJ1Y3QgYWNwaV92aWRlb19idXMgKnZpZGVvID0gZGF0YTsKIAlzdHJ1Y3Qg
YWNwaV9kZXZpY2UgKmRldmljZSA9IE5VTEw7CisJc3RydWN0IGlucHV0X2RldiAqaW5wdXQ7CisJ
aW50IGtleWNvZGU7IAogCiAJcHJpbnRrKCJ2aWRlbyBidXMgbm90aWZ5XG4iKTsKIApAQCAtMTcy
MSwxMSArMTcyNiwxMyBAQCBzdGF0aWMgdm9pZCBhY3BpX3ZpZGVvX2J1c19ub3RpZnkoYWNwaV9o
CiAJCXJldHVybjsKIAogCWRldmljZSA9IHZpZGVvLT5kZXZpY2U7CisJaW5wdXQgPSB2aWRlby0+
aW5wdXQ7CiAKIAlzd2l0Y2ggKGV2ZW50KSB7CiAJY2FzZSBBQ1BJX1ZJREVPX05PVElGWV9TV0lU
Q0g6CS8qIFVzZXIgcmVxdWVzdGVkIGEgc3dpdGNoLAogCQkJCQkgKiBtb3N0IGxpa2VseSB2aWEg
aG90a2V5LiAqLwogCQlhY3BpX2J1c19nZW5lcmF0ZV9ldmVudChkZXZpY2UsIGV2ZW50LCAwKTsK
KwkJa2V5Y29kZSA9IEtFWV9VTktOT1dOOwogCQlicmVhazsKIAogCWNhc2UgQUNQSV9WSURFT19O
T1RJRllfUFJPQkU6CS8qIFVzZXIgcGx1Z2dlZCBpbiBvciByZW1vdmVkIGEgdmlkZW8KQEAgLTE3
MzQsMjEgKzE3NDEsMzcgQEAgc3RhdGljIHZvaWQgYWNwaV92aWRlb19idXNfbm90aWZ5KGFjcGlf
aAogCQlhY3BpX3ZpZGVvX2RldmljZV9yZWJpbmQodmlkZW8pOwogCQlhY3BpX3ZpZGVvX3N3aXRj
aF9vdXRwdXQodmlkZW8sIGV2ZW50KTsKIAkJYWNwaV9idXNfZ2VuZXJhdGVfZXZlbnQoZGV2aWNl
LCBldmVudCwgMCk7CisJCWtleWNvZGUgPSBLRVlfVU5LTk9XTjsKIAkJYnJlYWs7CiAKIAljYXNl
IEFDUElfVklERU9fTk9USUZZX0NZQ0xFOgkvKiBDeWNsZSBEaXNwbGF5IG91dHB1dCBob3RrZXkg
cHJlc3NlZC4gKi8KKwkJYWNwaV92aWRlb19zd2l0Y2hfb3V0cHV0KHZpZGVvLCBldmVudCk7CisJ
CWFjcGlfYnVzX2dlbmVyYXRlX2V2ZW50KGRldmljZSwgZXZlbnQsIDApOworCQlrZXljb2RlID0g
S0VZX1VOS05PV047CisJCWJyZWFrOwogCWNhc2UgQUNQSV9WSURFT19OT1RJRllfTkVYVF9PVVRQ
VVQ6CS8qIE5leHQgRGlzcGxheSBvdXRwdXQgaG90a2V5IHByZXNzZWQuICovCisJCWFjcGlfdmlk
ZW9fc3dpdGNoX291dHB1dCh2aWRlbywgZXZlbnQpOworCQlhY3BpX2J1c19nZW5lcmF0ZV9ldmVu
dChkZXZpY2UsIGV2ZW50LCAwKTsKKwkJa2V5Y29kZSA9IEtFWV9WSURFT19ORVhUOworCQlicmVh
azsKIAljYXNlIEFDUElfVklERU9fTk9USUZZX1BSRVZfT1VUUFVUOgkvKiBwcmV2aW91cyBEaXNw
bGF5IG91dHB1dCBob3RrZXkgcHJlc3NlZC4gKi8KIAkJYWNwaV92aWRlb19zd2l0Y2hfb3V0cHV0
KHZpZGVvLCBldmVudCk7CiAJCWFjcGlfYnVzX2dlbmVyYXRlX2V2ZW50KGRldmljZSwgZXZlbnQs
IDApOworCQlrZXljb2RlID0gS0VZX1ZJREVPX1BSRVY7CiAJCWJyZWFrOwogCiAJZGVmYXVsdDoK
KwkJa2V5Y29kZSA9IEtFWV9VTktOT1dOOwogCQlBQ1BJX0RFQlVHX1BSSU5UKChBQ1BJX0RCX0lO
Rk8sCiAJCQkJICAiVW5zdXBwb3J0ZWQgZXZlbnQgWzB4JXhdXG4iLCBldmVudCkpOwogCQlicmVh
azsKIAl9CiAKKwlpbnB1dF9yZXBvcnRfa2V5KGlucHV0LCBrZXljb2RlLCAxKTsKKwlpbnB1dF9z
eW5jKGlucHV0KTsKKwlpbnB1dF9yZXBvcnRfa2V5KGlucHV0LCBrZXljb2RlLCAwKTsKKwlpbnB1
dF9zeW5jKGlucHV0KTsKKwogCXJldHVybjsKIH0KIApAQCAtMTc1NiwzMCArMTc3OSw2MCBAQCBz
dGF0aWMgdm9pZCBhY3BpX3ZpZGVvX2RldmljZV9ub3RpZnkoYWNwCiB7CiAJc3RydWN0IGFjcGlf
dmlkZW9fZGV2aWNlICp2aWRlb19kZXZpY2UgPSBkYXRhOwogCXN0cnVjdCBhY3BpX2RldmljZSAq
ZGV2aWNlID0gTlVMTDsKKwlzdHJ1Y3QgYWNwaV92aWRlb19idXMgKmJ1czsKKwlzdHJ1Y3QgaW5w
dXRfZGV2ICppbnB1dDsKKwlpbnQga2V5Y29kZTsKIAogCWlmICghdmlkZW9fZGV2aWNlKQogCQly
ZXR1cm47CiAKIAlkZXZpY2UgPSB2aWRlb19kZXZpY2UtPmRldjsKKwlidXMgPSB2aWRlb19kZXZp
Y2UtPnZpZGVvOworCWlucHV0ID0gYnVzLT5pbnB1dDsKIAogCXN3aXRjaCAoZXZlbnQpIHsKIAlj
YXNlIEFDUElfVklERU9fTk9USUZZX1NXSVRDSDoJLyogY2hhbmdlIGluIHN0YXR1cyAoY3ljbGUg
b3V0cHV0IGRldmljZSkgKi8KIAljYXNlIEFDUElfVklERU9fTk9USUZZX1BST0JFOgkvKiBjaGFu
Z2UgaW4gc3RhdHVzIChvdXRwdXQgZGV2aWNlIHN0YXR1cykgKi8KIAkJYWNwaV9idXNfZ2VuZXJh
dGVfZXZlbnQoZGV2aWNlLCBldmVudCwgMCk7CisJCWtleWNvZGUgPSBLRVlfVU5LTk9XTjsKIAkJ
YnJlYWs7CiAJY2FzZSBBQ1BJX1ZJREVPX05PVElGWV9DWUNMRV9CUklHSFRORVNTOgkvKiBDeWNs
ZSBicmlnaHRuZXNzICovCisJCWFjcGlfdmlkZW9fc3dpdGNoX2JyaWdodG5lc3ModmlkZW9fZGV2
aWNlLCBldmVudCk7CisJCWFjcGlfYnVzX2dlbmVyYXRlX2V2ZW50KGRldmljZSwgZXZlbnQsIDAp
OworCQlrZXljb2RlID0gS0VZX1VOS05PV047CisJCWJyZWFrOwogCWNhc2UgQUNQSV9WSURFT19O
T1RJRllfSU5DX0JSSUdIVE5FU1M6CS8qIEluY3JlYXNlIGJyaWdodG5lc3MgKi8KKwkJYWNwaV92
aWRlb19zd2l0Y2hfYnJpZ2h0bmVzcyh2aWRlb19kZXZpY2UsIGV2ZW50KTsKKwkJYWNwaV9idXNf
Z2VuZXJhdGVfZXZlbnQoZGV2aWNlLCBldmVudCwgMCk7CisJCWtleWNvZGUgPSBLRVlfQlJJR0hU
TkVTU19VUDsKKwkJYnJlYWs7CiAJY2FzZSBBQ1BJX1ZJREVPX05PVElGWV9ERUNfQlJJR0hUTkVT
UzoJLyogRGVjcmVhc2UgYnJpZ2h0bmVzcyAqLworCQlhY3BpX3ZpZGVvX3N3aXRjaF9icmlnaHRu
ZXNzKHZpZGVvX2RldmljZSwgZXZlbnQpOworCQlhY3BpX2J1c19nZW5lcmF0ZV9ldmVudChkZXZp
Y2UsIGV2ZW50LCAwKTsKKwkJa2V5Y29kZSA9IEtFWV9CUklHSFRORVNTX0RPV047CisJCWJyZWFr
OwogCWNhc2UgQUNQSV9WSURFT19OT1RJRllfWkVST19CUklHSFRORVNTOgkvKiB6ZXJvIGJyaWdo
dG5lc3NzICovCisJCWFjcGlfdmlkZW9fc3dpdGNoX2JyaWdodG5lc3ModmlkZW9fZGV2aWNlLCBl
dmVudCk7CisJCWFjcGlfYnVzX2dlbmVyYXRlX2V2ZW50KGRldmljZSwgZXZlbnQsIDApOworCQlr
ZXljb2RlID0gS0VZX0JSSUdIVE5FU1NfWkVSTzsKKwkJYnJlYWs7CiAJY2FzZSBBQ1BJX1ZJREVP
X05PVElGWV9ESVNQTEFZX09GRjoJLyogZGlzcGxheSBkZXZpY2Ugb2ZmICovCiAJCWFjcGlfdmlk
ZW9fc3dpdGNoX2JyaWdodG5lc3ModmlkZW9fZGV2aWNlLCBldmVudCk7CiAJCWFjcGlfYnVzX2dl
bmVyYXRlX2V2ZW50KGRldmljZSwgZXZlbnQsIDApOworCQlrZXljb2RlID0gS0VZX0JSSUdIVE5F
U1NfT0ZGOwogCQlicmVhazsKIAlkZWZhdWx0OgorCQlrZXljb2RlID0gS0VZX1VOS05PV047CiAJ
CUFDUElfREVCVUdfUFJJTlQoKEFDUElfREJfSU5GTywKIAkJCQkgICJVbnN1cHBvcnRlZCBldmVu
dCBbMHgleF1cbiIsIGV2ZW50KSk7CiAJCWJyZWFrOwogCX0KKworCWlucHV0X3JlcG9ydF9rZXko
aW5wdXQsIGtleWNvZGUsIDEpOworCWlucHV0X3N5bmMoaW5wdXQpOworCWlucHV0X3JlcG9ydF9r
ZXkoaW5wdXQsIGtleWNvZGUsIDApOworCWlucHV0X3N5bmMoaW5wdXQpOworCiAJcmV0dXJuOwog
fQogCkBAIC0xNzg4LDcgKzE4NDEsNyBAQCBzdGF0aWMgaW50IGFjcGlfdmlkZW9fYnVzX2FkZChz
dHJ1Y3QgYWNwCiAJaW50IHJlc3VsdCA9IDA7CiAJYWNwaV9zdGF0dXMgc3RhdHVzID0gMDsKIAlz
dHJ1Y3QgYWNwaV92aWRlb19idXMgKnZpZGVvID0gTlVMTDsKLQorCXN0cnVjdCBpbnB1dF9kZXYg
KmlucHV0OwogCiAJaWYgKCFkZXZpY2UpCiAJCXJldHVybiAtRUlOVkFMOwpAQCAtMTgzMCw3ICsx
ODgzLDE4IEBAIHN0YXRpYyBpbnQgYWNwaV92aWRlb19idXNfYWRkKHN0cnVjdCBhY3AKIAkJcmVz
dWx0ID0gLUVOT0RFVjsKIAkJZ290byBlbmQ7CiAJfQotCisJCisJdmlkZW8tPmlucHV0ID0gaW5w
dXQgPSBpbnB1dF9hbGxvY2F0ZV9kZXZpY2UoKTsKKworCXNucHJpbnRmKHZpZGVvLT5waHlzLCBz
aXplb2YodmlkZW8tPnBoeXMpLAorCQkgIiVzL3ZpZGVvL2lucHV0MCIsIGFjcGlfZGV2aWNlX2Jp
ZCh2aWRlby0+ZGV2aWNlKSk7CisKKwlpbnB1dC0+bmFtZSA9IGFjcGlfZGV2aWNlX25hbWUodmlk
ZW8tPmRldmljZSk7CisJaW5wdXQtPnBoeXMgPSB2aWRlby0+cGh5czsKKwlpbnB1dC0+aWQuYnVz
dHlwZSA9IEJVU19IT1NUOworCWlucHV0LT5pZC5wcm9kdWN0ID0gMHgwNjsKKwlpbnB1dC0+ZXZi
aXRbMF0gPSBCSVQoRVZfS0VZKTsKKwlpbnB1dF9yZWdpc3Rlcl9kZXZpY2UoaW5wdXQpOwogCXBy
aW50ayhLRVJOX0lORk8gUFJFRklYICIlcyBbJXNdIChtdWx0aS1oZWFkOiAlcyAgcm9tOiAlcyAg
cG9zdDogJXMpXG4iLAogCSAgICAgICBBQ1BJX1ZJREVPX0RFVklDRV9OQU1FLCBhY3BpX2Rldmlj
ZV9iaWQoZGV2aWNlKSwKIAkgICAgICAgdmlkZW8tPmZsYWdzLm11bHRpaGVhZCA/ICJ5ZXMiIDog
Im5vIiwKQEAgLTE4NjMsNyArMTkyNyw3IEBAIHN0YXRpYyBpbnQgYWNwaV92aWRlb19idXNfcmVt
b3ZlKHN0cnVjdAogCiAJYWNwaV92aWRlb19idXNfcHV0X2RldmljZXModmlkZW8pOwogCWFjcGlf
dmlkZW9fYnVzX3JlbW92ZV9mcyhkZXZpY2UpOwotCisJaW5wdXRfdW5yZWdpc3Rlcl9kZXZpY2Uo
dmlkZW8tPmlucHV0KTsKIAlrZnJlZSh2aWRlby0+YXR0YWNoZWRfYXJyYXkpOwogCWtmcmVlKHZp
ZGVvKTsKIApkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9pbnB1dC5oIGIvaW5jbHVkZS9saW51
eC9pbnB1dC5oCmluZGV4IGJlMmJmM2EuLjJjY2RiNTAgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGlu
dXgvaW5wdXQuaAorKysgYi9pbmNsdWRlL2xpbnV4L2lucHV0LmgKQEAgLTU0NCw2ICs1NDQsMTMg
QEAgc3RydWN0IGlucHV0X2Fic2luZm8gewogI2RlZmluZSBLRVlfQlJMX0RPVDcJCTB4MWY3CiAj
ZGVmaW5lIEtFWV9CUkxfRE9UOAkJMHgxZjgKIAorI2RlZmluZSBLRVlfVklERU9fTkVYVAkJMHgx
ZjkKKyNkZWZpbmUgS0VZX1ZJREVPX1BSRVYJCTB4MWZhCisjZGVmaW5lIEtFWV9CUklHSFRORVNT
X1VQCTB4MWZiCisjZGVmaW5lIEtFWV9CUklHSFRORVNTX0RPV04JMHgxZmMKKyNkZWZpbmUgS0VZ
X0JSSUdIVE5FU1NfWkVSTwkweDFmZAorI2RlZmluZSBLRVlfQlJJR0hUTkVTU19PRkYJMHgxZmUK
KwogLyogV2UgYXZvaWQgbG93IGNvbW1vbiBrZXlzIGluIG1vZHVsZSBhbGlhc2VzIHNvIHRoZXkg
ZG9uJ3QgZ2V0IGh1Z2UuICovCiAjZGVmaW5lIEtFWV9NSU5fSU5URVJFU1RJTkcJS0VZX01VVEUK
ICNkZWZpbmUgS0VZX01BWAkJCTB4MWZmCg==
------=_Part_6678_8218357.1185727216312--
