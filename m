From: Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: Re: [POC] Get acpi table to limit memory scope chosen by KASLR to
 home SB when "movable_node" is specified
Date: Thu, 3 Aug 2017 17:03:59 +0800
Message-ID: <20170803090359.GF25014@localhost.localdomain>
References: <20170803085155.GE25014@localhost.localdomain>
 <f894c7cd-9120-f2ea-d25d-8dae3e4243b3@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from [183.91.158.132] ([183.91.158.132]:46662 "EHLO
        heian.cn.fujitsu.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751067AbdHCJES (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Aug 2017 05:04:18 -0400
Content-Disposition: inline
In-Reply-To: <f894c7cd-9120-f2ea-d25d-8dae3e4243b3@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, keescook@chromium.org, bhe@redhat.com, dyoung@redhat.com, arnd@arndb.de, dave.jiang@intel.com, indou.takao@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, "Rafael J., Wysocki" <rjw@rjwysocki.net>, "Zheng, Lv" <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thu, Aug 03, 2017 at 04:59:26PM +0800, Dou Liyang wrote:
>Cc ACPI maintainers and mail list

So many thanks.

>
>At 08/03/2017 04:51 PM, Chao Fan wrote:
>> Hi all,
>> 
>> Here is an issue about movable_node and KASLR.
>> Currently, KASLR works well with "mem=", by which we can limit the scope of
>> memory chosen by KASLR. But if we use "movable_node" independently without
>> "mem=", we don't know the scope of memory in the home SB, which will cause
>> the memory of hotplug SB may be chosen by KASLR.
>> To solve this problem, I want to do this job:
>> If "movable_node" is specified, try to get the acpi table and find the scope
>> of memory in home SB, then set "mem_limit".
>> 
>> The order of getting table is:
>> boot_params
>>     \-systab
>>         \-efi tables
>>              \-rsdp
>>                  \-rsdt or xsdt
>>                       \-acpi root table list
>>                             \-acpi srat mem affinity
>> 

I am not sure if it's good to do this job in this period,
so I want to get the feedback of community.

Thanks,
Chao Fan

>> I am not sure if it's OK for community.
>> If there are any problems, please let me know.
>> Any comments will be welcome.
>> 
>> Thanks,
>> Chao Fan
>> 
>> 
>> 


