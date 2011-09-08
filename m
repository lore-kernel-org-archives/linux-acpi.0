From: Chen Gong <gong.chen@linux.intel.com>
Subject: Re: [RFC 1/2] ACPI, APEI, EINJ, Fix resource conflict on some machine
Date: Thu, 08 Sep 2011 10:18:04 +0800
Message-ID: <4E6825DC.9070309@linux.intel.com>
References: <1314685709-7280-1-git-send-email-ying.huang@intel.com> <1314685709-7280-2-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:34110 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753223Ab1IHCSH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Sep 2011 22:18:07 -0400
In-Reply-To: <1314685709-7280-2-git-send-email-ying.huang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org

=E4=BA=8E 2011/8/30 14:28, Huang Ying =E5=86=99=E9=81=93:
> Some APEI firmware implementaiton will access injected address
> specified in param1 to trigger the error when injecting memory error.
> This will cause resource conflict with RAM.  So remove it from trigge=
r
> table resources to avoid conflict.
>
> Signed-off-by: Huang Ying<ying.huang@intel.com>
> Cc: Tony Luck<tony.luck@intel.com>
> ---
>   drivers/acpi/apei/apei-base.c     |   11 +++++++++++
>   drivers/acpi/apei/apei-internal.h |    3 +++
>   drivers/acpi/apei/einj.c          |   24 ++++++++++++++++++++++--
>   3 files changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-b=
ase.c
> index ac11aff..35a7a3a 100644
> --- a/drivers/acpi/apei/apei-base.c
> +++ b/drivers/acpi/apei/apei-base.c
> @@ -421,6 +421,17 @@ static int apei_resources_merge(struct apei_reso=
urces *resources1,
>   	return 0;
>   }
>
> +int apei_resources_add(struct apei_resources *resources,
> +		       unsigned long start, unsigned long size,
> +		       bool iomem)
> +{
> +	if (iomem)
> +		return apei_res_add(&resources->iomem, start, size);
> +	else
> +		return apei_res_add(&resources->ioport, start, size);
> +}
> +EXPORT_SYMBOL_GPL(apei_resources_add);
> +
>   /*
>    * EINJ has two groups of GARs (EINJ table entry and trigger table
>    * entry), so common resources are subtracted from the trigger tabl=
e
> diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/ap=
ei-internal.h
> index f57050e..d778edd 100644
> --- a/drivers/acpi/apei/apei-internal.h
> +++ b/drivers/acpi/apei/apei-internal.h
> @@ -95,6 +95,9 @@ static inline void apei_resources_init(struct apei_=
resources *resources)
>   }
>
>   void apei_resources_fini(struct apei_resources *resources);
> +int apei_resources_add(struct apei_resources *resources,
> +		       unsigned long start, unsigned long size,
> +		       bool iomem);
>   int apei_resources_sub(struct apei_resources *resources1,
>   		       struct apei_resources *resources2);
>   int apei_resources_request(struct apei_resources *resources,
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index 3178521..a126c67 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -195,7 +195,8 @@ static int einj_check_trigger_header(struct acpi_=
einj_trigger *trigger_tab)
>   }
>
>   /* Execute instructions in trigger error action table */
> -static int __einj_error_trigger(u64 trigger_paddr)
> +static int __einj_error_trigger(u64 trigger_paddr, u32 type,
> +				u64 param1, u64 param2)
>   {
>   	struct acpi_einj_trigger *trigger_tab =3D NULL;
>   	struct apei_exec_context trigger_ctx;
> @@ -255,6 +256,25 @@ static int __einj_error_trigger(u64 trigger_padd=
r)
>   	rc =3D apei_resources_sub(&trigger_resources,&einj_resources);
>   	if (rc)
>   		goto out_fini;
> +	/*
> +	 * Some firmware will access target address specified in
> +	 * param1 to trigger the error when injecting memory error.
> +	 * This will cause resource conflict with regular memory.  So
> +	 * remove it from trigger table resources.
> +	 */
> +	if (param_extension&&  (type&  0x0038)&&  param2) {
> +		struct apei_resources addr_resources;
> +		apei_resources_init(&addr_resources);
> +		rc =3D apei_resources_add(&addr_resources,
> +					param1&  param2,
> +					~param2 + 1, true);

assuming following scenario:
param1: 0x827809000
param2: 0xffffffffffffffff
after above operation, only 1 byte will be added and be subtracted by
apei_resources_sub below, which means if 8 bytes are necessary to be
excluded from ioremap, finally only 1 byte is excluded, left 7 bytes
still be mapped via ioremap. The same thing will happen:

APEI: Can not request iomem region <00000000bf7b522a-00000000bf7b522c>=20
for GARs

We can't control the value of param2 here because 1) it is read from
the user; 2) the param1 is already aligned, the value of param2 is not
important under this kind of situation.

We have hit above error in our tests.

> +		if (rc)
> +			goto out_fini;
> +		rc =3D apei_resources_sub(&trigger_resources,&addr_resources);
> +		apei_resources_fini(&addr_resources);
> +		if (rc)
> +			goto out_fini;
> +	}
>   	rc =3D apei_resources_request(&trigger_resources, "APEI EINJ Trigg=
er");
>   	if (rc)
>   		goto out_fini;
> @@ -324,7 +344,7 @@ static int __einj_error_inject(u32 type, u64 para=
m1, u64 param2)
>   	if (rc)
>   		return rc;
>   	trigger_paddr =3D apei_exec_ctx_get_output(&ctx);
> -	rc =3D __einj_error_trigger(trigger_paddr);
> +	rc =3D __einj_error_trigger(trigger_paddr, type, param1, param2);
>   	if (rc)
>   		return rc;
>   	rc =3D apei_exec_run_optional(&ctx, ACPI_EINJ_END_OPERATION);

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
