From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 24/32] intel-oaktrail: Port to new backlight interface
 selection API
Date: Wed, 10 Jun 2015 15:01:24 +0200
Message-ID: <1433941292-21530-25-git-send-email-hdegoede@redhat.com>
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
R29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+Ci0tLQogZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50
ZWxfb2FrdHJhaWwuYyB8IDcgKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRl
bF9vYWt0cmFpbC5jIGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWxfb2FrdHJhaWwuYwppbmRl
eCA4MDM3YzhiLi42YWEzM2M0IDEwMDY0NAotLS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRl
bF9vYWt0cmFpbC5jCisrKyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsX29ha3RyYWlsLmMK
QEAgLTUwLDYgKzUwLDcgQEAKICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4KICNp
bmNsdWRlIDxsaW51eC9kbWkuaD4KICNpbmNsdWRlIDxsaW51eC9yZmtpbGwuaD4KKyNpbmNsdWRl
IDxhY3BpL3ZpZGVvLmg+CiAKICNkZWZpbmUgRFJJVkVSX05BTUUJImludGVsX29ha3RyYWlsIgog
I2RlZmluZSBEUklWRVJfVkVSU0lPTgkiMC40YWMxIgpAQCAtMzQzLDEzICszNDQsMTEgQEAgc3Rh
dGljIGludCBfX2luaXQgb2FrdHJhaWxfaW5pdCh2b2lkKQogCQlnb3RvIGVycl9kZXZpY2VfYWRk
OwogCX0KIAotCWlmICghYWNwaV92aWRlb19iYWNrbGlnaHRfc3VwcG9ydCgpKSB7CisJaWYgKGFj
cGlfdmlkZW9fZ2V0X2JhY2tsaWdodF90eXBlKCkgPT0gYWNwaV9iYWNrbGlnaHRfdmVuZG9yKSB7
CiAJCXJldCA9IG9ha3RyYWlsX2JhY2tsaWdodF9pbml0KCk7CiAJCWlmIChyZXQpCiAJCQlnb3Rv
IGVycl9iYWNrbGlnaHQ7Ci0KLQl9IGVsc2UKLQkJcHJfaW5mbygiQmFja2xpZ2h0IGNvbnRyb2xs
ZWQgYnkgQUNQSSB2aWRlbyBkcml2ZXJcbiIpOworCX0KIAogCXJldCA9IG9ha3RyYWlsX3Jma2ls
bF9pbml0KCk7CiAJaWYgKHJldCkgewotLSAKMi40LjIKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVs
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vZHJpLWRldmVsCg==
