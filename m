From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 21/32] eeepc-laptop: Port to new backlight interface
 selection API
Date: Fri, 12 Jun 2015 13:23:40 +0200
Message-ID: <1434108231-12323-22-git-send-email-hdegoede@redhat.com>
References: <1434108231-12323-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1434108231-12323-1-git-send-email-hdegoede@redhat.com>
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
R29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+Ci0tLQogZHJpdmVycy9wbGF0Zm9ybS94ODYvZWVl
cGMtbGFwdG9wLmMgfCA1ICsrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAz
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2VlZXBjLWxh
cHRvcC5jIGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvZWVlcGMtbGFwdG9wLmMKaW5kZXggODQ0YzIw
OS4uOGNkZjMxNSAxMDA2NDQKLS0tIGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvZWVlcGMtbGFwdG9w
LmMKKysrIGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvZWVlcGMtbGFwdG9wLmMKQEAgLTM3LDYgKzM3
LDcgQEAKICNpbmNsdWRlIDxsaW51eC9wY2lfaG90cGx1Zy5oPgogI2luY2x1ZGUgPGxpbnV4L2xl
ZHMuaD4KICNpbmNsdWRlIDxsaW51eC9kbWkuaD4KKyNpbmNsdWRlIDxhY3BpL3ZpZGVvLmg+CiAK
ICNkZWZpbmUgRUVFUENfTEFQVE9QX1ZFUlNJT04JIjAuMSIKICNkZWZpbmUgRUVFUENfTEFQVE9Q
X05BTUUJIkVlZSBQQyBIb3RrZXkgRHJpdmVyIgpAQCAtMTQzMywxMiArMTQzNCwxMCBAQCBzdGF0
aWMgaW50IGVlZXBjX2FjcGlfYWRkKHN0cnVjdCBhY3BpX2RldmljZSAqZGV2aWNlKQogCWlmIChy
ZXN1bHQpCiAJCWdvdG8gZmFpbF9wbGF0Zm9ybTsKIAotCWlmICghYWNwaV92aWRlb19iYWNrbGln
aHRfc3VwcG9ydCgpKSB7CisJaWYgKGFjcGlfdmlkZW9fZ2V0X2JhY2tsaWdodF90eXBlKCkgPT0g
YWNwaV9iYWNrbGlnaHRfdmVuZG9yKSB7CiAJCXJlc3VsdCA9IGVlZXBjX2JhY2tsaWdodF9pbml0
KGVlZXBjKTsKIAkJaWYgKHJlc3VsdCkKIAkJCWdvdG8gZmFpbF9iYWNrbGlnaHQ7Ci0JfSBlbHNl
IHsKLQkJcHJfaW5mbygiQmFja2xpZ2h0IGNvbnRyb2xsZWQgYnkgQUNQSSB2aWRlbyBkcml2ZXJc
biIpOwogCX0KIAogCXJlc3VsdCA9IGVlZXBjX2lucHV0X2luaXQoZWVlcGMpOwotLSAKMi40LjIK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZl
bCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
