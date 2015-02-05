From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v8 13/21] ARM64 / ACPI: Parse MADT for SMP initialization
Date: Thu, 05 Feb 2015 17:20:48 +0800
Message-ID: <54D335F0.5080508@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org> <1422881149-8177-14-git-send-email-hanjun.guo@linaro.org> <20150203135348.GA31837@leverpostej> <54D1E0C9.1040706@linaro.org> <20150204103009.GA6592@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:56338 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304AbbBEJU7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Feb 2015 04:20:59 -0500
Received: by mail-pa0-f51.google.com with SMTP id hz1so4160371pad.10
        for <linux-acpi@vger.kernel.org>; Thu, 05 Feb 2015 01:20:59 -0800 (PST)
In-Reply-To: <20150204103009.GA6592@leverpostej>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeauro>

On 2015=E5=B9=B402=E6=9C=8804=E6=97=A5 18:30, Mark Rutland wrote:
> On Wed, Feb 04, 2015 at 09:05:13AM +0000, Hanjun Guo wrote:
>> On 2015=E5=B9=B402=E6=9C=8803=E6=97=A5 21:53, Mark Rutland wrote:
>>> On Mon, Feb 02, 2015 at 12:45:41PM +0000, Hanjun Guo wrote:
>>>> MADT contains the information for MPIDR which is essential for
>>>> SMP initialization, parse the GIC cpu interface structures to
>>>> get the MPIDR value and map it to cpu_logical_map(), and add
>>>> enabled cpu with valid MPIDR into cpu_possible_map.
>>>>
>>>> ACPI 5.1 only has two explicit methods to boot up SMP, PSCI and
>>>> Parking protocol, but the Parking protocol is only specified for
>>>> ARMv7 now, so make PSCI as the only way for the SMP boot protocol
>>>> before some updates for the ACPI spec or the Parking protocol spec=
=2E
>>>>
>>>> Parking protocol patches for SMP boot will be sent to upstream whe=
n
>>>> the new version of Parking protocol is ready.
[...]
>>>> +       /* No need to check duplicate MPIDRs for the first CPU */
>>>> +       if (enabled_cpus) {
>>>> +               /*
>>>> +                * Duplicate MPIDRs are a recipe for disaster. Sca=
n
>>>> +                * all initialized entries and check for
>>>> +                * duplicates. If any is found just ignore the CPU=
=2E
>>>> +                */
>>>> +               for_each_possible_cpu(cpu) {
>>>> +                       if (cpu_logical_map(cpu) =3D=3D mpidr) {
>>>> +                               pr_err("Firmware bug, duplicate CP=
U MPIDR: 0x%llx in MADT\n",
>>>> +                                      mpidr);
>>>> +                               return -EINVAL;
>>>> +                       }
>>>> +               }
>>>> +
>>>> +               /* allocate a logical cpu id for the new comer */
>>>> +               cpu =3D cpumask_next_zero(-1, cpu_possible_mask);
>>>> +       } else {
>>>> +               /*
>>>> +                * First GICC entry must be BSP as ACPI spec said
>>>> +                * in section 5.2.12.15
>>>> +                */
>>>> +               if  (cpu_logical_map(0) !=3D mpidr) {
>>>> +                       pr_err("First GICC entry with MPIDR 0x%llx=
 is not BSP\n",
>>>> +                              mpidr);
>>>> +                       return -EINVAL;
>>>> +               }
>>>> +
>>>> +               /*
>>>> +                * boot_cpu_init() already hold bit 0 in cpu_possi=
ble_mask
>>>> +                * for BSP, no need to allocate again.
>>>> +                */
>>>> +               cpu =3D 0;
>>>> +       }
>>>
>>> If/when kexec comes, on systems where CPU0 can be hotplugged the ne=
xt
>>> kernel might boot on an AP rather than the BSP.
>>
>> so cpu_logical_map(0) will be the MPIDR of AP which boot the kernel,
>> then it will not equal to mpidr provided in the first entry of MADT,
>> right?
>
> Yes.
>
>> It seems that DT smp init will have the same problem, could you give=
 me
>> some guidance how it solved?
>
> For DT we don't rely on the first entry we see in /cpus/ being CPU0 -=
-
> we loop over all entries and expect one of them to be CPU0. I that wh=
at
> you're asking about, or have I misunderstood the question?

That's what I asked, thanks for the explain. I think I need to rework
this code a little bit and modify the logic as well.

>
>
>>> Is there a requirement
>>> Linux-side that CPU0 is the BSP, or is this just intended as a sani=
ty
>>> check of the tables the FW provided?
>>
>> It is just the check of the table that the FW provided, so in this
>> kexec case, I think this code need to be reworked.
>>
>> On x86, no check for the first LAPIC entry must be BSP, I think we
>> need to remove the check for ARM64 too if it makes sense.
>
> Ok. It would be nice to know that there's no implicit assumption that
> ACPI makes about code executing on the BSP elsewhere; if so we may ne=
ed
> to prevent CPU0 hotplug.
>
> On x86 CPU0 hotplug is typically inhibited for suspend/resume and
> PIC-specific issues, and it's not clear to me if there are other
> requirements for CPU0 to stay online.
>
> If the FW requires a particular CPU to stay online, then hopefully th=
at
> will be reported through PSCI MIGRATE_INFO_UP_CPU, but we don't
> currently check that that in the PSCI code.
>
>>
>>>
>>>> +
>>>> +       if (!acpi_psci_present())
>>>> +               return -EOPNOTSUPP;
>>>> +
>>>> +       cpu_ops[cpu] =3D cpu_get_ops("psci");
>>>> +       /* CPU 0 was already initialized */
>>>> +       if (cpu) {
>>>> +               if (!cpu_ops[cpu])
>>>> +                       return -EINVAL;
>>>> +
>>>> +               if (cpu_ops[cpu]->cpu_init(NULL, cpu))
>>>> +                       return -EOPNOTSUPP;
>>>> +
>>>> +               /* map the logical cpu id to cpu MPIDR */
>>>> +               cpu_logical_map(cpu) =3D mpidr;
>>>> +
>>>> +               set_cpu_possible(cpu, true);
>>>> +       }
>>>
>>> In the OF case we only set CPUs possible once we've scanned all the
>>> nodes, and only when the boot CPU was actually found in a table. We
>>> should keep the ACPI case consistent with that.
>>>
>>> Can we not handle all of this in a later call once we've scanned al=
l of
>>> the GICC structures?
>>
>> we can. the code will be same as DT ones, when all the structures
>> are scanned, we can add the init code in acpi_init_cpus():
>>
>>           for (i =3D 0; i < NR_CPUS; i++)
>>                   if (cpu_logical_map(i) !=3D INVALID_HWID)
>>                           set_cpu_possible(i, true);
>>
>> but I think there is no difference for the logic, maybe I missed
>> something.
>
> With the ACPI code above, we mark each CPU possible as we scan it. In
> the DT case, if we fail to find the current CPU in the DTB, we don't
> mark any other nodes as possible. So in the DT case you don't get SMP
> if the current CPU is not in the table provided by FW, but in the ACP=
I
> case you would (when the CPU0 =3D=3D BSP test is removed).
>
> I would prefer that we have a strong requirement that the current CPU=
 is
> in the tables in the ACPI case. It safeguards against obviously wrong
> tables.

OK, make sense to me too, I will update the code.

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
