From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v8 15/21] ARM64 / ACPI: Introduce ACPI_IRQ_MODEL_GIC and
 register device's gsi
Date: Mon, 09 Feb 2015 14:53:31 +0800
Message-ID: <54D8596B.1070102@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org> <1422881149-8177-16-git-send-email-hanjun.guo@linaro.org> <20150209063444.GJ13969@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150209063444.GJ13969@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeau>
List-Id: linux-acpi@vger.kernel.org

On 2015=E5=B9=B402=E6=9C=8809=E6=97=A5 14:34, Will Deacon wrote:
> On Mon, Feb 02, 2015 at 12:45:43PM +0000, Hanjun Guo wrote:
>> Introduce ACPI_IRQ_MODEL_GIC which is needed for ARM64 as GIC is
>> used, and then register device's gsi with the core IRQ subsystem.
>>
>> acpi_register_gsi() is similar to DT based irq_of_parse_and_map(),
>> since gsi is unique in the system, so use hwirq number directly
>> for the mapping.
>>
>> We are going to implement stacked domains when GICv2m, GICv3, ITS
>> support are added.
>>
>> CC: Marc Zyngier <marc.zyngier@arm.com>
>> Originally-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> Tested-by: Yijing Wang <wangyijing@huawei.com>
>> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
>> Tested-by: Jon Masters <jcm@redhat.com>
>> Tested-by: Timur Tabi <timur@codeaurora.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   arch/arm64/kernel/acpi.c | 73 ++++++++++++++++++++++++++++++++++++=
++++++++++++
>>   drivers/acpi/bus.c       |  3 ++
>>   include/linux/acpi.h     |  1 +
>>   3 files changed, 77 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
>> index f80caef..f86a982 100644
>> --- a/arch/arm64/kernel/acpi.c
>> +++ b/arch/arm64/kernel/acpi.c
>> @@ -38,6 +38,12 @@ EXPORT_SYMBOL(acpi_pci_disabled);
>>   static int enabled_cpus;	/* Processors (GICC) with enabled flag in=
 MADT */
>>
>>   /*
>> + * Since we're on ARM, the default interrupt routing model
>> + * clearly has to be GIC.
>> + */
>> +enum acpi_irq_model_id acpi_irq_model =3D ACPI_IRQ_MODEL_GIC;
>> +
>> +/*
>>    * __acpi_map_table() will be called before page_init(), so early_=
ioremap()
>>    * or early_memremap() should be called here to for ACPI table map=
ping.
>>    */
>> @@ -185,6 +191,73 @@ void __init acpi_init_cpus(void)
>>   	pr_info("%d CPUs enabled, %d CPUs total\n", enabled_cpus, total_c=
pus);
>>   }
>>
>> +int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
>> +{
>> +	*irq =3D irq_find_mapping(NULL, gsi);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
>> +
>> +/*
>> + * success: return IRQ number (>0)
>> + * failure: return =3D< 0
>> + */
>> +int acpi_register_gsi(struct device *dev, u32 gsi, int trigger, int=
 polarity)
>> +{
>> +	unsigned int irq;
>> +	unsigned int irq_type;
>> +
>> +	/*
>> +	 * ACPI have no bindings to indicate SPI or PPI, so we
>> +	 * use different mappings from DT in ACPI.
>> +	 *
>> +	 * For FDT
>> +	 * PPI interrupt: in the range [0, 15];
>> +	 * SPI interrupt: in the range [0, 987];
>> +	 *
>> +	 * For ACPI, GSI should be unique so using
>> +	 * the hwirq directly for the mapping:
>> +	 * PPI interrupt: in the range [16, 31];
>> +	 * SPI interrupt: in the range [32, 1019];
>> +	 */
>> +
>> +	if (trigger =3D=3D ACPI_EDGE_SENSITIVE &&
>> +				polarity =3D=3D ACPI_ACTIVE_LOW)
>> +		irq_type =3D IRQ_TYPE_EDGE_FALLING;
>> +	else if (trigger =3D=3D ACPI_EDGE_SENSITIVE &&
>> +				polarity =3D=3D ACPI_ACTIVE_HIGH)
>> +		irq_type =3D IRQ_TYPE_EDGE_RISING;
>> +	else if (trigger =3D=3D ACPI_LEVEL_SENSITIVE &&
>> +				polarity =3D=3D ACPI_ACTIVE_LOW)
>> +		irq_type =3D IRQ_TYPE_LEVEL_LOW;
>> +	else if (trigger =3D=3D ACPI_LEVEL_SENSITIVE &&
>> +				polarity =3D=3D ACPI_ACTIVE_HIGH)
>> +		irq_type =3D IRQ_TYPE_LEVEL_HIGH;
>> +	else
>> +		irq_type =3D IRQ_TYPE_NONE;
>> +
>> +	/*
>> +	 * Since only one GIC is supported in ACPI 5.0, we can
>> +	 * create mapping refer to the default domain
>> +	 */
>> +	irq =3D irq_create_mapping(NULL, gsi);
>> +	if (!irq)
>> +		return irq;
>> +
>> +	/* Set irq type if specified and different than the current one */
>> +	if (irq_type !=3D IRQ_TYPE_NONE &&
>> +		irq_type !=3D irq_get_trigger_type(irq))
>> +		irq_set_irq_type(irq, irq_type);
>> +	return irq;
>> +}
>> +EXPORT_SYMBOL_GPL(acpi_register_gsi);
>> +
>> +void acpi_unregister_gsi(u32 gsi)
>> +{
>> +}
>> +EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
>> +
>>   static int __init acpi_parse_fadt(struct acpi_table_header *table)
>>   {
>>   	struct acpi_table_fadt *fadt =3D (struct acpi_table_fadt *)table;
>
> Does this code *have* to sit under arch/arm64? I can't see anything
> architecture-specific about it and the bulk of the functions map dire=
ctly
> onto irq domain callbacks. I know that the answer is probably "we can=
 fix
> that in the future", but it doesn't seem like a huge amount of effort=
 to
> get the right abstractions in place from the beginning so that we don=
't
> have to churn this stuff later on.

Do you mean move acpi_register_gsi()/acpi_unregister_gsi() to irqdomain
related file?

Since x86 and IA64 have their arch specific acpi_register_gsi()
/acpi_unregister_gsi(), we will got compile errors on x86 and IA64
platforms.

Thanks
Hanjun
