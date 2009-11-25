From: Andrew Lutomirski <luto@mit.edu>
Subject: Re: [PATCH] Set osi=Linux for the ThinkPad X200s
Date: Wed, 25 Nov 2009 14:01:36 -0500
Message-ID: <cb0375e10911251101g5bcd189dh2413432822bdac7d@mail.gmail.com>
References: <cb0375e10911090847n4880f048ga0ef68bf41f968c9@mail.gmail.com>
	 <alpine.LFD.2.00.0911242347030.4058@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001517448474198d13047936b0c2
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:64036 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758796AbZKYTBb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Nov 2009 14:01:31 -0500
Received: by fxm5 with SMTP id 5so14014fxm.28
        for <linux-acpi@vger.kernel.org>; Wed, 25 Nov 2009 11:01:36 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0911242347030.4058@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: jerone.young@canonical.com, linux-thinkpad@linux-thinkpad.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

--001517448474198d13047936b0c2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2009 at 11:50 PM, Len Brown <lenb@kernel.org> wrote:
> On Mon, 9 Nov 2009, Andrew Lutomirski wrote:
>
>> The ThinkPad X200s, like the X61, requires OSI=3DLinux for the mute
>> button to work. =A0Without this patch (or the equivalent command-line
>> parameter), the mute button does not generate a keystroke and,
>> instead, messes up the sound hardware.
>>
>> Tested on an X200s.
>>
>> Signed-off-by: Andy Lutomirski <luto@mit.edu>
>
> I just applied the analogous T400/T500 patch from
> http://bugzilla.kernel.org/show_bug.cgi?id=3D13934
>
> and I'd apply this one too if it were not malformed.

I'll try again.  I've also attached a file containing exactly the same
thing as below (other than the '---') in case my mailer is having
problems.  I just checked that the patch still applies to Linus' tree.

--Andy

The ThinkPad X200s, like the X61, requires OSI=3DLinux for the mute
button to work.  Without this patch (or the equivalent command-line
parameter), the mute button does not generate a keystroke and,
instead, messes up the sound hardware.

Tested on an X200s.

Signed-off-by: Andy Lutomirski <luto@mit.edu>

---

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index e56b2a7..ea9f88b 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -224,6 +224,7 @@ static struct dmi_system_id acpi_osi_dmi_table[]
__initdata =3D {
 	 * _OSI(Linux) helps sound
 	 * DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad R61"),
 	 * DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T61"),
+	 * DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X200s"),
 	 * _OSI(Linux) has Linux specific hooks
 	 * DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X61"),
 	 * _OSI(Linux) is a NOP:
@@ -254,6 +255,14 @@ static struct dmi_system_id acpi_osi_dmi_table[]
__initdata =3D {
 		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X61"),
 		},
 	},
+	{
+	.callback =3D dmi_enable_osi_linux,
+	.ident =3D "Lenovo X200s",
+	.matches =3D {
+		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X200s"),
+		},
+	},
 	{}
 };

--001517448474198d13047936b0c2
Content-Type: application/octet-stream; name="acpi_x200s.patch"
Content-Disposition: attachment; filename="acpi_x200s.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g2ggjkwm0

VGhlIFRoaW5rUGFkIFgyMDBzLCBsaWtlIHRoZSBYNjEsIHJlcXVpcmVzIE9TST1MaW51eCBmb3Ig
dGhlIG11dGUKYnV0dG9uIHRvIHdvcmsuICBXaXRob3V0IHRoaXMgcGF0Y2ggKG9yIHRoZSBlcXVp
dmFsZW50IGNvbW1hbmQtbGluZQpwYXJhbWV0ZXIpLCB0aGUgbXV0ZSBidXR0b24gZG9lcyBub3Qg
Z2VuZXJhdGUgYSBrZXlzdHJva2UgYW5kLAppbnN0ZWFkLCBtZXNzZXMgdXAgdGhlIHNvdW5kIGhh
cmR3YXJlLgoKVGVzdGVkIG9uIGFuIFgyMDBzLgoKU2lnbmVkLW9mZi1ieTogQW5keSBMdXRvbWly
c2tpIDxsdXRvQG1pdC5lZHU+CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2JsYWNrbGlzdC5j
IGIvZHJpdmVycy9hY3BpL2JsYWNrbGlzdC5jCmluZGV4IGU1NmIyYTcuLmVhOWY4OGIgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvYWNwaS9ibGFja2xpc3QuYworKysgYi9kcml2ZXJzL2FjcGkvYmxhY2ts
aXN0LmMKQEAgLTIyNCw2ICsyMjQsNyBAQCBzdGF0aWMgc3RydWN0IGRtaV9zeXN0ZW1faWQgYWNw
aV9vc2lfZG1pX3RhYmxlW10gX19pbml0ZGF0YSA9IHsKIAkgKiBfT1NJKExpbnV4KSBoZWxwcyBz
b3VuZAogCSAqIERNSV9NQVRDSChETUlfUFJPRFVDVF9WRVJTSU9OLCAiVGhpbmtQYWQgUjYxIiks
CiAJICogRE1JX01BVENIKERNSV9QUk9EVUNUX1ZFUlNJT04sICJUaGlua1BhZCBUNjEiKSwKKwkg
KiBETUlfTUFUQ0goRE1JX1BST0RVQ1RfVkVSU0lPTiwgIlRoaW5rUGFkIFgyMDBzIiksCiAJICog
X09TSShMaW51eCkgaGFzIExpbnV4IHNwZWNpZmljIGhvb2tzCiAJICogRE1JX01BVENIKERNSV9Q
Uk9EVUNUX1ZFUlNJT04sICJUaGlua1BhZCBYNjEiKSwKIAkgKiBfT1NJKExpbnV4KSBpcyBhIE5P
UDoKQEAgLTI1NCw2ICsyNTUsMTQgQEAgc3RhdGljIHN0cnVjdCBkbWlfc3lzdGVtX2lkIGFjcGlf
b3NpX2RtaV90YWJsZVtdIF9faW5pdGRhdGEgPSB7CiAJCSAgICAgRE1JX01BVENIKERNSV9QUk9E
VUNUX1ZFUlNJT04sICJUaGlua1BhZCBYNjEiKSwKIAkJfSwKIAl9LAorCXsKKwkuY2FsbGJhY2sg
PSBkbWlfZW5hYmxlX29zaV9saW51eCwKKwkuaWRlbnQgPSAiTGVub3ZvIFgyMDBzIiwKKwkubWF0
Y2hlcyA9IHsKKwkJICAgICBETUlfTUFUQ0goRE1JX1NZU19WRU5ET1IsICJMRU5PVk8iKSwKKwkJ
ICAgICBETUlfTUFUQ0goRE1JX1BST0RVQ1RfVkVSU0lPTiwgIlRoaW5rUGFkIFgyMDBzIiksCisJ
CX0sCisJfSwKIAl7fQogfTsKIAo=
--001517448474198d13047936b0c2--
