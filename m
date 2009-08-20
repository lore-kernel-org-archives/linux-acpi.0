From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [Debian-eeepc-devel] Problems with wlan on a 1005HA-M
Date: Thu, 20 Aug 2009 14:38:58 +0100
Message-ID: <9b2b86520908200638y75c0c80cm4faf9a5c67b61397@mail.gmail.com>
References: <4A8D32A8.8000702@oss42.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000325557abaa3f482047192df8a
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:35002 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754365AbZHTNi5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Aug 2009 09:38:57 -0400
In-Reply-To: <4A8D32A8.8000702@oss42.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Karsten Jaeger <lists@oss42.com>
Cc: debian-eeepc-devel@lists.alioth.debian.org, Kernel Testers List <kernel-testers@vger.kernel.org>, acpi4asus-user <acpi4asus-user@lists.sourceforge.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

--000325557abaa3f482047192df8a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 8/20/09, Karsten Jaeger <lists@oss42.com> wrote:
> Hi there,
>
> I've just ask in IRC for help and was ask to write it to the list.
>
> Last week I bought my EeePC 1005HA-M. It comes with Windows and Ubuntu
> Installation, everything works fine.
> Because my favorite OS is Debian I install it on the EeePC with
> Standard-Lenny and kernel linux-image-2.6.31-rc5, updating it to sid and
> everything worked fine. I updated it last sunday with latest sid and
> kernel linux-image-2.6.31-rc6, put in in sleep mode (which worked fine
> before) and want to restart it again on monday but nothing worked, I
> have a black screen and it do not return from sleep. So I do an cold reboot.
> After that, my wlan said, it have an segmentation fault and also gives
> the line back:
>
> SIOCSIFFLAGS: Unknown error 132
> Because I want to change some more, I do reinstalling it all, but since
> than, I can't get wlan to work again.
>
> As attachment I give you some files, that I do think are nessesary. If
> you need more, just give a hint.

That looks like the new rfkill error code.  Basically it means the
wireless has been disabled.  I guess the segmentation fault is a
userspace bug, unless you also see a BUG message in dmesg.

You should definitely be able to re-enable the wireless using the BIOS
setup screen... try these instructions:

<http://www.1-script.com/forums/wireless-card-and-camera-no-longer-work-or-show-in-hardware-article46509--25.htm>

Are you able to confirm that this happens just by upgrading the
kernel?  If so, there's only one eeepc-laptop commit between -rc5 and
-rc6, and I'm afraid it's mine.

I re-wrote it again for 2.6.32 in a slightly more sensible way.  If
we're lucky, your problem is fixed by the re-write and it can be
expedited for 2.6.31.  I've attached the relevant changes as a test
patch; it should apply cleanly to 2.6.31-rc6.

Regards
Alan

--000325557abaa3f482047192df8a
Content-Type: text/x-diff; charset=US-ASCII; name="test.patch"
Content-Disposition: attachment; filename="test.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: file0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2VlZXBjLWxhcHRvcC5jIGIvZHJpdmVy
cy9wbGF0Zm9ybS94ODYvZWVlcGMtbGFwdG9wLmMKaW5kZXggMjIyZmZiOC4uMTc5MDEwMyAxMDA2
NDQKLS0tIGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvZWVlcGMtbGFwdG9wLmMKKysrIGIvZHJpdmVy
cy9wbGF0Zm9ybS94ODYvZWVlcGMtbGFwdG9wLmMKQEAgLTE0Myw3ICsxNDMsNyBAQCBzdHJ1Y3Qg
ZWVlcGNfaG90ayB7CiAJc3RydWN0IHJma2lsbCAqYmx1ZXRvb3RoX3Jma2lsbDsKIAlzdHJ1Y3Qg
cmZraWxsICp3d2FuM2dfcmZraWxsOwogCXN0cnVjdCBob3RwbHVnX3Nsb3QgKmhvdHBsdWdfc2xv
dDsKLQlzdHJ1Y3Qgd29ya19zdHJ1Y3QgaG90cGx1Z193b3JrOworCXN0cnVjdCBtdXRleCBob3Rw
bHVnX2xvY2s7CiB9OwogCiAvKiBUaGUgYWN0dWFsIGRldmljZSB0aGUgZHJpdmVyIGJpbmRzIHRv
ICovCkBAIC02NjEsMjQgKzY2MSwzMSBAQCBzdGF0aWMgaW50IGVlZXBjX2dldF9hZGFwdGVyX3N0
YXR1cyhzdHJ1Y3QgaG90cGx1Z19zbG90ICpob3RwbHVnX3Nsb3QsCiAJcmV0dXJuIDA7CiB9CiAK
LXN0YXRpYyB2b2lkIGVlZXBjX2hvdHBsdWdfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmsp
CitzdGF0aWMgdm9pZCBlZWVwY19yZmtpbGxfaG90cGx1Zyh2b2lkKQogewogCXN0cnVjdCBwY2lf
ZGV2ICpkZXY7Ci0Jc3RydWN0IHBjaV9idXMgKmJ1cyA9IHBjaV9maW5kX2J1cygwLCAxKTsKLQli
b29sIGJsb2NrZWQ7CisJc3RydWN0IHBjaV9idXMgKmJ1czsKKwlib29sIGJsb2NrZWQgPSBlZWVw
Y193bGFuX3Jma2lsbF9ibG9ja2VkKCk7CisKKwlyZmtpbGxfc2V0X3N3X3N0YXRlKGVob3RrLT53
bGFuX3Jma2lsbCwgYmxvY2tlZCk7CisKKwltdXRleF9sb2NrKCZlaG90ay0+aG90cGx1Z19sb2Nr
KTsKIAorCWlmIChlaG90ay0+aG90cGx1Z19zbG90ID09IE5VTEwpCisJCWdvdG8gb3V0X3VubG9j
azsKKworCWJ1cyA9IHBjaV9maW5kX2J1cygwLCAxKTsKIAlpZiAoIWJ1cykgewogCQlwcl93YXJu
aW5nKCJVbmFibGUgdG8gZmluZCBQQ0kgYnVzIDE/XG4iKTsKLQkJcmV0dXJuOworCQlnb3RvIG91
dF91bmxvY2s7CiAJfQogCi0JYmxvY2tlZCA9IGVlZXBjX3dsYW5fcmZraWxsX2Jsb2NrZWQoKTsK
IAlpZiAoIWJsb2NrZWQpIHsKIAkJZGV2ID0gcGNpX2dldF9zbG90KGJ1cywgMCk7CiAJCWlmIChk
ZXYpIHsKIAkJCS8qIERldmljZSBhbHJlYWR5IHByZXNlbnQgKi8KIAkJCXBjaV9kZXZfcHV0KGRl
dik7Ci0JCQlyZXR1cm47CisJCQlnb3RvIG91dF91bmxvY2s7CiAJCX0KIAkJZGV2ID0gcGNpX3Nj
YW5fc2luZ2xlX2RldmljZShidXMsIDApOwogCQlpZiAoZGV2KSB7CkBAIC02OTQsNyArNzAxLDgg
QEAgc3RhdGljIHZvaWQgZWVlcGNfaG90cGx1Z193b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29y
aykKIAkJfQogCX0KIAotCXJma2lsbF9zZXRfc3dfc3RhdGUoZWhvdGstPndsYW5fcmZraWxsLCBi
bG9ja2VkKTsKK291dF91bmxvY2s6CisJbXV0ZXhfdW5sb2NrKCZlaG90ay0+aG90cGx1Z19sb2Nr
KTsKIH0KIAogc3RhdGljIHZvaWQgZWVlcGNfcmZraWxsX25vdGlmeShhY3BpX2hhbmRsZSBoYW5k
bGUsIHUzMiBldmVudCwgdm9pZCAqZGF0YSkKQEAgLTcwMiw3ICs3MTAsNyBAQCBzdGF0aWMgdm9p
ZCBlZWVwY19yZmtpbGxfbm90aWZ5KGFjcGlfaGFuZGxlIGhhbmRsZSwgdTMyIGV2ZW50LCB2b2lk
ICpkYXRhKQogCWlmIChldmVudCAhPSBBQ1BJX05PVElGWV9CVVNfQ0hFQ0spCiAJCXJldHVybjsK
IAotCXNjaGVkdWxlX3dvcmsoJmVob3RrLT5ob3RwbHVnX3dvcmspOworCWVlZXBjX3Jma2lsbF9o
b3RwbHVnKCk7CiB9CiAKIHN0YXRpYyB2b2lkIGVlZXBjX2hvdGtfbm90aWZ5KHN0cnVjdCBhY3Bp
X2RldmljZSAqZGV2aWNlLCB1MzIgZXZlbnQpCkBAIC04OTMsNyArOTAxLDcgQEAgc3RhdGljIGlu
dCBlZWVwY19ob3RrX3Jlc3VtZShzdHJ1Y3QgYWNwaV9kZXZpY2UgKmRldmljZSkKIAogCQlyZmtp
bGxfc2V0X3N3X3N0YXRlKGVob3RrLT53bGFuX3Jma2lsbCwgd2xhbiAhPSAxKTsKIAotCQlzY2hl
ZHVsZV93b3JrKCZlaG90ay0+aG90cGx1Z193b3JrKTsKKwkJZWVlcGNfcmZraWxsX2hvdHBsdWco
KTsKIAl9CiAKIAlpZiAoZWhvdGstPmJsdWV0b290aF9yZmtpbGwpCkBAIC0xMDk0LDcgKzExMDIs
NyBAQCBzdGF0aWMgaW50IGVlZXBjX3Jma2lsbF9pbml0KHN0cnVjdCBkZXZpY2UgKmRldikKIHsK
IAlpbnQgcmVzdWx0ID0gMDsKIAotCUlOSVRfV09SSygmZWhvdGstPmhvdHBsdWdfd29yaywgZWVl
cGNfaG90cGx1Z193b3JrKTsKKwltdXRleF9pbml0KCZlaG90ay0+aG90cGx1Z19sb2NrKTsKIAog
CWVlZXBjX3JlZ2lzdGVyX3Jma2lsbF9ub3RpZmllcigiXFxfU0IuUENJMC5QMFA2Iik7CiAJZWVl
cGNfcmVnaXN0ZXJfcmZraWxsX25vdGlmaWVyKCJcXF9TQi5QQ0kwLlAwUDciKTsK
--000325557abaa3f482047192df8a--
