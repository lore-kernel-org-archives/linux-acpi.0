From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: bug in acpid scripts
Date: Thu, 12 Aug 2004 15:07:17 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B44D37711ED29844BEA67908EAF36F038AD732@pdsmsx401.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C4803B.012F9618"
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
To: russell-1vnkWVZi4QaVc3sceRu5cw@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4803B.012F9618
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Russell Neches Sunday, July 25, 2004 9:42 AM wrote:
>To: Li, Shaohua
>Cc: ACPI-Devel
>Subject: RE: [ACPI] bug in acpid scripts
>
>Neat! I'd like to help test your patch, if you wouldn't mind posting
it.
>Is there anything specific behavior (good or bad) you would like me to
>check for?
Here is it. The patch is very sample. I didn't observe any side effect
of this patch, but maybe it must be tested widely. Could you please try
it?

Thanks,
Shaohua

>
>Russell
>
>On Sat, 2004-07-24 at 09:23, Li, Shaohua wrote:
>> I'm working to disable all events sent to acpid (of course including
>> button event) when system is resuming. The patch is very
>> straightforward. But I need time to verify if it has side effect for
>> acpid.
>>
>> Thanks,
>> Shaohua
>>
>> >-----Original Message-----
>> >From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
>> >admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Matthew Garrett
>> >Sent: Saturday, July 24, 2004 8:50 PM
>> >To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>> >Subject: Re: [ACPI] bug in acpid scripts
>> >
>> >On Fri, 2004-07-23 at 20:36, Russell Neches wrote:
>> >
>> >> My system always enters S3 without complaining, and resumes
without
>> >> complaining. Then it immediately begins a clean shutdown. I had
>> assumed
>> >> this was caused by general S3 breakage, but the problem is
actually
>> >> caused by acpid catching the power button event that triggered the
>> >> system to resume. It then dutifully calls powerbtn.sh, and the
system
>> >> shuts down.
>> >
>> >My current workaround is to make button support modular, and then
>> remove
>> >the button module during suspend. The power button event then gets
>> >ignored on wakeup.
>> >
>> >--
>> >Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org
>> >
>> >
>> >
>> >-------------------------------------------------------
>> >This SF.Net email is sponsored by BEA Weblogic Workshop
>> >FREE Java Enterprise J2EE developer tools!
>> >Get your free copy of BEA WebLogic Workshop 8.1 today.
>> >http://ads.osdn.com/?ad_id=3D4721&alloc_id=3D10040&op=3Dclick
>> >_______________________________________________
>> >Acpi-devel mailing list
>> >Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>> >https://lists.sourceforge.net/lists/listinfo/acpi-devel
>>
>>
>> -------------------------------------------------------
>> This SF.Net email is sponsored by BEA Weblogic Workshop
>> FREE Java Enterprise J2EE developer tools!
>> Get your free copy of BEA WebLogic Workshop 8.1 today.
>> http://ads.osdn.com/?ad_idG21&alloc_id=10040&op=3Dclick
>> _______________________________________________
>> Acpi-devel mailing list
>> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>> https://lists.sourceforge.net/lists/listinfo/acpi-devel

------_=_NextPart_001_01C4803B.012F9618
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
ZW47CitleHRlcm4gaW50CQkJYWNwaV9ldmVudF9pc19tYXNrZWQ7CiAKIGludAogYWNwaV9idXNf
Z2VuZXJhdGVfZXZlbnQgKApAQCAtMjk5LDcgKzMwMCw3IEBAIGFjcGlfYnVzX2dlbmVyYXRlX2V2
ZW50ICgKIAkJcmV0dXJuX1ZBTFVFKC1FSU5WQUwpOwogCiAJLyogZHJvcCBldmVudCBvbiB0aGUg
Zmxvb3IgaWYgbm8gb25lJ3MgbGlzdGVuaW5nICovCi0JaWYgKCFldmVudF9pc19vcGVuKQorCWlm
ICghZXZlbnRfaXNfb3BlbiB8fCBhY3BpX2V2ZW50X2lzX21hc2tlZCkKIAkJcmV0dXJuX1ZBTFVF
KDApOwogCiAJZXZlbnQgPSBrbWFsbG9jKHNpemVvZihzdHJ1Y3QgYWNwaV9idXNfZXZlbnQpLCBH
RlBfQVRPTUlDKTsKPT09PT0gZHJpdmVycy9hY3BpL2V2ZW50LmMgMS41IHZzIGVkaXRlZCA9PT09
PQotLS0gMS41L2RyaXZlcnMvYWNwaS9ldmVudC5jCTIwMDQtMDUtMjkgMTc6MTI6NTUgKzA4OjAw
CisrKyBlZGl0ZWQvZHJpdmVycy9hY3BpL2V2ZW50LmMJMjAwNC0wOC0xMiAxNDo0MDoxMyArMDg6
MDAKQEAgLTE3LDcgKzE3LDggQEAgQUNQSV9NT0RVTEVfTkFNRQkJKCJldmVudCIpCiAKIC8qIEds
b2JhbCB2YXJzIGZvciBoYW5kbGluZyBldmVudCBwcm9jIGVudHJ5ICovCiBzdGF0aWMgc3Bpbmxv
Y2tfdAkJYWNwaV9zeXN0ZW1fZXZlbnRfbG9jayA9IFNQSU5fTE9DS19VTkxPQ0tFRDsKLWludAkJ
CQlldmVudF9pc19vcGVuID0gMDsKK2ludAkJCQlldmVudF9pc19vcGVuOworaW50CQkJCWFjcGlf
ZXZlbnRfaXNfbWFzazsKIGV4dGVybiBzdHJ1Y3QgbGlzdF9oZWFkCQlhY3BpX2J1c19ldmVudF9s
aXN0OwogZXh0ZXJuIHdhaXRfcXVldWVfaGVhZF90CWFjcGlfYnVzX2V2ZW50X3F1ZXVlOwogCj09
PT09IGRyaXZlcnMvYWNwaS9zbGVlcC9tYWluLmMgMS4zOCB2cyBlZGl0ZWQgPT09PT0KLS0tIDEu
MzgvZHJpdmVycy9hY3BpL3NsZWVwL21haW4uYwkyMDA0LTA3LTE0IDEzOjI5OjEzICswODowMAor
KysgZWRpdGVkL2RyaXZlcnMvYWNwaS9zbGVlcC9tYWluLmMJMjAwNC0wOC0xMiAxNDo0MToxMyAr
MDg6MDAKQEAgLTcwLDcgKzcwLDcgQEAgc3RhdGljIGludCBhY3BpX3BtX3ByZXBhcmUodTMyIHBt
X3N0YXRlKQogICoJYXJjaC1zcGVjaWZpYyBhc3NlbWJseSwgd2hpY2ggaW4gdHVybiBjYWxsIGFj
cGlfZW50ZXJfc2xlZXBfc3RhdGUoKS4KICAqCUl0J3MgdW5mb3J0dW5hdGUsIGJ1dCBpdCB3b3Jr
cy4gUGxlYXNlIGZpeCBpZiB5b3UncmUgZmVlbGluZyBmcmlza3kuCiAgKi8KLQorZXh0ZXJuIGlu
dCBhY3BpX2V2ZW50X2lzX21hc2s7CiBzdGF0aWMgaW50IGFjcGlfcG1fZW50ZXIodTMyIHBtX3N0
YXRlKQogewogCWFjcGlfc3RhdHVzIHN0YXR1cyA9IEFFX09LOwpAQCAtODksNiArODksNyBAQCBz
dGF0aWMgaW50IGFjcGlfcG1fZW50ZXIodTMyIHBtX3N0YXRlKQogCiAJbG9jYWxfaXJxX3NhdmUo
ZmxhZ3MpOwogCWFjcGlfZW5hYmxlX3dha2V1cF9kZXZpY2UoYWNwaV9zdGF0ZSk7CisJYWNwaV9l
dmVudF9pc19tYXNrID0gMTsKIAlzd2l0Y2ggKHBtX3N0YXRlKQogCXsKIAljYXNlIFBNX1NVU1BF
TkRfU1RBTkRCWToKQEAgLTEzOSw2ICsxNDAsNyBAQCBzdGF0aWMgaW50IGFjcGlfcG1fZmluaXNo
KHUzMiBwbV9zdGF0ZSkKIAogCWFjcGlfbGVhdmVfc2xlZXBfc3RhdGUoYWNwaV9zdGF0ZSk7CiAJ
YWNwaV9kaXNhYmxlX3dha2V1cF9kZXZpY2UoYWNwaV9zdGF0ZSk7CisJYWNwaV9ldmVudF9pc19t
YXNrID0gMDsKIAogCS8qIHJlc2V0IGZpcm13YXJlIHdha2luZyB2ZWN0b3IgKi8KIAlhY3BpX3Nl
dF9maXJtd2FyZV93YWtpbmdfdmVjdG9yKChhY3BpX3BoeXNpY2FsX2FkZHJlc3MpIDApOwo=

------_=_NextPart_001_01C4803B.012F9618--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
