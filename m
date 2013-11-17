From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 08/12] ACPI: in HW reduced mode, getting power latencies from FADT is not allowed
Date: Sun, 17 Nov 2013 23:17:09 +0100
Message-ID: <2301729.KUltyzqvUq@vostro.rjw.lan>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org> <1384047382-20623-9-git-send-email-al.stone@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58721 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751368Ab3KQWEe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 17 Nov 2013 17:04:34 -0500
In-Reply-To: <1384047382-20623-9-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: al.stone@linaro.org
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, Al Stone <ahs3@redhat.com>

On Saturday, November 09, 2013 06:36:18 PM al.stone@linaro.org wrote:
> From: Al Stone <ahs3@redhat.com>
> 
> Make sure we are not in HW reduced mode when we rely on the the
> P_LVL2_LAT or P_LVL3_LAT (c2_latency, c3_latency) values from the
> FADT.
> 
> Signed-off-by: Al Stone <al.stone@linaro.org>
> ---
>  drivers/acpi/processor_idle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 28079a6..e2bd0bf 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -644,7 +644,7 @@ static int acpi_processor_get_power_info(struct acpi_processor *pr)
>  	memset(pr->power.states, 0, sizeof(pr->power.states));
>  
>  	result = acpi_processor_get_power_info_cst(pr);
> -	if (result == -ENODEV)
> +	if (!acpi_gbl_reduced_hardware && (result == -ENODEV))
>  		result = acpi_processor_get_power_info_fadt(pr);

Wouldn't it be better to make acpi_processor_get_power_info_fadt() check
acpi_gbl_reduced_hardware ?

>  
>  	if (result)
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
