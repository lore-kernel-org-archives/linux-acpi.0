From: "Luming Yu" <luming.yu@gmail.com>
Subject: Re: [patch] ACPI video driver output switch sysfs support
Date: Wed, 9 May 2007 21:07:05 +0800
Message-ID: <3877989d0705090607m469a6f1aof3b3703fa5bd3cd7@mail.gmail.com>
References: <3877989d0703122231v7bb04f03ydf4c1de03040085f@mail.gmail.com>
	 <Pine.LNX.4.58.0703122231580.22327@shark.he.net>
	 <3877989d0704250706x57084249nc26ace98033c22d0@mail.gmail.com>
	 <20070425083111.e8c24bd4.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_93115_9530292.1178716025535"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:32657 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521AbXEINHH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 May 2007 09:07:07 -0400
Received: by nz-out-0506.google.com with SMTP id o1so181583nzf
        for <linux-acpi@vger.kernel.org>; Wed, 09 May 2007 06:07:06 -0700 (PDT)
In-Reply-To: <20070425083111.e8c24bd4.rdunlap@xenotime.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

------=_Part_93115_9530292.1178716025535
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

To use this patch, you need enable VIDEO_OUTPUT_CONTROL and ACPI_VIDEO.
After loading output.ko and video.ko, you would have
/sys/class/video_output and several device acpi_videoNum there. For
example, I got acpi_video0, acpi_video1,acpi_video2,and acpi_video3
under /sys/class/video_output on my T40.
I can query the status of  output device0 by running " cat
/sys/class/video_output/acpi_video0
" The return value is defined in ACPI SPEC B.5.5 _DCS(Return the
Status of Output Device).  Also you can turn off video1 and turn on
video0  by " echo 0 > acpi_video1; echo 0x80000000 > acpi_video0".
Please reference ACPI SPEC  B.5.7 _DSS for the parameter definition.
Also please note that it may or may NOT works purely depending on if
your vendor providing correct ACPI video extension support in bios.
the driver output.ko and video.ko just works like a interface to
invoke BIOS.

The update patch:

Add output switch sysfs class support for ACPI video driver.

signed-off-by: Luming Yu <Luming.yu@intel.com>
----

 acpi/Kconfig   |    2 +-
 acpi/video.c   |   40 ++++++++++++++++++++++++++++++++++++++++
 video/Kconfig  |    7 +++++++
 video/Makefile |    3 +++
 4 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 139f41f..eb4855f 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -124,7 +124,7 @@ config ACPI_BUTTON

 config ACPI_VIDEO
 	tristate "Video"
-	depends on X86 && BACKLIGHT_CLASS_DEVICE
+	depends on X86 && BACKLIGHT_CLASS_DEVICE && VIDEO_OUTPUT_CONTROL
 	help
 	  This driver implement the ACPI Extensions For Display Adapters
 	  for integrated graphics devices on motherboard, as specified in
diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 00d25b3..39273da 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -33,6 +33,7 @@
 #include <linux/seq_file.h>

 #include <linux/backlight.h>
+#include <linux/video_output.h>
 #include <asm/uaccess.h>

 #include <acpi/acpi_bus.h>
@@ -169,6 +170,7 @@ struct acpi_video_device {
 	struct acpi_device *dev;
 	struct acpi_video_device_brightness *brightness;
 	struct backlight_device *backlight;
+	struct output_device *output_dev;
 };

 /* bus */
@@ -272,6 +274,10 @@ static int acpi_video_get_next_level(struct
acpi_video_device *device,
 				     u32 level_current, u32 event);
 static void acpi_video_switch_brightness(struct acpi_video_device *device,
 					 int event);
+static int acpi_video_device_get_state(struct acpi_video_device *device,
+			    unsigned long *state);
+static int acpi_video_output_get(struct output_device *od);
+static int acpi_video_device_set_state(struct acpi_video_device
*device, int state);

 /*backlight device sysfs support*/
 static int acpi_video_get_brightness(struct backlight_device *bd)
@@ -297,6 +303,28 @@ static struct backlight_ops acpi_backlight_ops = {
 	.update_status  = acpi_video_set_brightness,
 };

+/*video output device sysfs support*/
+static int acpi_video_output_get(struct output_device *od)
+{
+	unsigned long state;
+	struct acpi_video_device *vd =
+		(struct acpi_video_device *)class_get_devdata(&od->class_dev);
+	acpi_video_device_get_state(vd, &state);
+	return (int)state;
+}
+
+static int acpi_video_output_set(struct output_device *od)
+{
+	unsigned long state = od->request_state;
+	struct acpi_video_device *vd=
+		(struct acpi_video_device *)class_get_devdata(&od->class_dev);
+	return acpi_video_device_set_state(vd, state);
+}
+
+static struct output_properties acpi_output_properties = {
+	.set_state = acpi_video_output_set,
+	.get_status = acpi_video_output_get,
+};
 /* --------------------------------------------------------------------------
                                Video Management
    --------------------------------------------------------------------------
*/
@@ -626,6 +654,17 @@ static void acpi_video_device_find_cap(struct
acpi_video_device *device)

 		kfree(name);
 	}
+	if (device->cap._DCS && device->cap._DSS){
+		static int count = 0;
+		char *name;
+		name = kzalloc(MAX_NAME_LEN, GFP_KERNEL);
+		if (!name)
+			return;
+		sprintf(name, "acpi_video%d", count++);
+		device->output_dev = video_output_register(name,
+				NULL, device, &acpi_output_properties);
+		kfree(name);
+	}
 	return;
 }

@@ -1669,6 +1708,7 @@ static int acpi_video_bus_put_one_device(struct
acpi_video_device *device)
 					    ACPI_DEVICE_NOTIFY,
 					    acpi_video_device_notify);
 	backlight_device_unregister(device->backlight);
+	video_output_unregister(device->output_dev);
 	return 0;
 }

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 8372ace..e96caa9 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -6,6 +6,13 @@ menu "Graphics support"

 source "drivers/video/backlight/Kconfig"

+config VIDEO_OUTPUT_CONTROL
+	tristate "Lowlevel video output switch controls"
+	default m
+	help
+	  This framework adds support for low-level control of the video
+	  output switch.
+
 config FB
 	tristate "Support for frame buffer devices"
 	---help---
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 760305c..f5ab032 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -108,3 +108,6 @@ obj-$(CONFIG_FB_OF)               += offb.o

 # the test framebuffer is last
 obj-$(CONFIG_FB_VIRTUAL)          += vfb.o
+
+#video output switch sysfs driver
+obj-$(CONFIG_VIDEO_OUTPUT_CONTROL) += output.o


On 4/25/07, Randy Dunlap <rdunlap@xenotime.net> wrote:
> On Wed, 25 Apr 2007 22:06:56 +0800 Luming Yu wrote:
>
> > The update patch:
> >
> > Add output switch sysfs class support for ACPI video driver.
> >
> > signed-off-by: Luming Yu <Luming.yu@intel.com>
> > ---
> >  acpi/Kconfig   |    2 +-
> >  acpi/video.c   |   40 ++++++++++++++++++++++++++++++++++++++++
> >  video/Kconfig  |    7 +++++++
> >  video/Makefile |    3 +++
> >  4 files changed, 51 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > index 8372ace..8f2c02b 100644
> > --- a/drivers/video/Kconfig
> > +++ b/drivers/video/Kconfig
> > @@ -6,6 +6,13 @@ menu "Graphics support"
> >
> >  source "drivers/video/backlight/Kconfig"
> >
> > +config VIDEO_OUTPUT_CONTROL
> > +     tristate "Lowlevel video output switch controls"
> > +     default m
> > +     help
> > +     This framework adds support for low-level control of the video
> > +     output switch.
>
> Please indent the 2 lines of help text (only)
> with <tab><space><space>.
>
> From Documentation/CodingStyle:
> Help text is indented with 2 spaces.
>
> (meaning 2 spaces more than the word "help" :)
>
> > +
> >  config FB
> >       tristate "Support for frame buffer devices"
> >       ---help---
>
>
> ---
> ~Randy
> *** Remember to use Documentation/SubmitChecklist when testing your code ***
>

------=_Part_93115_9530292.1178716025535
Content-Type: text/x-patch; name=video_output.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f1hsdifx
Content-Disposition: attachment; filename="video_output.patch"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9LY29uZmlnIGIvZHJpdmVycy9hY3BpL0tjb25maWcK
aW5kZXggMTM5ZjQxZi4uZWI0ODU1ZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9hY3BpL0tjb25maWcK
KysrIGIvZHJpdmVycy9hY3BpL0tjb25maWcKQEAgLTEyNCw3ICsxMjQsNyBAQCBjb25maWcgQUNQ
SV9CVVRUT04KIAogY29uZmlnIEFDUElfVklERU8KIAl0cmlzdGF0ZSAiVmlkZW8iCi0JZGVwZW5k
cyBvbiBYODYgJiYgQkFDS0xJR0hUX0NMQVNTX0RFVklDRQorCWRlcGVuZHMgb24gWDg2ICYmIEJB
Q0tMSUdIVF9DTEFTU19ERVZJQ0UgJiYgVklERU9fT1VUUFVUX0NPTlRST0wKIAloZWxwCiAJICBU
aGlzIGRyaXZlciBpbXBsZW1lbnQgdGhlIEFDUEkgRXh0ZW5zaW9ucyBGb3IgRGlzcGxheSBBZGFw
dGVycwogCSAgZm9yIGludGVncmF0ZWQgZ3JhcGhpY3MgZGV2aWNlcyBvbiBtb3RoZXJib2FyZCwg
YXMgc3BlY2lmaWVkIGluCmRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvc2xlZXAvbWFpbi5jIGIv
ZHJpdmVycy9hY3BpL3NsZWVwL21haW4uYwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL3ZpZGVv
LmMgYi9kcml2ZXJzL2FjcGkvdmlkZW8uYwppbmRleCAwMGQyNWIzLi4zOTI3M2RhIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2FjcGkvdmlkZW8uYworKysgYi9kcml2ZXJzL2FjcGkvdmlkZW8uYwpAQCAt
MzMsNiArMzMsNyBAQAogI2luY2x1ZGUgPGxpbnV4L3NlcV9maWxlLmg+CiAKICNpbmNsdWRlIDxs
aW51eC9iYWNrbGlnaHQuaD4KKyNpbmNsdWRlIDxsaW51eC92aWRlb19vdXRwdXQuaD4KICNpbmNs
dWRlIDxhc20vdWFjY2Vzcy5oPgogCiAjaW5jbHVkZSA8YWNwaS9hY3BpX2J1cy5oPgpAQCAtMTY5
LDYgKzE3MCw3IEBAIHN0cnVjdCBhY3BpX3ZpZGVvX2RldmljZSB7CiAJc3RydWN0IGFjcGlfZGV2
aWNlICpkZXY7CiAJc3RydWN0IGFjcGlfdmlkZW9fZGV2aWNlX2JyaWdodG5lc3MgKmJyaWdodG5l
c3M7CiAJc3RydWN0IGJhY2tsaWdodF9kZXZpY2UgKmJhY2tsaWdodDsKKwlzdHJ1Y3Qgb3V0cHV0
X2RldmljZSAqb3V0cHV0X2RldjsKIH07CiAKIC8qIGJ1cyAqLwpAQCAtMjcyLDYgKzI3NCwxMCBA
QCBzdGF0aWMgaW50IGFjcGlfdmlkZW9fZ2V0X25leHRfbGV2ZWwoc3RydWN0IGFjcGlfdmlkZW9f
ZGV2aWNlICpkZXZpY2UsCiAJCQkJICAgICB1MzIgbGV2ZWxfY3VycmVudCwgdTMyIGV2ZW50KTsK
IHN0YXRpYyB2b2lkIGFjcGlfdmlkZW9fc3dpdGNoX2JyaWdodG5lc3Moc3RydWN0IGFjcGlfdmlk
ZW9fZGV2aWNlICpkZXZpY2UsCiAJCQkJCSBpbnQgZXZlbnQpOworc3RhdGljIGludCBhY3BpX3Zp
ZGVvX2RldmljZV9nZXRfc3RhdGUoc3RydWN0IGFjcGlfdmlkZW9fZGV2aWNlICpkZXZpY2UsCisJ
CQkgICAgdW5zaWduZWQgbG9uZyAqc3RhdGUpOworc3RhdGljIGludCBhY3BpX3ZpZGVvX291dHB1
dF9nZXQoc3RydWN0IG91dHB1dF9kZXZpY2UgKm9kKTsKK3N0YXRpYyBpbnQgYWNwaV92aWRlb19k
ZXZpY2Vfc2V0X3N0YXRlKHN0cnVjdCBhY3BpX3ZpZGVvX2RldmljZSAqZGV2aWNlLCBpbnQgc3Rh
dGUpOwogCiAvKmJhY2tsaWdodCBkZXZpY2Ugc3lzZnMgc3VwcG9ydCovCiBzdGF0aWMgaW50IGFj
cGlfdmlkZW9fZ2V0X2JyaWdodG5lc3Moc3RydWN0IGJhY2tsaWdodF9kZXZpY2UgKmJkKQpAQCAt
Mjk3LDYgKzMwMywyOCBAQCBzdGF0aWMgc3RydWN0IGJhY2tsaWdodF9vcHMgYWNwaV9iYWNrbGln
aHRfb3BzID0gewogCS51cGRhdGVfc3RhdHVzICA9IGFjcGlfdmlkZW9fc2V0X2JyaWdodG5lc3Ms
CiB9OwogCisvKnZpZGVvIG91dHB1dCBkZXZpY2Ugc3lzZnMgc3VwcG9ydCovCitzdGF0aWMgaW50
IGFjcGlfdmlkZW9fb3V0cHV0X2dldChzdHJ1Y3Qgb3V0cHV0X2RldmljZSAqb2QpCit7CisJdW5z
aWduZWQgbG9uZyBzdGF0ZTsKKwlzdHJ1Y3QgYWNwaV92aWRlb19kZXZpY2UgKnZkID0KKwkJKHN0
cnVjdCBhY3BpX3ZpZGVvX2RldmljZSAqKWNsYXNzX2dldF9kZXZkYXRhKCZvZC0+Y2xhc3NfZGV2
KTsKKwlhY3BpX3ZpZGVvX2RldmljZV9nZXRfc3RhdGUodmQsICZzdGF0ZSk7CisJcmV0dXJuIChp
bnQpc3RhdGU7Cit9CisKK3N0YXRpYyBpbnQgYWNwaV92aWRlb19vdXRwdXRfc2V0KHN0cnVjdCBv
dXRwdXRfZGV2aWNlICpvZCkKK3sKKwl1bnNpZ25lZCBsb25nIHN0YXRlID0gb2QtPnJlcXVlc3Rf
c3RhdGU7CisJc3RydWN0IGFjcGlfdmlkZW9fZGV2aWNlICp2ZD0KKwkJKHN0cnVjdCBhY3BpX3Zp
ZGVvX2RldmljZSAqKWNsYXNzX2dldF9kZXZkYXRhKCZvZC0+Y2xhc3NfZGV2KTsKKwlyZXR1cm4g
YWNwaV92aWRlb19kZXZpY2Vfc2V0X3N0YXRlKHZkLCBzdGF0ZSk7Cit9CisKK3N0YXRpYyBzdHJ1
Y3Qgb3V0cHV0X3Byb3BlcnRpZXMgYWNwaV9vdXRwdXRfcHJvcGVydGllcyA9IHsKKwkuc2V0X3N0
YXRlID0gYWNwaV92aWRlb19vdXRwdXRfc2V0LAorCS5nZXRfc3RhdHVzID0gYWNwaV92aWRlb19v
dXRwdXRfZ2V0LAorfTsKIC8qIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgVmlkZW8gTWFuYWdlbWVudAogICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gKi8KQEAg
LTYyNiw2ICs2NTQsMTcgQEAgc3RhdGljIHZvaWQgYWNwaV92aWRlb19kZXZpY2VfZmluZF9jYXAo
c3RydWN0IGFjcGlfdmlkZW9fZGV2aWNlICpkZXZpY2UpCiAKIAkJa2ZyZWUobmFtZSk7CiAJfQor
CWlmIChkZXZpY2UtPmNhcC5fRENTICYmIGRldmljZS0+Y2FwLl9EU1MpeworCQlzdGF0aWMgaW50
IGNvdW50ID0gMDsKKwkJY2hhciAqbmFtZTsKKwkJbmFtZSA9IGt6YWxsb2MoTUFYX05BTUVfTEVO
LCBHRlBfS0VSTkVMKTsKKwkJaWYgKCFuYW1lKQorCQkJcmV0dXJuOworCQlzcHJpbnRmKG5hbWUs
ICJhY3BpX3ZpZGVvJWQiLCBjb3VudCsrKTsKKwkJZGV2aWNlLT5vdXRwdXRfZGV2ID0gdmlkZW9f
b3V0cHV0X3JlZ2lzdGVyKG5hbWUsCisJCQkJTlVMTCwgZGV2aWNlLCAmYWNwaV9vdXRwdXRfcHJv
cGVydGllcyk7CisJCWtmcmVlKG5hbWUpOworCX0KIAlyZXR1cm47CiB9CiAKQEAgLTE2NjksNiAr
MTcwOCw3IEBAIHN0YXRpYyBpbnQgYWNwaV92aWRlb19idXNfcHV0X29uZV9kZXZpY2Uoc3RydWN0
IGFjcGlfdmlkZW9fZGV2aWNlICpkZXZpY2UpCiAJCQkJCSAgICBBQ1BJX0RFVklDRV9OT1RJRlks
CiAJCQkJCSAgICBhY3BpX3ZpZGVvX2RldmljZV9ub3RpZnkpOwogCWJhY2tsaWdodF9kZXZpY2Vf
dW5yZWdpc3RlcihkZXZpY2UtPmJhY2tsaWdodCk7CisJdmlkZW9fb3V0cHV0X3VucmVnaXN0ZXIo
ZGV2aWNlLT5vdXRwdXRfZGV2KTsKIAlyZXR1cm4gMDsKIH0KIApkaWZmIC0tZ2l0IGEvZHJpdmVy
cy92aWRlby9LY29uZmlnIGIvZHJpdmVycy92aWRlby9LY29uZmlnCmluZGV4IDgzNzJhY2UuLmU5
NmNhYTkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdmlkZW8vS2NvbmZpZworKysgYi9kcml2ZXJzL3Zp
ZGVvL0tjb25maWcKQEAgLTYsNiArNiwxMyBAQCBtZW51ICJHcmFwaGljcyBzdXBwb3J0IgogCiBz
b3VyY2UgImRyaXZlcnMvdmlkZW8vYmFja2xpZ2h0L0tjb25maWciCiAKK2NvbmZpZyBWSURFT19P
VVRQVVRfQ09OVFJPTAorCXRyaXN0YXRlICJMb3dsZXZlbCB2aWRlbyBvdXRwdXQgc3dpdGNoIGNv
bnRyb2xzIgorCWRlZmF1bHQgbQorCWhlbHAKKwkgIFRoaXMgZnJhbWV3b3JrIGFkZHMgc3VwcG9y
dCBmb3IgbG93LWxldmVsIGNvbnRyb2wgb2YgdGhlIHZpZGVvIAorCSAgb3V0cHV0IHN3aXRjaC4K
KwogY29uZmlnIEZCCiAJdHJpc3RhdGUgIlN1cHBvcnQgZm9yIGZyYW1lIGJ1ZmZlciBkZXZpY2Vz
IgogCS0tLWhlbHAtLS0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlkZW8vTWFrZWZpbGUgYi9kcml2
ZXJzL3ZpZGVvL01ha2VmaWxlCmluZGV4IDc2MDMwNWMuLmY1YWIwMzIgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvdmlkZW8vTWFrZWZpbGUKKysrIGIvZHJpdmVycy92aWRlby9NYWtlZmlsZQpAQCAtMTA4
LDMgKzEwOCw2IEBAIG9iai0kKENPTkZJR19GQl9PRikgICAgICAgICAgICAgICArPSBvZmZiLm8K
IAogIyB0aGUgdGVzdCBmcmFtZWJ1ZmZlciBpcyBsYXN0CiBvYmotJChDT05GSUdfRkJfVklSVFVB
TCkgICAgICAgICAgKz0gdmZiLm8KKworI3ZpZGVvIG91dHB1dCBzd2l0Y2ggc3lzZnMgZHJpdmVy
CitvYmotJChDT05GSUdfVklERU9fT1VUUFVUX0NPTlRST0wpICs9IG91dHB1dC5vCg==
------=_Part_93115_9530292.1178716025535--
