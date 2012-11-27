From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v3 0/3] ACPI: container hot remove support.
Date: Tue, 27 Nov 2012 09:08:15 +0800
Message-ID: <50B4127F.3080400@huawei.com>
References: <1351668471-31436-1-git-send-email-tangchen@cn.fujitsu.com> <509106E2.70008@jp.fujitsu.com> <50B3014E.3040107@huawei.com> <50B306E0.3050207@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:4593 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756345Ab2K0BJn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Nov 2012 20:09:43 -0500
In-Reply-To: <50B306E0.3050207@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tang Chen <tangchen@cn.fujitsu.com>
Cc: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, yinghai@kernel.org, bhelgaas@google.com, lenb@kernel.org, jiang.liu@huawei.com, izumi.taku@jp.fujitsu.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Wen Congyang <wency@cn.fujitsu.com>, Toshi Kani <toshi.kani@hp.com>

On 2012/11/26 14:06, Tang Chen wrote:
> On 11/26/2012 01:42 PM, Hanjun Guo wrote:
>>
>> Hi all,
>> I think Yasuaki mentioned the key point for the container device rem=
ove,
>> that is dependency.
>>
>> Currently, container, processor, and memory hotpulg are managed by d=
ifferent ACPI
>> hotplug drivers, the driver works when handle device hotplug individ=
ually, but they
>> have no idea for each other.
>>
>> This may introduce some issues, such as Yasuaki mentioned above, tha=
t is to say, we
>> should remove its child before remove the device itself, and hot add=
 its parent before
>> the device itself.
>>
>> According to the ACPI namespace, we can resolve most of dependency i=
ssues. On a typical
>> two processor sockets system, the namespace is like this:
>>
>> /_SB                   ---container device, with HID ACPI0004
>>      |_SCK0             ---container device, with HID ACPI0004
>>       |_CPU0       ---processor device, with HID ACPI0009 or LNXCPU
>>            |_...
>>            |_CPUx
>>            |_MEM0       ---Memory device, with HID PNP0C80
>>      |_SCK1
>>       |_CPU0
>>            |_...
>>            |_CPUx
>>            |_MEM1
>>      |_PCI0            ---Host bridge, with HID PNP0A03 or PNP0A08
>>
>> If hot remove the container device, such as SCK0, we can easily know=
 the dependency list
>> is CPU0~CPUx and MEM0, but I think the ACPI hotplug driver haven't r=
esolve this now.
>>
>> And there is another corner case for hotplug devices in the namespac=
e above, that is:
>> 1) Remove SCK0. yes, we can remove it with no dependency to the host=
 bridge PCI0;
>>
>> 2) Remove SCK1 after SCK0. we should remove the host bridge PCI0 fir=
st,
>>     or the system will crash down. yes, dynamic dependency analysis =
is needed here.
>>     and the ACPI hotplug driver totally have no idea of this.
>>
>> so, should we do something to settle this down ?
>=20
> Hi Guo,
>=20
> I am trying to do this too. :)

Great=EF=BC=8C what's your idea of this?


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
