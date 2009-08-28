From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [Debian-eeepc-devel] Problems with wlan on a 1005HA-M
Date: Fri, 28 Aug 2009 15:25:47 +0100
Message-ID: <9b2b86520908280725v383ed045m563385eb2a7c5461@mail.gmail.com>
References: <4A8D32A8.8000702@oss42.com>
	 <9b2b86520908200638y75c0c80cm4faf9a5c67b61397@mail.gmail.com>
	 <4A9104CC.90504@oss42.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000325558fd6d92c320472347528
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:57400 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbZH1OZt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Aug 2009 10:25:49 -0400
Received: by fxm17 with SMTP id 17so1602837fxm.37
        for <linux-acpi@vger.kernel.org>; Fri, 28 Aug 2009 07:25:48 -0700 (PDT)
In-Reply-To: <4A9104CC.90504@oss42.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Karsten Jaeger <lists@oss42.com>
Cc: debian-eeepc-devel@lists.alioth.debian.org, acpi4asus-user <acpi4asus-user@lists.sourceforge.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Corentin Chary <corentincj@iksaif.net>

--000325558fd6d92c320472347528
Content-Type: text/plain; charset=ISO-8859-1

On 8/23/09, Karsten Jaeger <lists@oss42.com> wrote:
> Hi Alan!
>
> Alan Jenkins schrieb:
>> On 8/20/09, Karsten Jaeger <lists@oss42.com> wrote:
>>> Last week I bought my EeePC 1005HA-M. It comes with Windows and Ubuntu
>>> Installation, everything works fine.
>>> Because my favorite OS is Debian I install it on the EeePC with
>>> Standard-Lenny and kernel linux-image-2.6.31-rc5, updating it to sid and
>>> everything worked fine. I updated it last sunday with latest sid and
>>> kernel linux-image-2.6.31-rc6, put in in sleep mode (which worked fine
>>> before) and want to restart it again on monday but nothing worked, I
>>> have a black screen and it do not return from sleep. So I do an cold
>>> reboot.
>>> After that, my wlan said, it have an segmentation fault and also gives
>>> the line back:
>>>
>>> SIOCSIFFLAGS: Unknown error 132
>>> Because I want to change some more, I do reinstalling it all, but since
>>> than, I can't get wlan to work again.
>>
>> That looks like the new rfkill error code.  Basically it means the
>> wireless has been disabled.  I guess the segmentation fault is a
>> userspace bug, unless you also see a BUG message in dmesg.
>
> I do think about it before, but because it worked before upgrading, I am
> not serios that this is the same.
>
>> You should definitely be able to re-enable the wireless using the BIOS
>> setup screen... try these instructions:
>
> Yes, I can.
>
>> <http://www.1-script.com/forums/wireless-card-and-camera-no-longer-work-or-show-in-hardware-article46509--25.htm>
>>
>> Are you able to confirm that this happens just by upgrading the
>> kernel?  If so, there's only one eeepc-laptop commit between -rc5 and
>> -rc6, and I'm afraid it's mine.
>
> There also was an libc update. Not only the kernel-update. So I can't
> really say, what exactly causes the problem.
>
>> I re-wrote it again for 2.6.32 in a slightly more sensible way.  If
>> we're lucky, your problem is fixed by the re-write and it can be
>> expedited for 2.6.31.  I've attached the relevant changes as a test
>> patch; it should apply cleanly to 2.6.31-rc6.
>
> For now, I do an downgrade to 2.6.30 solve the WLAN-problem, it's more
> needed as LAN. LAN doesn't work by now, but maybe in a few days after
> the new 2.6.30 is uploaded.
>
> I give the test.patch a try on the weekend and get you informed.
>
> Thanks very much,
> Karsten
>
> PS: Sorry Alan, I have to look more carefully on the TO-Header. ;-/

No worries, I've lost count how many times I did that myself.

2.6.31 is fast approaching and this is a bad regression.  Please let
me know if it's fixed by the test patch I sent you earlier.

If that doesn't work, the safest approach is to revert my buggy
code[1].  I've attached the reversions as a patch you can test.

Thanks
Alan

[1] The change responsible was only intended to improve the case where
you toggle the wireless half-way through hibernation.  2.6.31 can live
without it.

--000325558fd6d92c320472347528
Content-Type: text/x-diff; charset=US-ASCII; name="revert.patch"
Content-Disposition: attachment; filename="revert.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: file0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2VlZXBjLWxhcHRvcC5jIGIvZHJpdmVy
cy9wbGF0Zm9ybS94ODYvZWVlcGMtbGFwdG9wLmMKaW5kZXggMjIyZmZiOC4uNTk0MWMzZiAxMDA2
NDQKLS0tIGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvZWVlcGMtbGFwdG9wLmMKKysrIGIvZHJpdmVy
cy9wbGF0Zm9ybS94ODYvZWVlcGMtbGFwdG9wLmMKQEAgLTE0Myw3ICsxNDMsNiBAQCBzdHJ1Y3Qg
ZWVlcGNfaG90ayB7CiAJc3RydWN0IHJma2lsbCAqYmx1ZXRvb3RoX3Jma2lsbDsKIAlzdHJ1Y3Qg
cmZraWxsICp3d2FuM2dfcmZraWxsOwogCXN0cnVjdCBob3RwbHVnX3Nsb3QgKmhvdHBsdWdfc2xv
dDsKLQlzdHJ1Y3Qgd29ya19zdHJ1Y3QgaG90cGx1Z193b3JrOwogfTsKIAogLyogVGhlIGFjdHVh
bCBkZXZpY2UgdGhlIGRyaXZlciBiaW5kcyB0byAqLwpAQCAtMTkyLDcgKzE5MSw2IEBAIHN0YXRp
YyBzdHJ1Y3Qga2V5X2VudHJ5IGVlZXBjX2tleW1hcFtdID0gewogICovCiBzdGF0aWMgaW50IGVl
ZXBjX2hvdGtfYWRkKHN0cnVjdCBhY3BpX2RldmljZSAqZGV2aWNlKTsKIHN0YXRpYyBpbnQgZWVl
cGNfaG90a19yZW1vdmUoc3RydWN0IGFjcGlfZGV2aWNlICpkZXZpY2UsIGludCB0eXBlKTsKLXN0
YXRpYyBpbnQgZWVlcGNfaG90a19yZXN1bWUoc3RydWN0IGFjcGlfZGV2aWNlICpkZXZpY2UpOwog
c3RhdGljIHZvaWQgZWVlcGNfaG90a19ub3RpZnkoc3RydWN0IGFjcGlfZGV2aWNlICpkZXZpY2Us
IHUzMiBldmVudCk7CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYWNwaV9kZXZpY2VfaWQgZWVlcGNf
ZGV2aWNlX2lkc1tdID0gewpAQCAtMjA5LDcgKzIwNyw2IEBAIHN0YXRpYyBzdHJ1Y3QgYWNwaV9k
cml2ZXIgZWVlcGNfaG90a19kcml2ZXIgPSB7CiAJLm9wcyA9IHsKIAkJLmFkZCA9IGVlZXBjX2hv
dGtfYWRkLAogCQkucmVtb3ZlID0gZWVlcGNfaG90a19yZW1vdmUsCi0JCS5yZXN1bWUgPSBlZWVw
Y19ob3RrX3Jlc3VtZSwKIAkJLm5vdGlmeSA9IGVlZXBjX2hvdGtfbm90aWZ5LAogCX0sCiB9OwpA
QCAtNjYxLDEyICs2NTgsMTUgQEAgc3RhdGljIGludCBlZWVwY19nZXRfYWRhcHRlcl9zdGF0dXMo
c3RydWN0IGhvdHBsdWdfc2xvdCAqaG90cGx1Z19zbG90LAogCXJldHVybiAwOwogfQogCi1zdGF0
aWMgdm9pZCBlZWVwY19ob3RwbHVnX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQorc3Rh
dGljIHZvaWQgZWVlcGNfcmZraWxsX25vdGlmeShhY3BpX2hhbmRsZSBoYW5kbGUsIHUzMiBldmVu
dCwgdm9pZCAqZGF0YSkKIHsKIAlzdHJ1Y3QgcGNpX2RldiAqZGV2OwogCXN0cnVjdCBwY2lfYnVz
ICpidXMgPSBwY2lfZmluZF9idXMoMCwgMSk7CiAJYm9vbCBibG9ja2VkOwogCisJaWYgKGV2ZW50
ICE9IEFDUElfTk9USUZZX0JVU19DSEVDSykKKwkJcmV0dXJuOworCiAJaWYgKCFidXMpIHsKIAkJ
cHJfd2FybmluZygiVW5hYmxlIHRvIGZpbmQgUENJIGJ1cyAxP1xuIik7CiAJCXJldHVybjsKQEAg
LTY5NywxNCArNjk3LDYgQEAgc3RhdGljIHZvaWQgZWVlcGNfaG90cGx1Z193b3JrKHN0cnVjdCB3
b3JrX3N0cnVjdCAqd29yaykKIAlyZmtpbGxfc2V0X3N3X3N0YXRlKGVob3RrLT53bGFuX3Jma2ls
bCwgYmxvY2tlZCk7CiB9CiAKLXN0YXRpYyB2b2lkIGVlZXBjX3Jma2lsbF9ub3RpZnkoYWNwaV9o
YW5kbGUgaGFuZGxlLCB1MzIgZXZlbnQsIHZvaWQgKmRhdGEpCi17Ci0JaWYgKGV2ZW50ICE9IEFD
UElfTk9USUZZX0JVU19DSEVDSykKLQkJcmV0dXJuOwotCi0Jc2NoZWR1bGVfd29yaygmZWhvdGst
PmhvdHBsdWdfd29yayk7Ci19Ci0KIHN0YXRpYyB2b2lkIGVlZXBjX2hvdGtfbm90aWZ5KHN0cnVj
dCBhY3BpX2RldmljZSAqZGV2aWNlLCB1MzIgZXZlbnQpCiB7CiAJc3RhdGljIHN0cnVjdCBrZXlf
ZW50cnkgKmtleTsKQEAgLTg3NywzMiArODY5LDYgQEAgc3RhdGljIGludCBlZWVwY19ob3RrX3Jl
bW92ZShzdHJ1Y3QgYWNwaV9kZXZpY2UgKmRldmljZSwgaW50IHR5cGUpCiAJcmV0dXJuIDA7CiB9
CiAKLXN0YXRpYyBpbnQgZWVlcGNfaG90a19yZXN1bWUoc3RydWN0IGFjcGlfZGV2aWNlICpkZXZp
Y2UpCi17Ci0JaWYgKGVob3RrLT53bGFuX3Jma2lsbCkgewotCQlib29sIHdsYW47Ci0KLQkJLyog
V29ya2Fyb3VuZCAtIGl0IHNlZW1zIHRoYXQgX1BUUyBkaXNhYmxlcyB0aGUgd2lyZWxlc3MKLQkJ
ICAgd2l0aG91dCBub3RpZmljYXRpb24gb3IgY2hhbmdpbmcgdGhlIHZhbHVlIHJlYWQgYnkgV0xB
Ti4KLQkJICAgTm9ybWFsbHkgdGhpcyBpcyBmaW5lIGJlY2F1c2UgdGhlIGNvcnJlY3QgdmFsdWUg
aXMgcmVzdG9yZWQKLQkJICAgZnJvbSB0aGUgbm9uLXZvbGF0aWxlIHN0b3JhZ2Ugb24gcmVzdW1l
LCBidXQgd2UgbmVlZCB0byBkbwotCQkgICBpdCBvdXJzZWxmIGlmIGNhc2Ugc3VzcGVuZCBpcyBh
Ym9ydGVkLCBvciB3ZSBsb3NlIHdpcmVsZXNzLgotCQkgKi8KLQkJd2xhbiA9IGdldF9hY3BpKENN
X0FTTF9XTEFOKTsKLQkJc2V0X2FjcGkoQ01fQVNMX1dMQU4sIHdsYW4pOwotCi0JCXJma2lsbF9z
ZXRfc3dfc3RhdGUoZWhvdGstPndsYW5fcmZraWxsLCB3bGFuICE9IDEpOwotCi0JCXNjaGVkdWxl
X3dvcmsoJmVob3RrLT5ob3RwbHVnX3dvcmspOwotCX0KLQotCWlmIChlaG90ay0+Ymx1ZXRvb3Ro
X3Jma2lsbCkKLQkJcmZraWxsX3NldF9zd19zdGF0ZShlaG90ay0+Ymx1ZXRvb3RoX3Jma2lsbCwK
LQkJCQkgICAgZ2V0X2FjcGkoQ01fQVNMX0JMVUVUT09USCkgIT0gMSk7Ci0KLQlyZXR1cm4gMDsK
LX0KLQogLyoKICAqIEh3bW9uCiAgKi8KQEAgLTEwOTQsOCArMTA2MCw2IEBAIHN0YXRpYyBpbnQg
ZWVlcGNfcmZraWxsX2luaXQoc3RydWN0IGRldmljZSAqZGV2KQogewogCWludCByZXN1bHQgPSAw
OwogCi0JSU5JVF9XT1JLKCZlaG90ay0+aG90cGx1Z193b3JrLCBlZWVwY19ob3RwbHVnX3dvcmsp
OwotCiAJZWVlcGNfcmVnaXN0ZXJfcmZraWxsX25vdGlmaWVyKCJcXF9TQi5QQ0kwLlAwUDYiKTsK
IAllZWVwY19yZWdpc3Rlcl9yZmtpbGxfbm90aWZpZXIoIlxcX1NCLlBDSTAuUDBQNyIpOwogCg==
--000325558fd6d92c320472347528--
