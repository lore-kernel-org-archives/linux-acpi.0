From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] Thermal: Provide option to choose default thermal
 governor
Date: Mon, 24 Sep 2012 13:40:05 +0800
Message-ID: <1348465205.10877.146.camel@rui.sh.intel.com>
References: <1348218144-6845-1-git-send-email-durgadoss.r@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:19330 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751537Ab2IXFjX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Sep 2012 01:39:23 -0400
In-Reply-To: <1348218144-6845-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Durgadoss R <durgadoss.r@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On =E4=BA=94, 2012-09-21 at 14:32 +0530, Durgadoss R wrote:
> This patch provides option to choose the default thermal
> governor. If no option is provided, the step_wise
> governor is selected by default.
>=20
yep, I like this approach. will apply to my next tree.

thanks,
rui

> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> ---
>  drivers/thermal/Kconfig |   33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>=20
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 040c626..c0e11aa 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -71,3 +71,36 @@ config USER_SPACE
>  	depends on THERMAL
>  	help
>  	  Enable this to let the user space manage the platform thermals.
> +
> +choice
> +	prompt "Default Thermal governor"
> +	depends on THERMAL
> +	default THERMAL_DEFAULT_GOV_STEP_WISE
> +	help
> +	  This option sets which thermal governor shall be loaded at
> +	  startup. If in doubt, select 'step_wise'.
> +
> +config THERMAL_DEFAULT_GOV_STEP_WISE
> +	bool "step_wise"
> +	select STEP_WISE
> +	help
> +	  Use the step_wise governor as default. This throttles the
> +	  devices one step at a time.
> +
> +config THERMAL_DEFAULT_GOV_FAIR_SHARE
> +	bool "fair_share"
> +	select FAIR_SHARE
> +	help
> +	  Use the fair_share governor as default. This throttles the
> +	  devices based on their 'contribution' to a zone. The
> +	  contribution should be provided through platform data.
> +
> +config THERMAL_DEFAULT_GOV_USER_SPACE
> +	bool "user_space"
> +	select USER_SPACE
> +	help
> +	  Select this if you want to let the user space manage the
> +	  platform thermals.
> +endchoice
> +
> +


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
