From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v7 3/4] gicv2m: Refactor to prepare for ACPI support
Date: Wed, 16 Dec 2015 18:23:49 -0600
Message-ID: <56720095.70004@amd.com>
References: <1449766530-16935-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1449766530-16935-4-git-send-email-Suravee.Suthikulpanit@amd.com>
 <20151216221208.GC27791@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bl2on0053.outbound.protection.outlook.com ([65.55.169.53]:22436
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752330AbbLQAX7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Dec 2015 19:23:59 -0500
In-Reply-To: <20151216221208.GC27791@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net, bhelgaas@google.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, hanjun.guo@linaro.org, tomasz.nowicki@linaro.org, graeme.gregory@linaro.org, dhdang@apm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org

Hi Bjorn,

Thanks for your review. Please see my comments below.

On 12/16/2015 4:12 PM, Bjorn Helgaas wrote:
> On Thu, Dec 10, 2015 at 08:55:29AM -0800, Suravee Suthikulpanit wrote:
>> This patch replaces the struct device_node with struct fwnode_handle
>> since this structure is common between DT and ACPI.
>>
>> It also refactors gicv2m_init_one() to prepare for ACPI support.
>> The only functional change is removing the node name from pr_info.
>>
>> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>
>> @@ -359,10 +355,10 @@ static int __init gicv2m_init_one(struct device_node *node,
>>   	}
>>
>>   	list_add_tail(&v2m->entry, &v2m_nodes);
>> -	pr_info("Node %s: range[%#lx:%#lx], SPI[%d:%d]\n", node->name,
>> -		(unsigned long)v2m->res.start, (unsigned long)v2m->res.end,
>> -		v2m->spi_start, (v2m->spi_start + v2m->nr_spis));
>>
>> +	pr_info("range[%#lx:%#lx], SPI[%d:%d]\n",
>> +		(unsigned long)res->start, (unsigned long)res->end,
>> +		v2m->spi_start, (v2m->spi_start + v2m->nr_spis));
>
> You didn't change this, but I don't think this message has enough
> context.  It's pretty cryptic all by itself.  It'd be nice if it could
> at least include a device name, e.g., if you could use dev_info().

Here is the example of the information printed:
[    0.000000] GICv2m: range[0xe1180000:0xe1181000], SPI[64:320]

Basically, the v2m is just an extension of the GIC. Here, we are 
printing the memory range that it is covering, which can be used to 
identify different V2m frame and the associate interrupt range (SPI). 
The node name is not really providing any values. So, we are removing it.

Thanks,
Suravee

> If that's possible, I guess a separate patch would be appropriate,
> since there are other similar things in this file.
> j
> Bjorn



