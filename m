From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 16/32] asus-laptop: Port to new backlight interface selection
 API
Date: Wed, 10 Jun 2015 15:01:16 +0200
Message-ID: <1433941292-21530-17-git-send-email-hdegoede@redhat.com>
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
R29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+Ci0tLQogZHJpdmVycy9wbGF0Zm9ybS94ODYvYXN1
cy1sYXB0b3AuYyB8IDYgKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAz
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2FzdXMtbGFw
dG9wLmMgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9hc3VzLWxhcHRvcC5jCmluZGV4IDQ2YjI3NDYu
LjU4ZDI5YzQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2FzdXMtbGFwdG9wLmMK
KysrIGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvYXN1cy1sYXB0b3AuYwpAQCAtNTQsNiArNTQsNyBA
QAogI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4KICNpbmNsdWRlIDxsaW51eC9kbWkuaD4KICNpbmNs
dWRlIDxsaW51eC9hY3BpLmg+CisjaW5jbHVkZSA8YWNwaS92aWRlby5oPgogCiAjZGVmaW5lIEFT
VVNfTEFQVE9QX1ZFUlNJT04JIjAuNDIiCiAKQEAgLTE4ODQsMTIgKzE4ODUsMTEgQEAgc3RhdGlj
IGludCBhc3VzX2FjcGlfYWRkKHN0cnVjdCBhY3BpX2RldmljZSAqZGV2aWNlKQogCWlmIChyZXN1
bHQpCiAJCWdvdG8gZmFpbF9wbGF0Zm9ybTsKIAotCWlmICghYWNwaV92aWRlb19iYWNrbGlnaHRf
c3VwcG9ydCgpKSB7CisJaWYgKGFjcGlfdmlkZW9fZ2V0X2JhY2tsaWdodF90eXBlKCkgPT0gYWNw
aV9iYWNrbGlnaHRfdmVuZG9yKSB7CiAJCXJlc3VsdCA9IGFzdXNfYmFja2xpZ2h0X2luaXQoYXN1
cyk7CiAJCWlmIChyZXN1bHQpCiAJCQlnb3RvIGZhaWxfYmFja2xpZ2h0OwotCX0gZWxzZQotCQlw
cl9pbmZvKCJCYWNrbGlnaHQgY29udHJvbGxlZCBieSBBQ1BJIHZpZGVvIGRyaXZlclxuIik7CisJ
fQogCiAJcmVzdWx0ID0gYXN1c19pbnB1dF9pbml0KGFzdXMpOwogCWlmIChyZXN1bHQpCi0tIAoy
LjQuMgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJp
LWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
