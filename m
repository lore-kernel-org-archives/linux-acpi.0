From: Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: [RFC PATCH 1/12] memory-hotplug : rename remove_memory to offline_memory
Date: Thu, 28 Jun 2012 11:25:16 +0800
Message-ID: <4FEBCE9C.7030904@cn.fujitsu.com>
References: <4FEA9C88.1070800@jp.fujitsu.com> <4FEA9D5C.1080508@jp.fujitsu.com> <4FEAB2E1.3090200@cn.fujitsu.com> <4FEAC891.7030808@cn.fujitsu.com> <4FEBC8EE.7040207@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:53238 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753686Ab2F1DUw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Jun 2012 23:20:52 -0400
In-Reply-To: <4FEBC8EE.7040207@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Cc: rientjes@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, len.brown@intel.com, benh@kernel.crashing.org, paulus@samba.org, cl@linux.com, minchan.kim@gmail.com, akpm@linux-foundation.org, kosaki.motohiro@jp.fujitsu.com

At 06/28/2012 11:01 AM, Yasuaki Ishimatsu Wrote:
> Hi David and Wen,
> 
> Thank you for reviewing my patch.
> 
> 2012/06/27 17:47, Wen Congyang wrote:
>> At 06/27/2012 03:14 PM, Wen Congyang Wrote:
>>> At 06/27/2012 01:42 PM, Yasuaki Ishimatsu Wrote:
>>>> remove_memory() does not remove memory but just offlines memory. The patch
>>>> changes name of it to offline_memory().
>>>
>>> There are 3 functions in the kernel:
>>> 1. add_memory()
>>> 2. online_pages()
>>> 3. remove_memory()
>>>
>>> So I think offline_pages() is better than offline_memory().
>>
>> There is already a function named offline_pages(). So we
>> should call offline_pages() instead of remove_memory() in
>> memory_block_action(), and there is no need to rename
>> remove_memory().
> 
> As Wen says, Linux has 4 functions for memory hotplug already.
> In my recognition, these functions are prepared for following purpose.
> 
> 1. add_memory     : add physical memory
> 2. online_pages   : online logical memory
> 3. remove_memory  : offline logical memory
> 4. offline_pages  : offline logical memory
> 
> add_memory() is used for adding physical memory. I think remove_memory()
> would rather be used for removing physical memory than be used for removing
> logical memory. So I renamed remove_memory() to offline_memory().
> How do you think?

Hmm, remove_memory() will revert all things we do in add_memory(), so I think
there is no need to rename it. If we rename it to offline_memory(), we should
also rename add_memory() to online_memory().

Thanks
Wen Congyang

> 
> Regards,
> Yasuaki Ishimatsu
> 
>>
>> Thanks
>> Wen Congyang
>>
>>>
>>> Thanks
>>> Wen Congyang
>>>>
