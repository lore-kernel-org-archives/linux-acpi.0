From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: bug in acpid scripts
Date: Fri, 13 Aug 2004 08:52:02 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B44D37711ED29844BEA67908EAF36F038ADB3E@pdsmsx401.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C480CF.BFF7876F"
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
To: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Cc: russell-1vnkWVZi4QaVc3sceRu5cw@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C480CF.BFF7876F
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
Oops, I'm sorry the patch has typo. I changed the parameter name after
my test, but I forgot changing all. Could you please try this one? Sorry
for the inconvenience.

Thanks,
Shaohua

>-----Original Message-----
>From: Nathan Bryant [mailto:nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org]
>Sent: Friday, August 13, 2004 8:25 AM
>To: Li, Shaohua
>Cc: russell-1vnkWVZi4QaVc3sceRu5cw@public.gmane.org; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: [ACPI] bug in acpid scripts
>
>Li, Shaohua wrote:
>
>>Russell Neches Sunday, July 25, 2004 9:42 AM wrote:
>>
>>
>>>To: Li, Shaohua
>>>Cc: ACPI-Devel
>>>Subject: RE: [ACPI] bug in acpid scripts
>>>
>>>Neat! I'd like to help test your patch, if you wouldn't mind posting
>>>
>>>
>>it.
>>
>>
>>>Is there anything specific behavior (good or bad) you would like me
to
>>>check for?
>>>
>>>
>>Here is it. The patch is very sample. I didn't observe any side effect
>>of this patch, but maybe it must be tested widely. Could you please
try
>>it?
>>
>>
>Shaohua,
>
>My system has the same problem. Unfortunately, your patch doesn't fix
>it. Also, I had to apply the attached just to get it to build (against
>current -rc4 bitkeeper plus linux-acpi-test-2.6.8)
>
>Nathan

------_=_NextPart_001_01C480CF.BFF7876F
Content-Type: application/octet-stream;
	name="maskevent.patch"
Content-Transfer-Encoding: base64
Content-Description: maskevent.patch
Content-Disposition: attachment;
	filename="maskevent.patch"

PT09PT0gZHJpdmVycy9hY3BpL2J1cy5jIDEuNDIgdnMgZWRpdGVkID09PT09Ci0tLSAxLjQyL2Ry
aXZlcnMvYWNwaS9idXMuYwkyMDA0LTA1LTEyIDEyOjM2OjU1ICswODowMAorKysgZWRpdGVkL2Ry
aXZlcnMvYWNwaS9idXMuYwkyMDA0LTA4LTEyIDE0OjM5OjQzICswODowMApAQCAtMjgzLDYgKzI4
Myw3IEBAIExJU1RfSEVBRChhY3BpX2J1c19ldmVudF9saXN0KTsKIERFQ0xBUkVfV0FJVF9RVUVV
RV9IRUFEKGFjcGlfYnVzX2V2ZW50X3F1ZXVlKTsKIAogZXh0ZXJuIGludAkJCWV2ZW50X2lzX29w
ZW47CitleHRlcm4gaW50CQkJYWNwaV9ldmVudF9pc19tYXNrOwogCiBpbnQKIGFjcGlfYnVzX2dl
bmVyYXRlX2V2ZW50ICgKQEAgLTI5OSw3ICszMDAsNyBAQCBhY3BpX2J1c19nZW5lcmF0ZV9ldmVu
dCAoCiAJCXJldHVybl9WQUxVRSgtRUlOVkFMKTsKIAogCS8qIGRyb3AgZXZlbnQgb24gdGhlIGZs
b29yIGlmIG5vIG9uZSdzIGxpc3RlbmluZyAqLwotCWlmICghZXZlbnRfaXNfb3BlbikKKwlpZiAo
IWV2ZW50X2lzX29wZW4gfHwgYWNwaV9ldmVudF9pc19tYXNrKQogCQlyZXR1cm5fVkFMVUUoMCk7
CiAKIAlldmVudCA9IGttYWxsb2Moc2l6ZW9mKHN0cnVjdCBhY3BpX2J1c19ldmVudCksIEdGUF9B
VE9NSUMpOwo9PT09PSBkcml2ZXJzL2FjcGkvZXZlbnQuYyAxLjUgdnMgZWRpdGVkID09PT09Ci0t
LSAxLjUvZHJpdmVycy9hY3BpL2V2ZW50LmMJMjAwNC0wNS0yOSAxNzoxMjo1NSArMDg6MDAKKysr
IGVkaXRlZC9kcml2ZXJzL2FjcGkvZXZlbnQuYwkyMDA0LTA4LTEyIDE0OjQwOjEzICswODowMApA
QCAtMTcsNyArMTcsOCBAQCBBQ1BJX01PRFVMRV9OQU1FCQkoImV2ZW50IikKIAogLyogR2xvYmFs
IHZhcnMgZm9yIGhhbmRsaW5nIGV2ZW50IHByb2MgZW50cnkgKi8KIHN0YXRpYyBzcGlubG9ja190
CQlhY3BpX3N5c3RlbV9ldmVudF9sb2NrID0gU1BJTl9MT0NLX1VOTE9DS0VEOwotaW50CQkJCWV2
ZW50X2lzX29wZW4gPSAwOworaW50CQkJCWV2ZW50X2lzX29wZW47CitpbnQJCQkJYWNwaV9ldmVu
dF9pc19tYXNrOwogZXh0ZXJuIHN0cnVjdCBsaXN0X2hlYWQJCWFjcGlfYnVzX2V2ZW50X2xpc3Q7
CiBleHRlcm4gd2FpdF9xdWV1ZV9oZWFkX3QJYWNwaV9idXNfZXZlbnRfcXVldWU7CiAKPT09PT0g
ZHJpdmVycy9hY3BpL3NsZWVwL21haW4uYyAxLjM4IHZzIGVkaXRlZCA9PT09PQotLS0gMS4zOC9k
cml2ZXJzL2FjcGkvc2xlZXAvbWFpbi5jCTIwMDQtMDctMTQgMTM6Mjk6MTMgKzA4OjAwCisrKyBl
ZGl0ZWQvZHJpdmVycy9hY3BpL3NsZWVwL21haW4uYwkyMDA0LTA4LTEyIDE0OjQxOjEzICswODow
MApAQCAtNzAsNyArNzAsNyBAQCBzdGF0aWMgaW50IGFjcGlfcG1fcHJlcGFyZSh1MzIgcG1fc3Rh
dGUpCiAgKglhcmNoLXNwZWNpZmljIGFzc2VtYmx5LCB3aGljaCBpbiB0dXJuIGNhbGwgYWNwaV9l
bnRlcl9zbGVlcF9zdGF0ZSgpLgogICoJSXQncyB1bmZvcnR1bmF0ZSwgYnV0IGl0IHdvcmtzLiBQ
bGVhc2UgZml4IGlmIHlvdSdyZSBmZWVsaW5nIGZyaXNreS4KICAqLwotCitleHRlcm4gaW50IGFj
cGlfZXZlbnRfaXNfbWFzazsKIHN0YXRpYyBpbnQgYWNwaV9wbV9lbnRlcih1MzIgcG1fc3RhdGUp
CiB7CiAJYWNwaV9zdGF0dXMgc3RhdHVzID0gQUVfT0s7CkBAIC04OSw2ICs4OSw3IEBAIHN0YXRp
YyBpbnQgYWNwaV9wbV9lbnRlcih1MzIgcG1fc3RhdGUpCiAKIAlsb2NhbF9pcnFfc2F2ZShmbGFn
cyk7CiAJYWNwaV9lbmFibGVfd2FrZXVwX2RldmljZShhY3BpX3N0YXRlKTsKKwlhY3BpX2V2ZW50
X2lzX21hc2sgPSAxOwogCXN3aXRjaCAocG1fc3RhdGUpCiAJewogCWNhc2UgUE1fU1VTUEVORF9T
VEFOREJZOgpAQCAtMTM5LDYgKzE0MCw3IEBAIHN0YXRpYyBpbnQgYWNwaV9wbV9maW5pc2godTMy
IHBtX3N0YXRlKQogCiAJYWNwaV9sZWF2ZV9zbGVlcF9zdGF0ZShhY3BpX3N0YXRlKTsKIAlhY3Bp
X2Rpc2FibGVfd2FrZXVwX2RldmljZShhY3BpX3N0YXRlKTsKKwlhY3BpX2V2ZW50X2lzX21hc2sg
PSAwOwogCiAJLyogcmVzZXQgZmlybXdhcmUgd2FraW5nIHZlY3RvciAqLwogCWFjcGlfc2V0X2Zp
cm13YXJlX3dha2luZ192ZWN0b3IoKGFjcGlfcGh5c2ljYWxfYWRkcmVzcykgMCk7Cg==

------_=_NextPart_001_01C480CF.BFF7876F--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
