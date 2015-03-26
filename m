From: Will Deacon <will.deacon@arm.com>
Subject: Re: [patch v11 12/23] ARM64 / ACPI: Parse MADT for SMP initialization
Date: Thu, 26 Mar 2015 21:12:42 +0000
Message-ID: <20150326211239.GA23660@arm.com>
References: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
 <1427205776-5060-13-git-send-email-hanjun.guo@linaro.org>
 <20150325171735.GI14585@localhost>
 <20150326151510.GI2805@arm.com>
 <551462A2.4070308@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54668 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752873AbbCZVMu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Mar 2015 17:12:50 -0400
Content-Disposition: inline
In-Reply-To: <551462A2.4070308@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Mark Rutland <Mark.Rutland@arm.com>, Ashwin Chaugule <ashwinc@codeaurora.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Robert Richter <rric@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Timur Tabi <timur@codeaurora.org>, "msalter@redhat.com" <msalter@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, "suravee.suthikulpanit@amd.com" <suravee.suthik>

On Thu, Mar 26, 2015 at 07:48:50PM +0000, Hanjun Guo wrote:
> On 2015=E5=B9=B403=E6=9C=8826=E6=97=A5 23:15, Will Deacon wrote:
> > commit 8ef320319592693f4a6286d80df210fd47b3e356
> > Author: Will Deacon <will.deacon@arm.com>
> > Date:   Thu Mar 26 15:09:20 2015 +0000
> >
> >      ARM64 / ACPI: fix usage of acpi_map_gic_cpu_interface
> >
> >      acpi_parse_gic_cpu_interface calls acpi_map_gic_cpu_interface =
by both
> >      passing a 32-bit value in the u8 enabled parameter and then su=
bsequently
> >      ignoring its return value.
> >
> >      Sort it out.
> >
> >      Reported-by: Catalin Marinas <catalin.marinas@arm.com>
> >      Signed-off-by: Will Deacon <will.deacon@arm.com>
> >
> > diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> > index cd60329da8c4..07649e413244 100644
> > --- a/arch/arm64/kernel/acpi.c
> > +++ b/arch/arm64/kernel/acpi.c
> > @@ -103,9 +103,12 @@ void __init __acpi_unmap_table(char *map, unsi=
gned long size)
> >    *
> >    * Returns the logical cpu number which maps to MPIDR
> >    */
> > -static int __init acpi_map_gic_cpu_interface(u64 mpidr, u8 enabled=
)
> > +static int __init
> > +acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *pro=
cessor)
>=20
> How about just replace u8 with u32? This function has its purpose to
> be lived, on x86/ia64, ACPI core will get the physcal cpu ID via
> ACPI handle, then pass it to the arch specific mapping function
> to map the physcal cpu ID with logical cpu ID for the new added
> CPU, so when ACPI based CPU hot-plug is introduced on ARM64, we
> need to go back to that solution.

If/when that happens, we can change things then. Right now, this is a s=
tatic
function with one caller. One step at a time, please.

> >   {
> >   	int i;
> > +	u64 mpidr =3D processor->arm_mpidr & MPIDR_HWID_BITMASK;
> > +	bool enabled =3D !!(processor->flags & ACPI_MADT_ENABLED);
> >
> >   	if (mpidr =3D=3D INVALID_HWID) {
> >   		pr_info("Skip MADT cpu entry with invalid MPIDR\n");
> > @@ -178,11 +181,7 @@ acpi_parse_gic_cpu_interface(struct acpi_subta=
ble_header *header,
> >   		return -EINVAL;
> >
> >   	acpi_table_print_madt_entry(header);
> > -
> > -	acpi_map_gic_cpu_interface(processor->arm_mpidr & MPIDR_HWID_BITM=
ASK,
> > -		processor->flags & ACPI_MADT_ENABLED);
> > -
> > -	return 0;
> > +	return acpi_map_gic_cpu_interface(processor);
>=20
> I don't think we need to return the error value here, in ACPI
> core, it will stop the MADT scanning once it returned the error
> value, but actually we can skip some disabled GICC (cpu) entries
> and find all the enabled ones in MADT, for example,
>=20
> cpu0 entry, with flag enabled
> cpu1 entry, disabled  - if we return the error value, table scanning
>                          will stop
> cpu2 entry, enabled   - and this cpu will be ignored

Then send me a patch making acpi_map_gic_cpu_interface have a void retu=
rn
type. Ignoring the return type is usually a good way to introduce subtl=
e
bugs.

Will
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
