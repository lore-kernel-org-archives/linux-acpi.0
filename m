From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v2 06/18] ARM64 / ACPI: Parse MADT to map logical cpu
 to MPIDR and get cpu_possible/present_map
Date: Thu, 21 Aug 2014 10:51:36 +0800
Message-ID: <53F55EB8.3010101@linaro.org>
References: <1407166105-17675-1-git-send-email-hanjun.guo@linaro.org> <1407166105-17675-7-git-send-email-hanjun.guo@linaro.org> <20140818142728.GS20043@localhost> <53F2FE8E.60307@linaro.org> <20140820143817.GN24600@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:50706 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbaHUCxL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Aug 2014 22:53:11 -0400
Received: by mail-pd0-f179.google.com with SMTP id v10so13130184pde.38
        for <linux-acpi@vger.kernel.org>; Wed, 20 Aug 2014 19:53:10 -0700 (PDT)
In-Reply-To: <20140820143817.GN24600@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <Mark.Rutland@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Will Deacon <Will.Deacon@arm.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On 2014-8-20 22:38, Catalin Marinas wrote:
> On Tue, Aug 19, 2014 at 08:36:46AM +0100, Hanjun Guo wrote:
>> On 2014-8-18 22:27, Catalin Marinas wrote:
>>> On Mon, Aug 04, 2014 at 04:28:13PM +0100, Hanjun Guo wrote:
>>>> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
>>>> index 6e04868..e877967 100644
>>>> --- a/arch/arm64/include/asm/acpi.h
>>>> +++ b/arch/arm64/include/asm/acpi.h
>>>> @@ -64,6 +64,8 @@ static inline void arch_fix_phys_package_id(int num, u32 slot) { }
>>>>  extern int (*acpi_suspend_lowlevel)(void);
>>>>  #define acpi_wakeup_address 0
>>>>  
>>>> +#define MAX_GIC_CPU_INTERFACE 65535
>>>
>>> Does this need to be more than NR_CPUS?
>>
>> Sometimes yes, CPU structure entries in MADT just like CPU nodes in
>> device tree, the number of them may more than NR_CPUS.
> 
> I have a more general question here. In ACPI, is MADT the only way to
> build a CPU topology? 

Unfortunately yes as far as I can tell.

> It looks weird that we use GIC properties to
> create the cpu_logical_map(). 

Actually information in GICC structures in MADT will both used
for GIC init and SMP init, GICC structures represents CPUs in the
system.

> A side-effect is that the GIC-related
> functions are now scattered all over the kernel rather than being
> contained in the GIC driver itself.

As patch 12/18 shows, all the GIC related code all contained in the
GIC driver, GICC structure is more than GIC-related but also CPUs in the
system (I have to admit that the name of GICC in ACPI is confusing).

Thanks
Hanjun

