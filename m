From: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v20 13/17] acpi/arm64: Add GTDT table parse driver
Date: Thu, 19 Jan 2017 18:32:55 +0800
Message-ID: <CADyBb7tdfw+wbTZbcnsaHRa=aG6i9acLp7rzMpfMs-vOHXL6pQ@mail.gmail.com>
References: <20170118132541.8989-1-fu.wei@linaro.org> <20170118132541.8989-14-fu.wei@linaro.org>
 <e69d80d1-0954-b1be-817e-c0be6fc24b77@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e69d80d1-0954-b1be-817e-c0be6fc24b77-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linaro ACPI Mailman List <linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, rruigrok-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, "Abdulhamid, Harb" <harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Christopher Covington <cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Timur Tabi <timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, G Gregory <graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Al Stone <al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Hanjun,

On 19 January 2017 at 17:11, Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 2017/1/18 21:25, fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
>>
>> From: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>
>> This patch adds support for parsing arch timer info in GTDT,
>> provides some kernel APIs to parse all the PPIs and
>> always-on info in GTDT and export them.
>>
>> By this driver, we can simplify arm_arch_timer drivers, and
>> separate the ACPI GTDT knowledge from it.
>>
>> Signed-off-by: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Tested-by: Xiongfeng Wang <wangxiongfeng2-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>> ---
>>  arch/arm64/Kconfig          |   1 +
>>  drivers/acpi/arm64/Kconfig  |   3 +
>>  drivers/acpi/arm64/Makefile |   1 +
>>  drivers/acpi/arm64/gtdt.c   | 157
>> ++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/acpi.h        |   6 ++
>>  5 files changed, 168 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 1117421..ab1ee10 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -2,6 +2,7 @@ config ARM64
>>         def_bool y
>>         select ACPI_CCA_REQUIRED if ACPI
>>         select ACPI_GENERIC_GSI if ACPI
>> +       select ACPI_GTDT if ACPI
>>         select ACPI_REDUCED_HARDWARE_ONLY if ACPI
>>         select ACPI_MCFG if ACPI
>>         select ACPI_SPCR_TABLE if ACPI
>> diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
>> index 4616da4..5a6f80f 100644
>> --- a/drivers/acpi/arm64/Kconfig
>> +++ b/drivers/acpi/arm64/Kconfig
>> @@ -4,3 +4,6 @@
>>
>>  config ACPI_IORT
>>         bool
>> +
>> +config ACPI_GTDT
>> +       bool
>> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
>> index 72331f2..1017def 100644
>> --- a/drivers/acpi/arm64/Makefile
>> +++ b/drivers/acpi/arm64/Makefile
>> @@ -1 +1,2 @@
>>  obj-$(CONFIG_ACPI_IORT)        += iort.o
>> +obj-$(CONFIG_ACPI_GTDT)        += gtdt.o
>> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
>> new file mode 100644
>> index 0000000..d93a790
>> --- /dev/null
>> +++ b/drivers/acpi/arm64/gtdt.c
>> @@ -0,0 +1,157 @@
>
> [...]
>
>> +
>> +/**
>> + * acpi_gtdt_init() - Get the info of GTDT table to prepare for further
>> init.
>> + * @table:     The pointer to GTDT table.
>> + * @platform_timer_count:      The pointer of int variate for returning
>> the
>> + *                             number of platform timers. It can be NULL,
>> if
>> + *                             driver don't need this info.
>> + *
>> + * Return: 0 if success, -EINVAL if error.
>> + */
>> +int __init acpi_gtdt_init(struct acpi_table_header *table,
>> +                         int *platform_timer_count)
>> +{
>> +       int ret = 0;
>> +       int timer_count = 0;
>> +       void *platform_timer = NULL;
>> +       struct acpi_table_gtdt *gtdt;
>> +
>> +       gtdt = container_of(table, struct acpi_table_gtdt, header);
>> +       acpi_gtdt_desc.gtdt = gtdt;
>> +       acpi_gtdt_desc.gtdt_end = (void *)table + table->length;
>> +
>> +       if (table->revision < 2)
>> +               pr_debug("Revision:%d doesn't support Platform Timers.\n",
>> +                        table->revision);
>
>
> GTDT table revision is updated to 2 in ACPI 5.1, we will
> not support ACPI version under 5.1 and disable ACPI in FADT
> parse before this code is called, so if we get revision
> <2 here, I think we need to print warning (we need to keep
> the firmware stick to the spec on ARM64).

agree, will change pr_debug to pr_warn.

Thanks :-)

>
>> +       else if (!gtdt->platform_timer_count)
>> +               pr_debug("No Platform Timer.\n");
>> +       else
>> +               timer_count = gtdt->platform_timer_count;
>> +
>> +       if (timer_count) {
>> +               platform_timer = (void *)gtdt +
>> gtdt->platform_timer_offset;
>> +               if (platform_timer < (void *)table +
>> +                                    sizeof(struct acpi_table_gtdt)) {
>> +                       pr_err(FW_BUG "invalid timer data.\n");
>
>
> It's ok but I didn't see other ACPI tables parsing did this check,
> maybe we can just remove it :)

here, I want to make sure the FW is valid.
Once there is a FW bug, we could just return with error.  :-)

>
>> +                       timer_count = 0;
>> +                       platform_timer = NULL;
>> +                       ret = -EINVAL;
>> +               }
>> +       }
>> +
>> +       acpi_gtdt_desc.platform_timer = platform_timer;
>> +       if (platform_timer_count)
>> +               *platform_timer_count = timer_count;
>
>
> Then the code will much simple:
>
> if (gtdt->platform_timer_count) {
>         acpi_gtdt_desc.platform_timer = (void *)gtdt +
> gtdt->platform_timer_offset;
>         if (platform_timer_count)
>                 *platform_timer_count = gtdt->platform_timer_count;
> }
>
> return 0;
>
> and remove ret, timer_count and platform_timer.

yes, this may can simplify the function, but this will be released at
the end of init because of "__init" :-)
So how about let's just keep this check to make sure the FW is OK.  :-)

>
> Thanks
> Hanjun



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
