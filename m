From: Bernhard Rosenkraenzer <bero-9zdaV+82baBg9hUCZPvPmw@public.gmane.org>
Subject: 2.4.23-pre8 ACPI breaks x86_64
Date: Sun, 26 Oct 2003 00:31:51 +0200 (CEST)
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <Pine.LNX.4.56.0310260018100.28163@dot.kde.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="658386544-830883715-1067121111=:28163"
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime-oOUblnuQwHKola3qYQ6TW/IULO3mGbRi9nwVQlTi/Pw@public.gmane.org for more info.

--658386544-830883715-1067121111=:28163
Content-Type: TEXT/PLAIN; charset=US-ASCII

SSIA - drivers/acpi/bus.c started using acpi_pic_set_level_irq 
unconditionally, and the function doesn't exist on x86_64.

The attached patch _might_ fix it (I don't have the x86_64 manuals and 
can't reboot my x86_64 test box to test myself ATM -- too many people 
working on it ;) )

LLaP
bero

-- 
Ark Linux - Linux for the masses
http://www.arklinux.org/

Redistribution and processing of this message is subject to
http://www.arklinux.org/terms.php
--658386544-830883715-1067121111=:28163
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="pre8-acpi-x86_64.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.56.0310260031510.28163-CpmL+rkjyb1AfugRpC6u6w@public.gmane.org>
Content-Description: Suspected fix
Content-Disposition: attachment; filename="pre8-acpi-x86_64.patch"

LS0tIGxpbnV4LTIuNC4yMi9hcmNoL3g4Nl82NC9rZXJuZWwvYWNwaS5jLmFy
awkyMDAzLTEwLTI2IDA3OjI1OjEwLjAwMDAwMDAwMCArMDEwMA0KKysrIGxp
bnV4LTIuNC4yMi9hcmNoL3g4Nl82NC9rZXJuZWwvYWNwaS5jCTIwMDMtMTAt
MjYgMDc6MzA6MDcuMDAwMDAwMDAwICswMTAwDQpAQCAtNTY1LDQgKzU2NSwx
NyBAQA0KIA0KICNlbmRpZiAvKkNPTkZJR19BQ1BJX1NMRUVQKi8NCiANCisj
aWZkZWYgQ09ORklHX0FDUElfQlVTDQordm9pZCBhY3BpX3BpY19zZXRfbGV2
ZWxfaXJxKHVuc2lnbmVkIGludCBpcnEpDQorew0KKwl1bnNpZ25lZCBjaGFy
IG1hc2sgPSAxIDw8IChpcnEgJiA3KTsNCisJdW5zaWduZWQgaW50IHBvcnQg
PSAweDRkMCArIChpcnEgPj4gMyk7DQorCXVuc2lnbmVkIGNoYXIgdmFsID0g
aW5iKHBvcnQpOw0KIA0KKwlpZiAoISh2YWwgJiBtYXNrKSkgew0KKwkJcHJp
bnRrKEtFUk5fV0FSTklORyBQUkVGSVggIklSUSAlZCB3YXMgRWRnZSBUcmln
Z2VyZWQsICINCisJCQkic2V0dGluZyB0byBMZXZlbCBUcmlnZ2VyZWRcbiIs
IGlycSk7DQorCQlvdXRiKHZhbCB8IG1hc2ssIHBvcnQpOw0KKwl9DQorfQ0K
KyNlbmRpZiAvKiBDT05GSUdfQUNQSV9CVVMgKi8NCg==

--658386544-830883715-1067121111=:28163--
