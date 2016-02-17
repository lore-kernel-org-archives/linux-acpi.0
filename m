From: Dave Airlie <airlied@gmail.com>
Subject: Lenovo W541, windows 10 and ACPI PM
Date: Wed, 17 Feb 2016 11:57:49 +1000
Message-ID: <CAPM=9tyY9bkCh2+-Sn3AXN+R4rZOS1z--bZoycGBmStQS2-bMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11c3cd70bdb61f052bed9378
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:35455 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933619AbcBQB5v (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Feb 2016 20:57:51 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>

--001a11c3cd70bdb61f052bed9378
Content-Type: text/plain; charset=UTF-8

So we got a bug filed in Fedora 23 that the nvidia GPU wasn't stalling
on resume from runtime poweroff. When we looked into it, we noticed
the GPU wasn't powering off and the delay was from things going to
hell after that.

I dug out the DSDT and noticed it has special Windows 10 handling code
for the SB.PCI0.PEG.VID device. Adding acpi_osi="!Windows 2013" made
things work again and everyone rejoiced and had battery life again.

Now what to do about this? I doubt this is restricted to the W541
laptop, I assume all Optimus laptops that support windows 10 will have
this problem, so I'm not sure blacklisting on a case by case basis is
going to help.

More information from investigation:
On Win7/8 paths, the way to poweroff the GPU is to call an ACPI _DSM
on the VID device that sets a magic bit, then the next time you go
into D3 the _PS3 method gets called and powers the device down. This
is to make up for the lack of D3cold in Windows at the time I suspect.

Now with Win10, the PCI0.PEG device has power resource methods,
specifically PR3 which enables D3cold. However nouveau is bound to the
VID device not the PEG device, so never attempts to power it down
using those methods. I've hacked up the attached patch, and it does
indeed power the device down, but I've no idea how this is meant to
work in real world.

Dave.

--001a11c3cd70bdb61f052bed9378
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-nouveau-hack-the-parent-power-down-so-the-GPU-powers.patch"
Content-Disposition: attachment;
	filename="0001-nouveau-hack-the-parent-power-down-so-the-GPU-powers.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ikq6ul660

RnJvbSA3NTNiYmIyMDJiOGU0NjRjYjQyNTM3MjI2NjA0MmNjN2Q2MGQzNTEzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZlIEFpcmxpZSA8YWlybGllZEByZWRoYXQuY29tPgpEYXRl
OiBXZWQsIDE3IEZlYiAyMDE2IDIzOjIxOjEzICsxMDAwClN1YmplY3Q6IFtQQVRDSF0gbm91dmVh
dTogaGFjayB0aGUgcGFyZW50IHBvd2VyIGRvd24gc28gdGhlIEdQVSBwb3dlcnMgZG93bi4KCi0t
LQogZHJpdmVycy9hY3BpL2RldmljZV9wbS5jICAgICAgICAgICAgICB8ICAzICsrKwogZHJpdmVy
cy9ncHUvZHJtL25vdXZlYXUvbm91dmVhdV9kcm0uYyB8IDE2ICsrKysrKysrKysrKysrKysKIDIg
ZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNw
aS9kZXZpY2VfcG0uYyBiL2RyaXZlcnMvYWNwaS9kZXZpY2VfcG0uYwppbmRleCBjZDJjM2Q2Li44
Njk2ODg5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2FjcGkvZGV2aWNlX3BtLmMKKysrIGIvZHJpdmVy
cy9hY3BpL2RldmljZV9wbS5jCkBAIC0xMTcsNiArMTE3LDkgQEAgaW50IGFjcGlfZGV2aWNlX2dl
dF9wb3dlcihzdHJ1Y3QgYWNwaV9kZXZpY2UgKmRldmljZSwgaW50ICpzdGF0ZSkKIAkgICAgJiYg
cmVzdWx0ID09IEFDUElfU1RBVEVfRDApCiAJCWRldmljZS0+cGFyZW50LT5wb3dlci5zdGF0ZSA9
IEFDUElfU1RBVEVfRDA7CiAKKwlpZiAocmVzdWx0ID09IEFDUElfU1RBVEVfVU5LTk9XTikKKwkJ
cmVzdWx0ID0gZGV2aWNlLT5wYXJlbnQgPworCQkJZGV2aWNlLT5wYXJlbnQtPnBvd2VyLnN0YXRl
IDogQUNQSV9TVEFURV9EMDsKIAkqc3RhdGUgPSByZXN1bHQ7CiAKICBvdXQ6CmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vbm91dmVhdS9ub3V2ZWF1X2RybS5jIGIvZHJpdmVycy9ncHUvZHJt
L25vdXZlYXUvbm91dmVhdV9kcm0uYwppbmRleCAyZjJmMjUyLi5kOWIyYmQ2IDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vbm91dmVhdS9ub3V2ZWF1X2RybS5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9ub3V2ZWF1L25vdXZlYXVfZHJtLmMKQEAgLTcxNSw2ICs3MTUsMTQgQEAgbm91dmVhdV9w
bW9wc19ydW50aW1lX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQogCXBjaV9kaXNhYmxlX2Rl
dmljZShwZGV2KTsKIAlwY2lfaWdub3JlX2hvdHBsdWcocGRldik7CiAJcGNpX3NldF9wb3dlcl9z
dGF0ZShwZGV2LCBQQ0lfRDNjb2xkKTsKKwl7CisJCXN0cnVjdCBhY3BpX2RldmljZSAqYWRldjsK
KwkJaW50IHI7CisKKwkJciA9IGFjcGlfYnVzX2dldF9kZXZpY2UoQUNQSV9IQU5ETEUoJnBkZXYt
PmRldiksICZhZGV2KTsKKwkJaWYgKCFyKQorCQkJYWNwaV9kZXZpY2Vfc2V0X3Bvd2VyKGFkZXYt
PnBhcmVudCwgQUNQSV9TVEFURV9EM19DT0xEKTsKKwl9CiAJZHJtX2Rldi0+c3dpdGNoX3Bvd2Vy
X3N0YXRlID0gRFJNX1NXSVRDSF9QT1dFUl9EWU5BTUlDX09GRjsKIAlyZXR1cm4gcmV0OwogfQpA
QCAtNzMwLDYgKzczOCwxNCBAQCBub3V2ZWF1X3Btb3BzX3J1bnRpbWVfcmVzdW1lKHN0cnVjdCBk
ZXZpY2UgKmRldikKIAlpZiAobm91dmVhdV9ydW50aW1lX3BtID09IDApCiAJCXJldHVybiAtRUlO
VkFMOwogCisJeworCQlzdHJ1Y3QgYWNwaV9kZXZpY2UgKmFkZXY7CisJCWludCByOworCisJCXIg
PSBhY3BpX2J1c19nZXRfZGV2aWNlKEFDUElfSEFORExFKCZwZGV2LT5kZXYpLCAmYWRldik7CisJ
CWlmICghcikKKwkJCWFjcGlfZGV2aWNlX3NldF9wb3dlcihhZGV2LT5wYXJlbnQsIEFDUElfU1RB
VEVfRDApOworCX0KIAlwY2lfc2V0X3Bvd2VyX3N0YXRlKHBkZXYsIFBDSV9EMCk7CiAJcGNpX3Jl
c3RvcmVfc3RhdGUocGRldik7CiAJcmV0ID0gcGNpX2VuYWJsZV9kZXZpY2UocGRldik7Ci0tIAoy
LjUuMAoK
--001a11c3cd70bdb61f052bed9378--
