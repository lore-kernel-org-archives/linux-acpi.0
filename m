From: "Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Subject: [PATCH] add access to ACPI docking station UID
Date: Mon, 19 Feb 2007 15:19:31 -0800
Message-ID: <45DA3083.9080604@total-knowledge.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080809070601010508030702"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from alpha.total-knowledge.com ([205.217.158.170]:45244 "EHLO
	total-knowledge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965533AbXBSX0W (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Feb 2007 18:26:22 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------080809070601010508030702
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

It is useful to know whether your laptop is docked or not,
but it is even more useful to know which docking station it's
docked to. Attached patch adds "uid" file to sysfs.
Tested on Dell Latitude D600 with D/Dock.
Patch is against official 2.6.20 release.

-- 
Ilya A. Volynets-Evenbakh
Total Knowledge. CTO
http://www.total-knowledge.com


--------------080809070601010508030702
Content-Type: text/plain;
 name="acpi-dock-uid.diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="acpi-dock-uid.diff"

LS0tIGxpbnV4LTIuNi4yMC5vcmlnL2RyaXZlcnMvYWNwaS9kb2NrLmMJMjAwNy0wMi0wNCAx
MDo0NDo1NC4wMDAwMDAwMDAgLTA4MDAKKysrIGxpbnV4LTIuNi4yMC9kcml2ZXJzL2FjcGkv
ZG9jay5jCTIwMDctMDItMTkgMTQ6NDM6MzkuMDAwMDAwMDAwIC0wODAwCkBAIC02NTksNiAr
NjU5LDIzIEBACiB9CiBERVZJQ0VfQVRUUih1bmRvY2ssIFNfSVdVU1IsIE5VTEwsIHdyaXRl
X3VuZG9jayk7CiAKKy8qCisgKiBzaG93X2RvY2tfdWlkIC0gcmVhZCBtZXRob2QgZm9yICJ1
aWQiIGZpbGUgaW4gc3lzZnMKKyAqLworc3RhdGljIHNzaXplX3Qgc2hvd19kb2NrX3VpZChz
dHJ1Y3QgZGV2aWNlICpkZXYsCisJCQkgICAgIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICph
dHRyLCBjaGFyICpidWYpCit7CisJdW5zaWduZWQgbG9uZyBsYnVmOworCWFjcGlfc3RhdHVz
IHN0YXR1cyA9IGFjcGlfZXZhbHVhdGVfaW50ZWdlcihkb2NrX3N0YXRpb24tPmhhbmRsZSwg
Il9VSUQiLCAwLCAmbGJ1Zik7CisJaWYoQUNQSV9GQUlMVVJFKHN0YXR1cykpIHsKKwkgICAg
cmV0dXJuIDA7CisJfQorCXJldHVybiBzbnByaW50ZihidWYsIFBBR0VfU0laRSwgIiVseFxu
IiwgbGJ1Zik7Cit9CitERVZJQ0VfQVRUUih1aWQsIFNfSVJVR08sIHNob3dfZG9ja191aWQs
IE5VTEwpOworCisKKwogLyoqCiAgKiBkb2NrX2FkZCAtIGFkZCBhIG5ldyBkb2NrIHN0YXRp
b24KICAqIEBoYW5kbGU6IHRoZSBkb2NrIHN0YXRpb24gaGFuZGxlCkBAIC03MDcsNiArNzI0
LDEzIEBACiAJCWtmcmVlKGRvY2tfc3RhdGlvbik7CiAJCXJldHVybiByZXQ7CiAJfQorCXJl
dCA9IGRldmljZV9jcmVhdGVfZmlsZSgmZG9ja19kZXZpY2UuZGV2LCAmZGV2X2F0dHJfdWlk
KTsKKwlpZiAocmV0KSB7CisJCXByaW50aygiRXJyb3IgJWQgYWRkaW5nIHN5c2ZzIGZpbGVc
biIsIHJldCk7CisJCXBsYXRmb3JtX2RldmljZV91bnJlZ2lzdGVyKCZkb2NrX2RldmljZSk7
CisJCWtmcmVlKGRvY2tfc3RhdGlvbik7CisJCXJldHVybiByZXQ7CisJfQogCiAJLyogRmlu
ZCBkZXBlbmRlbnQgZGV2aWNlcyAqLwogCWFjcGlfd2Fsa19uYW1lc3BhY2UoQUNQSV9UWVBF
X0RFVklDRSwgQUNQSV9ST09UX09CSkVDVCwK
--------------080809070601010508030702--
