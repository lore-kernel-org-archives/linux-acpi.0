From: huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH] PCI / ACPI: Always resume devices on ACPI wakeup notifications
Date: Tue, 2 Apr 2013 13:25:46 +0800
Message-ID: <CAC=cRTMJH+40oPSM9pFzkb5x6Q42rWR8BPtUOxJn_3WopmOSvQ@mail.gmail.com>
References: <2282655.IicBMMa6jN@vostro.rjw.lan>
	<CAErSpo7QXe1-R5_jXCcc3g_J-_HXqO3V12nNB=Z6eCAt-vwKfA@mail.gmail.com>
	<51548C9E.9090703@fold.natur.cuni.cz>
	<2990024.LMTIBUbM3d@vostro.rjw.lan>
	<51564804.9000700@fold.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf30223a8f386f8904d959f812
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:37488 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759855Ab3DBFZs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Apr 2013 01:25:48 -0400
Received: by mail-bk0-f46.google.com with SMTP id je9so19176bkc.33
        for <linux-acpi@vger.kernel.org>; Mon, 01 Apr 2013 22:25:46 -0700 (PDT)
In-Reply-To: <51564804.9000700@fold.natur.cuni.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Bjorn Helgaas <bhelgaas@google.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Sarah Sharp <sarah.a.sharp@linux.intel.com>

--20cf30223a8f386f8904d959f812
Content-Type: text/plain; charset=UTF-8

Hi, Martin,

On Sat, Mar 30, 2013 at 10:03 AM, Martin Mokrejs
<mmokrejs@fold.natur.cuni.cz> wrote:
> Rafael J. Wysocki wrote:
> > On Thursday, March 28, 2013 07:31:58 PM Martin Mokrejs wrote:
> >> Hi Bjorn,
> >>
> >> Bjorn Helgaas wrote:
> >>> On Thu, Mar 28, 2013 at 11:26 AM, Martin Mokrejs
> >>> <mmokrejs@fold.natur.cuni.cz> wrote:
> >>>>
> >>>>
> >>>> Rafael J. Wysocki wrote:
> >>>>> On Thursday, March 28, 2013 10:46:10 AM Bjorn Helgaas wrote:
> >>>>>> On Thu, Mar 28, 2013 at 10:41 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >>>>>>> On Thursday, March 28, 2013 10:21:30 AM Bjorn Helgaas wrote:
> >>>>>>>> On Thu, Mar 28, 2013 at 6:57 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >>>>>>>>> Hi Bjorn,
> >>>>>>>>>
> >>>>>>>>> I wonder what you think about the patch below?
> >>>>>>>>
> >>>>>>>> Seems fine to me (I'm trusting your and Matthew's judgment here since
> >>>>>>>> I don't know much about it).  Why don't you resend it with Matthew's
> >>>>>>>> ack and the appropriate stable tags, and I'll put it in.
> >>>>>>>
> >>>>>>> I will, thanks!
> >>>>>>>
> >>>>>>>> If you have
> >>>>>>>> a URL for a bugzilla or mailing list report of the original problem,
> >>>>>>>> that would be good, too.  It'd be nice if users and distros could
> >>>>>>>> match problem reports with this solution, but I can't tell what the
> >>>>>>>> user-visible issue was.  I assume that Sarah tested this (or somebody
> >>>>>>>> else reproduced the problem and tested the fix)?
> >>>>>>>
> >>>>>>> Sarah reported it to me privately and I'm afraid I don't have any pointers
> >>>>>>> to publicly available mailing list archives etc.
> >>>>>>
> >>>>>> Do you at least have a description of how a user could determine
> >>>>>> whether he is seeing the problem fixed by this patch?
> >>>>>
> >>>>> Yeah.  For example, when the problem is visible on a USB controller and that
> >>>>> controller is runtime-suspended, then plugging a new USB device into one
> >>>>> of the controller's ports won't wake the controller up without the patch.
> >>>>
> >>>> Hi,
> >>>>  I am wondering for a week or two why nobody answered any of my bug reports,
> >>>> not even Sarah who asked for more details. I am think the fix is about my report
> >>>> under thread "Re: 3.8.2: xhci port is dead until pcieport PME# goes to disabled"
> >>>> and I really wonder why I wasn't Cc:ed and listed as a reporter provided it is
> >>>> about my report. But I should better wait what Sarah says. ;-)
> >>>
> >>> I haven't forgotten about your hotplug issues, but I've been on
> >>> vacation for a week and have been working on the similar issue
> >>> reported by Chris Clayton
> >>> (https://bugzilla.kernel.org/show_bug.cgi?id=54981) because it seemed
> >>> a bit more tractable.  But I'll get back to yours eventually :)
> >>> Unfortunately nobody else seems to be jumping in to help, and I can
> >>> only do so much by myself.
> >>>
> >>> I haven't been following your XHCI issue at all, but one thing you
> >>
> >> But please do so now. If we are talking about an existing patch it should be
> >> possible to say whether what I observed is likely to be fixed by the patch.
> >> I will happily discuss then why I loose interrupts in a same way for my
> >> rtl8169 network card and why this PME# stuff happens for me only with 3.8
> >> and not 3.7 (unlike what Sarah claims). I am not arguing that something
> >> else makes 3.7 be able to wakeup the device and overcome the same bug
> >> while "it" is gone from 3.8. I think this should be an easy task for you,
> >> pci devs. ;-)
> >
> > OK, let's try to establish facts.
> >
> > Does the patch below causes the PCI PM issues you're seeing to go away?
>
> Yes, the PME# enabled to disabled is gone, because only PME# disabled is allowed.
> I don't think I really tested a scenario like before. Big thanks to Huang Ying
> (https://patchwork.kernel.org/patch/2359611/):
>
> # grep . /sys/bus/pci/devices/*/power/control
> /sys/bus/pci/devices/0000:00:00.0/power/control:on
> /sys/bus/pci/devices/0000:00:02.0/power/control:on
> /sys/bus/pci/devices/0000:00:16.0/power/control:on
> /sys/bus/pci/devices/0000:00:1a.0/power/control:on
> /sys/bus/pci/devices/0000:00:1b.0/power/control:on
> /sys/bus/pci/devices/0000:00:1c.0/power/control:on
> /sys/bus/pci/devices/0000:00:1c.1/power/control:on
> /sys/bus/pci/devices/0000:00:1c.3/power/control:on
> /sys/bus/pci/devices/0000:00:1c.4/power/control:on
> /sys/bus/pci/devices/0000:00:1c.7/power/control:on
> /sys/bus/pci/devices/0000:00:1d.0/power/control:on
> /sys/bus/pci/devices/0000:00:1f.0/power/control:on
> /sys/bus/pci/devices/0000:00:1f.2/power/control:on
> /sys/bus/pci/devices/0000:00:1f.3/power/control:on
> /sys/bus/pci/devices/0000:05:00.0/power/control:on
> /sys/bus/pci/devices/0000:09:00.0/power/control:on
> /sys/bus/pci/devices/0000:0b:00.0/power/control:on
> /sys/bus/pci/devices/0000:11:00.0/power/control:on
> # grep . /sys/bus/pci/devices/*/power/runtime_status
> /sys/bus/pci/devices/0000:00:00.0/power/runtime_status:active
> /sys/bus/pci/devices/0000:00:02.0/power/runtime_status:active
> /sys/bus/pci/devices/0000:00:16.0/power/runtime_status:active
> /sys/bus/pci/devices/0000:00:1a.0/power/runtime_status:active
> /sys/bus/pci/devices/0000:00:1b.0/power/runtime_status:active
> /sys/bus/pci/devices/0000:00:1c.0/power/runtime_status:active
> /sys/bus/pci/devices/0000:00:1c.1/power/runtime_status:active
> /sys/bus/pci/devices/0000:00:1c.3/power/runtime_status:active
> /sys/bus/pci/devices/0000:00:1c.4/power/runtime_status:active
> /sys/bus/pci/devices/0000:00:1c.7/power/runtime_status:active
> /sys/bus/pci/devices/0000:00:1d.0/power/runtime_status:active
> /sys/bus/pci/devices/0000:00:1f.0/power/runtime_status:active
> /sys/bus/pci/devices/0000:00:1f.2/power/runtime_status:active
> /sys/bus/pci/devices/0000:00:1f.3/power/runtime_status:active
> /sys/bus/pci/devices/0000:05:00.0/power/runtime_status:active
> /sys/bus/pci/devices/0000:09:00.0/power/runtime_status:active
> /sys/bus/pci/devices/0000:0b:00.0/power/runtime_status:active
> /sys/bus/pci/devices/0000:11:00.0/power/runtime_status:active
> #
>
> >
> > If it doesn't make all of them go away, does it make *some* of them go away?
>
> Yes, repeated inserts and removals of devices into xHCI slot work fine, no need
> to use "lsusb -vv" to wakeup devices.
>
> Aside from some minor USB errors (won't mess them here) what is important is the fact
> that the eSATA card hotplug works well or perfectly. I just sent to you and other pci devs
> much more detailed report under the "Re: 3.9-rc1: pciehp and eSATA card SiI 3132, no XHCI"
> thread although this particular testing was done on 3.8.3.
>
> I think I can stop replying to this thread which is about the patch from Sarah.
> My dead XHCI port issue is a power management issue, incidentally also fixed by the
> very same patch from Huang Ying. Cool! ;-)

Sorry, which patch do you mean?  Or to be more clear, could you test
the patch attached? For the XHCI dead port issue?

Please test this patch with laptop-mode-tool installed and enabled.  And
before/after test, please get PCI devices runtime status with:

grep . /sys/bus/pci/devices/*/power/runtime_status

And please give me the full dmesg for boot and incremental dmesg for
operations.

Best Regards,
Huang Ying

--20cf30223a8f386f8904d959f812
Content-Type: application/octet-stream; name="port_dbg.patch"
Content-Disposition: attachment; filename="port_dbg.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hf0mf7og0

LS0tCiBkcml2ZXJzL3BjaS9ob3RwbHVnL3BjaV9ob3RwbHVnX2NvcmUuYyB8ICAgIDggKysrKysr
KysKIGRyaXZlcnMvcGNpL3BjaS1hY3BpLmMgICAgICAgICAgICAgICAgIHwgICAyMSArKysrKysr
KysrKysrKysrKysrKy0KIGRyaXZlcnMvcGNpL3BjaS5jICAgICAgICAgICAgICAgICAgICAgIHwg
ICAgMSArCiBkcml2ZXJzL3BjaS9wY2llL3BvcnRkcnZfcGNpLmMgICAgICAgICB8ICAgMTIgKysr
KysrKysrLS0tCiBkcml2ZXJzL3BjaS9zbG90LmMgICAgICAgICAgICAgICAgICAgICB8ICAgMTgg
KysrKysrKysrKysrKysrKysrCiBpbmNsdWRlL2FjcGkvYWNwaV9idXMuaCAgICAgICAgICAgICAg
ICB8ICAgIDEgKwogaW5jbHVkZS9saW51eC9wY2kuaCAgICAgICAgICAgICAgICAgICAgfCAgICAx
ICsKIDcgZmlsZXMgY2hhbmdlZCwgNTggaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCi0t
LSBhL2RyaXZlcnMvcGNpL2hvdHBsdWcvcGNpX2hvdHBsdWdfY29yZS5jCisrKyBiL2RyaXZlcnMv
cGNpL2hvdHBsdWcvcGNpX2hvdHBsdWdfY29yZS5jCkBAIC0zOSw2ICszOSw3IEBACiAjaW5jbHVk
ZSA8bGludXgvbXV0ZXguaD4KICNpbmNsdWRlIDxsaW51eC9wY2kuaD4KICNpbmNsdWRlIDxsaW51
eC9wY2lfaG90cGx1Zy5oPgorI2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4KICNpbmNsdWRl
IDxhc20vdWFjY2Vzcy5oPgogI2luY2x1ZGUgIi4uL3BjaS5oIgogCkBAIC00NzMsNiArNDc0LDkg
QEAgaW50IF9fcGNpX2hwX3JlZ2lzdGVyKHN0cnVjdCBob3RwbHVnX3NsbwogCWRiZygiQWRkZWQg
c2xvdCAlcyB0byB0aGUgbGlzdFxuIiwgbmFtZSk7CiBvdXQ6CiAJbXV0ZXhfdW5sb2NrKCZwY2lf
aHBfbXV0ZXgpOworCS8qIEJyaWRnZSBydW50aW1lIFBNIHN0YXRlIG1heSBiZSBpbmZsdWVuY2Vk
IGJ5IGhvdHBsdWcgKi8KKwlwbV9ydW50aW1lX3Jlc3VtZSgmYnVzLT5zZWxmLT5kZXYpOworCWRl
dl9pbmZvKCZidXMtPnNlbGYtPmRldiwgImhvdHBsdWcgc2xvdCBhZGRlZCFcbiIpOwogCXJldHVy
biByZXN1bHQ7CiB9CiAKQEAgLTQ4OSw2ICs0OTMsNyBAQCBpbnQgcGNpX2hwX2RlcmVnaXN0ZXIo
c3RydWN0IGhvdHBsdWdfc2xvCiB7CiAJc3RydWN0IGhvdHBsdWdfc2xvdCAqdGVtcDsKIAlzdHJ1
Y3QgcGNpX3Nsb3QgKnNsb3Q7CisJc3RydWN0IHBjaV9idXMgKmJ1czsKIAogCWlmICghaG90cGx1
ZykKIAkJcmV0dXJuIC1FTk9ERVY7CkBAIC01MDgsOCArNTEzLDExIEBAIGludCBwY2lfaHBfZGVy
ZWdpc3RlcihzdHJ1Y3QgaG90cGx1Z19zbG8KIAogCWhvdHBsdWctPnJlbGVhc2UoaG90cGx1Zyk7
CiAJc2xvdC0+aG90cGx1ZyA9IE5VTEw7CisJYnVzID0gc2xvdC0+YnVzOwogCXBjaV9kZXN0cm95
X3Nsb3Qoc2xvdCk7CiAJbXV0ZXhfdW5sb2NrKCZwY2lfaHBfbXV0ZXgpOworCXBtX3J1bnRpbWVf
cmVzdW1lKCZidXMtPnNlbGYtPmRldik7CisJZGV2X2luZm8oJmJ1cy0+c2VsZi0+ZGV2LCAiaG90
cGx1ZyBzbG90IHJlbW92ZWQhXG4iKTsKIAogCXJldHVybiAwOwogfQotLS0gYS9kcml2ZXJzL3Bj
aS9wY2ktYWNwaS5jCisrKyBiL2RyaXZlcnMvcGNpL3BjaS1hY3BpLmMKQEAgLTQzLDEwICs0Mywx
NiBAQCBzdGF0aWMgdm9pZCBwY2lfYWNwaV93YWtlX2J1cyhhY3BpX2hhbmRsCiBzdGF0aWMgdm9p
ZCBwY2lfYWNwaV93YWtlX2RldihhY3BpX2hhbmRsZSBoYW5kbGUsIHUzMiBldmVudCwgdm9pZCAq
Y29udGV4dCkKIHsKIAlzdHJ1Y3QgcGNpX2RldiAqcGNpX2RldiA9IGNvbnRleHQ7CisJc3RydWN0
IGFjcGlfZGV2aWNlICphZGV2OwogCiAJaWYgKGV2ZW50ICE9IEFDUElfTk9USUZZX0RFVklDRV9X
QUtFIHx8ICFwY2lfZGV2KQogCQlyZXR1cm47CiAKKwlpZiAoIWFjcGlfYnVzX2dldF9kZXZpY2Uo
aGFuZGxlLCAmYWRldikpIHsKKwkJYWRldi0+d2FrZXVwLmZsYWdzLnJ1bl93YWtlX3dvcmtzID0g
dHJ1ZTsKKwkJZGV2X2luZm8oJnBjaV9kZXYtPmRldiwgInJ1biB3YWtlIHdvcmtzIVxuIik7CisJ
fQorCiAJaWYgKHBjaV9kZXYtPmN1cnJlbnRfc3RhdGUgPT0gUENJX0QzY29sZCkgewogCQlwY2lf
d2FrZXVwX2V2ZW50KHBjaV9kZXYpOwogCQlwbV9ydW50aW1lX3Jlc3VtZSgmcGNpX2Rldi0+ZGV2
KTsKQEAgLTE0Niw2ICsxNTIsMTkgQEAgcGh5c19hZGRyX3QgYWNwaV9wY2lfcm9vdF9nZXRfbWNm
Z19hZGRyKAogc3RhdGljIHBjaV9wb3dlcl90IGFjcGlfcGNpX2Nob29zZV9zdGF0ZShzdHJ1Y3Qg
cGNpX2RldiAqcGRldikKIHsKIAlpbnQgYWNwaV9zdGF0ZSwgZF9tYXg7CisJYWNwaV9oYW5kbGUg
aGFuZGxlID0gREVWSUNFX0FDUElfSEFORExFKCZwZGV2LT5kZXYpOworCXN0cnVjdCBhY3BpX2Rl
dmljZSAqYWRldjsKKworCWlmIChwY2lfaXNfYnJpZGdlKHBkZXYpKSB7CisJCWlmIChhY3BpX2J1
c19nZXRfZGV2aWNlKGhhbmRsZSwgJmFkZXYpKSB7CisJCQlkZXZfaW5mbygmcGRldi0+ZGV2LCAi
Y2hvb3NlIHN0YXRlLCBubyBBQ1BJIGRldmljZVxuIik7CisJCQlyZXR1cm4gUENJX0QwOworCQl9
CisJCWlmICghYWRldi0+d2FrZXVwLmZsYWdzLnJ1bl93YWtlX3dvcmtzKSB7CisJCQlkZXZfaW5m
bygmcGRldi0+ZGV2LCAiY2hvb3NlIHN0YXRlLCBydW4gd2FrZSBub3QgdmVyaWZpZWRcbiIpOwor
CQkJcmV0dXJuIFBDSV9EMDsKKwkJfQorCX0KIAogCWlmIChwZGV2LT5ub19kM2NvbGQpCiAJCWRf
bWF4ID0gQUNQSV9TVEFURV9EM19IT1Q7CkBAIC0yNjksNyArMjg4LDcgQEAgc3RhdGljIGludCBh
Y3BpX3BjaV9ydW5fd2FrZShzdHJ1Y3QgcGNpXwogCSAqIHdha2luZyB1cCB0byBwb3dlciBvbiB0
aGUgbWFpbiBsaW5rIGV2ZW4gaWYgdGhlcmUgaXMgUE1FCiAJICogc3VwcG9ydCBmb3IgRDNjb2xk
CiAJICovCi0JaWYgKGRldi0+cG1lX2ludGVycnVwdCAmJiAhZGV2LT5ydW50aW1lX2QzY29sZCkK
KwlpZiAoZGV2LT5wbWVfaW50ZXJydXB0ICYmICFkZXYtPnJ1bnRpbWVfZDNjb2xkICYmICFwY2lf
aXNfYnJpZGdlKGRldikpCiAJCXJldHVybiAwOwogCiAJaWYgKCFhY3BpX3BtX2RldmljZV9ydW5f
d2FrZSgmZGV2LT5kZXYsIGVuYWJsZSkpCi0tLSBhL2RyaXZlcnMvcGNpL3BjaS5jCisrKyBiL2Ry
aXZlcnMvcGNpL3BjaS5jCkBAIC0xODMyLDYgKzE4MzIsNyBAQCBpbnQgcGNpX2ZpbmlzaF9ydW50
aW1lX3N1c3BlbmQoc3RydWN0IHBjCiAJX19wY2lfZW5hYmxlX3dha2UoZGV2LCB0YXJnZXRfc3Rh
dGUsIHRydWUsIHBjaV9kZXZfcnVuX3dha2UoZGV2KSk7CiAKIAllcnJvciA9IHBjaV9zZXRfcG93
ZXJfc3RhdGUoZGV2LCB0YXJnZXRfc3RhdGUpOworCWRldl9pbmZvKCZkZXYtPmRldiwgInBmcnM6
IHRhcmdldDogJWQsICVkXG4iLCB0YXJnZXRfc3RhdGUsIGVycm9yKTsKIAogCWlmIChlcnJvcikg
ewogCQlfX3BjaV9lbmFibGVfd2FrZShkZXYsIHRhcmdldF9zdGF0ZSwgdHJ1ZSwgZmFsc2UpOwot
LS0gYS9kcml2ZXJzL3BjaS9wY2llL3BvcnRkcnZfcGNpLmMKKysrIGIvZHJpdmVycy9wY2kvcGNp
ZS9wb3J0ZHJ2X3BjaS5jCkBAIC0xNTQsOSArMTU0LDE1IEBAIHN0YXRpYyBpbnQgcGNpZV9wb3J0
X3J1bnRpbWVfaWRsZShzdHJ1Y3QKIAkgKi8KIAlwY2lfd2Fsa19idXMocGRldi0+c3Vib3JkaW5h
dGUsIHBjaV9kZXZfcG1lX3BvbGwsICZwbWVfcG9sbCk7CiAJLyogRGVsYXkgZm9yIGEgc2hvcnQg
d2hpbGUgdG8gcHJldmVudCB0b28gZnJlcXVlbnQgc3VzcGVuZC9yZXN1bWUgKi8KLQlpZiAoIXBt
ZV9wb2xsKQotCQlwbV9zY2hlZHVsZV9zdXNwZW5kKGRldiwgMTApOwotCXJldHVybiAtRUJVU1k7
CisJaWYgKHBtZV9wb2xsKQorCQlyZXR1cm4gLUVCVVNZOworCWlmIChwY2lfYnVzX2hhc19ob3Rw
bHVnX3Nsb3RzKHBkZXYtPnN1Ym9yZGluYXRlKSkgeworCQlkZXZfaW5mbygmcGRldi0+ZGV2LCAi
cHByaTogaGFzIGhvdHBsdWcgc2xvdHMsIGRvIG5vdCBzdXNwZW5kIVxuIik7CisJCXJldHVybiAt
RUJVU1k7CisJfQorCWRldl9pbmZvKCZwZGV2LT5kZXYsICJwcHJpOiB3aWxsIGdvIHN1c3BlbmQs
IGlzX2hvdHBsdWdfYnJpZGdlOiAlZC5cbiIsCisJCSBwZGV2LT5pc19ob3RwbHVnX2JyaWRnZSk7
CisJcmV0dXJuIHBtX3NjaGVkdWxlX3N1c3BlbmQoZGV2LCAxMCk7CiB9CiAjZWxzZQogI2RlZmlu
ZSBwY2llX3BvcnRfcnVudGltZV9zdXNwZW5kCU5VTEwKLS0tIGEvZHJpdmVycy9wY2kvc2xvdC5j
CisrKyBiL2RyaXZlcnMvcGNpL3Nsb3QuYwpAQCAtMzQ1LDYgKzM0NSwyNCBAQCBvdXQ6CiB9CiBF
WFBPUlRfU1lNQk9MX0dQTChwY2lfcmVudW1iZXJfc2xvdCk7CiAKK2Jvb2wgcGNpX2J1c19oYXNf
aG90cGx1Z19zbG90cyhzdHJ1Y3QgcGNpX2J1cyAqYnVzKQoreworCXN0cnVjdCBwY2lfc2xvdCAq
c2xvdDsKKwlib29sIGhhc19ob3RwbHVnX3Nsb3RzID0gZmFsc2U7CisKKwlkb3duX3JlYWQoJnBj
aV9idXNfc2VtKTsKKwlsaXN0X2Zvcl9lYWNoX2VudHJ5KHNsb3QsICZidXMtPnNsb3RzLCBsaXN0
KSB7CisJCWlmIChzbG90LT5ob3RwbHVnKSB7CisJCQloYXNfaG90cGx1Z19zbG90cyA9IHRydWU7
CisJCQlicmVhazsKKwkJfQorCX0KKwl1cF9yZWFkKCZwY2lfYnVzX3NlbSk7CisKKwlyZXR1cm4g
aGFzX2hvdHBsdWdfc2xvdHM7Cit9CitFWFBPUlRfU1lNQk9MX0dQTChwY2lfYnVzX2hhc19ob3Rw
bHVnX3Nsb3RzKTsKKwogLyoqCiAgKiBwY2lfZGVzdHJveV9zbG90IC0gZGVjcmVtZW50IHJlZmNv
dW50IGZvciBwaHlzaWNhbCBQQ0kgc2xvdAogICogQHNsb3Q6IHN0cnVjdCBwY2lfc2xvdCB0byBk
ZWNyZW1lbnQKLS0tIGEvaW5jbHVkZS9hY3BpL2FjcGlfYnVzLmgKKysrIGIvaW5jbHVkZS9hY3Bp
L2FjcGlfYnVzLmgKQEAgLTI0NSw2ICsyNDUsNyBAQCBzdHJ1Y3QgYWNwaV9kZXZpY2VfcGVyZiB7
CiBzdHJ1Y3QgYWNwaV9kZXZpY2Vfd2FrZXVwX2ZsYWdzIHsKIAl1OCB2YWxpZDoxOwkJLyogQ2Fu
IHN1Y2Nlc3NmdWxseSBlbmFibGUgd2FrZXVwPyAqLwogCXU4IHJ1bl93YWtlOjE7CQkvKiBSdW4t
V2FrZSBHUEUgZGV2aWNlcyAqLworCXU4IHJ1bl93YWtlX3dvcmtzOjE7CS8qIFJ1bi1XYWtlIHdv
cmtzIGZvciB0aGUgZGV2aWNlICovCiAJdTggbm90aWZpZXJfcHJlc2VudDoxOyAgLyogV2FrZS11
cCBub3RpZnkgaGFuZGxlciBoYXMgYmVlbiBpbnN0YWxsZWQgKi8KIH07CiAKLS0tIGEvaW5jbHVk
ZS9saW51eC9wY2kuaAorKysgYi9pbmNsdWRlL2xpbnV4L3BjaS5oCkBAIC03MjIsNiArNzIyLDcg
QEAgc3RydWN0IHBjaV9zbG90ICpwY2lfY3JlYXRlX3Nsb3Qoc3RydWN0CiB2b2lkIHBjaV9kZXN0
cm95X3Nsb3Qoc3RydWN0IHBjaV9zbG90ICpzbG90KTsKIHZvaWQgcGNpX3JlbnVtYmVyX3Nsb3Qo
c3RydWN0IHBjaV9zbG90ICpzbG90LCBpbnQgc2xvdF9ucik7CiBpbnQgcGNpX3NjYW5fc2xvdChz
dHJ1Y3QgcGNpX2J1cyAqYnVzLCBpbnQgZGV2Zm4pOworYm9vbCBwY2lfYnVzX2hhc19ob3RwbHVn
X3Nsb3RzKHN0cnVjdCBwY2lfYnVzICpidXMpOwogc3RydWN0IHBjaV9kZXYgKnBjaV9zY2FuX3Np
bmdsZV9kZXZpY2Uoc3RydWN0IHBjaV9idXMgKmJ1cywgaW50IGRldmZuKTsKIHZvaWQgcGNpX2Rl
dmljZV9hZGQoc3RydWN0IHBjaV9kZXYgKmRldiwgc3RydWN0IHBjaV9idXMgKmJ1cyk7CiB1bnNp
Z25lZCBpbnQgcGNpX3NjYW5fY2hpbGRfYnVzKHN0cnVjdCBwY2lfYnVzICpidXMpOwo=
--20cf30223a8f386f8904d959f812--
