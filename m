From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [RFC part2 PATCH 2/9] ARM64 / ACPI: Prefill cpu possible/present
 maps and map logical cpu id to APIC id
Date: Tue, 10 Dec 2013 23:07:18 +0800
Message-ID: <52A72E26.9080606@linaro.org>
References: <1385999094-3152-1-git-send-email-hanjun.guo@linaro.org> < 1385999094-3152-3-git-send-email-hanjun.guo@linaro.org> <20131210125328.923F2C40A27@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131210125328.923F2C40A27@trevor.secretlab.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Likely <grant.likely@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Mark Rutland <mark.rutland@arm.com>, Matthew Garrett <mjg59@srcf.ucam.org>, linaro-kernel@lists.linaro.org, linux-acpi@vger.kernel.org, patches@linaro.org, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, linaro-acpi@lists.linaro.org, Olof Johansson <olof@lixom.net>, Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

On 2013=E5=B9=B412=E6=9C=8810=E6=97=A5 20:53, Grant Likely wrote:
> On Mon,  2 Dec 2013 23:44:47 +0800, Hanjun Guo <hanjun.guo@linaro.org=
> wrote:
>> When boot the kernel with MADT, the cpu possible and present maps sh=
ould be
>> prefilled for cpu topology and acpi based cpu hot-plug.
>>
>> The logic cpu id maps to APIC id (GIC id) is also implemented, it is=
 needed
>> for acpi processor drivers.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
> [...]
>> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>> index a0c2ca6..1428024 100644
>> --- a/arch/arm64/kernel/smp.c
>> +++ b/arch/arm64/kernel/smp.c
>> @@ -420,7 +420,9 @@ void __init smp_prepare_cpus(unsigned int max_cp=
us)
>>   		if (err)
>>   			continue;
>>  =20
>> +#ifndef CONFIG_ACPI
>>   		set_cpu_present(cpu, true);
>> +#endif
>>   		max_cpus--;
>>   	}
>>   }
> This looks wrong. Will this break non-ACPI booting when CONFIG_ACPI i=
s
> enabled? The decision on whether or not to run code must be made at
> runtime.

Yes, you are right. I'm reworking on this patch now.

Thanks
Hanjun
