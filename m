From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v2 09/18] ACPI / processor: Make it possible to get CPU
 hardware ID via GICC
Date: Tue, 19 Aug 2014 19:29:05 +0800
Message-ID: <53F33501.2060009@linaro.org>
References: <1407166105-17675-1-git-send-email-hanjun.guo@linaro.org> <1407166105-17675-10-git-send-email-hanjun.guo@linaro.org> <53F2472F.5060400@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53F2472F.5060400@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <Mark.Rutland@arm.com>
Cc: "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>"linux-kernel@vger.kernel.org" <l>
List-Id: linux-acpi@vger.kernel.org

On 2014-8-19 2:34, Sudeep Holla wrote:
[...]
>>
>> +#include <asm/smp_plat.h>
>> +
>>   /* Basic configuration for ACPI */
>>   #ifdef    CONFIG_ACPI
>>   /*
>> @@ -59,6 +61,18 @@ static inline void disable_acpi(void)
>>       acpi_noirq = 1;
>>   }
>>
>> +u32 pack_mpidr_into_32_bits(u64 mpidr);
>> +
>> +/*
>> + * The ACPI processor driver for ACPI core code needs this macro
>> + * to find out this cpu was already mapped (mapping from CPU hardware
>> + * ID to CPU logical ID) or not.
>> + *
>> + * cpu_logical_map(cpu) is the mapping of MPIDR and the logical cpu,
>> + * and MPIDR is the cpu hardware ID we needed.
> 
> You need to specify this is packed version of cpu_logical_map or
> better is to move pack_mpidr_into_32_bits here along with the
> description you have so that it's easy to understand.

Agreed, I will make pack_mpidr_into_32_bits() as inline function here and
specify that it is the packed version we needed.

Thanks
Hanjun
