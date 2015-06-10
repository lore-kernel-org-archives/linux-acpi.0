From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 25/32] msi-laptop: Port to new backlight interface selection
 API
Date: Wed, 10 Jun 2015 15:01:25 +0200
Message-ID: <1433941292-21530-26-git-send-email-hdegoede@redhat.com>
References: <1433941292-21530-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1433941292-21530-1-git-send-email-hdegoede@redhat.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Darren Hart <dvhart@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Hans de Goede <hdegoede@redhat.com>, Ike Panhc <ike.pan@canonical.com>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, acpi4asus-user@lists.sourceforge.net, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, dri-devel@lists.freedesktop.org, Azael Avalos <coproscefalo@gmail.com>, Lee Chun-Yi <jlee@suse.com>, Mattia Dongili <malattia@linux.it>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Ben Skeggs <bskeggs@redhat.com>, Corentin Chary <corentin.chary@gmail.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, platform-driver-x86@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>
List-Id: linux-acpi@vger.kernel.org

UG9ydCB0aGUgYmFja2xpZ2h0IHNlbGVjdGlvbiBsb2dpYyB0byB0aGUgbmV3IGJhY2tsaWdodCBp
bnRlcmZhY2UKc2VsZWN0aW9uIEFQSS4KClRoaXMgY29tbWl0IGFsc28gcmVtb3ZlcyB2YXJpb3Vz
IG9ic29sZXRlIHByX3h4eCBtZXNzYWdlcyByZWxhdGVkIHRvCmJhY2tsaWdodCBpbnRlcmZhY2Ug
c2VsZWN0aW9uLiBUaGVzZSBhcmUgb2Jzb2xldGUgYmVjYXVzZSB0aGV5IGFzc3VtZQp0aGVyZSBp
cyBvbmx5IGEgdmVuZG9yIG9yIGFjcGkgYmFja2xpZ2h0IGRyaXZlciBhbmQgbm8gb3RoZXIgY2hv
aWNlLgpBbHNvIHRoZXkgYXJlIG5vdCBuZWNlc3NhcnksIGlmIHRoZSB1c2VyIHdhbnRzIHRvIGtu
b3cgd2hpY2ggYmFja2xpZ2h0CmludGVyZmFjZXMgYXJlIHJlZ2lzdGVyZWQgYSBzaW1wbGUgImxz
IC9zeXMvY2xhc3MvYmFja2xpZ2h0IiBzdWZmaWNlcy4KClNpZ25lZC1vZmYtYnk6IEhhbnMgZGUg
R29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+Ci0tLQogZHJpdmVycy9wbGF0Zm9ybS94ODYvbXNp
LWxhcHRvcC5jIHwgNiArKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvbXNpLWxhcHRv
cC5jIGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvbXNpLWxhcHRvcC5jCmluZGV4IDA4NTk4NzcuLjQy
MzE3NzAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L21zaS1sYXB0b3AuYworKysg
Yi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9tc2ktbGFwdG9wLmMKQEAgLTY0LDYgKzY0LDcgQEAKICNp
bmNsdWRlIDxsaW51eC9pODA0Mi5oPgogI2luY2x1ZGUgPGxpbnV4L2lucHV0Lmg+CiAjaW5jbHVk
ZSA8bGludXgvaW5wdXQvc3BhcnNlLWtleW1hcC5oPgorI2luY2x1ZGUgPGFjcGkvdmlkZW8uaD4K
IAogI2RlZmluZSBNU0lfRFJJVkVSX1ZFUlNJT04gIjAuNSIKIApAQCAtMTA2OSw5ICsxMDcwLDgg
QEAgc3RhdGljIGludCBfX2luaXQgbXNpX2luaXQodm9pZCkKIAogCS8qIFJlZ2lzdGVyIGJhY2ts
aWdodCBzdHVmZiAqLwogCi0JaWYgKCFxdWlya3MtPm9sZF9lY19tb2RlbCB8fCBhY3BpX3ZpZGVv
X2JhY2tsaWdodF9zdXBwb3J0KCkpIHsKLQkJcHJfaW5mbygiQnJpZ2h0bmVzcyBpZ25vcmVkLCBt
dXN0IGJlIGNvbnRyb2xsZWQgYnkgQUNQSSB2aWRlbyBkcml2ZXJcbiIpOwotCX0gZWxzZSB7CisJ
aWYgKHF1aXJrcy0+b2xkX2VjX21vZGVsIHx8CisJICAgIGFjcGlfdmlkZW9fZ2V0X2JhY2tsaWdo
dF90eXBlKCkgPT0gYWNwaV9iYWNrbGlnaHRfdmVuZG9yKSB7CiAJCXN0cnVjdCBiYWNrbGlnaHRf
cHJvcGVydGllcyBwcm9wczsKIAkJbWVtc2V0KCZwcm9wcywgMCwgc2l6ZW9mKHN0cnVjdCBiYWNr
bGlnaHRfcHJvcGVydGllcykpOwogCQlwcm9wcy50eXBlID0gQkFDS0xJR0hUX1BMQVRGT1JNOwot
LSAKMi40LjIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
