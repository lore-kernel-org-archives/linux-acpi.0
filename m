From: "Luming Yu" <luming.yu@gmail.com>
Subject: [patch] ACPI video driver output switch sysfs support
Date: Tue, 13 Mar 2007 13:31:03 +0800
Message-ID: <3877989d0703122231v7bb04f03ydf4c1de03040085f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_18911_10559671.1173763863097"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:36355 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994AbXCMFbF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Mar 2007 01:31:05 -0400
Received: by ug-out-1314.google.com with SMTP id 44so137985uga
        for <linux-acpi@vger.kernel.org>; Mon, 12 Mar 2007 22:31:04 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

------=_Part_18911_10559671.1173763863097
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Add output switch sysfs class support for ACPI video driver.

signed-off-by: Luming Yu <Luming.yu@intel.com>
---
 drivers/acpi/Kconfig     |    2 +-
 drivers/acpi/video.c     |   38 ++++++++++++++++++++++++++++++++++++++
 drivers/video/Kconfig    |    7 +++++++
 drivers/video/Makefile   |    3 +++
 include/acpi/processor.h |    0
 5 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index e2ce4a9..7d1627b 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -124,7 +124,7 @@ config ACPI_BUTTON

 config ACPI_VIDEO
        tristate "Video"
-       depends on X86 && BACKLIGHT_CLASS_DEVICE
+       depends on X86 && BACKLIGHT_CLASS_DEVICE && VIDEO_OUTPUT_CONTROL
        help
          This driver implement the ACPI Extensions For Display Adapters
          for integrated graphics devices on motherboard, as specified in
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 00d25b3..3456603 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -33,6 +33,7 @@ #include <linux/proc_fs.h>
 #include <linux/seq_file.h>

 #include <linux/backlight.h>
+#include <linux/video_output.h>
 #include <asm/uaccess.h>

 #include <acpi/acpi_bus.h>
@@ -169,6 +170,7 @@ struct acpi_video_device {
        struct acpi_device *dev;
        struct acpi_video_device_brightness *brightness;
        struct backlight_device *backlight;
+       struct output_device *output_dev;
 };

 /* bus */
@@ -297,6 +299,28 @@ static struct backlight_ops acpi_backlig
        .update_status  = acpi_video_set_brightness,
 };

+/*video output device sysfs support*/
+static int acpi_video_output_get(struct output_device *od)
+{
+       unsigned long state;
+       struct acpi_video_device *vd =
+               (struct acpi_video_device *)class_get_devdata(&od->class_dev);
+       acpi_video_device_get_state(vd,&state);
+       return (int)state;
+}
+
+static int acpi_video_output_set(struct output_device *od)
+{
+       unsigned long state = od->request_state;
+       struct acpi_video_device *vd=
+               (struct acpi_video_device *)class_get_devdata(&od->class_dev);
+       return acpi_video_device_set_state(vd,state);
+}
+
+static struct output_properties acpi_output_properties = {
+       .set_state = acpi_video_output_set,
+       .get_status = acpi_video_output_get,
+};
 /* --------------------------------------------------------------------------
                                Video Management
    --------------------------------------------------------------------------
*/
@@ -626,6 +650,19 @@ static void acpi_video_device_find_cap(s

                kfree(name);
        }
+       if (device->cap._DCS && device->cap._DSS){
+               unsigned long tmp;
+               static int count = 0;
+               char *name;
+               name = kzalloc(MAX_NAME_LEN, GFP_KERNEL);
+               if (!name)
+                       return;
+               sprintf(name, "acpi_video%d", count++);
+               device->output_dev = video_output_register(name,
+                               &(data->dev->dev),
+                               device, &acpi_output_properties);
+               kfree(name);
+       }
        return;
 }

@@ -1669,6 +1706,7 @@ static int acpi_video_bus_put_one_device
                                            ACPI_DEVICE_NOTIFY,
                                            acpi_video_device_notify);
        backlight_device_unregister(device->backlight);
+       video_output_unregister(device->output_dev);
        return 0;
 }

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 7f5a598..bd76a6c 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -6,6 +6,13 @@ menu "Graphics support"

 source "drivers/video/backlight/Kconfig"

+config VIDEO_OUTPUT_CONTROL
+        tristate "Lowlevel video output switch controls"
+       default m
+       help
+         This framework adds support for low-level control of the video
+          output switch.
+
 config FB
        tristate "Support for frame buffer devices"
        ---help---
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 760305c..f5ab032 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -108,3 +108,6 @@ obj-$(CONFIG_FB_OF)               += off

 # the test framebuffer is last
 obj-$(CONFIG_FB_VIRTUAL)          += vfb.o
+
+#video output switch sysfs driver
+obj-$(CONFIG_VIDEO_OUTPUT_CONTROL) += output.o

------=_Part_18911_10559671.1173763863097
Content-Type: application/octet-stream; name=video_output.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ez7wijri
Content-Disposition: attachment; filename="video_output.patch"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9LY29uZmlnIGIvZHJpdmVycy9hY3BpL0tjb25maWcK
aW5kZXggZTJjZTRhOS4uN2QxNjI3YiAxMDA2NDQKLS0tIGEvZHJpdmVycy9hY3BpL0tjb25maWcK
KysrIGIvZHJpdmVycy9hY3BpL0tjb25maWcKQEAgLTEyNCw3ICsxMjQsNyBAQCBjb25maWcgQUNQ
SV9CVVRUT04KIAogY29uZmlnIEFDUElfVklERU8KIAl0cmlzdGF0ZSAiVmlkZW8iCi0JZGVwZW5k
cyBvbiBYODYgJiYgQkFDS0xJR0hUX0NMQVNTX0RFVklDRQorCWRlcGVuZHMgb24gWDg2ICYmIEJB
Q0tMSUdIVF9DTEFTU19ERVZJQ0UgJiYgVklERU9fT1VUUFVUX0NPTlRST0wKIAloZWxwCiAJICBU
aGlzIGRyaXZlciBpbXBsZW1lbnQgdGhlIEFDUEkgRXh0ZW5zaW9ucyBGb3IgRGlzcGxheSBBZGFw
dGVycwogCSAgZm9yIGludGVncmF0ZWQgZ3JhcGhpY3MgZGV2aWNlcyBvbiBtb3RoZXJib2FyZCwg
YXMgc3BlY2lmaWVkIGluCmRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvdmlkZW8uYyBiL2RyaXZl
cnMvYWNwaS92aWRlby5jCmluZGV4IDAwZDI1YjMuLjM0NTY2MDMgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvYWNwaS92aWRlby5jCisrKyBiL2RyaXZlcnMvYWNwaS92aWRlby5jCkBAIC0zMyw2ICszMyw3
IEBAICNpbmNsdWRlIDxsaW51eC9wcm9jX2ZzLmg+CiAjaW5jbHVkZSA8bGludXgvc2VxX2ZpbGUu
aD4KIAogI2luY2x1ZGUgPGxpbnV4L2JhY2tsaWdodC5oPgorI2luY2x1ZGUgPGxpbnV4L3ZpZGVv
X291dHB1dC5oPgogI2luY2x1ZGUgPGFzbS91YWNjZXNzLmg+CiAKICNpbmNsdWRlIDxhY3BpL2Fj
cGlfYnVzLmg+CkBAIC0xNjksNiArMTcwLDcgQEAgc3RydWN0IGFjcGlfdmlkZW9fZGV2aWNlIHsK
IAlzdHJ1Y3QgYWNwaV9kZXZpY2UgKmRldjsKIAlzdHJ1Y3QgYWNwaV92aWRlb19kZXZpY2VfYnJp
Z2h0bmVzcyAqYnJpZ2h0bmVzczsKIAlzdHJ1Y3QgYmFja2xpZ2h0X2RldmljZSAqYmFja2xpZ2h0
OworCXN0cnVjdCBvdXRwdXRfZGV2aWNlICpvdXRwdXRfZGV2OwogfTsKIAogLyogYnVzICovCkBA
IC0yOTcsNiArMjk5LDI4IEBAIHN0YXRpYyBzdHJ1Y3QgYmFja2xpZ2h0X29wcyBhY3BpX2JhY2ts
aWcKIAkudXBkYXRlX3N0YXR1cyAgPSBhY3BpX3ZpZGVvX3NldF9icmlnaHRuZXNzLAogfTsKIAor
Lyp2aWRlbyBvdXRwdXQgZGV2aWNlIHN5c2ZzIHN1cHBvcnQqLworc3RhdGljIGludCBhY3BpX3Zp
ZGVvX291dHB1dF9nZXQoc3RydWN0IG91dHB1dF9kZXZpY2UgKm9kKQoreworCXVuc2lnbmVkIGxv
bmcgc3RhdGU7CisJc3RydWN0IGFjcGlfdmlkZW9fZGV2aWNlICp2ZCA9CisJCShzdHJ1Y3QgYWNw
aV92aWRlb19kZXZpY2UgKiljbGFzc19nZXRfZGV2ZGF0YSgmb2QtPmNsYXNzX2Rldik7CisJYWNw
aV92aWRlb19kZXZpY2VfZ2V0X3N0YXRlKHZkLCZzdGF0ZSk7CisJcmV0dXJuIChpbnQpc3RhdGU7
Cit9CisKK3N0YXRpYyBpbnQgYWNwaV92aWRlb19vdXRwdXRfc2V0KHN0cnVjdCBvdXRwdXRfZGV2
aWNlICpvZCkKK3sKKwl1bnNpZ25lZCBsb25nIHN0YXRlID0gb2QtPnJlcXVlc3Rfc3RhdGU7CisJ
c3RydWN0IGFjcGlfdmlkZW9fZGV2aWNlICp2ZD0KKwkJKHN0cnVjdCBhY3BpX3ZpZGVvX2Rldmlj
ZSAqKWNsYXNzX2dldF9kZXZkYXRhKCZvZC0+Y2xhc3NfZGV2KTsKKwlyZXR1cm4gYWNwaV92aWRl
b19kZXZpY2Vfc2V0X3N0YXRlKHZkLHN0YXRlKTsKK30KKworc3RhdGljIHN0cnVjdCBvdXRwdXRf
cHJvcGVydGllcyBhY3BpX291dHB1dF9wcm9wZXJ0aWVzID0geworCS5zZXRfc3RhdGUgPSBhY3Bp
X3ZpZGVvX291dHB1dF9zZXQsCisJLmdldF9zdGF0dXMgPSBhY3BpX3ZpZGVvX291dHB1dF9nZXQs
Cit9OwogLyogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBWaWRlbyBNYW5hZ2VtZW50CiAgICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSAqLwpAQCAtNjI2LDYgKzY1
MCwxOSBAQCBzdGF0aWMgdm9pZCBhY3BpX3ZpZGVvX2RldmljZV9maW5kX2NhcChzCiAKIAkJa2Zy
ZWUobmFtZSk7CiAJfQorCWlmIChkZXZpY2UtPmNhcC5fRENTICYmIGRldmljZS0+Y2FwLl9EU1Mp
eworCQl1bnNpZ25lZCBsb25nIHRtcDsKKwkJc3RhdGljIGludCBjb3VudCA9IDA7CisJCWNoYXIg
Km5hbWU7CisJCW5hbWUgPSBremFsbG9jKE1BWF9OQU1FX0xFTiwgR0ZQX0tFUk5FTCk7CisJCWlm
ICghbmFtZSkKKwkJCXJldHVybjsKKwkJc3ByaW50ZihuYW1lLCAiYWNwaV92aWRlbyVkIiwgY291
bnQrKyk7CisJCWRldmljZS0+b3V0cHV0X2RldiA9IHZpZGVvX291dHB1dF9yZWdpc3RlcihuYW1l
LAorCQkJCSYoZGF0YS0+ZGV2LT5kZXYpLAorCQkJCWRldmljZSwgJmFjcGlfb3V0cHV0X3Byb3Bl
cnRpZXMpOworCQlrZnJlZShuYW1lKTsKKwl9CiAJcmV0dXJuOwogfQogCkBAIC0xNjY5LDYgKzE3
MDYsNyBAQCBzdGF0aWMgaW50IGFjcGlfdmlkZW9fYnVzX3B1dF9vbmVfZGV2aWNlCiAJCQkJCSAg
ICBBQ1BJX0RFVklDRV9OT1RJRlksCiAJCQkJCSAgICBhY3BpX3ZpZGVvX2RldmljZV9ub3RpZnkp
OwogCWJhY2tsaWdodF9kZXZpY2VfdW5yZWdpc3RlcihkZXZpY2UtPmJhY2tsaWdodCk7CisJdmlk
ZW9fb3V0cHV0X3VucmVnaXN0ZXIoZGV2aWNlLT5vdXRwdXRfZGV2KTsKIAlyZXR1cm4gMDsKIH0K
IApkaWZmIC0tZ2l0IGEvZHJpdmVycy92aWRlby9LY29uZmlnIGIvZHJpdmVycy92aWRlby9LY29u
ZmlnCmluZGV4IDdmNWE1OTguLmJkNzZhNmMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdmlkZW8vS2Nv
bmZpZworKysgYi9kcml2ZXJzL3ZpZGVvL0tjb25maWcKQEAgLTYsNiArNiwxMyBAQCBtZW51ICJH
cmFwaGljcyBzdXBwb3J0IgogCiBzb3VyY2UgImRyaXZlcnMvdmlkZW8vYmFja2xpZ2h0L0tjb25m
aWciCiAKK2NvbmZpZyBWSURFT19PVVRQVVRfQ09OVFJPTAorICAgICAgICB0cmlzdGF0ZSAiTG93
bGV2ZWwgdmlkZW8gb3V0cHV0IHN3aXRjaCBjb250cm9scyIKKwlkZWZhdWx0IG0KKwloZWxwCisJ
ICBUaGlzIGZyYW1ld29yayBhZGRzIHN1cHBvcnQgZm9yIGxvdy1sZXZlbCBjb250cm9sIG9mIHRo
ZSB2aWRlbyAKKyAgICAgICAgICBvdXRwdXQgc3dpdGNoLgorCiBjb25maWcgRkIKIAl0cmlzdGF0
ZSAiU3VwcG9ydCBmb3IgZnJhbWUgYnVmZmVyIGRldmljZXMiCiAJLS0taGVscC0tLQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy92aWRlby9NYWtlZmlsZSBiL2RyaXZlcnMvdmlkZW8vTWFrZWZpbGUKaW5k
ZXggNzYwMzA1Yy4uZjVhYjAzMiAxMDA2NDQKLS0tIGEvZHJpdmVycy92aWRlby9NYWtlZmlsZQor
KysgYi9kcml2ZXJzL3ZpZGVvL01ha2VmaWxlCkBAIC0xMDgsMyArMTA4LDYgQEAgb2JqLSQoQ09O
RklHX0ZCX09GKSAgICAgICAgICAgICAgICs9IG9mZgogCiAjIHRoZSB0ZXN0IGZyYW1lYnVmZmVy
IGlzIGxhc3QKIG9iai0kKENPTkZJR19GQl9WSVJUVUFMKSAgICAgICAgICArPSB2ZmIubworCisj
dmlkZW8gb3V0cHV0IHN3aXRjaCBzeXNmcyBkcml2ZXIKK29iai0kKENPTkZJR19WSURFT19PVVRQ
VVRfQ09OVFJPTCkgKz0gb3V0cHV0Lm8KZGlmZiAtLWdpdCBhL2luY2x1ZGUvYWNwaS9wcm9jZXNz
b3IuaCBiL2luY2x1ZGUvYWNwaS9wcm9jZXNzb3IuaAo=
------=_Part_18911_10559671.1173763863097--
