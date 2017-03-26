From: Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH V3] ACPI / IPMI: allow ACPI_IPMI with IPMI_SSIF
Date: Sat, 25 Mar 2017 20:25:05 -0500
Message-ID: <1b71a9cf-f7c7-7bc4-2934-a357b0b5016b@acm.org>
References: <1490450575-29450-1-git-send-email-okaya@codeaurora.org>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36626 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbdCZBZa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 25 Mar 2017 21:25:30 -0400
In-Reply-To: <1490450575-29450-1-git-send-email-okaya@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org

On 03/25/2017 09:02 AM, Sinan Kaya wrote:
> ACPI_IPMI driver currently depends on IPMI System Interface (IPMI_SI)
> driver to be enabled. IPMI_SI driver only handles KCS, SMIC and BT BMC
> interfaces.
>
> IPMI_SSIF is an alternative BMC communication method. It allows BMC to
> be accessed over an I2C bus instead of a standard interface.
>
> Change the dependency to IPMI_HANDLER so that ACPI_IPMI works with all
> IPMI providers.

If the ACPI people ack this, I can queue it, or they can take it with:

Acked-by: Corey Minyard <cminyard@mvista.com>

Thanks,

-corey

> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>   drivers/acpi/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 83e5f7e..3e15bf8 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -256,7 +256,7 @@ config ACPI_PROCESSOR
>   
>   config ACPI_IPMI
>   	tristate "IPMI"
> -	depends on IPMI_SI
> +	depends on IPMI_HANDLER
>   	default n
>   	help
>   	  This driver enables the ACPI to access the BMC controller. And it


