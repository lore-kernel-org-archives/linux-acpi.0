From: "Baicar, Tyler" <tbaicar@codeaurora.org>
Subject: Re: [PATCH] acpi: apei: fix GHES estatus iteration
Date: Fri, 11 Aug 2017 07:17:48 -0600
Message-ID: <fe154c57-1316-1223-6bee-1535924c3d94@codeaurora.org>
References: <1501795945-5331-1-git-send-email-tbaicar@codeaurora.org>
 <20170808163219.GB2163@arm.com> <1971058.u9kdacGNiq@aspire.rjw.lan>
 <5591b641-6eb0-0cb6-e74d-7e55cad5ee33@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:35678 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752986AbdHKNRv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Aug 2017 09:17:51 -0400
In-Reply-To: <5591b641-6eb0-0cb6-e74d-7e55cad5ee33@huawei.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: gengdongjiu <gengdongjiu@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>
Cc: lenb@kernel.org, james.morse@arm.com, bp@suse.de, shiju.jose@huawei.com, geliangtang@gmail.com, andriy.shevchenko@linux.intel.com, tony.luck@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, austinwc@codeaurora.org

On 8/10/2017 4:04 PM, gengdongjiu wrote:
>
> On 2017/8/9 8:52, Rafael J. Wysocki wrote:
>> On Tuesday, August 8, 2017 6:32:20 PM CEST Will Deacon wrote:
>>> On Thu, Aug 03, 2017 at 03:32:25PM -0600, Tyler Baicar wrote:
>>>> Currently iterating through the GHES estatus blocks does not
>>>> take into account the new generic data v3 structure size. This
>>>> can result in garbage non-standard trace events to be triggered
>>>> since the loop will not properly iterate through the estatus
>>>> blocks and not properly terminate.
>>>>
>>>> Update the GHES estatus iteration to properly increment through
>>>> the estatus blocks similar to how the CPER estatus printing
>>>> iterates through them.
>>>>
>>>> Fixes: bbcc2e7b642e ("ras: acpi/apei: cper: add support for generic data v3 structure")
> I do not think it has relationship with this "bbcc2e7b642e", the root cause is that it
> does not consider the acpi_hest_generic_data_v300, this code exists long long time ago.

bbcc2e7b642e ("ras: acpi/apei: cper: add support for generic data v3 structure") is the change
that introduced the generic data v300 structure and this patch does fix the issue with this
iteration not taking into account the size difference of the v300 structure.

>
> so please also review this patch:
> https://lkml.org/lkml/2017/8/10/747
>
> previously I do not see Tyler's this modification, just know see it.
>
>
>>>> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
>>>> Tested-by: Austin Christ <austinwc@codeaurora.org>
>>>> ---
>>>>   drivers/acpi/apei/apei-internal.h | 5 -----
>>>>   drivers/acpi/apei/ghes.c          | 8 +++++++-
>>>>   2 files changed, 7 insertions(+), 6 deletions(-)
>>> Whilst much of the initial code here went through the arm64 tree in the
>>> previous merge window, I'm assuming that Boris will take this fix via his
>>> tree (likewise for "[PATCH V2] acpi: apei: clear error status before
>>> acknowledging the error").
>> Actually I will if Boris ACKs these.
>>
>> Thanks,
>> Rafael
>>
>>
>> .
>>

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

