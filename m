From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v8 14/21] ACPI / processor: Make it possible to get CPU
 hardware ID via GICC
Date: Thu, 05 Feb 2015 17:27:15 +0800
Message-ID: <54D33773.5090000@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org> <1422881149-8177-15-git-send-email-hanjun.guo@linaro.org> <20150203141749.GA32536@leverpostej> <20150203200936.GA21731@e104818-lin.cambridge.arm.com> <54D1EAD5.4080105@linaro.org> <20150204112105.GA26006@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:53089 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755877AbbBEJ1Z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Feb 2015 04:27:25 -0500
Received: by mail-pa0-f48.google.com with SMTP id ey11so8863861pad.7
        for <linux-acpi@vger.kernel.org>; Thu, 05 Feb 2015 01:27:25 -0800 (PST)
In-Reply-To: <20150204112105.GA26006@e104818-lin.cambridge.arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>

On 2015=E5=B9=B402=E6=9C=8804=E6=97=A5 19:21, Catalin Marinas wrote:
> On Wed, Feb 04, 2015 at 09:48:05AM +0000, Hanjun Guo wrote:
>> On 2015=E5=B9=B402=E6=9C=8804=E6=97=A5 04:09, Catalin Marinas wrote:
>>> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm=
/acpi.h
>>> index ea4d2b35c57b..4fafd62b1b86 100644
>>> --- a/arch/arm64/include/asm/acpi.h
>>> +++ b/arch/arm64/include/asm/acpi.h
>>> @@ -49,33 +49,12 @@ static inline void enable_acpi(void)
>>>    	acpi_noirq =3D 0;
>>>    }
>>>
>>> -/* MPIDR value provided in GICC structure is 64 bits, but the
>>> - * existing phys_id (CPU hardware ID) using in acpi processor
>>> - * driver is 32-bit, to conform to the same datatype we need
>>> - * to repack the GICC structure MPIDR.
>>> - *
>>> - * bits other than following 32 bits are defined as 0, so it
>>> - * will be no information lost after repacked.
>>> - *
>>> - * Bits [0:7] Aff0;
>>> - * Bits [8:15] Aff1;
>>> - * Bits [16:23] Aff2;
>>> - * Bits [32:39] Aff3;
>>> - */
>>> -static inline u32 pack_mpidr(u64 mpidr)
>>> -{
>>> -	return (u32) ((mpidr & 0xff00000000) >> 8) | mpidr;
>>> -}
>>> -
>>>    /*
>>>     * The ACPI processor driver for ACPI core code needs this macro
>>>     * to find out this cpu was already mapped (mapping from CPU har=
dware
>>>     * ID to CPU logical ID) or not.
>>> - *
>>> - * cpu_logical_map(cpu) is the mapping of MPIDR and the logical cp=
u,
>>> - * and MPIDR is the cpu hardware ID we needed to pack.
>>>     */
>>> -#define cpu_physical_id(cpu) pack_mpidr(cpu_logical_map(cpu))
>>> +#define cpu_physical_id(cpu) cpu_logical_map(cpu)
>>>
>>>    /*
>>>     * It's used from ACPI core in kdump to boot UP system with SMP =
kernel,
>>> diff --git a/arch/arm64/include/asm/smp_plat.h b/arch/arm64/include=
/asm/smp_plat.h
>>> index 59e282311b58..a492276e008d 100644
>>> --- a/arch/arm64/include/asm/smp_plat.h
>>> +++ b/arch/arm64/include/asm/smp_plat.h
>>> @@ -40,4 +40,6 @@ static inline u32 mpidr_hash_size(void)
>>>    extern u64 __cpu_logical_map[NR_CPUS];
>>>    #define cpu_logical_map(cpu)    __cpu_logical_map[cpu]
>>>
>>> +typedef u64 cpuid_t;
>>
>> I think cpuid_t is a little confused because people may recognize
>> it as cpu logical id, its original meaning is the physical cpu ID,
>> so how about:
>>
>> typedef u64 phys_id_t; ?
>
> I would keep "cpu" somewhere in the name as "phys" is too generic, ma=
ybe
> phys_cpuid_t.

This is pretty fine to me too :)

x86 and IA64 use 32 bit cpu phys_id (apic_id) everywhere in the arch
code, but I think I don't need to touch them in this patch.

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
