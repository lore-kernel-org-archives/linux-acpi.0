From: matthieu castet <castet.matthieu@free.fr>
Subject: Re: [PATCH] check that acpi_wakeup_address is below 1MB v2
Date: Fri, 11 Apr 2008 20:04:02 +0200
Message-ID: <47FFA812.3070108@free.fr>
References: <47FE87B0.7080709@free.fr> <1207907709.9448.19.camel@yakui_zhao.sh.intel.com> <200804111712.24233.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2-g19.free.fr ([212.27.42.28]:56631 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760167AbYDKSEE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Apr 2008 14:04:04 -0400
In-Reply-To: <200804111712.24233.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org

Hi,

Rafael J. Wysocki wrote:
> On Friday, 11 of April 2008, Zhao Yakui wrote:
>> On Thu, 2008-04-10 at 23:33 +0200, matthieu castet wrote:
>>> Hi,
>>>
>>> this patch add a check that the memory allocated for s3 wakeup is in the 
>>> first 1MB as required by acpi spec.
>>>
>> Have you found whether some systems are afflicted by this ?
>>
>> In fact that OS allacates the acpi_wake_address follows the below two
>> functions:
>> reserve_bootmem(0, PAGE_SIZE, BOOTMEM_DEFAULT);
>> reserve_bootmem(PAGE_SIZE, PAGE_SIZE, BOOTMEM_DEFAULT);
>>
That's on 32 bits kernel. Aren't the 1MB limitation valid on 64 bits 
kernel ?

>> The above mechanism can insure that the acpi_wake_address is in memroy
>> below 1M. (It is unncessary to apply the patch. IMO)
> 
> Agreed.
>  
>> Of course the addressing check will be more strict after this patch is
>> applied.
> 
> Matthieu, can you please explain why you consider the patch as necessary?
This can help to debug strange S3 wakeup problem. It make sure the 
allocation is correct.

Also I believe relying on the bootmem allocator internal to be sure it 
is in the first 1MB is a bad things (why can't it start allocating 
memory to the top of 16MB memory).
If you are sure of the allocated memory before the call, why don't do a
reserve_bootmem(PAGE_SIZE*2, PAGE_SIZE*2, BOOTMEM_DEFAULT); ?


Matthieu
