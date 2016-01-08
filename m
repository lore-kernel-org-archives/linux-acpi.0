From: Fu Wei <fu.wei@linaro.org>
Subject: Re: [PATCH v3] acpi, apei: add Boot Error Record Table (BERT) support
Date: Fri, 8 Jan 2016 11:25:16 +0800
Message-ID: <CADyBb7v+8dN3DyeL=+-hAoaoMer+r0qnguesqin9mNqPiGJixA@mail.gmail.com>
References: <1452166023-14501-1-git-send-email-fu.wei@linaro.org>
	<CADyBb7uAp4whMiMP5f2wXeGHsGPgELsuAGobnuoREfJcEH_ajQ@mail.gmail.com>
	<87io34khkx.fsf@yhuang-dev.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:36773 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753544AbcAHDZR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jan 2016 22:25:17 -0500
Received: by mail-ob0-f178.google.com with SMTP id ba1so344428730obb.3
        for <linux-acpi@vger.kernel.org>; Thu, 07 Jan 2016 19:25:16 -0800 (PST)
In-Reply-To: <87io34khkx.fsf@yhuang-dev.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Tony Luck <tony.luck@intel.com>, "Chen, Gong" <gong.chen@intel.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Tomasz Nowicki <tn@semihalf.com>, tbaicar@codeaurora.org, rruigrok@codeaurora.org, "Abdulhamid, Harb" <harba@qti.qualcomm.com>, G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Jon Masters <jcm@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Rafael Wysocki <rjw@rjwysocki.net>, bp <bp@alien8.de>, "matt.fleming" <matt.fleming@intel.com>, "Chen, Gong" <gong.chen@linux.intel.com>

Hi Huang,

On 8 January 2016 at 09:03, Huang, Ying <ying.huang@intel.com> wrote:
> Fu Wei <fu.wei@linaro.org> writes:
>
>> Hi Borislav,
>>
>>
>> On 7 January 2016 at 19:27,  <fu.wei@linaro.org> wrote:
>>> From: Huang Ying <ying.huang@intel.com>
>>>
>>> ACPI/APEI is designed to verifiy/report H/W errors, like Corrected
>>> Error(CE) and Uncorrected Error(UC). It contains four tables: HEST,
>>> ERST, EINJ and BERT. The first three tables have been merged for
>>> a long time, but because of lacking BIOS support for BERT, the
>>> support for BERT is pending until now. Recently on ARM 64 platform
>>> it is has been supported. So here we come.
>>>
>>> Under normal circumstances, when a hardware error occurs, kernel will
>>> be notified via NMI, MCE or some other method, then kernel will
>>> process the error condition, report it, and recover it if possible.
>>> But sometime, the situation is so bad, so that firmware may choose to
>>> reset directly without notifying Linux kernel.
>>>
>>> Linux kernel can use the Boot Error Record Table (BERT) to get the
>>> un-notified hardware errors that occurred in a previous boot. In this
>>> patch, the error information is reported via printk.
>>>
>>> For more information about BERT, please refer to ACPI Specification
>>> version 6.0, section 18.3.1:
>>>   http://www.uefi.org/sites/default/files/resources/ACPI_6.0.pdf
>>>
>>> The following log is a BERT record after system reboot because of
>>> hitting a fatal error.
>>>
>>> BERT: Obtained BERT iomem region <00000000fe801000-00000000fe802000> for BERT.
>>> [Hardware Error]: Error record from previous boot:
>>> [Hardware Error]: event severity: fatal
>>> [Hardware Error]:  Error 0, type: fatal
>>> [Hardware Error]:   section_type: memory error
>>> [Hardware Error]:   physical_address: 0x00000000fe800000
>>> [Hardware Error]:   physical_address_mask: 0x0000000000000fff
>>> [Hardware Error]:   card: 0 module: 1 bank: 0 device: 1 row: 1 column: 1 bit_pos
>>>
>>> [Tomasz Nowicki: Clear error status at the end of error handling]
>>> [Tony: Applied some cleanups suggested by Fu Wei]
>>> [Fu Wei: delete EXPORT_SYMBOL_GPL(bert_disable), improve the code]
>>>
>>> Signed-off-by: Huang Ying <ying.huang@intel.com>
>>> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>> Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
>>> Tested-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
>>> Signed-off-by: Tony Luck <tony.luck@intel.com>
>>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>>> Tested-by: Tyler Baicar <tbaicar@codeaurora.org>
>>> ---
>>> Changelog:
>>> v3: Merge the two patches
>>>     Do some improvements according to Borislav's suggestion.
>>>
>>> v2: https://lkml.org/lkml/2015/8/18/336
>>>     Delete EXPORT_SYMBOL_GPL(bert_disable), because "bert_disable" is only used
>>>     in bert.c for now.
>>>     Do some code-style cleanups.
>>>
>>> v1: The first upstream version submitted in linux-acpi mailing list:
>>>     http://www.spinics.net/lists/linux-acpi/msg57384.html
>>>
>>>  Documentation/kernel-parameters.txt |   3 +
>>>  drivers/acpi/apei/Makefile          |   2 +-
>>>  drivers/acpi/apei/bert.c            | 158 ++++++++++++++++++++++++++++++++++++
>>>  include/acpi/apei.h                 |   1 +
>>>  4 files changed, 163 insertions(+), 1 deletion(-)
>>>  create mode 100644 drivers/acpi/apei/bert.c
>>>
>>> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
>>> index 742f69d..2310e97 100644
>>> --- a/Documentation/kernel-parameters.txt
>>> +++ b/Documentation/kernel-parameters.txt
>>> @@ -555,6 +555,9 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>>>
>>>         bootmem_debug   [KNL] Enable bootmem allocator debug messages.
>>>
>>> +       bert_disable    [ACPI]
>>> +                       Disable Boot Error Record Table (BERT) support.
>>> +
>>
>> This comes from the original version of BERT patch
>> But I don't think we need this, and I don't see any benefit of this.
>>
>> Any suggestion ? Or anything I missed?
>
> The original intention of this parameter is to avoid the bad influence
> of some buggy BIOS, for example the malformed table or table with
> garbage information.

Thanks for your explanation,  got it
will add this info in the next patch

>
> Best Regards,
> Huang, Ying
>
>>>         bttv.card=      [HW,V4L] bttv (bt848 + bt878 based grabber cards)
>>>         bttv.radio=     Most important insmod options are available as
>>>                         kernel args too.
>>> diff --git a/drivers/acpi/apei/Makefile b/drivers/acpi/apei/Makefile
>>> index 5d575a9..e50573d 100644
>>> --- a/drivers/acpi/apei/Makefile
>>> +++ b/drivers/acpi/apei/Makefile
>>> @@ -3,4 +3,4 @@ obj-$(CONFIG_ACPI_APEI_GHES)    += ghes.o
>>>  obj-$(CONFIG_ACPI_APEI_EINJ)   += einj.o
>>>  obj-$(CONFIG_ACPI_APEI_ERST_DEBUG) += erst-dbg.o
>>>
>>> -apei-y := apei-base.o hest.o erst.o
>>> +apei-y := apei-base.o hest.o erst.o bert.o
>>> diff --git a/drivers/acpi/apei/bert.c b/drivers/acpi/apei/bert.c
>>> new file mode 100644
>>> index 0000000..6f6ae38
>>> --- /dev/null
>>> +++ b/drivers/acpi/apei/bert.c
>>> @@ -0,0 +1,158 @@
>>> +/*
>>> + * APEI Boot Error Record Table (BERT) support
>>> + *
>>> + * Copyright 2011 Intel Corp.
>>> + *   Author: Huang Ying <ying.huang@intel.com>
>>> + *
>>> + * Under normal circumstances, when a hardware error occurs, kernel
>>> + * will be notified via NMI, MCE or some other method, then kernel
>>> + * will process the error condition, report it, and recover it if
>>> + * possible. But sometime, the situation is so bad, so that firmware
>>> + * may choose to reset directly without notifying Linux kernel.
>>> + *
>>> + * Linux kernel can use the Boot Error Record Table (BERT) to get the
>>> + * un-notified hardware errors that occurred in a previous boot.
>>> + *
>>> + * For more information about BERT, please refer to ACPI Specification
>>> + * version 4.0, section 17.3.1
>>> + *
>>> + * This file is licensed under GPLv2.
>>> + *
>>> + */
>>> +
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/init.h>
>>> +#include <linux/acpi.h>
>>> +#include <linux/io.h>
>>> +
>>> +#include "apei-internal.h"
>>> +
>>> +#undef pr_fmt(fmt)
>>> +#define pr_fmt(fmt) "BERT: " fmt
>>> +
>>> +static int bert_disable;
>>> +
>>> +static void __init bert_print_all(struct acpi_bert_region *region,
>>> +                                 unsigned int region_len)
>>> +{
>>> +       /*
>>> +        * We use cper_estatus_* which uses struct acpi_hest_generic_status,
>>> +        * struct acpi_hest_generic_status and acpi_bert_region are the same
>>> +        * (Generic Error Status Block), so we declare the "estatus" here.
>>> +        */
>>> +       struct acpi_hest_generic_status *estatus =
>>> +               (struct acpi_hest_generic_status *)region;
>>> +       int remain = region_len;
>>> +       u32 estatus_len;
>>> +
>>> +       /* The records have been polled*/
>>> +       if (!estatus->block_status)
>>> +               return;
>>> +
>>> +       while (remain > sizeof(struct acpi_bert_region)) {
>>> +               /*
>>> +                * Test Generic Error Status Block first,
>>> +                * if the data(Offset, Length) is invalid, we just return,
>>> +                * because we can't trust the length data from this block.
>>> +                */
>>> +               if (cper_estatus_check(estatus)) {
>>> +                       pr_err(FW_BUG "Invalid error record\n");
>>> +                       return;
>>> +               }
>>> +
>>> +               estatus_len = cper_estatus_len(estatus);
>>> +               if (remain < estatus_len) {
>>> +                       pr_err(FW_BUG "Invalid status block length (%u)\n",
>>> +                              estatus_len);
>>> +                       return;
>>> +               }
>>> +
>>> +               pr_info_once(HW_ERR "Error records from previous boot:\n");
>>> +
>>> +               cper_estatus_print(KERN_INFO HW_ERR, estatus);
>>> +
>>> +               /*
>>> +                * Because the boot error source is "one-time polled" type,
>>> +                * clear Block Status of current Generic Error Status Block,
>>> +                * once it's printed.
>>> +                */
>>> +               estatus->block_status = 0;
>>> +
>>> +               estatus = (void *)estatus + estatus_len;
>>> +               if (!estatus->block_status)
>>> +                       return; /* No more error records */
>>> +
>>> +               remain -= estatus_len;
>>> +       }
>>> +}
>>> +
>>> +static int __init setup_bert_disable(char *str)
>>> +{
>>> +       bert_disable = 1;
>>> +
>>> +       return 0;
>>> +}
>>> +__setup("bert_disable", setup_bert_disable);
>>> +
>>> +static int __init bert_check_table(struct acpi_table_bert *bert_tab)
>>> +{
>>> +       if (bert_tab->header.length < sizeof(struct acpi_table_bert) ||
>>> +           bert_tab->region_length < sizeof(struct acpi_bert_region))
>>> +               return -EINVAL;
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static int __init bert_init(void)
>>> +{
>>> +       struct acpi_bert_region *boot_error_region;
>>> +       struct acpi_table_bert *bert_tab;
>>> +       unsigned int region_len;
>>> +       acpi_status status;
>>> +       int rc = 0;
>>> +
>>> +       if (acpi_disabled)
>>> +               return 0;
>>> +
>>> +       if (bert_disable) {
>>> +               pr_info("Boot Error Record Table support is disabled\n");
>>> +               return 0;
>>> +       }
>>> +
>>> +       status = acpi_get_table(ACPI_SIG_BERT, 0, (struct acpi_table_header **)&bert_tab);
>>> +       if (status == AE_NOT_FOUND)
>>> +               return 0;
>>> +       if (ACPI_FAILURE(status)) {
>>> +               pr_err("get table failed, %s\n", acpi_format_exception(status));
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       rc = bert_check_table(bert_tab);
>>> +       if (rc) {
>>> +               pr_err(FW_BUG "table invalid\n");
>>> +               return rc;
>>> +       }
>>> +
>>> +       region_len = bert_tab->region_length;
>>> +       if (!request_mem_region(bert_tab->address, region_len, "APEI BERT")) {
>>> +               pr_err("Can't request iomem region <%016llx-%016llx>\n",
>>> +                      (unsigned long long)bert_tab->address,
>>> +                      (unsigned long long)bert_tab->address + region_len - 1);
>>> +               return -EIO;
>>> +       }
>>> +
>>> +       boot_error_region = ioremap_cache(bert_tab->address, region_len);
>>> +       if (boot_error_region) {
>>> +               bert_print_all(boot_error_region, region_len);
>>> +               iounmap(boot_error_region);
>>> +       } else {
>>> +               rc = -ENOMEM;
>>> +       }
>>> +
>>> +       release_mem_region(bert_tab->address, region_len);
>>> +
>>> +       return rc;
>>> +}
>>> +
>>> +late_initcall(bert_init);
>>> diff --git a/include/acpi/apei.h b/include/acpi/apei.h
>>> index 76284bb..284801a 100644
>>> --- a/include/acpi/apei.h
>>> +++ b/include/acpi/apei.h
>>> @@ -23,6 +23,7 @@ extern bool ghes_disable;
>>>  #else
>>>  #define ghes_disable 1
>>>  #endif
>>> +extern int bert_disable;
>>>
>>>  #ifdef CONFIG_ACPI_APEI
>>>  void __init acpi_hest_init(void);
>>> --
>>> 2.5.0
>>>



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
Ph: +86 21 61221326(direct)
Ph: +86 186 2020 4684 (mobile)
Room 1512, Regus One Corporate Avenue,Level 15,
One Corporate Avenue,222 Hubin Road,Huangpu District,
Shanghai,China 200021
