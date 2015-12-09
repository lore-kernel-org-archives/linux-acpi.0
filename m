From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v5 5/5] gicv2m: acpi: Introducing GICv2m ACPI support
Date: Wed, 09 Dec 2015 18:16:40 +0000
Message-ID: <56687008.3020703@arm.com>
References: <1449625686-5594-1-git-send-email-Suravee.Suthikulpanit@amd.com> <1449625686-5594-6-git-send-email-Suravee.Suthikulpanit@amd.com> <20151209103806.41488405@why.wild-wind.fr.eu.org> <56686C9F.6060804@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56686C9F.6060804@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
Cc: tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, hanjun.guo@linaro.org, tomasz.nowicki@linaro.org, graeme.gregory@linaro.org, dhdang@apm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 09/12/15 18:02, Suravee Suthikulanit wrote:
> Hi Marc,
> 
> On 12/9/2015 4:38 AM, Marc Zyngier wrote:
>> On Tue, 8 Dec 2015 17:48:06 -0800
>> Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com> wrote:
>>
>>> This patch introduces gicv2m_acpi_init(), which uses information
>>> in MADT GIC MSI frames structure to initialize GICv2m driver.
>>>
>>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>> ---
>>>   drivers/irqchip/irq-gic-v2m.c   | 95 +++++++++++++++++++++++++++++++++++++++++
>>>   drivers/irqchip/irq-gic.c       |  3 ++
>>>   include/linux/irqchip/arm-gic.h |  4 ++
>>>   3 files changed, 102 insertions(+)
>>>
>>> diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
>>> [...]
>>> @@ -359,6 +368,8 @@ static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
>>>
>>>   	if (to_of_node(fwnode))
>>>   		name = to_of_node(fwnode)->name;
>>> +	else
>>> +		name = irq_domain_get_irqchip_fwnode_name(fwnode);
>>
>> Don't bother with that, the name associated with the domain is
>> absolutely meaningless. You are already printing the frame address,
>> which is enough to identify it, should someone need to debug this.
>>
>> Drop the name from the previous patch as well, and that will make one
>> less difference to care about. Patch #3 can die as well.
>>
> 
> Ok. I'll just leave them blank (i.e. const char *name ="")

No, just remove name altogether. Nobody reads that anyway, and if they
want to find out, there is the address that's clear enough.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
