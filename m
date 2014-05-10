From: "Lv Zheng" <zetalog@gmail.com>
Subject: Re: [PATCH v2 1/2] ACPI: Fix the issue that auto SSDT loading is conflict with customized SSDT that is included by the customized DSDT.
Date: Sat, 10 May 2014 11:55:50 +0800
Message-ID: <971B9B968D364E4DB4AE22B3B4210CB8@LvZheng>
References: <cover.1396925060.git.lv.zheng@intel.com> <f31e537e671ca01168e98e555cdee4154bb6c136.1399624932.git.lv.zheng@intel.com> <536CB099.6000104@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:42167 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753336AbaEJD4M (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 May 2014 23:56:12 -0400
Received: by mail-pd0-f170.google.com with SMTP id v10so4464046pde.29
        for <linux-acpi@vger.kernel.org>; Fri, 09 May 2014 20:56:12 -0700 (PDT)
In-Reply-To: <536CB099.6000104@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Lv Zheng <lv.zheng@intel.com>, Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

Hi, Rafael

Thanks for the review.

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Sent: Friday, May 09, 2014 6:40 PM


> On 5/9/2014 10:44 AM, Lv Zheng wrote:
>> This patch fixes the following issue:
>> User can specify a DSDT with SSDT embedded, in which case, no_static_ssdt
>> must be enforced.  If we don't do that, then:
>> 1. The namespace object conflicts will result in an AE_ALREADY_EXISTS
>>     exception;
>> 2. The namespace objects that are deleted from the original SSDT will be
>>     restored by the auto loading of the original SSDT.
>>
>> Note that the DSDT customization is a compile-time feature, thus the SSDT
>> inclusion indication of the DSDT customization is also implemented as a
>> compile-time configurable.
>>
>> Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=69711
>> Original-by: Enrico Etxe Arte <goitizena.generoa@gmail.com>
>> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
>> ---
>>   drivers/acpi/Kconfig    |    8 ++++++++
>>   drivers/acpi/internal.h |    5 +++++
>>   drivers/acpi/osl.c      |   14 +++++++++++++-
>>   drivers/acpi/tables.c   |    2 ++
>>   4 files changed, 28 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index c0160bb..6fef394 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -233,6 +233,14 @@ config ACPI_CUSTOM_DSDT
>>   bool
>>   default ACPI_CUSTOM_DSDT_FILE != ""
>>   +config ACPI_CUSTOM_DSDT_WITH_SSDT
>> + bool "Customize DSDT with SSDT tables included"
>> + depends on ACPI_CUSTOM_DSDT
>
> If you think that we really have to have a separate CONFIG_ option here, I
> would prefer ACPI_CUSTOM_DSDT to become a menu with a choice to build it
> either with or without embedded SSDTs.
>

Ah! I see what you meant now.
The new config should be put below the ACPI_CUSTOM_DSDT_FILE, while
depending on ACPI_CUSTOM_DSDT cannot achieve this.
OK. I'll try to find a way.
Besides, with the cleanup of ACPICA table manager, now it is possible to
merge acpi_os_physical_table_override() with acpi_os_table_override().
So we could have a menu and put the both of the override mechanisms together
under it.

>> + help
>> +   This option turns on acpi.no_static_ssdt by default.
>
> This description requires the user building the kernel to know what the
> above command line option means which isn't very useful.

This is from the original patch.  Let me purify it.
And this comment remindes me that there is one more cleanup I need to do.

The acpi.no_static_ssdt was created for only this use case:
http://bugzilla.kernel.org/show_bug.cgi?id=3774
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=67effe8f

And over so long time, there is no situation other than this to use this
boot parameter.
The use case is a compile-time behavior.
So IMO the runtime kernel parameter should be deleted after introducing this
new kconfig item.

Thanks and best regards
-Lv

>
>> +
>> +   If the SSDT tables has been merged into the custom DSDT file, say Y.
>> +
>>   config ACPI_INITRD_TABLE_OVERRIDE
>>   bool "ACPI tables override via initrd"
>>   depends on BLK_DEV_INITRD && X86
>> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
>> index 9573913..f84ef59 100644
>> --- a/drivers/acpi/internal.h
>> +++ b/drivers/acpi/internal.h
>> @@ -57,6 +57,11 @@ void acpi_cmos_rtc_init(void);
>>   #else
>>   static inline void acpi_cmos_rtc_init(void) {}
>>   #endif
>> +#ifdef CONFIG_ACPI_CUSTOM_DSDT_WITH_SSDT
>> +void __init acpi_ssdt_customized(void);
>> +#else
>> +static inline void acpi_ssdt_customized(void) {}
>> +#endif
>>   extern bool acpi_force_hot_remove;
>>   diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
>> index 9aeae41..089e55d 100644
>> --- a/drivers/acpi/osl.c
>> +++ b/drivers/acpi/osl.c
>> @@ -1770,15 +1770,27 @@ acpi_status acpi_os_release_object(acpi_cache_t *
>> cache, void *object)
>>   }
>>   #endif
>>   -static int __init acpi_no_static_ssdt_setup(char *s)
>> +static void __init acpi_set_no_static_ssdt(void)
>>   {
>>   acpi_gbl_disable_ssdt_table_install = TRUE;
>>   pr_info("ACPI: static SSDT installation disabled\n");
>> +}
>> +
>> +#ifdef CONFIG_ACPI_CUSTOM_DSDT_WITH_SSDT
>> +void __init acpi_ssdt_customized(void)
>> +{
>> + acpi_set_no_static_ssdt();
>> +}
>> +#else
>> +static int __init acpi_no_static_ssdt_setup(char *s)
>> +{
>> + acpi_set_no_static_ssdt();
>>   return 0;
>>   }
>>   early_param("acpi_no_static_ssdt", acpi_no_static_ssdt_setup);
>> +#endif
>>   static int __init acpi_disable_return_repair(char *s)
>>   {
>> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
>> index 2178229..aaf2177 100644
>> --- a/drivers/acpi/tables.c
>> +++ b/drivers/acpi/tables.c
>> @@ -184,6 +184,7 @@ void acpi_table_print_madt_entry(struct
>> acpi_subtable_header *header)
>>   }
>>   }
>>   +#include "internal.h"
>>   int __init
>>   acpi_table_parse_entries(char *id,
>> @@ -333,6 +334,7 @@ int __init acpi_table_init(void)
>>   {
>>   acpi_status status;
>>   + acpi_ssdt_customized();
>>   status = acpi_initialize_tables(initial_tables, ACPI_MAX_TABLES, 0);
>>   if (ACPI_FAILURE(status))
>>   return -EINVAL;
>

