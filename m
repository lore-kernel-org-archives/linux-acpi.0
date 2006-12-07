From: "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>
Subject: RE: 2.6.19: ACPI reports AC not present after resume from STD
Date: Thu, 7 Dec 2006 21:57:27 +0300
Message-ID: <E3C0BCA40296C347AF7142161DB9FC828618B8@mssmsx411>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C71A31.8A8661CF"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12783 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163208AbWLGTHF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Dec 2006 14:07:05 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-acpi@vger.kernel.org, "Lebedev, Vladimir P" <vladimir.p.lebedev@intel.com>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C71A31.8A8661CF
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Unfortunately, I cannot reproduce this bug on my system, but the problem
could be solved by adding a resume handler for AC adapter device. Could
you try the attached patch to see if it helps.

Regards.
Konstantin.
>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>owner@vger.kernel.org] On Behalf Of Andrey Borzenkov
>Sent: Sunday, December 03, 2006 7:01 PM
>To: Alexey Starikovskiy
>Cc: Pavel Machek; linux-acpi@vger.kernel.org;
linux-kernel@vger.kernel.org
>Subject: Re: 2.6.19: ACPI reports AC not present after resume from STD
>
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>On Sunday 03 December 2006 17:35, Alexey Starikovskiy wrote:
>> Andrey Borzenkov wrote:
>> > -----BEGIN PGP SIGNED MESSAGE-----
>> > Hash: SHA1
>> >
>> > On Sunday 03 December 2006 16:11, Pavel Machek wrote:
>> >> Hi!
>> >>
>> >>> I started to notice it some time ago; I can't say exactly if this
was
>> >>> not present in earlier versions because recently I switched from
STR
>> >>> (which gave me no end of troubles) to STD. So I may have not seen
it
>> >>> before.
>> >>>
>> >>> Suspend to disk while on battery. Plug in AC, resume. ACPI
continues
>to
>> >>> show AC adapter as not present:
>> >>>
>> >>> {pts/0}% cat /proc/acpi/ac_adapter/ADP1/state
>> >>> state:                   off-line
>> >>>
>> >>> replugging AC correctly changes state to on-line.
>> >>
>> >> try echo platform > /sys/power/disk.
>> >
>> > Nope.
>> >
>> > {pts/0}% pmsuspend disk
>> > ... after resume
>> > {pts/0}% cat /sys/power/disk
>> > platform
>> > {pts/0}% cat /proc/acpi/ac_adapter/ADP1/state
>> > state:                   off-line
>>
>> please look if patches in 7122 work  for you.
>
>No. I applied patches from comments 38 and 52 (modified, it did not
apply
>cleanly to 2.6.19). As far as I understood, those two were final.
>-----BEGIN PGP SIGNATURE-----
>Version: GnuPG v1.4.5 (GNU/Linux)
>
>iD8DBQFFcvS3R6LMutpd94wRAp9oAKCM7+6G4SsgFEGLgkW1jxM3VMQHqQCdFSDQ
>14w+QsgDtxWusmfdzCMOdqo=3D
>=3DQDyt
>-----END PGP SIGNATURE-----
>-
>To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

------_=_NextPart_001_01C71A31.8A8661CF
Content-Type: application/octet-stream;
	name="ac_resume.patch"
Content-Transfer-Encoding: base64
Content-Description: ac_resume.patch
Content-Disposition: attachment;
	filename="ac_resume.patch"

SW5kZXg6IGxpbnV4LTIuNi9kcml2ZXJzL2FjcGkvYWMuYwo9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC0y
LjYub3JpZy9kcml2ZXJzL2FjcGkvYWMuYwkyMDA2LTA5LTIwIDA3OjQyOjA2LjAwMDAwMDAwMCAr
MDQwMAorKysgbGludXgtMi42L2RyaXZlcnMvYWNwaS9hYy5jCTIwMDYtMTItMDcgMjI6NTI6MDAu
MDAwMDAwMDAwICswMzAwCkBAIC01NSw2ICs1NSw3IEBACiAKIHN0YXRpYyBpbnQgYWNwaV9hY19h
ZGQoc3RydWN0IGFjcGlfZGV2aWNlICpkZXZpY2UpOwogc3RhdGljIGludCBhY3BpX2FjX3JlbW92
ZShzdHJ1Y3QgYWNwaV9kZXZpY2UgKmRldmljZSwgaW50IHR5cGUpOworc3RhdGljIGludCBhY3Bp
X2FjX3Jlc3VtZShzdHJ1Y3QgYWNwaV9kZXZpY2UgKmRldmljZSwgaW50IHN0YXRlKTsKIHN0YXRp
YyBpbnQgYWNwaV9hY19vcGVuX2ZzKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpm
aWxlKTsKIAogc3RhdGljIHN0cnVjdCBhY3BpX2RyaXZlciBhY3BpX2FjX2RyaXZlciA9IHsKQEAg
LTY0LDYgKzY1LDcgQEAKIAkub3BzID0gewogCQkuYWRkID0gYWNwaV9hY19hZGQsCiAJCS5yZW1v
dmUgPSBhY3BpX2FjX3JlbW92ZSwKKwkJLnJlc3VtZSA9IGFjcGlfYWNfcmVzdW1lLAogCQl9LAog
fTsKIApAQCAtMjgxLDYgKzI4MywyMiBAQAogCXJldHVybiAwOwogfQogCitzdGF0aWMgaW50IGFj
cGlfYWNfcmVzdW1lKHN0cnVjdCBhY3BpX2RldmljZSAqZGV2aWNlLCBpbnQgc3RhdGUpCit7CisJ
aW50IHJlc3VsdCA9IDA7CisJc3RydWN0IGFjcGlfYWMgKmFjID0gTlVMTDsKKworCisJaWYgKCFk
ZXZpY2UgfHwgIWFjcGlfZHJpdmVyX2RhdGEoZGV2aWNlKSkKKwkJcmV0dXJuIC1FSU5WQUw7CisK
KwlhYyA9IChzdHJ1Y3QgYWNwaV9hYyAqKWFjcGlfZHJpdmVyX2RhdGEoZGV2aWNlKTsKKworCXJl
c3VsdCA9IGFjcGlfYWNfZ2V0X3N0YXRlKGFjKTsKKworCXJldHVybiAocmVzdWx0KTsKK30KKwog
c3RhdGljIGludCBfX2luaXQgYWNwaV9hY19pbml0KHZvaWQpCiB7CiAJaW50IHJlc3VsdDsK

------_=_NextPart_001_01C71A31.8A8661CF--
