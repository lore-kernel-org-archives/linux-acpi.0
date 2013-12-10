From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [Linaro-acpi] [PATCH v3 1/5] ACPI: introduce CONFIG_ACPI_REDUCED_HARDWARE
 to enable this ACPI mode
Date: Tue, 10 Dec 2013 23:05:03 +0800
Message-ID: <52A72D9F.1070004@linaro.org>
References: <1386192127-28564-1-git-send-email-al.stone@linaro.org> < 1386192127-28564-2-git-send-email-al.stone@linaro.org> <20131210123717.59493C40A27@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:41908 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753822Ab3LJPFP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Dec 2013 10:05:15 -0500
Received: by mail-pb0-f43.google.com with SMTP id rq2so7816486pbb.30
        for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2013 07:05:14 -0800 (PST)
In-Reply-To: <20131210123717.59493C40A27@trevor.secretlab.ca>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: al.stone@linaro.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org

On 2013=E5=B9=B412=E6=9C=8810=E6=97=A5 20:37, Grant Likely wrote:
> On Wed,  4 Dec 2013 14:22:03 -0700, al.stone@linaro.org wrote:
>> From: Al Stone <al.stone@linaro.org>
>>
>> To enable the hardware reduced mode of ACPI on some platforms (such =
as
>> ARM), we need to modify the kernel code and set ACPI_REDUCED_HARDWAR=
E
>> to TRUE in the ACPICA source.
>>
>> This can be done more resonably by introducing a kernel config item
>> to enable/disable ACPI_REDUCED_HARDWARE.  We can then change the ker=
nel
>> config instead of having to modify the kernel source directly to ena=
ble
>> the reduced hardware mode of ACPI.
>>
>> Lv Zheng suggested that this configuration item does not belong in A=
CPICA,
>> the upstream source for much of the ACPI internals, but rather to th=
e
>> Linux kernel itself.  Hence, we introduce this flag so that we can m=
ake
>> ACPI_REDUCED_HARDWARE configurable.  For the details of the discussi=
on,
>> please refer to: http://www.spinics.net/lists/linux-acpi/msg46369.ht=
ml
>>
>> Support for X86 in hardware reduced mode is also provided to make it
>> simpler to debug this mode, and to provide for probable use in such
>> products.  Hardware reduced mode, despite the name, exists primarily
>> to allow newer platforms to use a much simpler form of ACPI that doe=
s
>> not require supporting the legacy of previous versions of the specif=
ication,
>> and is likely to be used more often in the near future as a result.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> ---
>>   drivers/acpi/Kconfig            | 8 ++++++++
>>   include/acpi/platform/aclinux.h | 6 ++++++
>>   2 files changed, 14 insertions(+)
>>
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index 5d92485..66e6bb2 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -343,6 +343,14 @@ config ACPI_BGRT
>>   	  data from the firmware boot splash. It will appear under
>>   	  /sys/firmware/acpi/bgrt/ .
>>  =20
>> +config ACPI_REDUCED_HARDWARE
>> +	bool "Hardware-reduced ACPI support"
>> +	depends on X86 || ARM || ARM64
>> +	help
>> +	This config adds support for Hardware-reduced ACPI. When this opti=
on
>> +	is selected, will generate a specialized version of ACPICA that ON=
LY
>> +	supports the ACPI "reduced hardware".
>> +
>>   source "drivers/acpi/apei/Kconfig"
>>  =20
>>   config ACPI_EXTLOG
>> diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform=
/aclinux.h
>> index 28f4f4d..a33f502 100644
>> --- a/include/acpi/platform/aclinux.h
>> +++ b/include/acpi/platform/aclinux.h
>> @@ -52,6 +52,12 @@
>>  =20
>>   #ifdef __KERNEL__
>>  =20
>> +/* Compile for reduced hardware mode if requested for this kernel c=
onfig */
>> +
>> +#ifdef CONFIG_ACPI_REDUCED_HARDWARE
>> +#define ACPI_REDUCED_HARDWARE 1
>> +#endif
> Will this change the way ACPICA is compiled? Will it disable
> non-hardware-reduced mode?

Both yes. ACPICA supports reduced hardware mode when
ACPI_REDUCED_HARWARE is TRUE at compile time. There is
no way to support both normal ACPI and hardware reduced
ACPI with single binary image for now.

> If so, then this is a big problem. Enabling
> the hardware reduced feature should *not* break normal ACPI usage.

It will break normal ACPI usage but it is ok I think. Since
lots of features are not supported in the hardware in hardware
reduced mode, and normal ACPI will not run probably such as
leading kernel panic when refer to some registers which are not
exist on reduced hardware, we should introduce this kernel
config and modify the ACPI drivers to avoid such failures.

Thanks
Hanjun

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
