From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] ACPI/Processor: Remove acpi_processor_get_limit_info()
Date: Tue, 13 Aug 2013 16:50:59 +0800
Message-ID: <1376383859.2335.25.camel@rzhang-lenovo>
References: <1376359678-5826-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:28747 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752135Ab3HMIuD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 Aug 2013 04:50:03 -0400
In-Reply-To: <1376359678-5826-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tianyu.lan@intel.com
Cc: rjw@sisk.pl, lenb@kernel.org, linux-acpi@vger.kernel.org

On =E4=BA=8C, 2013-08-13 at 10:07 +0800, tianyu.lan@intel.com wrote:
> From: Lan Tianyu <tianyu.lan@intel.com>
>=20
> acpi_processor_get_limit_info() is only called in the __acpi_processo=
r_start()
> and what it does actually is just to check pr->flags.throttling and s=
et limit.
> The pr pointer has been checked in the __acpi_processor_start() befor=
e
> acpi_processor_get_limit_info() being called. It doesn't make sense s=
till to
> keep it as a function. So move code to __acpi_processor_start() and r=
emove
> acpi_processor_get_limit_info().
>=20
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>

Acked-by: Zhang Rui <rui.zhang@intel.com>

thanks,
rui
> ---
>  drivers/acpi/processor_driver.c  |  4 +++-
>  drivers/acpi/processor_thermal.c | 12 ------------
>  2 files changed, 3 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor=
_driver.c
> index bd11ef9..e534ba6 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -175,7 +175,9 @@ static int __acpi_processor_start(struct acpi_dev=
ice *device)
>  	acpi_processor_load_module(pr);
>  #endif
>  	acpi_processor_get_throttling_info(pr);
> -	acpi_processor_get_limit_info(pr);
> +
> +	if (pr->flags.throttling)
> +		pr->flags.limit =3D 1;
> =20
>  	if (!cpuidle_get_driver() || cpuidle_get_driver() =3D=3D &acpi_idle=
_driver)
>  		acpi_processor_power_init(pr);
> diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processo=
r_thermal.c
> index e8e6527..d1d2e7f 100644
> --- a/drivers/acpi/processor_thermal.c
> +++ b/drivers/acpi/processor_thermal.c
> @@ -186,18 +186,6 @@ static int cpufreq_set_cur_state(unsigned int cp=
u, int state)
> =20
>  #endif
> =20
> -int acpi_processor_get_limit_info(struct acpi_processor *pr)
> -{
> -
> -	if (!pr)
> -		return -EINVAL;
> -
> -	if (pr->flags.throttling)
> -		pr->flags.limit =3D 1;
> -
> -	return 0;
> -}
> -
>  /* thermal coolign device callbacks */
>  static int acpi_processor_max_state(struct acpi_processor *pr)
>  {


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
