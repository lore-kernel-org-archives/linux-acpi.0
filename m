From: Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH v3 09/17] ARM64 / ACPI: Parse MADT for SMP initialization
Date: Tue, 09 Sep 2014 01:44:00 -0400
Message-ID: <540E93A0.4040306@redhat.com>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org> <1409583475-6978-10-git-send-email-hanjun.guo@linaro.org> <540E80BD.20801@redhat.com> <540E88A2.1000606@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48073 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777AbaIIFpJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Sep 2014 01:45:09 -0400
In-Reply-To: <540E88A2.1000606@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, linaro-acpi@lists.linaro.org, Liviu Dudau <Liviu.Dudau@arm.com>, Lv Zheng <lv.zheng@intel.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, Charles.Garcia-Tobin@arm.com, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org, Graeme Gregory <graeme.gregory@linaro.org>

On 09/09/2014 12:57 AM, Hanjun Guo wrote:
> Hi Jon,
>=20
> On 2014=E5=B9=B409=E6=9C=8809=E6=97=A5 12:23, Jon Masters wrote:
>> On 09/01/2014 10:57 AM, Hanjun Guo wrote:
>>> MADT contains the information for MPIDR which is essential for
>>> SMP initialization, parse the GIC cpu interface structures to
>>> get the MPIDR value and map it to cpu_logical_map(), and add
>>> enabled cpu with valid MPIDR into cpu_possible_map.
>>>
>>> ACPI 5.1 only has two explicit methods to boot up SMP, PSCI and
>>> Parking protocol, but the Parking protocol is only specified for
>>> ARMv7 now, so make PSCI as the only way for the SMP boot protocol
>>> before some updates for the ACPI spec or the Parking protocol spec.
>>> +	/* CPU 0 was already initialized */
>>> +	if (cpu) {
>>> +		if (cpu_ops[cpu]->cpu_init(NULL, cpu))
>>> +			return -EOPNOTSUPP;
>>> +
>>> +		/* map the logical cpu id to cpu MPIDR */
>>> +		cpu_logical_map(cpu) =3D mpidr;
>> I'm not sure it's worth noting in a comment or just in the dialogue =
that
>> none of these MPIDR values is literally the value in the MPIDR. Linu=
x
>> doesn't store that anyway (even in the cpu_logical_map), since it is
>> pre-filtered against MPIDR_HWID_BITMASK to remove the non-affinity l=
evel
>> bits. And since the ACPI5.1 specification requires that non-affinity
>> bits be zero everything works. But it relies upon this assumption so=
 it
>> might be worth explicitly masking out the bits when making the call =
into:
>>
>>        acpi_map_gic_cpu_interface(processor->arm_mpidr,
>>                processor->flags & ACPI_MADT_ENABLED);
>>
>> During the parsing of the processor object's MPIDR value.
>=20
> Yes, I agree with you. When I tested this patch set on our
> ARM64 platform, I found this problem too. some firmware
> will just present the real MPIDR value to OS which some reserved
> bit set to 1, and it will lead to some logic problem in this patch.
> (actually firmware didn't obey with ACPI spec)
>=20
> I had updated the patch with:
>=20
> +	acpi_map_gic_cpu_interface(processor->arm_mpidr & MPIDR_HWID_BITMAS=
K,
> +		processor->flags & ACPI_MADT_ENABLED);
>=20
> and then the problem was gone :)

Did I miss an updated patch posting then? It is possible...I was keepin=
g
out of this thread for "obvious" reasons (I'm somewhat biased in favor
of ACPI on 64-bit ARM server platforms and thus not objective in all
cases...so I am confining my feedback to technical specifics). But it's
necessary that there be a little more discussion here. I've got a coupl=
e
of requests into various vendors to get more vocal too.

Jon.

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
