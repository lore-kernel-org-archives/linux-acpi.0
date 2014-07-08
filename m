From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 4/4] ACPI: Make EC debugfs depend on X86 || IA64 in Kconfig
Date: Tue, 08 Jul 2014 17:23:16 +0800
Message-ID: <53BBB884.5000005@linaro.org>
References: <1404290847-7671-1-git-send-email-hanjun.guo@linaro.org> <1404290847-7671-5-git-send-email-hanjun.guo@linaro.org> <200683000.sgUJl2AyWR@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:61950 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603AbaGHJXU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jul 2014 05:23:20 -0400
Received: by mail-we0-f169.google.com with SMTP id t60so5660032wes.14
        for <linux-acpi@vger.kernel.org>; Tue, 08 Jul 2014 02:23:19 -0700 (PDT)
In-Reply-To: <200683000.sgUJl2AyWR@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Tony Luck <tony.luck@intel.com>, Thomas Gleixner <tglx@linutronix.de>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org

On 2014=E5=B9=B407=E6=9C=8808=E6=97=A5 05:16, Rafael J. Wysocki wrote:
> On Wednesday, July 02, 2014 04:47:26 PM Hanjun Guo wrote:
>> Since EC (Embedded controller) needs SCI for the interupt which
>> is not available on ARM64, make the EC debugfs depend on X86 || IA64
>> only in the Kconfig file.
>>
>> Reviewed-by: Grant Likely <grant.likely@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>  drivers/acpi/Kconfig |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index 0e6f72d..7de5e3f 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -69,6 +69,7 @@ config ACPI_PROCFS_POWER
>> =20
>>  config ACPI_EC_DEBUGFS
>>  	tristate "EC read/write access through /sys/kernel/debug/ec"
>> +	depends on X86 || IA64
> This is totally inconsistent with the other patches in the series whe=
re you
> define per-arch symbols for similar things.  In addition to that, do =
we need
> to build ec.c on ARM at all?

Yes, EC will be needed on ARM. This patch is not needed after some more
consideration, I will drop it.

Thanks
Hanjun

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
