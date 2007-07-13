From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Remove #ifdef CONFIG_PM from ACPI power-off code
Date: Thu, 12 Jul 2007 23:19:16 -0400
Message-ID: <200707122319.16433.lenb@kernel.org>
References: <20070712145840.GJ4083@blackpad.ctb.virtua.com.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43216 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754973AbXGMDTZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Jul 2007 23:19:25 -0400
In-Reply-To: <20070712145840.GJ4083@blackpad.ctb.virtua.com.br>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Thursday 12 July 2007 10:58, Eduardo Habkost wrote:
> The ACPI poweroff code is inside a #ifdef CONFIG_PM, that was added on
> commit b35c67a46b025e8dc320b59fbe5c283094e1d7f5. The #ifdef is not
> necessary because the poweroff code compiles and works even if
> CONFIG_PM is disabled. This patch removes the #ifdef around the code.

the patch is correct, but the comment is not,
as it should not be possible to build CONFIG_ACPI w/o CONFIG_PM,

-Len

> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  drivers/acpi/sleep/poweroff.c |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/sleep/poweroff.c b/drivers/acpi/sleep/poweroff.c
> index d9801ef..5d6ba10 100644
> --- a/drivers/acpi/sleep/poweroff.c
> +++ b/drivers/acpi/sleep/poweroff.c
> @@ -37,8 +37,6 @@ #endif
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM
> -
>  void acpi_power_off(void)
>  {
>  	/* acpi_sleep_prepare(ACPI_STATE_S5) should have already been called */
> @@ -94,5 +92,3 @@ static int acpi_poweroff_init(void)
>  }
>  
>  late_initcall(acpi_poweroff_init);
> -
> -#endif				/* CONFIG_PM */
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
