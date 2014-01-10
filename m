From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: Re: kdump failed because of hotplug memory adding in kdump kernel
Date: Fri, 10 Jan 2014 18:35:07 +0900
Message-ID: <52CFBECB.9040309@jp.fujitsu.com>
References: <20140109145035.GB25897@redhat.com> <1389283439.1792.66.camel@misato.fc.hp.com> <20140109162427.GF25897@redhat.com> <1389288265.1792.108.camel@misato.fc.hp.com> <20140109182310.GG25897@redhat.com> <1389292470.1792.109.camel@misato.fc.hp.com> <20140109212705.GC12111@redhat.com> <1389304583.1792.139.camel@misato.fc.hp.com> <20140110071124.GA6464@dhcp-16-105.nay.redhat.com> <52CFAA20.2010109@jp.fujitsu.com> <20140110091433.GA14074@dhcp-16-105.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:39354 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbaAJJgN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Jan 2014 04:36:13 -0500
In-Reply-To: <20140110091433.GA14074@dhcp-16-105.nay.redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Baoquan <bhe@redhat.com>
Cc: Toshi Kani <toshi.kani@hp.com>, Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, tangchen@cn.fujitsu.com, linux-acpi@vger.kernel.org, zhangyanfei@cn.fujitsu.com, dyoung@redhat.com

(2014/01/10 18:14), Baoquan wrote:
>
>   >In ns
>>> object tree, they are not treated as hotplug memory.
>>
>> wrong.
>> They are treated as hotplug memory. But the memory cannot hot removed
>> because the memory has kernel memory.
>>
>>> Otherwise, any hotplug memory which is not reserved for 2nd kernel can
>>> be parsed and need be added as hotplug memory, and add them into movable
>>> zone.
>>
>> wrong.
>> The memory is allocated as normal zone and it is offline.
>
> Hi,
>
> Thanks for answering.
>


> I am confused. Now the fact is in 1st kernel memory is reserved for
> crashkernel and passed to 2nd kernel by exactmap. Then in 2nd kernel,
> reserved memory regions are added into e820. Later hotplug memory still
> trigger add_memory, and cause bug I reported.

Does the issue occur even if you apply the following Prarit's patch to
your kernel and add no_memory_hotplug boot option to 2nd kernel?

http://marc.info/?l=linux-acpi&m=138922019607796&w=2

Thanks,
Yasuaki Ishimatsu

>
>
>>
>>>
>>> Am I right?
>>>
>>
>>> The other question, e820 reserve is done earlier than acpi
>>> initialization, because acpi_early_init() invocation is very late in
>>> start_kernel(). Does that means at the very beginning all memorys are in
>>> e820, later when acpi_early_init is called, hotplug memory is detected,
>>> they will be moved to different place or need be marked with a specific
>>> flag?
>>
>> No.
>>
>> Thanks,
>> Yasuaki Ishimatsu
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


