From: "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Radeon PM Support
Date: Thu, 5 Aug 2004 10:52:48 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <88056F38E9E48644A0F562A38C64FB600289AE7C@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C47B15.057A310E"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: anib-La3J9u0raUk@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, stefandoesinger-RbZlAiThDcE@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C47B15.057A310E
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Does this addon patch (over the Ole's original patch) help?

This works with Radeon 9000M and frame buffer for me. This=20
should also help any other graphics drivers which doesn't
implement their own suspend resume functions.

I just hope that this video reposting won't break any of the
already working systems :).

Thanks,
Venki

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
>Alexander Bruder
>Sent: Thursday, August 05, 2004 10:15 AM
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; stefandoesinger-RbZlAiThDcE@public.gmane.org
>Subject: Re: [ACPI] Radeon PM Support
>
>Hi,
>
>> Intel's new graphics chipset probably. Owners of Acer=20
>Travelmate 60X told
>> me that the video doesn't come back. But in the these case=20
>the whole system
>> locked up on resume, so we can't tell if the video resume works.
>
>it also happends for the 80x series (in my case 801Lcib) with=20
>ATI Technologies=20
>Inc Radeon R250 Lf [Radeon Mobility 9000] using the framebuffer.=20
>"echo 3 > /proc/acpi/sleep" and "echo 4 > /proc/acpi/sleep"=20
>doesn't work=20
>because video doesn't come back as described by Stefan. The=20
>only reaction is=20
>the fan which runs like hell and doesn't stop. Same thing with=20
>pmdisk and=20
>suspend to disk ("echo -n disk > /sys/power/state"). All=20
>tested with recent=20
>kernels 2.6.7-2.6.8-rc3 .
>But with swsusp2 as the suspend to disk system  ("echo=20
>> /proc/swsusp/activate" ) on a 2.6.7 kernel the video card=20
>recovers!?!=20
>I don't know much about the whole thing and why swsusp2 can=20
>(help) recover(s)=20
>the video card but perhaps it may help you. =20
>
>
>Alexander
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by OSTG. Have you noticed the changes on
>Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
>one more big change to announce. We are now OSTG- Open Source=20
>Technology
>Group. Come see the changes on the new OSTG site. www.ostg.com
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>

------_=_NextPart_001_01C47B15.057A310E
Content-Type: application/octet-stream;
	name="videoresume-addon.patch"
Content-Transfer-Encoding: base64
Content-Description: videoresume-addon.patch
Content-Disposition: attachment;
	filename="videoresume-addon.patch"

LS0tIGxpbnV4LTIuNi43LXMzLy9kcml2ZXJzL3BjaS9wY2ktZHJpdmVyLmMub3JnCTIwMDQtMDct
MjIgMTg6NTk6NDAuNDQ2MzkyNzQ0IC0wNzAwCisrKyBsaW51eC0yLjYuNy1zMy8vZHJpdmVycy9w
Y2kvcGNpLWRyaXZlci5jCTIwMDQtMDctMjIgMTg6NTk6NTIuNDczNTY0MzM2IC0wNzAwCkBAIC0z
MzQsOCArMzM0LDEyIEBAIHN0YXRpYyBpbnQgcGNpX2RldmljZV9yZXN1bWUoc3RydWN0IGRldmkK
IAlwY2lfc2V0X3Bvd2VyX3N0YXRlKHBjaV9kZXYsIDApOwogCWlmIChkcnYgJiYgZHJ2LT5yZXN1
bWUpCiAJCWRydi0+cmVzdW1lKHBjaV9kZXYpOwotCWVsc2UKKwllbHNlIHsKIAkJcGNpX2RlZmF1
bHRfcmVzdW1lKHBjaV9kZXYpOworICAgICAgICAJLyogSWYgdmlkZW8gZGV2aWNlIGRvIGEgdmlk
ZW8gcmVwb3N0ICovCisgICAgICAgIAlpZiAoKHBjaV9kZXYtPmNsYXNzID4+IDE2KSA9PSBQQ0lf
QkFTRV9DTEFTU19ESVNQTEFZKQorICAgICAgICAgICAgICAgIAlhY3BpX3ZnYXBvc3QocGNpX2Rl
di0+ZGV2Zm4pOworCX0KIAogCiAJcmV0dXJuIDA7Cg==

------_=_NextPart_001_01C47B15.057A310E--


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
