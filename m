From: huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH] PCI / ACPI: Always resume devices on ACPI wakeup notifications
Date: Fri, 29 Mar 2013 15:41:23 +0800
Message-ID: <CAC=cRTPOOmnkZvM+3Kw4FU79paEhyh-M9vXU4cGoEkN7niH7Eg@mail.gmail.com>
References: <2282655.IicBMMa6jN@vostro.rjw.lan>
	<CAErSpo7QXe1-R5_jXCcc3g_J-_HXqO3V12nNB=Z6eCAt-vwKfA@mail.gmail.com>
	<51548C9E.9090703@fold.natur.cuni.cz>
	<2990024.LMTIBUbM3d@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=bcaec52d4d03dc630004d90b65d0
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f52.google.com ([209.85.214.52]:38442 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952Ab3C2HlZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Mar 2013 03:41:25 -0400
Received: by mail-bk0-f52.google.com with SMTP id it16so98492bkc.11
        for <linux-acpi@vger.kernel.org>; Fri, 29 Mar 2013 00:41:23 -0700 (PDT)
In-Reply-To: <2990024.LMTIBUbM3d@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Sarah Sharp <sarah.a.sharp@linux.intel.com>

--bcaec52d4d03dc630004d90b65d0
Content-Type: text/plain; charset=UTF-8

On Fri, Mar 29, 2013 at 5:27 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Thursday, March 28, 2013 07:31:58 PM Martin Mokrejs wrote:
>> Hi Bjorn,
>>
>> Bjorn Helgaas wrote:
>> > On Thu, Mar 28, 2013 at 11:26 AM, Martin Mokrejs
>> > <mmokrejs@fold.natur.cuni.cz> wrote:
>> >>
>> >>
>> >> Rafael J. Wysocki wrote:
>> >>> On Thursday, March 28, 2013 10:46:10 AM Bjorn Helgaas wrote:
>> >>>> On Thu, Mar 28, 2013 at 10:41 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> >>>>> On Thursday, March 28, 2013 10:21:30 AM Bjorn Helgaas wrote:
>> >>>>>> On Thu, Mar 28, 2013 at 6:57 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> >>>>>>> Hi Bjorn,
>> >>>>>>>
>> >>>>>>> I wonder what you think about the patch below?
>> >>>>>>
>> >>>>>> Seems fine to me (I'm trusting your and Matthew's judgment here since
>> >>>>>> I don't know much about it).  Why don't you resend it with Matthew's
>> >>>>>> ack and the appropriate stable tags, and I'll put it in.
>> >>>>>
>> >>>>> I will, thanks!
>> >>>>>
>> >>>>>> If you have
>> >>>>>> a URL for a bugzilla or mailing list report of the original problem,
>> >>>>>> that would be good, too.  It'd be nice if users and distros could
>> >>>>>> match problem reports with this solution, but I can't tell what the
>> >>>>>> user-visible issue was.  I assume that Sarah tested this (or somebody
>> >>>>>> else reproduced the problem and tested the fix)?
>> >>>>>
>> >>>>> Sarah reported it to me privately and I'm afraid I don't have any pointers
>> >>>>> to publicly available mailing list archives etc.
>> >>>>
>> >>>> Do you at least have a description of how a user could determine
>> >>>> whether he is seeing the problem fixed by this patch?
>> >>>
>> >>> Yeah.  For example, when the problem is visible on a USB controller and that
>> >>> controller is runtime-suspended, then plugging a new USB device into one
>> >>> of the controller's ports won't wake the controller up without the patch.
>> >>
>> >> Hi,
>> >>  I am wondering for a week or two why nobody answered any of my bug reports,
>> >> not even Sarah who asked for more details. I am think the fix is about my report
>> >> under thread "Re: 3.8.2: xhci port is dead until pcieport PME# goes to disabled"
>> >> and I really wonder why I wasn't Cc:ed and listed as a reporter provided it is
>> >> about my report. But I should better wait what Sarah says. ;-)

Hi, Martin,

Sorry for late.  Just found your bug report.  That seems related with
PCIe port runtime PM support.

Can you try the debug patch attached?  And send me back the dmesg?

Sorry I use gmail web client, so I can only send patch as attachment.

Best Regards,
Huang Ying

--bcaec52d4d03dc630004d90b65d0
Content-Type: application/octet-stream; name="port_wake_dbg.patch"
Content-Disposition: attachment; filename="port_wake_dbg.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hev1g2j50

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3BjaS1hY3BpLmMgYi9kcml2ZXJzL3BjaS9wY2ktYWNw
aS5jCmluZGV4IGRlZTVkZGQuLjhkMGI5MDkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGNpL3BjaS1h
Y3BpLmMKKysrIGIvZHJpdmVycy9wY2kvcGNpLWFjcGkuYwpAQCAtNDMsMTAgKzQzLDE2IEBAIHN0
YXRpYyB2b2lkIHBjaV9hY3BpX3dha2VfYnVzKGFjcGlfaGFuZGxlIGhhbmRsZSwgdTMyIGV2ZW50
LCB2b2lkICpjb250ZXh0KQogc3RhdGljIHZvaWQgcGNpX2FjcGlfd2FrZV9kZXYoYWNwaV9oYW5k
bGUgaGFuZGxlLCB1MzIgZXZlbnQsIHZvaWQgKmNvbnRleHQpCiB7CiAJc3RydWN0IHBjaV9kZXYg
KnBjaV9kZXYgPSBjb250ZXh0OworCXN0cnVjdCBhY3BpX2RldmljZSAqYWRldjsKIAogCWlmIChl
dmVudCAhPSBBQ1BJX05PVElGWV9ERVZJQ0VfV0FLRSB8fCAhcGNpX2RldikKIAkJcmV0dXJuOwog
CisJaWYgKCFhY3BpX2J1c19nZXRfZGV2aWNlKGhhbmRsZSwgJmFkZXYpKSB7CisJCWFkZXYtPndh
a2V1cC5mbGFncy5ydW5fd2FrZV93b3JrcyA9IHRydWU7CisJCWRldl9pbmZvKCZwY2lfZGV2LT5k
ZXYsICJydW4gd2FrZSB3b3JrcyFcbiIpOworCX0KKwogCWlmIChwY2lfZGV2LT5jdXJyZW50X3N0
YXRlID09IFBDSV9EM2NvbGQpIHsKIAkJcGNpX3dha2V1cF9ldmVudChwY2lfZGV2KTsKIAkJcG1f
cnVudGltZV9yZXN1bWUoJnBjaV9kZXYtPmRldik7CkBAIC0xNDYsNiArMTUyLDE1IEBAIHBoeXNf
YWRkcl90IGFjcGlfcGNpX3Jvb3RfZ2V0X21jZmdfYWRkcihhY3BpX2hhbmRsZSBoYW5kbGUpCiBz
dGF0aWMgcGNpX3Bvd2VyX3QgYWNwaV9wY2lfY2hvb3NlX3N0YXRlKHN0cnVjdCBwY2lfZGV2ICpw
ZGV2KQogewogCWludCBhY3BpX3N0YXRlLCBkX21heDsKKwlhY3BpX2hhbmRsZSBoYW5kbGUgPSBE
RVZJQ0VfQUNQSV9IQU5ETEUoJnBkZXYtPmRldik7CisJc3RydWN0IGFjcGlfZGV2aWNlICphZGV2
OworCisJaWYgKHBjaV9pc19icmlkZ2UocGRldikgJiYgIWFjcGlfYnVzX2dldF9kZXZpY2UoaGFu
ZGxlLCAmYWRldikpIHsKKwkJaWYgKCFhZGV2LT53YWtldXAuZmxhZ3MucnVuX3dha2Vfd29ya3Mp
IHsKKwkJCWRldl9pbmZvKCZwZGV2LT5kZXYsICJjaG9vc2Ugc3RhdGUsIHJ1bl93YWtlIG5vdCB2
ZXJpZmllZFxuIik7CisJCQlyZXR1cm4gUENJX0QwOworCQl9CisJfQogCiAJaWYgKHBkZXYtPm5v
X2QzY29sZCkKIAkJZF9tYXggPSBBQ1BJX1NUQVRFX0QzX0hPVDsKZGlmZiAtLWdpdCBhL2luY2x1
ZGUvYWNwaS9hY3BpX2J1cy5oIGIvaW5jbHVkZS9hY3BpL2FjcGlfYnVzLmgKaW5kZXggMjJiYTU2
ZS4uYmM4ODQxOSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9hY3BpL2FjcGlfYnVzLmgKKysrIGIvaW5j
bHVkZS9hY3BpL2FjcGlfYnVzLmgKQEAgLTI0NSw2ICsyNDUsNyBAQCBzdHJ1Y3QgYWNwaV9kZXZp
Y2VfcGVyZiB7CiBzdHJ1Y3QgYWNwaV9kZXZpY2Vfd2FrZXVwX2ZsYWdzIHsKIAl1OCB2YWxpZDox
OwkJLyogQ2FuIHN1Y2Nlc3NmdWxseSBlbmFibGUgd2FrZXVwPyAqLwogCXU4IHJ1bl93YWtlOjE7
CQkvKiBSdW4tV2FrZSBHUEUgZGV2aWNlcyAqLworCXU4IHJ1bl93YWtlX3dvcmtzOjE7CS8qIFJ1
bi1XYWtlIHdvcmtzIGZvciB0aGUgZGV2aWNlICovCiAJdTggbm90aWZpZXJfcHJlc2VudDoxOyAg
LyogV2FrZS11cCBub3RpZnkgaGFuZGxlciBoYXMgYmVlbiBpbnN0YWxsZWQgKi8KIH07CiAK
--bcaec52d4d03dc630004d90b65d0--
