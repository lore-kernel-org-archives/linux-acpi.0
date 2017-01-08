From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: 174cc7187e6f ACPICA: Tables: Back port acpi_get_table_with_size()
 and early_acpi_os_unmap_memory() from Linux kernel
Date: Sun, 8 Jan 2017 02:45:44 +0100
Message-ID: <CAJZ5v0hxrz9os4ZpS=EHbdFp8rd7D+BU10bSyfBV-FE6UHQ6FA@mail.gmail.com>
References: <20170107204227.bwdb5yzrjpiggkmo@pd.tnic> <4034dde8-ffc1-18e2-f40c-00cf37471793@intel.com>
 <20170108000702.wrov5ajeou2y3tuy@pd.tnic> <CAJZ5v0jtGo207YmBGDw55uCV+3sp-QX2Gx7cup-4e8ESjnHhrQ@mail.gmail.com>
 <20170108003730.hlcqkhdxtah65z66@pd.tnic> <CAJZ5v0jgdctHEEOaAUBNZZPb=ni_DLdkJtmiDkvVP4WQUYr3rA@mail.gmail.com>
 <20170108010158.b62eovaxsbmhfnkb@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36529 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933164AbdAHBpq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Jan 2017 20:45:46 -0500
In-Reply-To: <20170108010158.b62eovaxsbmhfnkb@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, lkml <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Sun, Jan 8, 2017 at 2:01 AM, Borislav Petkov <bp@alien8.de> wrote:
> On Sun, Jan 08, 2017 at 01:52:50AM +0100, Rafael J. Wysocki wrote:
>> So we get the table, but apparently we crash when we attempt to put it.
>
> Right, except on 4.10-rc2 we don't crash but we freeze early. These are
> the last lines:
>
> ...
> [    0.004778] mce: CPU supports 7 MCE banks
> [    0.004861] LVT offset 1 assigned for vector 0xf9
> [    0.004945] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
> [    0.005025] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
> [    0.005165] Freeing SMP alternatives memory: 24K
> [    0.211154] ftrace: allocating 25022 entries in 98 pages
> [    0.219614] smpboot: Max logical packages: 2
> <EOF>
>
>> Let's try to check the obvious just to rule it out (see attached), but
>> honestly I'm not sure what's going on in there.
>
> No change, same freeze.

I was afraid that that would be the case.

Can you try to comment out the acpi_put_table() in
early_amd_iommu_init() and see if that makes any difference?

Thanks,
Rafael
