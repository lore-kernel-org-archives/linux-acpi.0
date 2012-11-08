From: Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: acpi_memhotplug.c: don't allow to eject the memory device if
 it is being used
Date: Thu, 08 Nov 2012 18:03:15 +0800
Message-ID: <509B8363.1090500@cn.fujitsu.com>
References: <20121105181133.GA21846@elgon.mountain> <20121106140545.GB11566@mwanda> <509B7C77.7040601@cn.fujitsu.com> <1868139.0d5iSM0t2m@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:65480 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755182Ab2KHJ5R (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Nov 2012 04:57:17 -0500
In-Reply-To: <1868139.0d5iSM0t2m@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

At 11/08/2012 05:58 PM, Rafael J. Wysocki Wrote:
> On Thursday, November 08, 2012 05:33:43 PM Wen Congyang wrote:
>> Hi, Rafael J. Wysocki 
>>
>> At 11/06/2012 10:05 PM, Dan Carpenter Wrote:
>>> On Tue, Nov 06, 2012 at 10:10:11AM +0800, Wen Congyang wrote:
>>>> At 11/06/2012 02:11 AM, Dan Carpenter Wrote:
>>>>> Hello Wen Congyang,
>>>>>
>>>>> The patch 306859f13dc1: "acpi_memhotplug.c: don't allow to eject the
>>>>> memory device if it is being used" from Nov 3, 2012, leads to the
>>>>> following Smatch warning:
>>>>> drivers/acpi/acpi_memhotplug.c:367 acpi_memory_remove_memory()
>>>>> 	 warn: inconsistent returns mutex:&mem_device->list_lock:
>>>>> 	locked (357,361) unlocked (367)
>>>>
>>>> Thanks for pointing it out.
>>>>
>>>> The patch 306859f13dc1 is in akpm's tree, and it conflicts with another
>>>> patch in linux-pm's tree. So Andrew Morton drops them.
>>>>
>>>> I will resend them based on linux-pm's next tree.
>>>
>>> Ok. Today's linux-next version 85fcb3758c10e "ACPI / memory-hotplug:
>>> introduce a mutex lock to protect the list in acpi_memory_device"
>>> has a similar problem and should be fixed as well.
>>
>> This patch is in pm tree, and there is one problem. Should I resend them?
> 
> Yes, please.
> 
> Please also let me know which commits in linux-pm.git/linux-next should be
> replaced with the new versions.

OK. I will write it in the patches.

Thanks
Wen Congyang

> 
> Thanks,
> Rafael
> 
> 

