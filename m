From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v8 17/21] clocksource / arch_timer: Parse GTDT to initialize
 arch timer
Date: Thu, 05 Feb 2015 18:11:47 +0800
Message-ID: <54D341E3.9020402@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org> <1422881149-8177-18-git-send-email-hanjun.guo@linaro.org> <20150204185929.GH22035@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150204185929.GH22035@red-moon>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Will Deacon <Will.Deacon@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>
List-Id: linux-acpi@vger.kernel.org

Hi Lorenzo,

On 2015=E5=B9=B402=E6=9C=8805=E6=97=A5 02:59, Lorenzo Pieralisi wrote:
> On Mon, Feb 02, 2015 at 12:45:45PM +0000, Hanjun Guo wrote:
>> Using the information presented by GTDT (Generic Timer Description T=
able)
>> to initialize the arch timer (not memory-mapped).
>
> Why are you not initializing the memory mapped timer ?

We left it for later work because no need for that to boot
available ARM64 hardware at now, and we have no hardware to
test unless I missed some of platforms.

>
>> CC: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Originally-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> Tested-by: Yijing Wang <wangyijing@huawei.com>
>> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
>> Tested-by: Jon Masters <jcm@redhat.com>
>> Tested-by: Timur Tabi <timur@codeaurora.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   arch/arm64/kernel/time.c             |   7 ++
>>   drivers/clocksource/arm_arch_timer.c | 132 +++++++++++++++++++++++=
+++++-------
>>   include/linux/clocksource.h          |   6 ++
>>   3 files changed, 118 insertions(+), 27 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/time.c b/arch/arm64/kernel/time.c
>> index 1a7125c..42f9195 100644
>> --- a/arch/arm64/kernel/time.c
>> +++ b/arch/arm64/kernel/time.c
>> @@ -35,6 +35,7 @@
>>   #include <linux/delay.h>
>>   #include <linux/clocksource.h>
>>   #include <linux/clk-provider.h>
>> +#include <linux/acpi.h>
>>
>>   #include <clocksource/arm_arch_timer.h>
>>
>> @@ -72,6 +73,12 @@ void __init time_init(void)
>>
>>   	tick_setup_hrtimer_broadcast();
>>
>> +	/*
>> +	 * Since ACPI or FDT will only one be available in the system,
>> +	 * we can use acpi_generic_timer_init() here safely
>> +	 */
>> +	acpi_generic_timer_init();
>> +
>>   	arch_timer_rate =3D arch_timer_get_rate();
>>   	if (!arch_timer_rate)
>>   		panic("Unable to initialise architected timer.\n");
>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksou=
rce/arm_arch_timer.c
>> index 095c177..407aa63 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -21,6 +21,7 @@
>>   #include <linux/io.h>
>>   #include <linux/slab.h>
>>   #include <linux/sched_clock.h>
>> +#include <linux/acpi.h>
>>
>>   #include <asm/arch_timer.h>
>>   #include <asm/virt.h>
>> @@ -370,8 +371,12 @@ arch_timer_detect_rate(void __iomem *cntbase, s=
truct device_node *np)
>>   	if (arch_timer_rate)
>>   		return;
>>
>> -	/* Try to determine the frequency from the device tree or CNTFRQ *=
/
>> -	if (of_property_read_u32(np, "clock-frequency", &arch_timer_rate))=
 {
>> +	/*
>> +	 * Try to determine the frequency from the device tree or CNTFRQ,
>> +	 * if ACPI is enabled, get the frequency from CNTFRQ ONLY.
>> +	 */
>> +	if (!acpi_disabled ||
>> +	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate))=
 {
>
> This is getting a mess. cntbase tells you it is a memory mapped timer=
,
> node pointer that you are probing through DT, and to top it all
> acpi_disabled detects if you are probing in ACPI or DT mode.
>
> I think this function should be simplified, this driver is also
> pending a refactoring to split arch timer and the memory mapped one
> so I think you'd better wait that work to make things simpler.

Does anyone working on this now?

>
> [...]
>
>> +/* Initialize all the generic timers presented in GTDT */
>> +void __init acpi_generic_timer_init(void)
>> +{
>> +	if (acpi_disabled)
>> +		return;
>
> acpi_disabled used again here, I repeat myself this is going to be
> hard to track. You should try to organize the code something like:
>
> if (acpi_disabled)
> 	timer_dt_probe();
> else
> 	timer_acpi_probe();
>
> mixing the code paths is getting unwieldy, see above to see my
> reasoning.

Olof is unhappy with such approach, I think if (acpi_disabled) is
self-contained because we only get DT or ACPI in the system, we
can call this function time_init() without more if (acpi_disabled).

>
>> +
>> +	acpi_table_parse(ACPI_SIG_GTDT, arch_timer_acpi_init);
>> +}
>> +#endif
>> diff --git a/include/linux/clocksource.h b/include/linux/clocksource=
=2Eh
>> index abcafaa..af6155a 100644
>> --- a/include/linux/clocksource.h
>> +++ b/include/linux/clocksource.h
>> @@ -346,4 +346,10 @@ extern void clocksource_of_init(void);
>>   static inline void clocksource_of_init(void) {}
>>   #endif
>>
>> +#ifdef CONFIG_ACPI
>> +void acpi_generic_timer_init(void);
>> +#else
>> +static inline void acpi_generic_timer_init(void) { }
>> +#endif
>> +
>
> That's not nice, it is a generic header, arch specific stuff should b=
e
> avoided. I think you should have an ACPI generic layer similar to
> clocksource_of_init(), and probe from there when matching the respect=
ive
> timers.

I think I'm OK with it, but do we really need to introduce a heavy
framework to init just arm arch timer (memory mapped or not) ?

Thanks
Hanjun
