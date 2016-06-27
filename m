From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v6 5/5] ACPI : enable ACPI_PROCESSOR_IDLE on ARM64
Date: Mon, 27 Jun 2016 16:33:15 +0200
Message-ID: <5771392B.3080002@linaro.org>
References: <1465915719-8409-1-git-send-email-sudeep.holla@arm.com>
 <1465915719-8409-6-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35982 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbcF0OdR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jun 2016 10:33:17 -0400
Received: by mail-wm0-f52.google.com with SMTP id f126so103101573wma.1
        for <linux-acpi@vger.kernel.org>; Mon, 27 Jun 2016 07:33:16 -0700 (PDT)
In-Reply-To: <1465915719-8409-6-git-send-email-sudeep.holla@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc: Vikas Sajjan <vikas.cha.sajjan@hpe.com>, Sunil <sunil.vl@hpe.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Prashanth Prakash <pprakash@codeaurora.org>, Al Stone <al.stone@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 06/14/2016 04:48 PM, Sudeep Holla wrote:
> Now that ACPI processor idle driver supports LPI(Low Power Idle), let=
s
> enable ACPI_PROCESSOR_IDLE for ARM64 too.
>
> This patch just removes the IA64 and X86 dependency on ACPI_PROCESSOR=
_IDLE
>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---

Hi Sudeep,

now that ACPI processor supports ARM64 did you check the=20
CPUIDLE_DRIVER_STATE_START trick in the code and its derivative ?

I deleted the patch 2/5 but there is a place where:

if (max_cstate=3D0)
	max_cstate=3D1;

Probably this is because the POLL state is inserted, so there is always=
=20
an idle state. But for ARM, that is not the case.

Also, there are some places where the idle state index begins to 1. I=20
think it should be 0 for ARM.

>   drivers/acpi/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 1358fb7d7a68..d74275c0f374 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -238,7 +238,7 @@ config ACPI_CPPC_LIB
>   config ACPI_PROCESSOR
>   	tristate "Processor"
>   	depends on X86 || IA64 || ARM64
> -	select ACPI_PROCESSOR_IDLE if X86 || IA64
> +	select ACPI_PROCESSOR_IDLE
>   	select ACPI_CPU_FREQ_PSS if X86 || IA64
>   	default y
>   	help
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
