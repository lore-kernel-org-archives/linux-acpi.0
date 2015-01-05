From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v6 14/17] ARM64 / ACPI: Parse GTDT to initialize arch
 timer
Date: Mon, 05 Jan 2015 16:59:44 +0800
Message-ID: <54AA5280.3050802@linaro.org>
References: <D0CF9C94.CD69%suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <D0CF9C94.CD69%suravee.suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, "Charles.Garcia-Tobin@arm.com" <Charles.Garcia-Tobin@arm.com>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Timur Tabi <timur@codeaurora.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>
List-Id: linux-acpi@vger.kernel.org

On 2015=E5=B9=B401=E6=9C=8805=E6=97=A5 15:55, Suthikulpanit, Suravee wr=
ote:
> On 1/4/15, 04:55, "Hanjun Guo" <hanjun.guo@linaro.org> wrote:
>
>> Using the information presented by GTDT to initialize the arch
>> timer (not memory-mapped).
>>
>> Originally-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>> arch/arm64/kernel/time.c             |   7 ++
>> drivers/clocksource/arm_arch_timer.c | 132
>> ++++++++++++++++++++++++++++-------
>> include/linux/clocksource.h          |   6 ++
>> 3 files changed, 118 insertions(+), 27 deletions(-)
[...]
>> +static void __init arch_timer_of_init(struct device_node *np)
>> +{
>> +	int i;
>> +
>> +	if (arch_timers_present & ARCH_CP15_TIMER) {
>> +		pr_warn("arch_timer: multiple nodes in dt, skipping\n");
>> +		return;
>> +	}
>> +
>> +	arch_timers_present |=3D ARCH_CP15_TIMER;
>> +	for (i =3D PHYS_SECURE_PPI; i < MAX_TIMER_PPI; i++)
>> +		arch_timer_ppi[i] =3D irq_of_parse_and_map(np, i);
>> +
>> +	arch_timer_detect_rate(NULL, np);
>> +
>> +	arch_timer_c3stop =3D !of_property_read_bool(np, "always-on");
>> +
>> +	/*
>> +	 * If we cannot rely on firmware initializing the timer registers =
then
>> +	 * we should use the physical timers instead.
>> +	 */
>> +	if (IS_ENABLED(CONFIG_ARM) &&
>> +	    of_property_read_bool(np, "arm,cpu-registers-not-fw-configured=
"))
>> +			arch_timer_use_virtual =3D false;
>> +
>> +	arch_timer_init();
>> +}
>> +CLOCKSOURCE_OF_DECLARE(armv7_arch_timer, "arm,armv7-timer",
>> arch_timer_of_init);
>> +CLOCKSOURCE_OF_DECLARE(armv8_arch_timer, "arm,armv8-timer",
>> arch_timer_of_init);
>
> Hanjun,
>
> FYI, it seems that the tree that you have rebased the patch series ha=
s an
> issue determining clocksource in ARM64 introduced by this commit.
>
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D0
> b46b8a718c6e90910a1b1b0fe797be3c167e186
>
> Here is the fix from Catalin that already went upstream:
>
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit=
/drive
> rs/clocksource/arm_arch_timer.c?id=3Dd6ad36913083d683aad4e02e53580c99=
5f1a6ede

This bug fix patch was merged in Dec 30 by Linus, which is the date
after 3.19-rc2 released :)

Thanks
Hanjun
