From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [RFC v2 1/7] ACPI/PCI: Enhance ACPI core to support sparse IO
 space
Date: Mon, 11 May 2015 21:01:34 +0800
Message-ID: <5550A82E.7040809@linaro.org>
References: <1430793970-11159-1-git-send-email-jiang.liu@linux.intel.com> <1430793970-11159-2-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34100 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073AbbEKNBo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 May 2015 09:01:44 -0400
Received: by pacyx8 with SMTP id yx8so109570499pac.1
        for <linux-acpi@vger.kernel.org>; Mon, 11 May 2015 06:01:44 -0700 (PDT)
In-Reply-To: <1430793970-11159-2-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <marc.zyngier@arm.com>, Yijing Wang <wangyijing@huawei.com>, Len Brown <lenb@kernel.org>, Vivek Goyal <vgoyal@redhat.com>, Thierry Reding <treding@nvidia.com>, Jakub Sitnicki <jsitnicki@gmail.com>
Cc: Lv Zheng <lv.zheng@intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>, linux-arm-kernel@lists.infradead.org

On 2015=E5=B9=B405=E6=9C=8805=E6=97=A5 10:46, Jiang Liu wrote:
> Enhance ACPI resource parsing interfaces to support sparse IO space,
> which will be used to share common code between x86 and IA64 later.
>
> Tested-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>   drivers/acpi/resource.c |    9 ++++++---
>   include/linux/ioport.h  |    1 +
>   2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 8244f013f210..fdcc73dad2c1 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -123,7 +123,7 @@ bool acpi_dev_resource_memory(struct acpi_resourc=
e *ares, struct resource *res)
>   EXPORT_SYMBOL_GPL(acpi_dev_resource_memory);
>
>   static void acpi_dev_ioresource_flags(struct resource *res, u64 len=
,
> -				      u8 io_decode)
> +				      u8 io_decode, u8 translation_type)
>   {
>   	res->flags =3D IORESOURCE_IO;
>
> @@ -135,6 +135,8 @@ static void acpi_dev_ioresource_flags(struct reso=
urce *res, u64 len,
>
>   	if (io_decode =3D=3D ACPI_DECODE_16)
>   		res->flags |=3D IORESOURCE_IO_16BIT_ADDR;
> +	if (translation_type =3D=3D ACPI_SPARSE_TRANSLATION)
> +		res->flags |=3D IORESOURCE_IO_SPARSE;
>   }
>
>   static void acpi_dev_get_ioresource(struct resource *res, u64 start=
, u64 len,
> @@ -142,7 +144,7 @@ static void acpi_dev_get_ioresource(struct resour=
ce *res, u64 start, u64 len,
>   {
>   	res->start =3D start;
>   	res->end =3D start + len - 1;
> -	acpi_dev_ioresource_flags(res, len, io_decode);
> +	acpi_dev_ioresource_flags(res, len, io_decode, 0);
>   }
>
>   /**
> @@ -227,7 +229,8 @@ static bool acpi_decode_space(struct resource_win=
 *win,
>   		acpi_dev_memresource_flags(res, len, wp);
>   		break;
>   	case ACPI_IO_RANGE:
> -		acpi_dev_ioresource_flags(res, len, iodec);
> +		acpi_dev_ioresource_flags(res, len, iodec,
> +					  addr->info.io.translation_type);
>   		break;
>   	case ACPI_BUS_NUMBER_RANGE:
>   		res->flags =3D IORESOURCE_BUS;
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 388e3ae94f7a..24bea087e7af 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -94,6 +94,7 @@ struct resource {
>   /* PnP I/O specific bits (IORESOURCE_BITS) */
>   #define IORESOURCE_IO_16BIT_ADDR	(1<<0)
>   #define IORESOURCE_IO_FIXED		(1<<1)
> +#define IORESOURCE_IO_SPARSE		(1<<2)
>
>   /* PCI ROM control bits (IORESOURCE_BITS) */
>   #define IORESOURCE_ROM_ENABLE		(1<<0)	/* ROM is enabled, same as PC=
I_ROM_ADDRESS_ENABLE */

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
