From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v8 13/21] ARM64 / ACPI: Parse MADT for SMP initialization
Date: Wed, 4 Feb 2015 10:30:09 +0000
Message-ID: <20150204103009.GA6592@leverpostej>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <1422881149-8177-14-git-send-email-hanjun.guo@linaro.org>
 <20150203135348.GA31837@leverpostej>
 <54D1E0C9.1040706@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:40980 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932682AbbBDKao (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Feb 2015 05:30:44 -0500
Content-Disposition: inline
In-Reply-To: <54D1E0C9.1040706@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeauro>

On Wed, Feb 04, 2015 at 09:05:13AM +0000, Hanjun Guo wrote:
> On 2015=E5=B9=B402=E6=9C=8803=E6=97=A5 21:53, Mark Rutland wrote:
> > On Mon, Feb 02, 2015 at 12:45:41PM +0000, Hanjun Guo wrote:
> >> MADT contains the information for MPIDR which is essential for
> >> SMP initialization, parse the GIC cpu interface structures to
> >> get the MPIDR value and map it to cpu_logical_map(), and add
> >> enabled cpu with valid MPIDR into cpu_possible_map.
> >>
> >> ACPI 5.1 only has two explicit methods to boot up SMP, PSCI and
> >> Parking protocol, but the Parking protocol is only specified for
> >> ARMv7 now, so make PSCI as the only way for the SMP boot protocol
> >> before some updates for the ACPI spec or the Parking protocol spec=
=2E
> >>
> >> Parking protocol patches for SMP boot will be sent to upstream whe=
n
> >> the new version of Parking protocol is ready.
> >>
> >> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >> CC: Catalin Marinas <catalin.marinas@arm.com>
> >> CC: Will Deacon <will.deacon@arm.com>
> >> CC: Mark Rutland <mark.rutland@arm.com>
> >> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> >> Tested-by: Yijing Wang <wangyijing@huawei.com>
> >> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
> >> Tested-by: Jon Masters <jcm@redhat.com>
> >> Tested-by: Timur Tabi <timur@codeaurora.org>
> >> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> >> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> >> ---
> >>   arch/arm64/include/asm/acpi.h    |   2 +
> >>   arch/arm64/include/asm/cpu_ops.h |   1 +
> >>   arch/arm64/include/asm/smp.h     |   5 +-
> >>   arch/arm64/kernel/acpi.c         | 150 +++++++++++++++++++++++++=
+++++++++++++-
> >>   arch/arm64/kernel/cpu_ops.c      |   2 +-
> >>   arch/arm64/kernel/setup.c        |   7 +-
> >>   arch/arm64/kernel/smp.c          |   2 +-
> >>   7 files changed, 161 insertions(+), 8 deletions(-)
> >
> > [...]
> >
> >> +/**
> >> + * acpi_map_gic_cpu_interface - generates a logical cpu number
> >> + * and map to MPIDR represented by GICC structure
> >> + * @mpidr: CPU's hardware id to register, MPIDR represented in MA=
DT
> >> + * @enabled: this cpu is enabled or not
> >> + *
> >> + * Returns the logical cpu number which maps to MPIDR
> >> + */
> >> +static int __init acpi_map_gic_cpu_interface(u64 mpidr, u8 enable=
d)
> >> +{
> >> +       int cpu;
> >> +
> >> +       if (mpidr =3D=3D INVALID_HWID) {
> >> +               pr_info("Skip MADT cpu entry with invalid MPIDR\n"=
);
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       total_cpus++;
> >> +       if (!enabled)
> >> +               return -EINVAL;
> >> +
> >> +       if (enabled_cpus >=3D  NR_CPUS) {
> >> +               pr_warn("NR_CPUS limit of %d reached, Processor %d=
/0x%llx ignored.\n",
> >> +                       NR_CPUS, total_cpus, mpidr);
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       /* No need to check duplicate MPIDRs for the first CPU */
> >> +       if (enabled_cpus) {
> >> +               /*
> >> +                * Duplicate MPIDRs are a recipe for disaster. Sca=
n
> >> +                * all initialized entries and check for
> >> +                * duplicates. If any is found just ignore the CPU=
=2E
> >> +                */
> >> +               for_each_possible_cpu(cpu) {
> >> +                       if (cpu_logical_map(cpu) =3D=3D mpidr) {
> >> +                               pr_err("Firmware bug, duplicate CP=
U MPIDR: 0x%llx in MADT\n",
> >> +                                      mpidr);
> >> +                               return -EINVAL;
> >> +                       }
> >> +               }
> >> +
> >> +               /* allocate a logical cpu id for the new comer */
> >> +               cpu =3D cpumask_next_zero(-1, cpu_possible_mask);
> >> +       } else {
> >> +               /*
> >> +                * First GICC entry must be BSP as ACPI spec said
> >> +                * in section 5.2.12.15
> >> +                */
> >> +               if  (cpu_logical_map(0) !=3D mpidr) {
> >> +                       pr_err("First GICC entry with MPIDR 0x%llx=
 is not BSP\n",
> >> +                              mpidr);
> >> +                       return -EINVAL;
> >> +               }
> >> +
> >> +               /*
> >> +                * boot_cpu_init() already hold bit 0 in cpu_possi=
ble_mask
> >> +                * for BSP, no need to allocate again.
> >> +                */
> >> +               cpu =3D 0;
> >> +       }
> >
> > If/when kexec comes, on systems where CPU0 can be hotplugged the ne=
xt
> > kernel might boot on an AP rather than the BSP.
>=20
> so cpu_logical_map(0) will be the MPIDR of AP which boot the kernel,
> then it will not equal to mpidr provided in the first entry of MADT,
> right?

Yes.

> It seems that DT smp init will have the same problem, could you give =
me
> some guidance how it solved?

=46or DT we don't rely on the first entry we see in /cpus/ being CPU0 -=
-
we loop over all entries and expect one of them to be CPU0. I that what
you're asking about, or have I misunderstood the question?


> > Is there a requirement
> > Linux-side that CPU0 is the BSP, or is this just intended as a sani=
ty
> > check of the tables the FW provided?
>=20
> It is just the check of the table that the FW provided, so in this
> kexec case, I think this code need to be reworked.
>=20
> On x86, no check for the first LAPIC entry must be BSP, I think we
> need to remove the check for ARM64 too if it makes sense.

Ok. It would be nice to know that there's no implicit assumption that
ACPI makes about code executing on the BSP elsewhere; if so we may need
to prevent CPU0 hotplug.

On x86 CPU0 hotplug is typically inhibited for suspend/resume and
PIC-specific issues, and it's not clear to me if there are other
requirements for CPU0 to stay online.

If the FW requires a particular CPU to stay online, then hopefully that
will be reported through PSCI MIGRATE_INFO_UP_CPU, but we don't
currently check that that in the PSCI code.

>=20
> >
> >> +
> >> +       if (!acpi_psci_present())
> >> +               return -EOPNOTSUPP;
> >> +
> >> +       cpu_ops[cpu] =3D cpu_get_ops("psci");
> >> +       /* CPU 0 was already initialized */
> >> +       if (cpu) {
> >> +               if (!cpu_ops[cpu])
> >> +                       return -EINVAL;
> >> +
> >> +               if (cpu_ops[cpu]->cpu_init(NULL, cpu))
> >> +                       return -EOPNOTSUPP;
> >> +
> >> +               /* map the logical cpu id to cpu MPIDR */
> >> +               cpu_logical_map(cpu) =3D mpidr;
> >> +
> >> +               set_cpu_possible(cpu, true);
> >> +       }
> >
> > In the OF case we only set CPUs possible once we've scanned all the
> > nodes, and only when the boot CPU was actually found in a table. We
> > should keep the ACPI case consistent with that.
> >
> > Can we not handle all of this in a later call once we've scanned al=
l of
> > the GICC structures?
>=20
> we can. the code will be same as DT ones, when all the structures
> are scanned, we can add the init code in acpi_init_cpus():
>=20
>          for (i =3D 0; i < NR_CPUS; i++)
>                  if (cpu_logical_map(i) !=3D INVALID_HWID)
>                          set_cpu_possible(i, true);
>=20
> but I think there is no difference for the logic, maybe I missed
> something.

With the ACPI code above, we mark each CPU possible as we scan it. In
the DT case, if we fail to find the current CPU in the DTB, we don't
mark any other nodes as possible. So in the DT case you don't get SMP
if the current CPU is not in the table provided by FW, but in the ACPI
case you would (when the CPU0 =3D=3D BSP test is removed).

I would prefer that we have a strong requirement that the current CPU i=
s
in the tables in the ACPI case. It safeguards against obviously wrong
tables.

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
