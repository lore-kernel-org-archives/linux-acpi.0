From: Chen Gong <gong.chen@linux.intel.com>
Subject: Re: [PATCH] Use acpi_os_map_memory() instead of ioremap() in einj
 driver
Date: Wed, 25 Jan 2012 09:49:40 +0800
Message-ID: <4F1F5FB4.1020004@linux.intel.com>
References: <4f1decfc19324ca832@agluck-desktop.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:35623 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754694Ab2AYBto (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Jan 2012 20:49:44 -0500
In-Reply-To: <4f1decfc19324ca832@agluck-desktop.sc.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Myron Stowe <mstowe@redhat.com>

=E4=BA=8E 2012/1/24 7:27, Luck, Tony =E5=86=99=E9=81=93:
> ioremap() has become more picky and is now spitting out console messa=
ges like:
>
>   ioremap error for 0xbddbd000-0xbddbe000, requested 0x10, got 0x0
>
> when loading the einj driver.  What we are trying to so here is map
> a couple of data structures that the EINJ table points to. Perhaps
> acpi_os_map_memory() is a better tool for this?
> Most importantly it works, but as a side benefit it maps the structur=
es
> into kernel virtual space so we can access them with normal C memory
> dereferences, so instead of using:
> 	writel(param1,&v5param->apicid);
> we can use the more natural:
> 	v5param->apicid =3D param1;

I can understand why here C memory access model can work because ACPI t=
able
is in physical memory zone but not in device space, but I still have
two confusion: 1)why ioremap fail but acpi_os_map_memory can work? In e=
ssential
acpi_os_map_memory is ioremap (or precisely, ioremap_cache), right?
2)since acpi_os_map_memory is io mapping too (though it is a little bit
special), read/write should work besides *C memory access*. If so, why =
removing
read/write here? Some ARCH compatibility or compilation issue?

>
> Signed-off-by: Tony Luck<tony.luck@intel.com>
>
> ---
>   drivers/acpi/apei/einj.c |   82 +++++++++++++++++++++--------------=
------------
>   1 file changed, 38 insertions(+), 44 deletions(-)
>
> The unmap paths are ugly - suggestions for improvement welcome.
>
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index c89b0e5..dc3e63b 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -141,21 +141,6 @@ static DEFINE_MUTEX(einj_mutex);
>
>   static void *einj_param;
>
> -#ifndef readq
> -static inline __u64 readq(volatile void __iomem *addr)
> -{
> -	return ((__u64)readl(addr+4)<<  32) + readl(addr);
> -}
> -#endif
> -
> -#ifndef writeq
> -static inline void writeq(__u64 val, volatile void __iomem *addr)
> -{
> -	writel(val, addr);
> -	writel(val>>  32, addr+4);
> -}
> -#endif
> -
>   static void einj_exec_ctx_init(struct apei_exec_context *ctx)
>   {
>   	apei_exec_ctx_init(ctx, einj_ins_type, ARRAY_SIZE(einj_ins_type),
> @@ -204,22 +189,21 @@ static int einj_timedout(u64 *t)
>   static void check_vendor_extension(u64 paddr,
>   				   struct set_error_type_with_address *v5param)
>   {
> -	int	offset =3D readl(&v5param->vendor_extension);
> +	int	offset =3D v5param->vendor_extension;
>   	struct	vendor_error_type_extension *v;
>   	u32	sbdf;
>
>   	if (!offset)
>   		return;
> -	v =3D ioremap(paddr + offset, sizeof(*v));
> +	v =3D acpi_os_map_memory(paddr + offset, sizeof(*v));
>   	if (!v)
>   		return;
> -	sbdf =3D readl(&v->pcie_sbdf);
> +	sbdf =3D v->pcie_sbdf;
>   	sprintf(vendor_dev, "%x:%x:%x.%x vendor_id=3D%x device_id=3D%x rev=
_id=3D%x\n",
>   		sbdf>>  24, (sbdf>>  16)&  0xff,
>   		(sbdf>>  11)&  0x1f, (sbdf>>  8)&  0x7,
> -		 readw(&v->vendor_id), readw(&v->device_id),
> -		readb(&v->rev_id));
> -	iounmap(v);
> +		 v->vendor_id, v->device_id, v->rev_id);
> +	acpi_os_unmap_memory(v, sizeof(*v));
>   }
>
>   static void *einj_get_parameter_address(void)
> @@ -247,7 +231,7 @@ static void *einj_get_parameter_address(void)
>   	if (paddrv5) {
>   		struct set_error_type_with_address *v5param;
>
> -		v5param =3D ioremap(paddrv5, sizeof(*v5param));
> +		v5param =3D acpi_os_map_memory(paddrv5, sizeof(*v5param));
>   		if (v5param) {
>   			acpi5 =3D 1;
>   			check_vendor_extension(paddrv5, v5param);
> @@ -257,11 +241,11 @@ static void *einj_get_parameter_address(void)
>   	if (paddrv4) {
>   		struct einj_parameter *v4param;
>
> -		v4param =3D ioremap(paddrv4, sizeof(*v4param));
> +		v4param =3D acpi_os_map_memory(paddrv4, sizeof(*v4param));
>   		if (!v4param)
>   			return NULL;
> -		if (readq(&v4param->reserved1) || readq(&v4param->reserved2)) {
> -			iounmap(v4param);
> +		if (v4param->reserved1 || v4param->reserved2) {
> +			acpi_os_unmap_memory(v4param, sizeof(*v4param));
>   			return NULL;
>   		}
>   		return v4param;
> @@ -440,41 +424,41 @@ static int __einj_error_inject(u32 type, u64 pa=
ram1, u64 param2)
>   	if (acpi5) {
>   		struct set_error_type_with_address *v5param =3D einj_param;
>
> -		writel(type,&v5param->type);
> +		v5param->type =3D type;
>   		if (type&  0x80000000) {
>   			switch (vendor_flags) {
>   			case SETWA_FLAGS_APICID:
> -				writel(param1,&v5param->apicid);
> +				v5param->apicid =3D param1;
>   				break;
>   			case SETWA_FLAGS_MEM:
> -				writeq(param1,&v5param->memory_address);
> -				writeq(param2,&v5param->memory_address_range);
> +				v5param->memory_address =3D param1;
> +				v5param->memory_address_range =3D param2;
>   				break;
>   			case SETWA_FLAGS_PCIE_SBDF:
> -				writel(param1,&v5param->pcie_sbdf);
> +				v5param->pcie_sbdf =3D param1;
>   				break;
>   			}
> -			writel(vendor_flags,&v5param->flags);
> +			v5param->flags =3D vendor_flags;
>   		} else {
>   			switch (type) {
>   			case ACPI_EINJ_PROCESSOR_CORRECTABLE:
>   			case ACPI_EINJ_PROCESSOR_UNCORRECTABLE:
>   			case ACPI_EINJ_PROCESSOR_FATAL:
> -				writel(param1,&v5param->apicid);
> -				writel(SETWA_FLAGS_APICID,&v5param->flags);
> +				v5param->apicid =3D param1;
> +				v5param->flags =3D SETWA_FLAGS_APICID;
>   				break;
>   			case ACPI_EINJ_MEMORY_CORRECTABLE:
>   			case ACPI_EINJ_MEMORY_UNCORRECTABLE:
>   			case ACPI_EINJ_MEMORY_FATAL:
> -				writeq(param1,&v5param->memory_address);
> -				writeq(param2,&v5param->memory_address_range);
> -				writel(SETWA_FLAGS_MEM,&v5param->flags);
> +				v5param->memory_address =3D param1;
> +				v5param->memory_address_range =3D param2;
> +				v5param->flags =3D SETWA_FLAGS_MEM;
>   				break;
>   			case ACPI_EINJ_PCIX_CORRECTABLE:
>   			case ACPI_EINJ_PCIX_UNCORRECTABLE:
>   			case ACPI_EINJ_PCIX_FATAL:
> -				writel(param1,&v5param->pcie_sbdf);
> -				writel(SETWA_FLAGS_PCIE_SBDF,&v5param->flags);
> +				v5param->pcie_sbdf =3D param1;
> +				v5param->flags =3D SETWA_FLAGS_PCIE_SBDF;
>   				break;
>   			}
>   		}
> @@ -484,8 +468,8 @@ static int __einj_error_inject(u32 type, u64 para=
m1, u64 param2)
>   			return rc;
>   		if (einj_param) {
>   			struct einj_parameter *v4param =3D einj_param;
> -			writeq(param1,&v4param->param1);
> -			writeq(param2,&v4param->param2);
> +			v4param->param1 =3D param1;
> +			v4param->param2 =3D param2;
>   		}
>   	}
>   	rc =3D apei_exec_run(&ctx, ACPI_EINJ_EXECUTE_OPERATION);
> @@ -736,8 +720,13 @@ static int __init einj_init(void)
>   	return 0;
>
>   err_unmap:
> -	if (einj_param)
> -		iounmap(einj_param);
> +	if (einj_param) {
> +		acpi_size size =3D (acpi5) ?
> +			sizeof (struct set_error_type_with_address) :
> +			sizeof (struct einj_parameter);
> +
> +		acpi_os_unmap_memory(einj_param, size);
> +	}
>   	apei_exec_post_unmap_gars(&ctx);
>   err_release:
>   	apei_resources_release(&einj_resources);
> @@ -753,8 +742,13 @@ static void __exit einj_exit(void)
>   {
>   	struct apei_exec_context ctx;
>
> -	if (einj_param)
> -		iounmap(einj_param);
> +	if (einj_param) {
> +		acpi_size size =3D (acpi5) ?
> +			sizeof (struct set_error_type_with_address) :
> +			sizeof (struct einj_parameter);
> +
> +		acpi_os_unmap_memory(einj_param, size);
> +	}
>   	einj_exec_ctx_init(&ctx);
>   	apei_exec_post_unmap_gars(&ctx);
>   	apei_resources_release(&einj_resources);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
