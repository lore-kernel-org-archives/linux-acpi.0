From: Scott Howard <showard314@gmail.com>
Subject: [PATCH] for Bad _BQC behavior on HP laptops
Date: Sat, 13 Jun 2009 08:30:49 -0400
Message-ID: <8555910906130530y7bb92108ia46c23ec476b6b04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016364c7590c26c63046c39fe17
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:33885 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470AbZFMMas (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 Jun 2009 08:30:48 -0400
Received: by ewy6 with SMTP id 6so3712977ewy.37
        for <linux-acpi@vger.kernel.org>; Sat, 13 Jun 2009 05:30:50 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--0016364c7590c26c63046c39fe17
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello, this is the patch [1] as discussed on kernel bugzilla bug
#13511 [2]. I'm including the original comments from the patch
creator.

[1] http://bugzilla.kernel.org/attachment.cgi?id=21889
[2] http://bugzilla.kernel.org/show_bug.cgi?id=13511



Hello. On the following model
    Manufacturer: Packard Bell BV
    Product Name: EasyNote_BG45-U-001CH
BQC returns a value between 0 and 15 but the brightness levels are
between 0 and 8. I could make a table of correspondance however I find
it too inflexible. So I propose the following patch which disables BQC
if it behaves badly

-- 
Regards
Vladimir 'phcoder' Serbinenko

["bad_bqc.patch" (text/x-patch)]

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 1bdfb37..1735c34 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -594,6 +594,7 @@ acpi_video_device_lcd_get_level_current(struct
acpi_video_device *device,
                     unsigned long long *level)
 {
     acpi_status status = AE_OK;
+    int i;

     if (device->cap._BQC || device->cap._BCQ) {
         char *buf = device->cap._BQC ? "_BQC" : "_BCQ";
@@ -609,8 +610,15 @@ acpi_video_device_lcd_get_level_current(struct
acpi_video_device *device,

             }
             *level += bqc_offset_aml_bug_workaround;
-            device->brightness->curr = *level;
-            return 0;
+             for (i = 2; i < device->brightness->count; i++)
+                     if (device->brightness->levels[i] == *level) {
+                         device->brightness->curr = *level;
+                             return 0;
+                     }
+             /* BQC returned an invalid level. Stop using it.  */
+             ACPI_WARNING((AE_INFO, "%s returned an invalid level",
+                       buf));
+             device->cap._BQC = device->cap._BCQ = 0;
         } else {
             /* Fixme:
              * should we return an error or ignore this failure?

--0016364c7590c26c63046c39fe17
Content-Type: application/octet-stream; name="bad_bqc.patch"
Content-Disposition: attachment; filename="bad_bqc.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fvwb2dvh0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS92aWRlby5jIGIvZHJpdmVycy9hY3BpL3ZpZGVvLmMK
aW5kZXggMWJkZmIzNy4uMTczNWMzNCAxMDA2NDQKLS0tIGEvZHJpdmVycy9hY3BpL3ZpZGVvLmMK
KysrIGIvZHJpdmVycy9hY3BpL3ZpZGVvLmMKQEAgLTU5NCw2ICs1OTQsNyBAQCBhY3BpX3ZpZGVv
X2RldmljZV9sY2RfZ2V0X2xldmVsX2N1cnJlbnQoc3RydWN0IGFjcGlfdmlkZW9fZGV2aWNlICpk
ZXZpY2UsCiAJCQkJCXVuc2lnbmVkIGxvbmcgbG9uZyAqbGV2ZWwpCiB7CiAJYWNwaV9zdGF0dXMg
c3RhdHVzID0gQUVfT0s7CisJaW50IGk7CiAKIAlpZiAoZGV2aWNlLT5jYXAuX0JRQyB8fCBkZXZp
Y2UtPmNhcC5fQkNRKSB7CiAJCWNoYXIgKmJ1ZiA9IGRldmljZS0+Y2FwLl9CUUMgPyAiX0JRQyIg
OiAiX0JDUSI7CkBAIC02MDksOCArNjEwLDE1IEBAIGFjcGlfdmlkZW9fZGV2aWNlX2xjZF9nZXRf
bGV2ZWxfY3VycmVudChzdHJ1Y3QgYWNwaV92aWRlb19kZXZpY2UgKmRldmljZSwKIAogCQkJfQog
CQkJKmxldmVsICs9IGJxY19vZmZzZXRfYW1sX2J1Z193b3JrYXJvdW5kOwotCQkJZGV2aWNlLT5i
cmlnaHRuZXNzLT5jdXJyID0gKmxldmVsOwotCQkJcmV0dXJuIDA7CisgCQkJZm9yIChpID0gMjsg
aSA8IGRldmljZS0+YnJpZ2h0bmVzcy0+Y291bnQ7IGkrKykKKyAJCQkgICAgICAgIGlmIChkZXZp
Y2UtPmJyaWdodG5lc3MtPmxldmVsc1tpXSA9PSAqbGV2ZWwpIHsKKyAJCQkJICAgICAgICBkZXZp
Y2UtPmJyaWdodG5lc3MtPmN1cnIgPSAqbGV2ZWw7CisgCQkJICAgICAgICAgICAgICAgIHJldHVy
biAwOworIAkJCSAgICAgICAgfQorIAkJCS8qIEJRQyByZXR1cm5lZCBhbiBpbnZhbGlkIGxldmVs
LiBTdG9wIHVzaW5nIGl0LiAgKi8KKyAJCQlBQ1BJX1dBUk5JTkcoKEFFX0lORk8sICIlcyByZXR1
cm5lZCBhbiBpbnZhbGlkIGxldmVsIiwKKyAJCQkJICAgICAgYnVmKSk7CisgCQkJZGV2aWNlLT5j
YXAuX0JRQyA9IGRldmljZS0+Y2FwLl9CQ1EgPSAwOwogCQl9IGVsc2UgewogCQkJLyogRml4bWU6
CiAJCQkgKiBzaG91bGQgd2UgcmV0dXJuIGFuIGVycm9yIG9yIGlnbm9yZSB0aGlzIGZhaWx1cmU/
Cg==
--0016364c7590c26c63046c39fe17--
