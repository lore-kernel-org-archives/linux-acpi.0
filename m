From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: 174cc7187e6f ACPICA: Tables: Back port acpi_get_table_with_size()
 and early_acpi_os_unmap_memory() from Linux kernel
Date: Sun, 8 Jan 2017 01:52:50 +0100
Message-ID: <CAJZ5v0jgdctHEEOaAUBNZZPb=ni_DLdkJtmiDkvVP4WQUYr3rA@mail.gmail.com>
References: <20170107204227.bwdb5yzrjpiggkmo@pd.tnic> <4034dde8-ffc1-18e2-f40c-00cf37471793@intel.com>
 <20170108000702.wrov5ajeou2y3tuy@pd.tnic> <CAJZ5v0jtGo207YmBGDw55uCV+3sp-QX2Gx7cup-4e8ESjnHhrQ@mail.gmail.com>
 <20170108003730.hlcqkhdxtah65z66@pd.tnic>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a113cd39ea40d6905458aab61
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36728 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933014AbdAHAwv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Jan 2017 19:52:51 -0500
In-Reply-To: <20170108003730.hlcqkhdxtah65z66@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, lkml <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

--001a113cd39ea40d6905458aab61
Content-Type: text/plain; charset=UTF-8

On Sun, Jan 8, 2017 at 1:37 AM, Borislav Petkov <bp@alien8.de> wrote:
> On Sun, Jan 08, 2017 at 01:22:55AM +0100, Rafael J. Wysocki wrote:
>> Is an IVRS table actually present on this machine?
>
> Like this?
>
> [    0.000000] ACPI: IVRS 0x000000009CFD6000 0000D0 (v02 AMD    AGESA    00000001 AMD  00000000)

Yup.

So we get the table, but apparently we crash when we attempt to put it.

Let's try to check the obvious just to rule it out (see attached), but
honestly I'm not sure what's going on in there.

Thanks,
Rafael

--001a113cd39ea40d6905458aab61
Content-Type: text/x-patch; charset=US-ASCII; name="acpi-table-put-debug.patch"
Content-Disposition: attachment; filename="acpi-table-put-debug.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ixny0zgq0

Ci0tLQogZHJpdmVycy9pb21tdS9hbWRfaW9tbXVfaW5pdC5jIHwgICAgOSArKysrKystLS0KIDEg
ZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpJbmRleDogbGlu
dXgtcG0vZHJpdmVycy9pb21tdS9hbWRfaW9tbXVfaW5pdC5jCj09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4
LXBtLm9yaWcvZHJpdmVycy9pb21tdS9hbWRfaW9tbXVfaW5pdC5jCisrKyBsaW51eC1wbS9kcml2
ZXJzL2lvbW11L2FtZF9pb21tdV9pbml0LmMKQEAgLTIzMzcsOCArMjMzNywxMCBAQCBzdGF0aWMg
aW50IF9faW5pdCBlYXJseV9hbWRfaW9tbXVfaW5pdCh2CiAKIG91dDoKIAkvKiBEb24ndCBsZWFr
IGFueSBBQ1BJIG1lbW9yeSAqLwotCWFjcGlfcHV0X3RhYmxlKGl2cnNfYmFzZSk7Ci0JaXZyc19i
YXNlID0gTlVMTDsKKwlpZiAoaXZyc19iYXNlKSB7CisJCWFjcGlfcHV0X3RhYmxlKGl2cnNfYmFz
ZSk7CisJCWl2cnNfYmFzZSA9IE5VTEw7CisJfQogCiAJcmV0dXJuIHJldDsKIH0KQEAgLTIzNzIs
NyArMjM3NCw4IEBAIHN0YXRpYyBib29sIGRldGVjdF9pdnJzKHZvaWQpCiAJCXJldHVybiBmYWxz
ZTsKIAl9CiAKLQlhY3BpX3B1dF90YWJsZShpdnJzX2Jhc2UpOworCWlmIChpdnJzX2Jhc2UpCisJ
CWFjcGlfcHV0X3RhYmxlKGl2cnNfYmFzZSk7CiAKIAkvKiBNYWtlIHN1cmUgQUNTIHdpbGwgYmUg
ZW5hYmxlZCBkdXJpbmcgUENJIHByb2JlICovCiAJcGNpX3JlcXVlc3RfYWNzKCk7Cg==
--001a113cd39ea40d6905458aab61--
