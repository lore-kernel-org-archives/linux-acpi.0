From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH v3 0/3] ACPI: container hot remove support.
Date: Mon, 26 Nov 2012 14:06:24 +0800
Message-ID: <50B306E0.3050207@cn.fujitsu.com>
References: <1351668471-31436-1-git-send-email-tangchen@cn.fujitsu.com> <509106E2.70008@jp.fujitsu.com> <50B3014E.3040107@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:38734 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752282Ab2KZGH3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Nov 2012 01:07:29 -0500
In-Reply-To: <50B3014E.3040107@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>
Cc: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, yinghai@kernel.org, bhelgaas@google.com, lenb@kernel.org, jiang.liu@huawei.com, izumi.taku@jp.fujitsu.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Wen Congyang <wency@cn.fujitsu.com>, Toshi Kani <toshi.kani@hp.com>

On 11/26/2012 01:42 PM, Hanjun Guo wrote:
>
> Hi all,
> I think Yasuaki mentioned the key point for the container device remove,
> that is dependency.
>
> Currently, container, processor, and memory hotpulg are managed by different ACPI
> hotplug drivers, the driver works when handle device hotplug individually, but they
> have no idea for each other.
>
> This may introduce some issues, such as Yasuaki mentioned above, that is to say, we
> should remove its child before remove the device itself, and hot add its parent before
> the device itself.
>
> According to the ACPI namespace, we can resolve most of dependency issues. On a typical
> two processor sockets system, the namespace is like this:
>
> /_SB                   ---container device, with HID ACPI0004
>      |_SCK0             ---container device, with HID ACPI0004
> 	  |_CPU0       ---processor device, with HID ACPI0009 or LNXCPU
>            |_...
>            |_CPUx
>            |_MEM0       ---Memory device, with HID PNP0C80
>      |_SCK1
> 	  |_CPU0
>            |_...
>            |_CPUx
>            |_MEM1
>      |_PCI0            ---Host bridge, with HID PNP0A03 or PNP0A08
>
> If hot remove the container device, such as SCK0, we can easily know the dependency list
> is CPU0~CPUx and MEM0, but I think the ACPI hotplug driver haven't resolve this now.
>
> And there is another corner case for hotplug devices in the namespace above, that is:
> 1) Remove SCK0. yes, we can remove it with no dependency to the host bridge PCI0;
>
> 2) Remove SCK1 after SCK0. we should remove the host bridge PCI0 first,
>     or the system will crash down. yes, dynamic dependency analysis is needed here.
>     and the ACPI hotplug driver totally have no idea of this.
>
> so, should we do something to settle this down ?

Hi Guo,

I am trying to do this too. :)

But so far as I know, Vasilis Liaskovitis has provided an approach.
Please refer to the following url.
https://lkml.org/lkml/2012/11/15/159

I think we can review his patches first. :)

And by the way, I think the ACPI based hotplug framework provided by
Liu Jiang may also settle this problem. But I'm not quit sure yet. :)

Thanks. :)

>
> Thanks
> Hanjun Guo
>
>
>> The example is as follows:
>>
>>   https://lkml.org/lkml/2012/9/26/318
>>
>> Thanks,
>> Yasuaki Ishimatsu
>>
>>>
>
>
>
>

