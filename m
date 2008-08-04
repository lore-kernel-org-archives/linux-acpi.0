From: Thomas Renninger <trenn@suse.de>
Subject: Re: Check for ACPI backlight support otherwise use vendor ACPIdrivers - version 4
Date: Mon, 4 Aug 2008 12:20:28 +0200
Message-ID: <200808041220.29892.trenn@suse.de>
References: <1217605083-31003-1-git-send-email-trenn@suse.de> <1217812580.2969.184.camel@rzhang-dt> <1217830192.4580.8.camel@hidalgo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:56020 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753068AbYHDKUd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Aug 2008 06:20:33 -0400
In-Reply-To: <1217830192.4580.8.camel@hidalgo>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yves-Alexis Perez <corsac@debian.org>
Cc: Zhang Rui <rui.zhang@intel.com>, ak@linux.intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org, hmh@debian.org

On Monday 04 August 2008 08:09:52 Yves-Alexis Perez wrote:
> On lun, 2008-08-04 at 09:16 +0800, Zhang Rui wrote:
> > I think you're using the laptop that this patch does break.
> > Please try acpi_backlight=3Dvendor.
>
> When booting to single user with acpi_backlight=3Dvendor, thinkpad-ac=
pi
> takes over backlight:
>
> Aug  4 07:54:38 hidalgo kernel: thinkpad_acpi: ThinkPad ACPI Extras v=
0.21
> Aug  4 07:54:38 hidalgo kernel: thinkpad_acpi: http://ibm-acpi.sf.net=
/
> Aug  4 07:54:38 hidalgo kernel: thinkpad_acpi: ThinkPad BIOS 7LETB9WW=
 (2.19
> ), EC 7KHT24WW-1.08 Aug  4 07:54:38 hidalgo kernel: thinkpad_acpi: Le=
novo
> ThinkPad T61, model 8897CTO Aug  4 07:54:38 hidalgo kernel: thinkpad_=
acpi:
> radio switch found; radios are enabled Aug  4 07:54:38 hidalgo kernel=
:
> thinkpad_acpi: This ThinkPad has standard ACPI backlight brightness
> control, supported by the ACPI video driver Aug  4 07:54:38 hidalgo k=
ernel:
> thinkpad_acpi: Disabling thinkpad-acpi brightness events by default..=
=2E Aug=20
> 4 07:54:38 hidalgo kernel: Registered led device: tpacpi::thinklight =
Aug  4
> 07:54:38 hidalgo kernel: Registered led device: tpacpi::power Aug  4
> 07:54:38 hidalgo kernel: Registered led device: tpacpi:orange:batt Au=
g  4
> 07:54:38 hidalgo kernel: Registered led device: tpacpi:green:batt Aug=
  4
> 07:54:38 hidalgo kernel: Registered led device: tpacpi::dock_active A=
ug  4
> 07:54:38 hidalgo kernel: Registered led device: tpacpi::bay_active Au=
g  4
> 07:54:38 hidalgo kernel: Registered led device: tpacpi::dock_batt Aug=
  4
> 07:54:38 hidalgo kernel: Registered led device: tpacpi::unknown_led A=
ug  4
> 07:54:38 hidalgo kernel: Registered led device: tpacpi::standby Aug  =
4
> 07:54:38 hidalgo kernel: thinkpad_acpi: Standard ACPI backlight inter=
face
> not available, thinkpad_acpi driver will take over control Aug  4 07:=
54:38
> hidalgo kernel: thinkpad_acpi: detected a 16-level brightness capable
> ThinkPad Aug  4 07:54:38 hidalgo kernel: input: ThinkPad Extra Button=
s as
> /devices/virtual/input/input6 Aug  4 07:54:38 hidalgo kernel: usb 1-1=
: new
> full speed USB device using uhci_hcd and address 4 Aug  4 07:54:38 hi=
dalgo
> kernel: usb 1-1: configuration #1 chosen from 1 choice
>
> But when in user mode, brightness keys doesn't do anything either.
> Echo'ing to /proc/acpi/ibm/brightness doesn't work, but echoing
> to /sys/class/backlight/thinkpad_screen/brightness works.
That /proc/acpi/ibm/brightness does not and
/sys/class/backlight/thinkpad_screen/brightness=20
works is strange, this should be a bug?

I wonder whether /proc/acpi/ibm/brightness can be removed soon, people =
had
some time to make use of the generic interface.

What you describe very much reminds me when I tested on a ThinkPad with=
 an IGD
device. I removed the check for IGD devices in favour of a working IGD =
driver.

Attached patch might help you (with acpi_backlight=3Dvendor)?
You should be able to apply this on my latest patchset, but use this pa=
tch
instead of the thinkpad_acpi one.

> Cat'ing /proc/acpi/events still gives:
> video LCD0 00000086 00000000
> video LCD0 00000087 00000000
>
> At one time I get the 750ms delay, but I don't have the
> ibm/hotkey HKEY 00000080 00005010 at all.
Hmm, on my machine it was 1010 and 1011 key event values for up/down
brightness. If you do not see those, the patch might not work.

> In X, same thing, no brightness keys, but xbacklight does work in
> standard mode (=E2=80=9Ckernel=E2=80=9D).
>
> (btw it seems my mails don't reach linux-acpi, I don't really know wh=
y
> and postmaster don't answer, maybe they didn't have my mail either).

I expect you have an IGD device and this should by default be served by
Matthew's/Hong's patches. Matthew said something about a needed peace
that came in in latest BIOSes? But I expect you already run on the late=
st?
If not, you should update.

        Thomas



diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 85c3d2c..c9ed761 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -93,6 +93,11 @@ long acpi_is_video_device(struct acpi_device *device=
)
 	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_SPD", &h_dummy)))
 		video_caps |=3D ACPI_VIDEO_DEVICE_POSTING;
=20
+	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "DRDY", &h_dummy))) =
{
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found IGD device\n"));
+		video_caps |=3D ACPI_VIDEO_IGD;
+	}
+
 	/* Only check for backlight functionality if one of the above hit. */
 	if (video_caps)
 		acpi_walk_namespace(ACPI_TYPE_DEVICE, device->handle,
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.=
c
index d3eb790..c68c6b1 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -240,6 +240,7 @@ static struct {
 	u32 light_status:1;
 	u32 bright_16levels:1;
 	u32 bright_acpimode:1;
+	u32 bright_igdmode:1;
 	u32 wan:1;
 	u32 fan_ctrl_status_undef:1;
 	u32 input_device_registered:1;
@@ -2353,6 +2354,9 @@ err_exit:
 	return (res < 0)? res : 1;
 }
=20
+static struct backlight_device *ibm_backlight_device;
+static int brightness_update_status(struct backlight_device *bd);
+
 static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 {
 	u32 hkey;
@@ -2391,6 +2395,28 @@ static void hotkey_notify(struct ibm_struct *ibm=
, u32 event)
 		case 1:
 			/* 0x1000-0x1FFF: key presses */
 			scancode =3D hkey & 0xfff;
+			if (tp_features.bright_igdmode) {
+				/* ToDo:
+				 * Is there an already defined key?
+				 */
+				if (hkey =3D=3D 0x1011) {
+					if (ibm_backlight_device->
+					    props.brightness > 0) {
+						ibm_backlight_device->
+							props.brightness--;
+					}
+				} else if (hkey =3D=3D 0x1010) {
+					if (ibm_backlight_device->
+					    props.brightness <
+					    ibm_backlight_device->
+					    props.max_brightness) {
+						ibm_backlight_device->
+							props.brightness++;
+					}
+				}
+				brightness_update_status(ibm_backlight_device);
+			}
+
 			if (scancode > 0 && scancode < 0x21) {
 				scancode--;
 				if (!(hotkey_source_mask & (1 << scancode))) {
@@ -4771,7 +4797,6 @@ enum {
 	TP_EC_BACKLIGHT_MAPSW =3D 0x20,
 };
=20
-static struct backlight_device *ibm_backlight_device;
 static int brightness_mode;
 static unsigned int brightness_enable =3D 2; /* 2 =3D auto, 0 =3D no, =
1 =3D yes */
=20
@@ -4910,7 +4935,7 @@ static struct backlight_ops ibm_backlight_data =3D=
 {
 static int __init brightness_init(struct ibm_init_struct *iibm)
 {
 	int b;
-
+	long acpi_video_support;
 	vdbg_printk(TPACPI_DBG_INIT, "initializing brightness subdriver\n");
=20
 	mutex_init(&brightness_mutex);
@@ -4922,17 +4947,43 @@ static int __init brightness_init(struct ibm_in=
it_struct *iibm)
 	 */
 	b =3D tpacpi_check_std_acpi_brightness_support();
 	if (b > 0) {
-		if (thinkpad_id.vendor =3D=3D PCI_VENDOR_ID_LENOVO) {
-			printk(TPACPI_NOTICE
-			       "Lenovo BIOS switched to ACPI backlight "
-			       "control mode\n");
-		}
-		if (brightness_enable > 1) {
-			printk(TPACPI_NOTICE
-			       "standard ACPI backlight interface "
-			       "available, not loading native one...\n");
-			return 1;
-		}
+
+		if (acpi_video_backlight_support()) {
+			if (brightness_enable > 1) {
+				printk(TPACPI_NOTICE
+				       "standard ACPI backlight interface "
+				       "available, not loading native one.\n");
+				return 1;
+			} else if (brightness_enable =3D=3D 1) {
+				printk(TPACPI_NOTICE
+				       "Backlight control force, even standard "
+				       "ACPI backlight interface available\n");
+			}
+		} else {
+			if (brightness_enable > 1) {
+				printk(TPACPI_NOTICE
+				       "Standard ACPI backlight interface "
+				       "available, but thinkpad_acpi driver "
+				       "will take over control\n");
+			}
+			/* We have an Integrated Graphics Device and BIOS
+			 * won't switch. By default the IGD driver should take
+			 * care about backlight and display output switching.
+			 * People can still run into this code path and let
+			 * thinkpad_acpi take over control by passing:
+			 * acpi_backlight=3Dvendor or acpi_display_output=3Dvendor
+			 * boot params.
+			 */
+			acpi_video_support =3D acpi_video_get_capabilities(NULL);
+			vdbg_printk(TPACPI_DBG_INIT, "XXXXXk\n");
+
+			if (acpi_video_support & ACPI_VIDEO_IGD) {
+				vdbg_printk(TPACPI_DBG_INIT, "IGD device"
+					    " detected - take over backlight"
+					    " switching\n");
+				tp_features.bright_igdmode =3D 1;
+			}
+ 		}
 	}
=20
 	if (!brightness_enable) {
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index eb51726..cd012a3 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -214,6 +214,7 @@ extern bool wmi_has_guid(const char *guid);
 #define ACPI_VIDEO_BACKLIGHT_DMI_VIDEO			0x0200
 #define ACPI_VIDEO_OUTPUT_SWITCHING_DMI_VENDOR		0x0400
 #define ACPI_VIDEO_OUTPUT_SWITCHING_DMI_VIDEO		0x0800
+#define ACPI_VIDEO_IGD					0x1000
=20
 #if defined(CONFIG_ACPI_VIDEO) || defined(CONFIG_ACPI_VIDEO_MODULE)
=20
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
