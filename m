From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V3 1/2] ACPI / EC: Fix broken big-endian 64bit platforms
 using 'global_lock'
Date: Wed, 23 Sep 2015 10:57:44 +0100
Message-ID: <56027798.7000700@arm.com>
References: <9b705747a138c96c26faee5218f7b47403195b28.1442305897.git.viresh.kumar@linaro.org>
 <56026DBE.3090603@arm.com> <3821285.7cLYDZsCsX@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33880 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753014AbbIWJ5s (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Sep 2015 05:57:48 -0400
In-Reply-To: <3821285.7cLYDZsCsX@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Rafael Wysocki <rjw@rjwysocki.net>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>, open list <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "open list:ACPI" <linux-acpi@vger.kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>, Len Brown <lenb@kernel.org>



On 23/09/15 10:39, Arnd Bergmann wrote:
> On Wednesday 23 September 2015 10:15:42 Sudeep Holla wrote:
>> On 15/09/15 09:34, Viresh Kumar wrote:
>>> global_lock is defined as an unsigned long and accessing only its lower
>>> 32 bits from sysfs is incorrect, as we need to consider other 32 bits
>>> for big endian 64 bit systems.
>>>
>>> Fix that by making global_lock an u32 instead.
>>>
>>> Cc: <stable@vger.kernel.org>  # v4.1+
>>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>>
>>> ---
>>> Its marked just for # v4.1+, because arm64 has the first 64 big-endian
>>> platform with ACPI. And ACPI support for that is mainlined recently
>>> only (Arnd Bergmann).
>>>
>>
>> Just to clarify, we don't support big-endian with ACPI on ARM64.
>> We mandate use of EFI for ACPI on ARM64 and EFI spec mandates only
>> little endian.
>>
>
> EFI doesn't care what endianess the kernel has, as long as the
> data structures are interpreted in the same way that the firmware
> defines them, and I thought that at least UEFI on ARM64 with big-endian
> is working in principle (if not, that is a bug that should be fixed).
>
> If ACPI is broken with big-endian kernels, we should probably add a
> Kconfig statement to forbid it, like this:
>

The diff looks sensible thing to have to avoid enabling ACPI with BE
though I am not sure if this can be regarded as broken as it could be
case of just not supported(my guess as I am not completely aware of the
history).

Also I am not against the $subject patch as such, just added
clarification so that it shouldn't be assumed that BE + ACPI works on
ARM64.

Regards,
Sudeep

> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 5d1015c26ff4..06cacc13e3d2 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -6,6 +6,7 @@ menuconfig ACPI
>   	bool "ACPI (Advanced Configuration and Power Interface) Support"
>   	depends on !IA64_HP_SIM
>   	depends on IA64 || X86 || (ARM64 && EXPERT)
> +	depends on !ARM64 || !CPU_BIG_ENDIAN || BROKEN
>   	depends on PCI
>   	select PNP
>   	default y
>
>
> 	Arnd
>
