From: Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] ACPI / IPMI: allow ACPI_IPMI with IPMI_SSIF
Date: Fri, 24 Mar 2017 21:56:36 -0500
Message-ID: <78897278-9240-6794-e99b-f3ff3013304f@acm.org>
References: <1490284420-26657-1-git-send-email-okaya@codeaurora.org>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1490284420-26657-1-git-send-email-okaya@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Oops, yes, this is an issue.

However, it should probably depend on IPMI_HANDLER, not the individual 
interface types.

-corey

On 03/23/2017 10:53 AM, Sinan Kaya wrote:
> ACPI_IPMI driver currently depends on IPMI System Interface (IPMI_SI) driver
> to be enabled. IPMI_SI driver only handles KCS, SMIC and BT BMC interfaces.
>
> IPMI_SSIF is an alternative BMC communication method. It allows BMC to be
> accessed over an I2C bus instead of a standard interface.
>
> Enabling ACPI_IPMI over IPMI_SSIF with this change.
>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>   drivers/acpi/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 83e5f7e..8767062 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -256,7 +256,7 @@ config ACPI_PROCESSOR
>   
>   config ACPI_IPMI
>   	tristate "IPMI"
> -	depends on IPMI_SI
> +	depends on IPMI_SI||IPMI_SSIF
>   	default n
>   	help
>   	  This driver enables the ACPI to access the BMC controller. And it
