From: "Vladimir 'phcoder' Serbinenko" <phcoder@gmail.com>
Subject: Bad _BQC behaviour on Packard Bell Easynot BG-45
Date: Tue, 9 Jun 2009 17:19:16 +0200
Message-ID: <d7ead6de0906090819h177b7495xaa98dd062abf1f62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636c59860cb72ad046bebe143
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:41128 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753623AbZFIPTP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Jun 2009 11:19:15 -0400
Received: by bwz9 with SMTP id 9so52663bwz.37
        for <linux-acpi@vger.kernel.org>; Tue, 09 Jun 2009 08:19:16 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--001636c59860cb72ad046bebe143
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello. On the following model
	Manufacturer: Packard Bell BV
	Product Name: EasyNote_BG45-U-001CH
BQC returns a value between 0 and 15 but the brightness levels are
between 0 and 8. I could make a table of correspondance however I find
it too inflexible. So I propose the following patch which disables BQC
if it behaves badly

-- 
Regards
Vladimir 'phcoder' Serbinenko

--001636c59860cb72ad046bebe143
Content-Type: text/x-patch; charset=US-ASCII; name="bad_bqc.patch"
Content-Disposition: attachment; filename="bad_bqc.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fvqrbyue0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS92aWRlby5jIGIvZHJpdmVycy9hY3BpL3ZpZGVvLmMK
aW5kZXggMWJkZmIzNy4uMTczNWMzNCAxMDA2NDQKLS0tIGEvZHJpdmVycy9hY3BpL3ZpZGVvLmMK
KysrIGIvZHJpdmVycy9hY3BpL3ZpZGVvLmMKQEAgLTU5NCw2ICs1OTQsNyBAQCBhY3BpX3ZpZGVv
X2RldmljZV9sY2RfZ2V0X2xldmVsX2N1cnJlbnQoc3RydWN0IGFjcGlfdmlkZW9fZGV2aWNlICpk
ZXZpY2UsCiAJCQkJCXVuc2lnbmVkIGxvbmcgbG9uZyAqbGV2ZWwpCiB7CiAJYWNwaV9zdGF0dXMg
c3RhdHVzID0gQUVfT0s7CisJaW50IGk7CiAKIAlpZiAoZGV2aWNlLT5jYXAuX0JRQyB8fCBkZXZp
Y2UtPmNhcC5fQkNRKSB7CiAJCWNoYXIgKmJ1ZiA9IGRldmljZS0+Y2FwLl9CUUMgPyAiX0JRQyIg
OiAiX0JDUSI7CkBAIC02MDksOCArNjEwLDE1IEBAIGFjcGlfdmlkZW9fZGV2aWNlX2xjZF9nZXRf
bGV2ZWxfY3VycmVudChzdHJ1Y3QgYWNwaV92aWRlb19kZXZpY2UgKmRldmljZSwKIAogCQkJfQog
CQkJKmxldmVsICs9IGJxY19vZmZzZXRfYW1sX2J1Z193b3JrYXJvdW5kOwotCQkJZGV2aWNlLT5i
cmlnaHRuZXNzLT5jdXJyID0gKmxldmVsOwotCQkJcmV0dXJuIDA7CisgCQkJZm9yIChpID0gMjsg
aSA8IGRldmljZS0+YnJpZ2h0bmVzcy0+Y291bnQ7IGkrKykKKyAJCQkgICAgICAgIGlmIChkZXZp
Y2UtPmJyaWdodG5lc3MtPmxldmVsc1tpXSA9PSAqbGV2ZWwpIHsKKyAJCQkJICAgICAgICBkZXZp
Y2UtPmJyaWdodG5lc3MtPmN1cnIgPSAqbGV2ZWw7CisgCQkJICAgICAgICAgICAgICAgIHJldHVy
biAwOworIAkJCSAgICAgICAgfQorIAkJCS8qIEJRQyByZXR1cm5lZCBhbiBpbnZhbGlkIGxldmVs
LiBTdG9wIHVzaW5nIGl0LiAgKi8KKyAJCQlBQ1BJX1dBUk5JTkcoKEFFX0lORk8sICIlcyByZXR1
cm5lZCBhbiBpbnZhbGlkIGxldmVsIiwKKyAJCQkJICAgICAgYnVmKSk7CisgCQkJZGV2aWNlLT5j
YXAuX0JRQyA9IGRldmljZS0+Y2FwLl9CQ1EgPSAwOwogCQl9IGVsc2UgewogCQkJLyogRml4bWU6
CiAJCQkgKiBzaG91bGQgd2UgcmV0dXJuIGFuIGVycm9yIG9yIGlnbm9yZSB0aGlzIGZhaWx1cmU/
Cg==
--001636c59860cb72ad046bebe143--
