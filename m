From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 30/32] toshiba-acpi: Port to new backlight interface
 selection API
Date: Fri, 12 Jun 2015 13:23:49 +0200
Message-ID: <1434108231-12323-31-git-send-email-hdegoede@redhat.com>
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
bnRlcmZhY2UKc2VsZWN0aW9uIEFQSS4KCkFsc28gZml4IGEgY29tcGlsZXIgd2FybmluZyBhYm91
dCBidF9wcmVzZW50IG5vdCBiZWluZyBpbml0aWFsaXplZC4KClNpZ25lZC1vZmYtYnk6IEhhbnMg
ZGUgR29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+Ci0tLQogZHJpdmVycy9wbGF0Zm9ybS94ODYv
dG9zaGliYV9hY3BpLmMgfCA5ICsrKy0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni90
b3NoaWJhX2FjcGkuYyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L3Rvc2hpYmFfYWNwaS5jCmluZGV4
IDk5NTZiOTkwLi5jNDg0ZDQ3IDEwMDY0NAotLS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni90b3No
aWJhX2FjcGkuYworKysgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni90b3NoaWJhX2FjcGkuYwpAQCAt
MjY0MCwxNCArMjY0MCwxMSBAQCBzdGF0aWMgaW50IHRvc2hpYmFfYWNwaV9zZXR1cF9iYWNrbGln
aHQoc3RydWN0IHRvc2hpYmFfYWNwaV9kZXYgKmRldikKIAkgKi8KIAlpZiAoZGV2LT50cl9iYWNr
bGlnaHRfc3VwcG9ydGVkIHx8CiAJICAgIGRtaV9jaGVja19zeXN0ZW0odG9zaGliYV92ZW5kb3Jf
YmFja2xpZ2h0X2RtaSkpCi0JCWFjcGlfdmlkZW9fZG1pX3Byb21vdGVfdmVuZG9yKCk7CisJCWFj
cGlfdmlkZW9fc2V0X2RtaV9iYWNrbGlnaHRfdHlwZShhY3BpX2JhY2tsaWdodF92ZW5kb3IpOwog
Ci0JaWYgKGFjcGlfdmlkZW9fYmFja2xpZ2h0X3N1cHBvcnQoKSkKKwlpZiAoYWNwaV92aWRlb19n
ZXRfYmFja2xpZ2h0X3R5cGUoKSAhPSBhY3BpX2JhY2tsaWdodF92ZW5kb3IpCiAJCXJldHVybiAw
OwogCi0JLyogYWNwaS12aWRlbyBtYXkgaGF2ZSBsb2FkZWQgYmVmb3JlIHdlIGNhbGxlZCBkbWlf
cHJvbW90ZV92ZW5kb3IoKSAqLwotCWFjcGlfdmlkZW9fdW5yZWdpc3Rlcl9iYWNrbGlnaHQoKTsK
LQogCW1lbXNldCgmcHJvcHMsIDAsIHNpemVvZihwcm9wcykpOwogCXByb3BzLnR5cGUgPSBCQUNL
TElHSFRfUExBVEZPUk07CiAJcHJvcHMubWF4X2JyaWdodG5lc3MgPSBIQ0lfTENEX0JSSUdIVE5F
U1NfTEVWRUxTIC0gMTsKQEAgLTI3MzMsNyArMjczMCw3IEBAIHN0YXRpYyBpbnQgdG9zaGliYV9h
Y3BpX2FkZChzdHJ1Y3QgYWNwaV9kZXZpY2UgKmFjcGlfZGV2KQogCWNvbnN0IGNoYXIgKmhjaV9t
ZXRob2Q7CiAJdTMyIHNwZWNpYWxfZnVuY3Rpb25zOwogCXUzMiBkdW1teTsKLQlib29sIGJ0X3By
ZXNlbnQ7CisJYm9vbCBidF9wcmVzZW50ID0gZmFsc2U7CiAJaW50IHJldCA9IDA7CiAKIAlpZiAo
dG9zaGliYV9hY3BpKQotLSAKMi40LjIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vZHJpLWRldmVsCg==
