From: "Alexey Starikovskiy" <aystarik@gmail.com>
Subject: [PATCH] ACPI: Remove possible recursion from thermal driver
Date: Tue, 15 May 2007 09:54:51 +0400
Message-ID: <8f8ff01d0705142254r97c8dd9h8aa82eb67e44ae5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_95215_21776734.1179208491475"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:20429 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756854AbXEOFyx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 May 2007 01:54:53 -0400
Received: by an-out-0708.google.com with SMTP id d18so483641and
        for <linux-acpi@vger.kernel.org>; Mon, 14 May 2007 22:54:51 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

------=_Part_95215_21776734.1179208491475
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

This patch helps to fight infinite recursion on some ACER laptops, see
bugzilla #8385.

Thanks,
Alex.

------=_Part_95215_21776734.1179208491475
Content-Type: text/x-diff;
	name=remove_thermal_check_from_change_thermal_points.patch;
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f1py87id
Content-Disposition: attachment; filename="remove_thermal_check_from_change_thermal_points.patch"

VGhlcm1hbCBjaGVjayBtYXkgcmVzdWx0IGluIHRoZXJtYWwgcG9pbnRzIHRvIGJlIG1vdmVkIGRv
d24uIERvbid0IGRvIHRoZXJtYWwgY2hlY2sgYWdhaW4gaW4gdGhpcyBjYXNlLgoKRnJvbTogQWxl
eGV5IFN0YXJpa292c2tpeSA8YXlzdGFyaWtAZ21haWwuY29tPgoKU2lnbmVkLW9mZi1ieTogQWxl
eGV5IFN0YXJpa292c2tpeSA8YXlzdGFyaWtAZ21haWwuY29tPgotLS0KCiBkcml2ZXJzL2FjcGkv
dGhlcm1hbC5jIHwgICAgMSAtCiAxIGZpbGVzIGNoYW5nZWQsIDAgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvdGhlcm1hbC5jIGIvZHJpdmVy
cy9hY3BpL3RoZXJtYWwuYwppbmRleCAxYWRhMDE3Li43YWE1ZjExIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2FjcGkvdGhlcm1hbC5jCisrKyBiL2RyaXZlcnMvYWNwaS90aGVybWFsLmMKQEAgLTExMDYs
NyArMTEwNiw2IEBAIHN0YXRpYyB2b2lkIGFjcGlfdGhlcm1hbF9ub3RpZnkoYWNwaV9oYW5kbGUg
aGFuZGxlLCB1MzIgZXZlbnQsIHZvaWQgKmRhdGEpCiAJCWJyZWFrOwogCWNhc2UgQUNQSV9USEVS
TUFMX05PVElGWV9USFJFU0hPTERTOgogCQlhY3BpX3RoZXJtYWxfZ2V0X3RyaXBfcG9pbnRzKHR6
KTsKLQkJYWNwaV90aGVybWFsX2NoZWNrKHR6KTsKIAkJYWNwaV9idXNfZ2VuZXJhdGVfZXZlbnQo
ZGV2aWNlLCBldmVudCwgMCk7CiAJCWJyZWFrOwogCWNhc2UgQUNQSV9USEVSTUFMX05PVElGWV9E
RVZJQ0VTOgo=
------=_Part_95215_21776734.1179208491475--
