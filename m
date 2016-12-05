From: "majun (Euler7)" <majun258@huawei.com>
Subject: Re: [RFC PATCH 0/3] Add a new flag for ITS device to control indirect
 route
Date: Mon, 5 Dec 2016 11:11:28 +0800
Message-ID: <5844DAE0.9050101@huawei.com>
References: <1480578360-9268-1-git-send-email-majun258@huawei.com>
 <3ce161a7-ee63-a018-4a75-9e7520143d97@arm.com> <58413F0E.3030604@huawei.com>
 <bd4114c2-a6d9-123c-8f9f-e6da33a481ba@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:24564 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbcLEDLz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Dec 2016 22:11:55 -0500
In-Reply-To: <bd4114c2-a6d9-123c-8f9f-e6da33a481ba@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, robert.moore@intel.com, lenb@kernel.org, lv.zheng@intel.com, rafael.j.wysocki@intel.com, devel@acpica.org, mark.rutland@arm.com, robh+dt@kernel.org, jason@lakedaemon.net
Cc: majun258@huawei.com, dingtianhong@huawei.com, guohanjun@huawei.com

Hi Marc:

在 2016/12/2 17:35, Marc Zyngier 写道:
> On 02/12/16 09:29, majun (Euler7) wrote:
>>
>>
>> 在 2016/12/1 17:07, Marc Zyngier 写道:
>>> On 01/12/16 07:45, Majun wrote:
>>>> From: MaJun <majun258@huawei.com>
>>>>
>>>> For current ITS driver, two level table (indirect route) is enabled when the memory used
>>>> for LPI route table over the limit(64KB * 2) size. But this function impact the 
>>>> performance of LPI interrupt actually because need more time to look up the table.
>>>
>>> Are you implying that your ITS doesn't have a cache to lookup the most
>>> active devices, hence performing a full lookup on each interrupt?
>>
>> Our ITS chip has the cache with depth 64. But this seems not enough for some
>> scenario,espeically on virtulization platform.
> 
> Then I don't see how switching to to flat tables is going to improve
> things. Can you share actual performance numbers?
> 
Sorry, I run this code on EMU and have no actual performance numbers now.

Suppose there are 66 devices in system.
As far as our chip concerned, there are always 2 devices can't benefit from
cache fully when they report the interrupt.

If i'm wrong, please correct me.

Thanks
Majun

>>> Anyway, doing this as a DT quirk doesn't feel right. Please use the ITS
>>> quirk infrastructure.
>>
>> If there is no other better solutions, I will do this.
> 
> Thanks,
> 
> 	M.
> 

