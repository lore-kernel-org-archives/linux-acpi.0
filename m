From: Krzysztof Oledzki <olel@ans.pl>
Subject: Re: [Bug 5243] Very high interrupt rate for IRQ8 (rtc) unless
 pnpacpi=off
Date: Thu, 4 Oct 2007 00:54:00 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0710040051020.15320@bizon.gios.gov.pl>
References: <20070928013224.0EDF2108014@picon.linux-foundation.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-187430788-631169894-1191452040=:15320"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bizon.gios.gov.pl ([212.244.124.8]:41315 "EHLO
	bizon.gios.gov.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851AbXJCXUt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Oct 2007 19:20:49 -0400
In-Reply-To: <20070928013224.0EDF2108014@picon.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: yakui.zhao@intel.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---187430788-631169894-1191452040=:15320
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Thu, 27 Sep 2007, bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=3D5243
>
>
> ------- Comment #14 from yakui.zhao@intel.com  2007-09-27 18:32 -------
> (In reply to comment #13)
>> Created an attachment (id=3D12951)
> --> (http://bugzilla.kernel.org/attachment.cgi?id=3D12951&action=3Dview) =
[details]
>> Working workaround for this PNP BIOS bug
>>
> Now it seems that the patch can solve the problem. Will you please send t=
he
> patch to the acpi maillist?

Attached.

Best regards,

 =09=09=09Krzysztof Ol=EAdzki
---187430788-631169894-1191452040=:15320
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="fix-very-high-interrupt-rate-for-irq8-rtc-unless-pnpacpi=off.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0710040054000.15320@bizon.gios.gov.pl>
Content-Description: 
Content-Disposition: attachment; filename="fix-very-high-interrupt-rate-for-irq8-rtc-unless-pnpacpi=off.patch"

RnJvbTogS3J6eXN6dG9mIE9sZWR6a2kgPG9sZWxAYW5zLnBsPg0KDQpXb3Jr
YXJvdW5kIGZvciBicm9rZW4gc3lzdGVtcyB3aXRoIEJJT1MgdGhhdCBtYWtl
cyBSVEMgaW50ZXJydXB0IGxldmVsDQp0cmlnZ2VyZWQgYW5kL29yIGFjdGl2
ZSBsb3cuDQoNClNlZSBodHRwOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93
X2J1Zy5jZ2k/aWQ9NTI0Mw0KDQpCYXNlZCBvbiB0aGUgcGF0Y2ggZnJvbSBT
aGFvaHVhIExpIDxzaGFvaHVhLmxpQGludGVsLmNvbT4NCg0KU2lnbmVkLW9m
Zi1ieTogS3J6eXN6dG9mIFBpb3RyIE9sZWR6a2kgPG9sZUBhbnMucGw+DQpD
YzogIkxpLCBTaGFvaHVhIiA8c2hhb2h1YS5saUBpbnRlbC5jb20+DQpDYzog
Qmpvcm4gSGVsZ2FhcyA8Ympvcm4uaGVsZ2Fhc0BocC5jb20+DQpDYzogQW5k
aSBLbGVlbiA8YWtAc3VzZS5kZT4NCkNjOiBBZGFtIEJlbGF5IDxhbWJ4MUBu
ZW8ucnIuY29tPg0KU2lnbmVkLW9mZi1ieTogQW5kcmV3IE1vcnRvbiA8YWtw
bUBsaW51eC1mb3VuZGF0aW9uLm9yZz4NCi0tLQ0KDQoNCmRpZmYgLXB1TiBk
cml2ZXJzL3BucC9wbnBhY3BpL3JzcGFyc2VyLmN+Zml4LXZlcnktaGlnaC1p
bnRlcnJ1cHQtcmF0ZS1mb3ItaXJxOC1ydGMtdW5sZXNzLXBucGFjcGk9b2Zm
IGRyaXZlcnMvcG5wL3BucGFjcGkvcnNwYXJzZXIuYw0KLS0tIGEvZHJpdmVy
cy9wbnAvcG5wYWNwaS9yc3BhcnNlci5jfmZpeC12ZXJ5LWhpZ2gtaW50ZXJy
dXB0LXJhdGUtZm9yLWlycTgtcnRjLXVubGVzcy1wbnBhY3BpPW9mZg0KKysr
IGEvZHJpdmVycy9wbnAvcG5wYWNwaS9yc3BhcnNlci5jDQpAQCAtODUsNiAr
ODUsMTYgQEAgc3RhdGljIHZvaWQgcG5wYWNwaV9wYXJzZV9hbGxvY2F0ZWRf
aXJxcg0KIAlpZiAoaSA+PSBQTlBfTUFYX0lSUSkNCiAJCXJldHVybjsNCiAN
CisjaWZkZWYgQ09ORklHX1g4Ng0KKwlpZiAoZ3NpIDwgMTYgJiYgKHRyaWdn
ZXJpbmcgIT0gQUNQSV9FREdFX1NFTlNJVElWRSB8fA0KKwkJCQlwb2xhcml0
eSAhPSBBQ1BJX0FDVElWRV9ISUdIKSkgew0KKwkJcG5wX3dhcm4oIkJJT1Mg
QlVHOiBsZWdhY3kgUE5QIElSUSAlZCBzaG91bGQgYmUgZWRnZSB0cmlnZ2Vy
LCAiDQorCQkJCSJhY3RpdmUgaGlnaCIsIGdzaSk7DQorCQl0cmlnZ2VyaW5n
ID0gQUNQSV9FREdFX1NFTlNJVElWRTsNCisJCXBvbGFyaXR5ID0gQUNQSV9B
Q1RJVkVfSElHSDsNCisJfQ0KKyNlbmRpZg0KKw0KIAlyZXMtPmlycV9yZXNv
dXJjZVtpXS5mbGFncyA9IElPUkVTT1VSQ0VfSVJROwkvLyBBbHNvIGNsZWFy
cyBfVU5TRVQgZmxhZw0KIAlyZXMtPmlycV9yZXNvdXJjZVtpXS5mbGFncyB8
PSBpcnFfZmxhZ3ModHJpZ2dlcmluZywgcG9sYXJpdHkpOw0KIAlpcnEgPSBh
Y3BpX3JlZ2lzdGVyX2dzaShnc2ksIHRyaWdnZXJpbmcsIHBvbGFyaXR5KTsN
Cl8NCg==

---187430788-631169894-1191452040=:15320--
