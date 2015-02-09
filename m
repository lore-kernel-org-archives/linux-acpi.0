From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v8 15/21] ARM64 / ACPI: Introduce ACPI_IRQ_MODEL_GIC and
 register device's gsi
Date: Mon, 9 Feb 2015 07:07:54 +0000
Message-ID: <20150209070754.GL13969@arm.com>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <1422881149-8177-16-git-send-email-hanjun.guo@linaro.org>
 <20150209063444.GJ13969@arm.com>
 <54D8596B.1070102@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:42694 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759369AbbBIHIC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Feb 2015 02:08:02 -0500
Content-Disposition: inline
In-Reply-To: <54D8596B.1070102@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeau>

On Mon, Feb 09, 2015 at 06:53:31AM +0000, Hanjun Guo wrote:
> On 2015=E5=B9=B402=E6=9C=8809=E6=97=A5 14:34, Will Deacon wrote:
> > On Mon, Feb 02, 2015 at 12:45:43PM +0000, Hanjun Guo wrote:
> >> Introduce ACPI_IRQ_MODEL_GIC which is needed for ARM64 as GIC is
> >> used, and then register device's gsi with the core IRQ subsystem.
> >>
> >> acpi_register_gsi() is similar to DT based irq_of_parse_and_map(),
> >> since gsi is unique in the system, so use hwirq number directly
> >> for the mapping.
> >>
> >> We are going to implement stacked domains when GICv2m, GICv3, ITS
> >> support are added.
> >>
> >> CC: Marc Zyngier <marc.zyngier@arm.com>
> >> Originally-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> >> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> >> Tested-by: Yijing Wang <wangyijing@huawei.com>
> >> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
> >> Tested-by: Jon Masters <jcm@redhat.com>
> >> Tested-by: Timur Tabi <timur@codeaurora.org>
> >> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> >> ---
> >>   arch/arm64/kernel/acpi.c | 73 ++++++++++++++++++++++++++++++++++=
++++++++++++++
> >>   drivers/acpi/bus.c       |  3 ++
> >>   include/linux/acpi.h     |  1 +
> >>   3 files changed, 77 insertions(+)
> >>
> >> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> >> index f80caef..f86a982 100644
> >> --- a/arch/arm64/kernel/acpi.c
> >> +++ b/arch/arm64/kernel/acpi.c
> >> @@ -38,6 +38,12 @@ EXPORT_SYMBOL(acpi_pci_disabled);
> >>   static int enabled_cpus;	/* Processors (GICC) with enabled flag =
in MADT */
> >>
> >>   /*
> >> + * Since we're on ARM, the default interrupt routing model
> >> + * clearly has to be GIC.
> >> + */
> >> +enum acpi_irq_model_id acpi_irq_model =3D ACPI_IRQ_MODEL_GIC;
> >> +
> >> +/*
> >>    * __acpi_map_table() will be called before page_init(), so earl=
y_ioremap()
> >>    * or early_memremap() should be called here to for ACPI table m=
apping.
> >>    */
> >> @@ -185,6 +191,73 @@ void __init acpi_init_cpus(void)
> >>   	pr_info("%d CPUs enabled, %d CPUs total\n", enabled_cpus, total=
_cpus);
> >>   }
> >>
> >> +int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
> >> +{
> >> +	*irq =3D irq_find_mapping(NULL, gsi);
> >> +
> >> +	return 0;
> >> +}
> >> +EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
> >> +
> >> +/*
> >> + * success: return IRQ number (>0)
> >> + * failure: return =3D< 0
> >> + */
> >> +int acpi_register_gsi(struct device *dev, u32 gsi, int trigger, i=
nt polarity)
> >> +{
> >> +	unsigned int irq;
> >> +	unsigned int irq_type;
> >> +
> >> +	/*
> >> +	 * ACPI have no bindings to indicate SPI or PPI, so we
> >> +	 * use different mappings from DT in ACPI.
> >> +	 *
> >> +	 * For FDT
> >> +	 * PPI interrupt: in the range [0, 15];
> >> +	 * SPI interrupt: in the range [0, 987];
> >> +	 *
> >> +	 * For ACPI, GSI should be unique so using
> >> +	 * the hwirq directly for the mapping:
> >> +	 * PPI interrupt: in the range [16, 31];
> >> +	 * SPI interrupt: in the range [32, 1019];
> >> +	 */
> >> +
> >> +	if (trigger =3D=3D ACPI_EDGE_SENSITIVE &&
> >> +				polarity =3D=3D ACPI_ACTIVE_LOW)
> >> +		irq_type =3D IRQ_TYPE_EDGE_FALLING;
> >> +	else if (trigger =3D=3D ACPI_EDGE_SENSITIVE &&
> >> +				polarity =3D=3D ACPI_ACTIVE_HIGH)
> >> +		irq_type =3D IRQ_TYPE_EDGE_RISING;
> >> +	else if (trigger =3D=3D ACPI_LEVEL_SENSITIVE &&
> >> +				polarity =3D=3D ACPI_ACTIVE_LOW)
> >> +		irq_type =3D IRQ_TYPE_LEVEL_LOW;
> >> +	else if (trigger =3D=3D ACPI_LEVEL_SENSITIVE &&
> >> +				polarity =3D=3D ACPI_ACTIVE_HIGH)
> >> +		irq_type =3D IRQ_TYPE_LEVEL_HIGH;
> >> +	else
> >> +		irq_type =3D IRQ_TYPE_NONE;
> >> +
> >> +	/*
> >> +	 * Since only one GIC is supported in ACPI 5.0, we can
> >> +	 * create mapping refer to the default domain
> >> +	 */
> >> +	irq =3D irq_create_mapping(NULL, gsi);
> >> +	if (!irq)
> >> +		return irq;
> >> +
> >> +	/* Set irq type if specified and different than the current one =
*/
> >> +	if (irq_type !=3D IRQ_TYPE_NONE &&
> >> +		irq_type !=3D irq_get_trigger_type(irq))
> >> +		irq_set_irq_type(irq, irq_type);
> >> +	return irq;
> >> +}
> >> +EXPORT_SYMBOL_GPL(acpi_register_gsi);
> >> +
> >> +void acpi_unregister_gsi(u32 gsi)
> >> +{
> >> +}
> >> +EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
> >> +
> >>   static int __init acpi_parse_fadt(struct acpi_table_header *tabl=
e)
> >>   {
> >>   	struct acpi_table_fadt *fadt =3D (struct acpi_table_fadt *)tabl=
e;
> >
> > Does this code *have* to sit under arch/arm64? I can't see anything
> > architecture-specific about it and the bulk of the functions map di=
rectly
> > onto irq domain callbacks. I know that the answer is probably "we c=
an fix
> > that in the future", but it doesn't seem like a huge amount of effo=
rt to
> > get the right abstractions in place from the beginning so that we d=
on't
> > have to churn this stuff later on.
>=20
> Do you mean move acpi_register_gsi()/acpi_unregister_gsi() to irqdoma=
in
> related file?
>=20
> Since x86 and IA64 have their arch specific acpi_register_gsi()
> /acpi_unregister_gsi(), we will got compile errors on x86 and IA64
> platforms.

Right, but nobody builds a single kernel image supporting x86 and arm, =
so
this doesn't sound impossible to fix.

The code here basically consists of:

  - Definition of acpi_irq_model. That can stay here for now.
  - Empty stub for acpi_unregister_gsi -- should be in core code
  - acpi_gsi_to_irq -- maps directly to irq_find_mapping, core code.
  - Code to translate an ACPI interrupt type to a Linux IRQ subsystem t=
ype
  - Instantiaton of an irq mapping

None of that has anything to do with the arm64 architecture. If we have=
 to
make some small changes to core code to accommodate a non-x86 architect=
ure,
then I think we should at least consider that first.

Will
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
