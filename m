From: Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: acpi_memhotplug.c: don't allow to eject the memory device if
 it is being used
Date: Wed, 07 Nov 2012 09:39:30 +0800
Message-ID: <5099BBD2.4020003@cn.fujitsu.com>
References: <20121105181133.GA21846@elgon.mountain> <50987183.5020007@cn.fujitsu.com> <20121106140545.GB11566@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:21474 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751300Ab2KGBde (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 6 Nov 2012 20:33:34 -0500
In-Reply-To: <20121106140545.GB11566@mwanda>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@linux-foundation.org>

At 11/06/2012 10:05 PM, Dan Carpenter Wrote:
> On Tue, Nov 06, 2012 at 10:10:11AM +0800, Wen Congyang wrote:
>> At 11/06/2012 02:11 AM, Dan Carpenter Wrote:
>>> Hello Wen Congyang,
>>>
>>> The patch 306859f13dc1: "acpi_memhotplug.c: don't allow to eject the
>>> memory device if it is being used" from Nov 3, 2012, leads to the
>>> following Smatch warning:
>>> drivers/acpi/acpi_memhotplug.c:367 acpi_memory_remove_memory()
>>> 	 warn: inconsistent returns mutex:&mem_device->list_lock:
>>> 	locked (357,361) unlocked (367)
>>
>> Thanks for pointing it out.
>>
>> The patch 306859f13dc1 is in akpm's tree, and it conflicts with another
>> patch in linux-pm's tree. So Andrew Morton drops them.
>>
>> I will resend them based on linux-pm's next tree.
> 
> Ok. Today's linux-next version 85fcb3758c10e "ACPI / memory-hotplug:
> introduce a mutex lock to protect the list in acpi_memory_device"
> has a similar problem and should be fixed as well.
> 
>    319  static int acpi_memory_remove_memory(struct acpi_memory_device *mem_device)
>    320  {
>    321          int result;
>    322          struct acpi_memory_info *info, *n;
>    323  
>    324          mutex_lock(&mem_device->list_lock);
>    325          list_for_each_entry_safe(info, n, &mem_device->res_list, list) {
>    326                  if (info->enabled) {
>    327                          result = remove_memory(info->start_addr, info->length);
>    328                          if (result)
>    329                                  return result;
>                                         ^^^^^^^^^^^^^
> We are still holding the lock here.

Yes, I found this problem.

Thanks
Wen Congyang

> 
>    330                  }
>    331  
>    332                  list_del(&info->list);
>    333                  kfree(info);
>    334          }
>    335          mutex_unlock(&mem_device->list_lock);
>    336  
>    337          return 0;
>    338  }
> 
> regards,
> dan carpenter
> 
> 

