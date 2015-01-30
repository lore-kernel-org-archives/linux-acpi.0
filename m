From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI/sleep: mark acpi_sleep_dmi_check() __init
Date: Fri, 30 Jan 2015 01:09:31 +0100
Message-ID: <13078642.MlpeDpdLtA@vostro.rjw.lan>
References: <54C2106602000078000588DF@mail.emea.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:65208 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752349AbbA2Xqn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Jan 2015 18:46:43 -0500
In-Reply-To: <54C2106602000078000588DF@mail.emea.novell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Beulich <JBeulich@suse.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Friday, January 23, 2015 08:12:06 AM Jan Beulich wrote:
> ACPI/sleep: mark acpi_sleep_dmi_check() __init
> 
> This makes a difference if the compiler decides not to inline the
> function, as then the function's reference to acpisleep_dmi_table[]
> yields a section mismatch warning.
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>

Queued up for 3.20, thanks!

> ---
>  drivers/acpi/sleep.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- 3.19-rc5/drivers/acpi/sleep.c
> +++ 3.19-rc5-ACPI-sleep-DMI-check-init/drivers/acpi/sleep.c
> @@ -321,7 +321,7 @@ static struct dmi_system_id acpisleep_dm
>  	{},
>  };
>  
> -static void acpi_sleep_dmi_check(void)
> +static void __init acpi_sleep_dmi_check(void)
>  {
>  	int year;
>  
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
