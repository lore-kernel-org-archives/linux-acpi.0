Return-Path: <SRS0=rJye=WQ=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DCEC3A589
	for <linux-acpi@archiver.kernel.org>; Tue, 20 Aug 2019 09:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577F022CF7
	for <linux-acpi@archiver.kernel.org>; Tue, 20 Aug 2019 09:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbfHTJCY (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 20 Aug 2019 05:02:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5162 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728545AbfHTJCX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 20 Aug 2019 05:02:23 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6915A5821CB23C58AC55;
        Tue, 20 Aug 2019 17:02:12 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 20 Aug 2019
 17:02:04 +0800
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v4 1/2] ACPI/PPTT: Add support for ACPI 6.3 thread flag
To:     Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>
References: <20190808204007.30110-1-jeremy.linton@arm.com>
 <20190808204007.30110-2-jeremy.linton@arm.com>
 <20190808222518.5q4fhd2tvs4lb6aw@rric.localdomain>
 <CAJZ5v0imn0X=M38LJcwe76gfLafWGU+MgyGd=NuKAeDtNZ+1DQ@mail.gmail.com>
 <20190812115907.kugk57jvv3g2r66a@willie-the-truck>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "rric@kernel.org" <rric@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>
Message-ID: <a2960c68-d422-3cdb-4354-6f357433ad6c@huawei.com>
Date:   Tue, 20 Aug 2019 10:01:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190812115907.kugk57jvv3g2r66a@willie-the-truck>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 12/08/2019 12:59, Will Deacon wrote:
> On Mon, Aug 12, 2019 at 11:06:07AM +0200, Rafael J. Wysocki wrote:
>> On Fri, Aug 9, 2019 at 12:25 AM Robert Richter <rrichter@marvell.com> wrote:
>>>
>>> On 08.08.19 15:40:06, Jeremy Linton wrote:
>>>> ACPI 6.3 adds a flag to the CPU node to indicate whether
>>>> the given PE is a thread. Add a function to return that
>>>> information for a given linux logical CPU.
>>>>
>>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>>> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>>>> ---
>>>>  drivers/acpi/pptt.c  | 53 +++++++++++++++++++++++++++++++++++++++++++-
>>>>  include/linux/acpi.h |  5 +++++
>>>>  2 files changed, 57 insertions(+), 1 deletion(-)
>>>
>>> Reviewed-by: Robert Richter <rrichter@marvell.com>
>>
>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> and please push it through ARM64 along with the second patch.
>
> Thanks. I'll push these into -next shortly.


Hi Jeremy,

We're considering requesting this support is backported to stable. We 
have a platform which incorrectly sets the MT bit. To update our 
firmware to PPTT v2, we need the kernel to support PPTT v2 also.

Please let me know if you anticipate an issue in this.

Cheers,
John

>
> Will
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>


