From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v5 5/5] gicv2m: acpi: Introducing GICv2m ACPI support
Date: Wed, 9 Dec 2015 12:02:07 -0600
Message-ID: <56686C9F.6060804@amd.com>
References: <1449625686-5594-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1449625686-5594-6-git-send-email-Suravee.Suthikulpanit@amd.com>
 <20151209103806.41488405@why.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151209103806.41488405@why.wild-wind.fr.eu.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, jason@lakedaemon.net, graeme.gregory@linaro.org, rjw@rjwysocki.net, dhdang@apm.com, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, tomasz.nowicki@linaro.org, linux-acpi@vger.kernel.org, hanjun.guo@linaro.org, Catalin Marinas <Catalin.Marinas@arm.com>, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

Hi Marc,

On 12/9/2015 4:38 AM, Marc Zyngier wrote:
> On Tue, 8 Dec 2015 17:48:06 -0800
> Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com> wrote:
>
>> This patch introduces gicv2m_acpi_init(), which uses information
>> in MADT GIC MSI frames structure to initialize GICv2m driver.
>>
>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   drivers/irqchip/irq-gic-v2m.c   | 95 +++++++++++++++++++++++++++++++++++++++++
>>   drivers/irqchip/irq-gic.c       |  3 ++
>>   include/linux/irqchip/arm-gic.h |  4 ++
>>   3 files changed, 102 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
>> [...]
>> @@ -359,6 +368,8 @@ static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
>>
>>   	if (to_of_node(fwnode))
>>   		name = to_of_node(fwnode)->name;
>> +	else
>> +		name = irq_domain_get_irqchip_fwnode_name(fwnode);
>
> Don't bother with that, the name associated with the domain is
> absolutely meaningless. You are already printing the frame address,
> which is enough to identify it, should someone need to debug this.
>
> Drop the name from the previous patch as well, and that will make one
> less difference to care about. Patch #3 can die as well.
>

Ok. I'll just leave them blank (i.e. const char *name ="")

>> [...]
>> diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
>> index bae69e5..30b2ccb 100644
>> --- a/include/linux/irqchip/arm-gic.h
>> +++ b/include/linux/irqchip/arm-gic.h
>> @@ -108,6 +108,10 @@ void gic_init(unsigned int nr, int start,
>>
>>   int gicv2m_of_init(struct device_node *node, struct irq_domain *parent);
>>
>> +#ifdef CONFIG_ACPI
>> +int gicv2m_acpi_init(struct irq_domain *parent);
>> +#endif
>> +
>
> How about having a single:
>
> int gicv2m_init(struct fwnode_handle *parent_handle,
> 		struct irq_domain *parent_domain);
>
> which in turn calls either gicv2m_of_init or gicv2m_acpi_init? Saves
> some #ifdef, and avoids another entry point.

Sounds good. I'll take care of this.

>>   void gic_send_sgi(unsigned int cpu_id, unsigned int irq);
>>   int gic_get_cpu_id(unsigned int cpu);
>>   void gic_migrate_target(unsigned int new_cpu_id);
>
> Otherwise, this looks good.
>
> Thanks,
>
> 	M.
>

Thanks. Sending out v6 in a little bit.

Suravee
