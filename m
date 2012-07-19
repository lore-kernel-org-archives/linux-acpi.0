From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: Re: [RFC PATCH v4 1/13] memory-hotplug : rename remove_memory to
 offline_memory
Date: Thu, 19 Jul 2012 18:26:25 +0900
Message-ID: <5007D2C1.90406@jp.fujitsu.com>
References: <50068974.1070409@jp.fujitsu.com> <50068A6E.5050904@jp.fujitsu.com> <CAA_GA1fayhA1A3vT5BcDCoL_JVd6pZJn2_=NXK0bjJNRXo=7LA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:53408 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701Ab2GSJ1F (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Jul 2012 05:27:05 -0400
In-Reply-To: <CAA_GA1fayhA1A3vT5BcDCoL_JVd6pZJn2_=NXK0bjJNRXo=7LA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bob Liu <lliubbo@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, rientjes@google.com, liuj97@gmail.com, len.brown@intel.com, benh@kernel.crashing.org, paulus@samba.org, cl@linux.com, minchan.kim@gmail.com, akpm@linux-foundation.org, kosaki.motohiro@jp.fujitsu.com, wency@cn.fujitsu.com

Hi Bob,

2012/07/19 17:19, Bob Liu wrote:
> Hi Yasuaki,
>
> On Wed, Jul 18, 2012 at 6:05 PM, Yasuaki Ishimatsu
> <isimatu.yasuaki@jp.fujitsu.com> wrote:
>> remove_memory() does not remove memory but just offlines memory. The patch
>> changes name of it to offline_memory().
>
> Since offline_memory() just align the start/end pfn and there is no
> matched online_memory() function,
> i think it's better to remove this function and add the alignment into
> offline_pages().

If we change it, these argument becomes different as follows:

   online_pages  : page frame number and number of page frame number
   offline_pages : memory address and memory length

I think it is ugly. So I don't want to change it. As you say, there is no
function that matches to offline_memory(). If we create export symbol
function for onlining page, in this case, the function should be named
online_memory().

Thanks,
Yasuaki Ishimatsu

>
>>
>> CC: David Rientjes <rientjes@google.com>
>> CC: Jiang Liu <liuj97@gmail.com>
>> CC: Len Brown <len.brown@intel.com>
>> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> CC: Paul Mackerras <paulus@samba.org>
>> CC: Christoph Lameter <cl@linux.com>
>> Cc: Minchan Kim <minchan.kim@gmail.com>
>> CC: Andrew Morton <akpm@linux-foundation.org>
>> CC: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
>> CC: Wen Congyang <wency@cn.fujitsu.com>
>> Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
>>
>> ---
>>   drivers/acpi/acpi_memhotplug.c |    2 +-
>>   drivers/base/memory.c          |    4 ++--
>>   include/linux/memory_hotplug.h |    2 +-
>>   mm/memory_hotplug.c            |    6 +++---
>>   4 files changed, 7 insertions(+), 7 deletions(-)
>>
>> Index: linux-3.5-rc4/drivers/acpi/acpi_memhotplug.c
>> ===================================================================
>> --- linux-3.5-rc4.orig/drivers/acpi/acpi_memhotplug.c   2012-07-03 14:21:46.102416917 +0900
>> +++ linux-3.5-rc4/drivers/acpi/acpi_memhotplug.c        2012-07-03 14:21:49.458374960 +0900
>> @@ -318,7 +318,7 @@ static int acpi_memory_disable_device(st
>>           */
>>          list_for_each_entry_safe(info, n, &mem_device->res_list, list) {
>>                  if (info->enabled) {
>> -                       result = remove_memory(info->start_addr, info->length);
>> +                       result = offline_memory(info->start_addr, info->length);
>>                          if (result)
>>                                  return result;
>>                  }
>> Index: linux-3.5-rc4/drivers/base/memory.c
>> ===================================================================
>> --- linux-3.5-rc4.orig/drivers/base/memory.c    2012-07-03 14:21:46.095417003 +0900
>> +++ linux-3.5-rc4/drivers/base/memory.c 2012-07-03 14:21:49.459374948 +0900
>> @@ -266,8 +266,8 @@ memory_block_action(unsigned long phys_i
>>                          break;
>>                  case MEM_OFFLINE:
>>                          start_paddr = page_to_pfn(first_page) << PAGE_SHIFT;
>> -                       ret = remove_memory(start_paddr,
>> -                                           nr_pages << PAGE_SHIFT);
>> +                       ret = offline_memory(start_paddr,
>> +                                            nr_pages << PAGE_SHIFT);
>>                          break;
>>                  default:
>>                          WARN(1, KERN_WARNING "%s(%ld, %ld) unknown action: "
>> Index: linux-3.5-rc4/mm/memory_hotplug.c
>> ===================================================================
>> --- linux-3.5-rc4.orig/mm/memory_hotplug.c      2012-07-03 14:21:46.102416917 +0900
>> +++ linux-3.5-rc4/mm/memory_hotplug.c   2012-07-03 14:21:49.466374860 +0900
>> @@ -990,7 +990,7 @@ out:
>>          return ret;
>>   }
>>
>> -int remove_memory(u64 start, u64 size)
>> +int offline_memory(u64 start, u64 size)
>>   {
>>          unsigned long start_pfn, end_pfn;
>>
>> @@ -999,9 +999,9 @@ int remove_memory(u64 start, u64 size)
>>          return offline_pages(start_pfn, end_pfn, 120 * HZ);
>>   }
>>   #else
>> -int remove_memory(u64 start, u64 size)
>> +int offline_memory(u64 start, u64 size)
>>   {
>>          return -EINVAL;
>>   }
>>   #endif /* CONFIG_MEMORY_HOTREMOVE */
>> -EXPORT_SYMBOL_GPL(remove_memory);
>> +EXPORT_SYMBOL_GPL(offline_memory);
>> Index: linux-3.5-rc4/include/linux/memory_hotplug.h
>> ===================================================================
>> --- linux-3.5-rc4.orig/include/linux/memory_hotplug.h   2012-07-03 14:21:46.102416917 +0900
>> +++ linux-3.5-rc4/include/linux/memory_hotplug.h        2012-07-03 14:21:49.471374796 +0900
>> @@ -233,7 +233,7 @@ static inline int is_mem_section_removab
>>   extern int mem_online_node(int nid);
>>   extern int add_memory(int nid, u64 start, u64 size);
>>   extern int arch_add_memory(int nid, u64 start, u64 size);
>> -extern int remove_memory(u64 start, u64 size);
>> +extern int offline_memory(u64 start, u64 size);
>>   extern int sparse_add_one_section(struct zone *zone, unsigned long start_pfn,
>>                                                                  int nr_pages);
>>   extern void sparse_remove_one_section(struct zone *zone, struct mem_section *ms);
>>
>> --
>> To unsubscribe, send a message with 'unsubscribe linux-mm' in
>> the body to majordomo@kvack.org.  For more info on Linux MM,
>> see: http://www.linux-mm.org/ .
>> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
>
>


