From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [RFC part1 PATCH 5/7] ARM64 / ACPI: Introduce arm_core.c and
 its related head file
Date: Wed, 04 Dec 2013 23:53:55 +0800
Message-ID: <529F5013.4050502@linaro.org>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org> <1386088611-2801-6-git-send-email-hanjun.guo@linaro.org> <1AE640813FDE7649BE1B193DEA596E88024941A4@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:35498 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932239Ab3LDPyF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Dec 2013 10:54:05 -0500
Received: by mail-pd0-f171.google.com with SMTP id z10so22637187pdj.30
        for <linux-acpi@vger.kernel.org>; Wed, 04 Dec 2013 07:54:05 -0800 (PST)
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E88024941A4@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <rob.herring@calxeda.com>, Mark Rutland <mark.rutland@arm.com>, Jon Masters <jonathan@jonmasters.org>, "patches@linaro.org" <patches@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@l>

On 2013=E5=B9=B412=E6=9C=8804=E6=97=A5 13:46, Zheng, Lv wrote:
>> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger=
=2Ekernel.org] On Behalf Of Hanjun Guo
>> Sent: Wednesday, December 04, 2013 12:37 AM
>>
>> introduce arm_core.c and its related head file, after this patch,
>> we can get ACPI tables from BIOS on ARM64 now.
>>
>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   arch/arm64/include/asm/acpi.h |   57 +++++++++++
>>   arch/arm64/kernel/setup.c     |    8 ++
>>   drivers/acpi/Makefile         |    2 +
>>   drivers/acpi/plat/Makefile    |    1 +
>>   drivers/acpi/plat/arm-core.c  |  219 +++++++++++++++++++++++++++++=
++++++++++++
>>   5 files changed, 287 insertions(+)
>>   create mode 100644 drivers/acpi/plat/Makefile
>>   create mode 100644 drivers/acpi/plat/arm-core.c
>>
>> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/=
acpi.h
>> index c186f5b..e9444e4 100644
>> --- a/arch/arm64/include/asm/acpi.h
>> +++ b/arch/arm64/include/asm/acpi.h
>> @@ -19,6 +19,43 @@
>>   #ifndef _ASM_ARM_ACPI_H
>>   #define _ASM_ARM_ACPI_H
>>
>> +#include <asm/cacheflush.h>
>> +
>> +#include <linux/init.h>
>> +
>> +#define COMPILER_DEPENDENT_INT64	long long
>> +#define COMPILER_DEPENDENT_UINT64	unsigned long long
>> +
>> +/*
>> + * Calling conventions:
>> + *
>> + * ACPI_SYSTEM_XFACE        - Interfaces to host OS (handlers, thre=
ads)
>> + * ACPI_EXTERNAL_XFACE      - External ACPI interfaces
>> + * ACPI_INTERNAL_XFACE      - Internal ACPI interfaces
>> + * ACPI_INTERNAL_VAR_XFACE  - Internal variable-parameter list inte=
rfaces
>> + */
>> +#define ACPI_SYSTEM_XFACE
>> +#define ACPI_EXTERNAL_XFACE
>> +#define ACPI_INTERNAL_XFACE
>> +#define ACPI_INTERNAL_VAR_XFACE
>> +
>> +/* Asm macros */
>> +#define ACPI_FLUSH_CPU_CACHE() flush_cache_all()
> Well, you may need to check the following environments defined in <ac=
pi/platform/aclinux.h> is sufficient for ARM targets:
> 49 #define ACPI_USE_SYSTEM_CLIBRARY
> 50 #define ACPI_USE_DO_WHILE_0
> 51 #define ACPI_MUTEX_TYPE             ACPI_BINARY_SEMAPHORE
>
> 70 #define ACPI_MACHINE_WIDTH          BITS_PER_LONG
> Will this zap IO addresses on ARM32 platforms?

In this patch set, we only implemented ACPI for ARM64, and ARM32 is
not included in this patch set.

My bad, sorry for the vague changelog.

> And following default settings in <acpi/platform/acenv.h> and <acpi/a=
cxxx.h> is sufficient for ARM targets:
> 179 #if defined (__IA64__) || defined (__ia64__)
> 180 #define ACPI_MISALIGNMENT_NOT_SUPPORTED
> 181 #endif
> Will this cause any exceptions on ARM by executing ACPICA name functi=
ons?
>
> 444 #if ACPI_MACHINE_WIDTH =3D=3D 64
> 445 #define ACPI_USE_NATIVE_DIVIDE  /* Use compiler native 64-bit div=
ide */
> 446 #endif
> I think you may see build breakage on ARM32 as you haven't implemente=
d the following ACPICA macros for ARM:
> 67 #define ACPI_DIV_64_BY_32(n_hi, n_lo, d32, q32, r32)
> 74 #define ACPI_SHIFT_RIGHT_64(n_hi, n_lo)
> Have you tested this yet?

Yes, we tested on ARM32 and it works fine on linaro-acpi, but patches
for ARM32 is not sent out for upstream yet, that's why you can't see
the code you needed.


>
> I'm not sure if all global lock code blocks are not referenced by ACP=
I_REDUCED_HARDWARE and I'm not sure what mechanism is implemented on AR=
M ACPI platforms to offer the synchronization mechanism between firmwar=
e and OSPM.  So you may need to implement the following synchronization=
 protocol in <asm/acpi.h>:
> 58 #define ACPI_ACQUIRE_GLOBAL_LOCK(facs, Acq)
> 61 #define ACPI_RELEASE_GLOBAL_LOCK(facs, Acq)

In reduced hardware mode, No hardware resource sharing between
OSPM and other asynchronous operating environments, such as
UEFI Runtime Services or System Management Mode. (The Global Lock
is not supported)
 =20
please refer to chapter 3.11.1 of ACPI 5.0.


>
> I only reviewed the ACPICA stuffs in <asm/acpi.h>, I didn't take a lo=
ok at your Linux ACPI stuff in <asm/acpi.h>.  You may need more instruc=
tions on the porting issues from Linux ACPI guys.

Yes, I will. Thank you for the review and guidance, and you are the exp=
ert
for ACPICA, we need your instructions too

Thanks
Hanjun

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
