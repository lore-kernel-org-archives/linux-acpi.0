From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v3 part1 04/11] ARM64 / ACPI: Introduce arm-core.c and
 its related head file
Date: Mon, 28 Apr 2014 17:32:43 +0800
Message-ID: <535E203B.70006@linaro.org>
References: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org> <1398432017-8506-5-git-send-email-hanjun.guo@linaro.org> <1AE640813FDE7649BE1B193DEA596E88025586F4@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:55184 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753604AbaD1JdG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Apr 2014 05:33:06 -0400
Received: by mail-pd0-f178.google.com with SMTP id fp1so3359873pdb.23
        for <linux-acpi@vger.kernel.org>; Mon, 28 Apr 2014 02:33:05 -0700 (PDT)
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E88025586F4@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@linaro.org>, Grant Likely <grant.likely@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Olof Johansson <olof@lixom.net>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, "Charles.Garcia-Tobin@arm.com" <Charles.Garcia-Tobin@arm.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Al Stone <al.stone@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>

Hi Lv,

On 2014-4-28 12:54, Zheng, Lv wrote:
> Hi,
> 
>> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Hanjun Guo
>> Sent: Friday, April 25, 2014 9:20 PM
>>
>> ACPI core need lots extern variables and functions which should
>> be provided by arch dependent code to make itself compilable. so
>> introduce arm_core.c and its related header file here.
>>
>> acpi_boot_table_init() will be called in setup_arch() before
>> paging_init(), so we should use eary_ioremap() mechanism here
>> to get the RSDP and all the table pointers, with this patch,
>> we can get ACPI boot-time tables from firmware on ARM64.
>>
>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>> ---
>>  arch/arm64/include/asm/acpi.h |   53 +++++++++++++++++++
>>  arch/arm64/kernel/setup.c     |    4 ++
>>  drivers/acpi/Makefile         |    2 +
>>  drivers/acpi/plat/Makefile    |    1 +
>>  drivers/acpi/plat/arm-core.c  |  113 +++++++++++++++++++++++++++++++++++++++++
>>  5 files changed, 173 insertions(+)
>>  create mode 100644 drivers/acpi/plat/Makefile
>>  create mode 100644 drivers/acpi/plat/arm-core.c
>>
>> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
>> index e3e990e..3ac9dfb 100644
>> --- a/arch/arm64/include/asm/acpi.h
>> +++ b/arch/arm64/include/asm/acpi.h
>> @@ -19,6 +19,43 @@
>>  #ifndef _ASM_ACPI_H
>>  #define _ASM_ACPI_H
>>
>> +#include <asm/cacheflush.h>
>> +
>> +#include <linux/init.h>
>> +
>> +#define COMPILER_DEPENDENT_INT64	s64
>> +#define COMPILER_DEPENDENT_UINT64	u64
>> +
>> +/*
>> + * Calling conventions:
>> + *
>> + * ACPI_SYSTEM_XFACE        - Interfaces to host OS (handlers, threads)
>> + * ACPI_EXTERNAL_XFACE      - External ACPI interfaces
>> + * ACPI_INTERNAL_XFACE      - Internal ACPI interfaces
>> + * ACPI_INTERNAL_VAR_XFACE  - Internal variable-parameter list interfaces
>> + */
>> +#define ACPI_SYSTEM_XFACE
>> +#define ACPI_EXTERNAL_XFACE
>> +#define ACPI_INTERNAL_XFACE
>> +#define ACPI_INTERNAL_VAR_XFACE
> 
> Just a reminder.
> I'm going to sort such default definitions out.
> The story can be found here:
> https://lkml.org/lkml/2014/4/8/57
> The patch to achieve this can be found here:
> https://lkml.org/lkml/2014/4/23/71
> 
> If your series is merged after the above series, you don't need the above lines.
> 
>> +
>> +/* Asm macros */
>> +#define ACPI_FLUSH_CPU_CACHE() flush_cache_all()
>> +
> 
> Another reminder.
> I'm going to split this into <asm/acenv.h> in the same story.
> The patch to achieve this can be found here:
> https://lkml.org/lkml/2014/4/23/75
> If your series is merged after the above series, you need to put this line into arch/arm/include/asm/acenv.h.

It is ok to me, once your patches are accepted by Rafael and merged
into linux-next, I will rebase my patch set.

Thanks a lot the reminding :)

Best regards
Hanjun

