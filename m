From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: 174cc7187e6f ACPICA: Tables: Back port acpi_get_table_with_size()
 and early_acpi_os_unmap_memory() from Linux kernel
Date: Sun, 8 Jan 2017 03:20:20 +0100
Message-ID: <CAJZ5v0idFBHG=OKRiBqvsYPgUrWQsqjTKYXfKxfdG023qsCbkw@mail.gmail.com>
References: <20170107204227.bwdb5yzrjpiggkmo@pd.tnic> <4034dde8-ffc1-18e2-f40c-00cf37471793@intel.com>
 <20170108000702.wrov5ajeou2y3tuy@pd.tnic> <CAJZ5v0jtGo207YmBGDw55uCV+3sp-QX2Gx7cup-4e8ESjnHhrQ@mail.gmail.com>
 <20170108003730.hlcqkhdxtah65z66@pd.tnic> <CAJZ5v0jgdctHEEOaAUBNZZPb=ni_DLdkJtmiDkvVP4WQUYr3rA@mail.gmail.com>
 <20170108010158.b62eovaxsbmhfnkb@pd.tnic> <CAJZ5v0hxrz9os4ZpS=EHbdFp8rd7D+BU10bSyfBV-FE6UHQ6FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a1134fa8088b03e05458be4ea
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:32921 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933053AbdAHCUV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Jan 2017 21:20:21 -0500
In-Reply-To: <CAJZ5v0hxrz9os4ZpS=EHbdFp8rd7D+BU10bSyfBV-FE6UHQ6FA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, lkml <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

--001a1134fa8088b03e05458be4ea
Content-Type: text/plain; charset=UTF-8

On Sun, Jan 8, 2017 at 2:45 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Sun, Jan 8, 2017 at 2:01 AM, Borislav Petkov <bp@alien8.de> wrote:
>> On Sun, Jan 08, 2017 at 01:52:50AM +0100, Rafael J. Wysocki wrote:
>>> So we get the table, but apparently we crash when we attempt to put it.
>>
>> Right, except on 4.10-rc2 we don't crash but we freeze early. These are
>> the last lines:
>>
>> ...
>> [    0.004778] mce: CPU supports 7 MCE banks
>> [    0.004861] LVT offset 1 assigned for vector 0xf9
>> [    0.004945] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
>> [    0.005025] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
>> [    0.005165] Freeing SMP alternatives memory: 24K
>> [    0.211154] ftrace: allocating 25022 entries in 98 pages
>> [    0.219614] smpboot: Max logical packages: 2
>> <EOF>
>>
>>> Let's try to check the obvious just to rule it out (see attached), but
>>> honestly I'm not sure what's going on in there.
>>
>> No change, same freeze.
>
> I was afraid that that would be the case.
>
> Can you try to comment out the acpi_put_table() in
> early_amd_iommu_init() and see if that makes any difference?

Well, there is a bug in early_amd_iommu_init() that may matter in
theory if the table checksum is incorrect.

Please see if the attached makes any difference.

Thanks,
Rafael

--001a1134fa8088b03e05458be4ea
Content-Type: text/x-patch; charset=US-ASCII; name="amd-iommu-fix.patch"
Content-Disposition: attachment; filename="amd-iommu-fix.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ixo178ni0

LS0tCiBkcml2ZXJzL2lvbW11L2FtZF9pb21tdV9pbml0LmMgfCAgICAyICstCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCkluZGV4OiBsaW51eC1wbS9kcml2
ZXJzL2lvbW11L2FtZF9pb21tdV9pbml0LmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgtcG0ub3JpZy9k
cml2ZXJzL2lvbW11L2FtZF9pb21tdV9pbml0LmMKKysrIGxpbnV4LXBtL2RyaXZlcnMvaW9tbXUv
YW1kX2lvbW11X2luaXQuYwpAQCAtMjIzMCw3ICsyMjMwLDcgQEAgc3RhdGljIGludCBfX2luaXQg
ZWFybHlfYW1kX2lvbW11X2luaXQodgogCSAqLwogCXJldCA9IGNoZWNrX2l2cnNfY2hlY2tzdW0o
aXZyc19iYXNlKTsKIAlpZiAocmV0KQotCQlyZXR1cm4gcmV0OworCQlnb3RvIG91dDsKIAogCWFt
ZF9pb21tdV90YXJnZXRfaXZoZF90eXBlID0gZ2V0X2hpZ2hlc3Rfc3VwcG9ydGVkX2l2aGRfdHlw
ZShpdnJzX2Jhc2UpOwogCURVTVBfcHJpbnRrKCJVc2luZyBJVkhEIHR5cGUgJSN4XG4iLCBhbWRf
aW9tbXVfdGFyZ2V0X2l2aGRfdHlwZSk7Cg==
--001a1134fa8088b03e05458be4ea--
