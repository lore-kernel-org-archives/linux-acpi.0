From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 3/4] ACPI / processor: Introduce ARCH_HAS_ACPI_PDC
Date: Tue, 08 Jul 2014 17:58:46 +0800
Message-ID: <53BBC0D6.2090606@linaro.org>
References: <1404290847-7671-1-git-send-email-hanjun.guo@linaro.org> <1404290847-7671-4-git-send-email-hanjun.guo@linaro.org> <2064691.ZpxCs0gfL8@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:36303 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752907AbaGHJ6u (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jul 2014 05:58:50 -0400
Received: by mail-wg0-f47.google.com with SMTP id y10so307789wgg.30
        for <linux-acpi@vger.kernel.org>; Tue, 08 Jul 2014 02:58:49 -0700 (PDT)
In-Reply-To: <2064691.ZpxCs0gfL8@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Tony Luck <tony.luck@intel.com>, Thomas Gleixner <tglx@linutronix.de>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org

On 2014=E5=B9=B407=E6=9C=8808=E6=97=A5 05:13, Rafael J. Wysocki wrote:
> On Wednesday, July 02, 2014 04:47:25 PM Hanjun Guo wrote:
>> The use of _PDC is deprecated in ACPI 3.0 in favor of _OSC,
>> as ARM platform is supported only in ACPI 5.0 or higher version,
>> _PDC will not be used in ARM platform, so make Make _PDC only for
>> platforms with Intel CPUs.
>>
>> Introduce ARCH_HAS_ACPI_PDC and move _PDC related code in ACPI
>> processor driver into a single file processor_pdc.c, make x86
>> and ia64 select ARCH_HAS_ACPI_PDC when ACPI is enabled.
>>
>> This patch also use pr_* to replace printk to fix the checkpatch
>> warning and factor acpi_processor_alloc_pdc() a little bit to
>> avoid duplicate pr_err() code.
>>
>> Suggested-by: Robert Richter <rric@kernel.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>  arch/ia64/Kconfig             |    1 +
>>  arch/x86/Kconfig              |    1 +
>>  drivers/acpi/Kconfig          |   10 ++
>>  drivers/acpi/Makefile         |    1 +
>>  drivers/acpi/internal.h       |    5 +
>>  drivers/acpi/processor_core.c |  198 ------------------------------=
---------
>>  drivers/acpi/processor_pdc.c  |  206 ++++++++++++++++++++++++++++++=
+++++++++++
>>  7 files changed, 224 insertions(+), 198 deletions(-)
>>  create mode 100644 drivers/acpi/processor_pdc.c
>>
>> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
>> index f82b352..cde2626 100644
>> --- a/arch/ia64/Kconfig
>> +++ b/arch/ia64/Kconfig
>> @@ -10,6 +10,7 @@ config IA64
>>  	select ARCH_MIGHT_HAVE_PC_SERIO
>>  	select PCI if (!IA64_HP_SIM)
>>  	select ACPI if (!IA64_HP_SIM)
>> +	select ARCH_HAS_ACPI_PDC if ACPI
> The ARCH_HAS part doesn't seem to be particularly consistent with
> the existing naming.  ARCH_MIGHT_HAVE_ACPI_PDC would be better IMO.

OK, I will update the patch.

>
>>  	select PM if (!IA64_HP_SIM)
>>  	select HAVE_UNSTABLE_SCHED_CLOCK
>>  	select HAVE_IDE
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 4865d44..d60cec7 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -21,6 +21,7 @@ config X86_64
>>  ### Arch settings
>>  config X86
>>  	def_bool y
>> +	select ARCH_HAS_ACPI_PDC if ACPI
>>  	select ARCH_HAS_DEBUG_STRICT_USER_COPY_CHECKS
>>  	select ARCH_MIGHT_HAVE_PC_PARPORT
>>  	select ARCH_MIGHT_HAVE_PC_SERIO
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index 70eaf7a..0e6f72d 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -367,6 +367,16 @@ config ACPI_REDUCED_HARDWARE_ONLY
>> =20
>>  	If you are unsure what to do, do not enable this option.
>> =20
>> +config ARCH_HAS_ACPI_PDC
>> +	bool
>> +	help
>> +	  The _PDC object provides OSPM a mechanism to convey to the platf=
orm
>> +	  the capabilities supported by OSPM for processor power managemen=
t.
>> +	  This allows the platform to modify the ACPI namespace objects re=
turning
>> +	  configuration information for processor power management based o=
n the
>> +	  level of support provided by OSPM.The use of _PDC is deprecated =
in
>> +	  ACPI 3.0 in favor of _OSC.
> Is the help actually useful?  This doesn't seem to be user-selectable=
, does it?

Yes, my bad, I will remove the help in next version.

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
