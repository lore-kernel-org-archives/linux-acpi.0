From: Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: acpi_memhotplug.c: don't allow to eject the memory device if
 it is being used
Date: Tue, 06 Nov 2012 10:10:11 +0800
Message-ID: <50987183.5020007@cn.fujitsu.com>
References: <20121105181133.GA21846@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:2511 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S933504Ab2KFCsm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 Nov 2012 21:48:42 -0500
In-Reply-To: <20121105181133.GA21846@elgon.mountain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

At 11/06/2012 02:11 AM, Dan Carpenter Wrote:
> Hello Wen Congyang,
> 
> The patch 306859f13dc1: "acpi_memhotplug.c: don't allow to eject the
> memory device if it is being used" from Nov 3, 2012, leads to the
> following Smatch warning:
> drivers/acpi/acpi_memhotplug.c:367 acpi_memory_remove_memory()
> 	 warn: inconsistent returns mutex:&mem_device->list_lock:
> 	locked (357,361) unlocked (367)

Thanks for pointing it out.

The patch 306859f13dc1 is in akpm's tree, and it conflicts with another
patch in linux-pm's tree. So Andrew Morton drops them.

I will resend them based on linux-pm's next tree.

Wen Congyang

> 
>    341  static int acpi_memory_remove_memory(struct acpi_memory_device *mem_device)
>    342  {
>    343          int result;
>    344          struct acpi_memory_info *info, *n;
>    345  
>    346          mutex_lock(&mem_device->list_lock);
>    347          list_for_each_entry_safe(info, n, &mem_device->res_list, list) {
>    348                  if (info->failed)
>    349                          /* The kernel does not use this memory block */
>    350                          continue;
>    351  
>    352                  if (!info->enabled)
>    353                          /*
>    354                           * The kernel uses this memory block, but it may be not
>    355                           * managed by us.
>    356                           */
>    357                          return -EBUSY;
>                                 ^^^^^^^^^^^^^
>    358  
>    359                  result = remove_memory(info->start_addr, info->length);
>    360                  if (result)
>    361                          return result;
>                                 ^^^^^^^^^^^^^^
> Unlock before returning?
> 
>    362                  list_del(&info->list);
>    363                  kfree(info);
>    364          }
>    365          mutex_unlock(&mem_device->list_lock);
>    366  
>    367          return 0;
>    368  }
> 
> 
> 
> 
> regards,
> dan carpenter
> 
> 

