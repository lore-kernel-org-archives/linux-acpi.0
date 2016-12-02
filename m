From: "majun (Euler7)" <majun258@huawei.com>
Subject: Re: [RFC PATCH 0/3] Add a new flag for ITS device to control indirect
 route
Date: Fri, 2 Dec 2016 17:29:50 +0800
Message-ID: <58413F0E.3030604@huawei.com>
References: <1480578360-9268-1-git-send-email-majun258@huawei.com>
 <3ce161a7-ee63-a018-4a75-9e7520143d97@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:39052 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751731AbcLBJaV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Dec 2016 04:30:21 -0500
In-Reply-To: <3ce161a7-ee63-a018-4a75-9e7520143d97@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, robert.moore@intel.com, lenb@kernel.org, lv.zheng@intel.com, rafael.j.wysocki@intel.com, devel@acpica.org, mark.rutland@arm.com, robh+dt@kernel.org, jason@lakedaemon.net
Cc: majun258@huawei.com, dingtianhong@huawei.com, guohanjun@huawei.com



在 2016/12/1 17:07, Marc Zyngier 写道:
> On 01/12/16 07:45, Majun wrote:
>> From: MaJun <majun258@huawei.com>
>>
>> For current ITS driver, two level table (indirect route) is enabled when the memory used
>> for LPI route table over the limit(64KB * 2) size. But this function impact the 
>> performance of LPI interrupt actually because need more time to look up the table.
> 
> Are you implying that your ITS doesn't have a cache to lookup the most
> active devices, hence performing a full lookup on each interrupt?

Our ITS chip has the cache with depth 64. But this seems not enough for some
scenario,espeically on virtulization platform.
> 
> Anyway, doing this as a DT quirk doesn't feel right. Please use the ITS
> quirk infrastructure.

If there is no other better solutions, I will do this.

Thanks!
Majun



> 
> Thanks,
> 
> 	M.
> 

