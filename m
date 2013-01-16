From: Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: enabled and failed flags in acpi_memory_info
Date: Wed, 16 Jan 2013 22:33:13 +0800
Message-ID: <50F6BA29.9020201@cn.fujitsu.com>
References: <1357693472.14145.42.camel@misato.fc.hp.com> <1358197617.14145.92.camel@misato.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:60832 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750963Ab3APO0B (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jan 2013 09:26:01 -0500
In-Reply-To: <1358197617.14145.92.camel@misato.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: isimatu.yasuaki@jp.fujitsu.com, linux-acpi@vger.kernel.org


Sorry for late reply.

At 01/15/2013 05:06 AM, Toshi Kani Wrote:
> Wen, Yasuaki, any thoughts on this?
> 
> Thanks,
> -Toshi
> 
> 
> On Tue, 2013-01-08 at 18:04 -0700, Toshi Kani wrote:
>> Hi Wen,
>>
>> I have a question about the change you made in commit 65479472 in
>> acpi_memhotplug.c.  This change seems to require that
>> acpi_memory_enable_device() calls add_memory() to add all memory ranges
>> represented by memory device objects at boot-time, and keep the results
>> be used for hot-remove.  
>>
>> If I understand it right, this add_memory() call fails with EEXIST at
>> boot-time since all memory ranges should have been added from EFI memory
>> table (or e820) already.  This results all memory ranges be marked as !
>> enabled & !failed.  I think this means that we cannot hot-delete any
>> memory ranges presented at boot-time since acpi_memory_remove_memory()
>> only calls remove_memory() when the enabled flag is set.  Is that
>> correct?  If so, why do we need such restriction?t 

Hmm, it means that this memory range is not managed by this driver. I am
not sure it is safe to remove it, so I restrict it...


If it is safe to remove such memory, you can remove this restriction.

Thanks
Wen Congyang
>>
>> In addition, as part of RFC patchset of proposed hotplug framework below
>> (well, this is why I am wondering this... :), I simply called
>> add_memory() and remove_memory() for the ranges requested for hot-add /
>> hot-delete.  It does not call add_memory() at boot-time and set the
>> enabled & failed flags.  But it does not eject memory when
>> remove_memory() failed, either.  Do you see any problems with this
>> approach? 
>> https://lkml.org/lkml/2012/12/12/457
>>
>> Thanks,
>> -Toshi
> 
> 
> 

