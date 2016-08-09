From: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 0/9] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
Date: Wed, 10 Aug 2016 02:12:03 +0800
Message-ID: <CADyBb7vG=3XdosfugybfMatb8YK2wqf5PKeW5b-tQZY4WXPCHA@mail.gmail.com>
References: <1469460427-8643-1-git-send-email-fu.wei@linaro.org> <7c11cca2-1eaa-a4fb-a44b-cdb36ea99ae9@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7c11cca2-1eaa-a4fb-a44b-cdb36ea99ae9-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linaro ACPI Mailman List <linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, rruigrok-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Christopher Covington <cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Timur Tabi <timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, G Gregory <graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Al Stone <al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, wei-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will
List-Id: linux-acpi@vger.kernel.org

Hi Tomasz

On 9 August 2016 at 19:03, Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org> wrote:
> Hi Fu,
>
> Are you planing to respin the series based on v4.8-rc1 ? My IORT patches
> depend on this series since they will end up in the same drivers/acpi/arm64/
>
> I think patches are in good shape so we need to enquire who is going to pull
> it in ?

the latest v10 patchset can apply on  v4.8-rc1:
https://lkml.org/lkml/2016/7/26/215

>
> Thanks,
> Tomasz
>
>
> On 25.07.2016 17:26, fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
>>
>> From: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>
>> This patchset:
>>     (1)Preparation for adding GTDT support in arm_arch_timer:
>>         1. Move some enums and marcos to header file;
>>         2. Add a new enum for spi type;
>>         3. Improve printk relevant code;
>>         4. use readq to get 64-bit CNTVCT.
>>
>>     (2)Introduce ACPI GTDT parser: drivers/acpi/arm64/acpi_gtdt.c
>>     Parse all kinds of timer in GTDT table of ACPI:arch timer,
>>     memory-mapped timer and SBSA Generic Watchdog timer.
>>     This driver can help to simplify all the relevant timer drivers,
>>     and separate all the ACPI GTDT knowledge from them.
>>
>>     (3)Simplify ACPI code for arm_arch_timer
>>
>>     (4)Add GTDT support for ARM memory-mapped timer
>>
>> This patchset has been tested on the following platforms:
>>     (1)ARM Foundation v8 model
>>
>> Changelog:
>> V9: https://lkml.org/lkml/2016/7/25/
>>     Improve pr_err message in acpi gtdt driver.
>>     Update Commit message for 7/9
>>     shorten the irq mapping function name
>>     Improve GTDT driver for memory-mapped timer
>>
>> v8: https://lkml.org/lkml/2016/7/19/660
>>     Improve "pr_fmt(fmt)" definition: add "ACPI" in front of "GTDT",
>>     and also improve printk message.
>>     Simplify is_timer_block and is_watchdog.
>>     Merge acpi_gtdt_desc_init and gtdt_arch_timer_init into
>> acpi_gtdt_init();
>>     Delete __init in include/linux/acpi.h for GTDT API
>>     Make ARM64 select GTDT.
>>     Delete "#include <linux/module.h>" from acpi_gtdt.c
>>     Simplify GT block parse code.
>>
>> v7: https://lkml.org/lkml/2016/7/13/769
>>     Move the GTDT driver to drivers/acpi/arm64
>>     Add add the ARM64-specific ACPI Support maintainers in MAINTAINERS
>>     Merge 3 patches of GTDT parser driver.
>>     Fix the for_each_platform_timer bug.
>>
>> v6: https://lkml.org/lkml/2016/6/29/580
>>     split the GTDT driver to 4 parts: basic, arch_timer, memory-mapped
>> timer,
>>     and SBSA Generic Watchdog timer
>>     Improve driver by suggestions and example code from Daniel Lezcano
>>
>> v5: https://lkml.org/lkml/2016/5/24/356
>>     Sorting out all patches, simplify the API of GTDT driver:
>>     GTDT driver just fills the data struct for arm_arch_timer driver.
>>
>> v4: https://lists.linaro.org/pipermail/linaro-acpi/2016-March/006667.html
>>     Delete the kvm relevant patches
>>     Separate two patches for sorting out the code for arm_arch_timer.
>>     Improve irq info export code to allow missing irq info in GTDT table.
>>
>> v3: https://lkml.org/lkml/2016/2/1/658
>>     Improve GTDT driver code:
>>       (1)improve pr_* by defining pr_fmt(fmt)
>>       (2)simplify gtdt_sbsa_gwdt_init
>>       (3)improve gtdt_arch_timer_data_init, if table is NULL, it will try
>>       to get GTDT table.
>>     Move enum ppi_nr to arm_arch_timer.h, and add enum spi_nr.
>>     Add arm_arch_timer get ppi from DT and GTDT support for kvm.
>>
>> v2: https://lkml.org/lkml/2015/12/2/10
>>     Rebase to latest kernel version(4.4-rc3).
>>     Fix the bug about the config problem,
>>     use CONFIG_ACPI_GTDT instead of CONFIG_ACPI in arm_arch_timer.c
>>
>> v1: The first upstreaming version: https://lkml.org/lkml/2015/10/28/553
>>
>> Fu Wei (9):
>>   clocksource/drivers/arm_arch_timer: Move enums and defines to header
>>     file
>>   clocksource/drivers/arm_arch_timer: Add a new enum for spi type
>>   clocksource/drivers/arm_arch_timer: Improve printk relevant code
>>   clocksource/drivers/arm_arch_timer: use readq to get 64-bit CNTVCT
>>   acpi/arm64: Add GTDT table parse driver
>>   clocksource/drivers/arm_arch_timer: Simplify ACPI support code.
>>   acpi/arm64: Add memory-mapped timer support in GTDT driver
>>   clocksource/drivers/arm_arch_timer: Add GTDT support for memory-mapped
>>     timer
>>   acpi/arm64: Add SBSA Generic Watchdog support in GTDT driver
>>
>>  arch/arm64/Kconfig                   |   1 +
>>  drivers/acpi/Kconfig                 |   5 +
>>  drivers/acpi/Makefile                |   1 +
>>  drivers/acpi/arm64/Kconfig           |   5 +
>>  drivers/acpi/arm64/Makefile          |   1 +
>>  drivers/acpi/arm64/acpi_gtdt.c       | 309
>> +++++++++++++++++++++++++++++++++++
>>  drivers/clocksource/Kconfig          |   2 +-
>>  drivers/clocksource/arm_arch_timer.c | 233 +++++++++++++++++---------
>>  drivers/watchdog/Kconfig             |   1 +
>>  include/clocksource/arm_arch_timer.h |  32 ++++
>>  include/linux/acpi.h                 |   7 +
>>  11 files changed, 519 insertions(+), 78 deletions(-)
>>  create mode 100644 drivers/acpi/arm64/Kconfig
>>  create mode 100644 drivers/acpi/arm64/Makefile
>>  create mode 100644 drivers/acpi/arm64/acpi_gtdt.c
>>
>



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
