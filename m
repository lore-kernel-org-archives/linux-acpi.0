From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 12/19] ACPICA: ACPI 6.0: Add changes for MADT table.
Date: Thu, 21 May 2015 22:36:25 +0800
Message-ID: <555DED69.7040203@linaro.org>
References: <cover.1432175162.git.lv.zheng@intel.com> <e5bb0a9389d04b75d702fbdb747f3015b6be51c3.1432175162.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36363 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754097AbbEUOga (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 May 2015 10:36:30 -0400
Received: by pabts4 with SMTP id ts4so107316784pab.3
        for <linux-acpi@vger.kernel.org>; Thu, 21 May 2015 07:36:30 -0700 (PDT)
In-Reply-To: <e5bb0a9389d04b75d702fbdb747f3015b6be51c3.1432175162.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

Hi Lv,

On 2015=E5=B9=B405=E6=9C=8821=E6=97=A5 10:31, Lv Zheng wrote:
> From: Bob Moore <robert.moore@intel.com>
>
> ACPICA commit 02cbb41232bccf7a91967140cab95d5f48291f21
>
> New subtable type. Some additions to existing subtables.
>
> Link: https://github.com/acpica/acpica/commit/02cbb412
> Signed-off-by: Bob Moore <robert.moore@intel.com>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> ---
[...]
>
>   /* Masks for Flags field above */
> @@ -819,7 +822,7 @@ struct acpi_madt_generic_interrupt {
>   #define ACPI_MADT_PERFORMANCE_IRQ_MODE  (1<<1)	/* 01: Performance I=
nterrupt Mode */
>   #define ACPI_MADT_VGIC_IRQ_MODE         (1<<2)	/* 02: VGIC Maintena=
nce Interrupt mode */
>
> -/* 12: Generic Distributor (ACPI 5.0) */
> +/* 12: Generic Distributor (ACPI 5.0 + ACPI 6.0 changes) */
>
>   struct acpi_madt_generic_distributor {
>   	struct acpi_subtable_header header;
> @@ -827,7 +830,8 @@ struct acpi_madt_generic_distributor {
>   	u32 gic_id;
>   	u64 base_address;
>   	u32 global_irq_base;
> -	u32 reserved2;		/* reserved - must be zero */
> +	u8 version;

version filed in generic distributor has following values,

/* Values for gic_version in Generic Distributor  (ACPI 6.0) */

enum acpi_madt_gic_ver_type
{
         ACPI_MADT_GIC_VER_UNKNOWN       =3D 0,
         ACPI_MADT_GIC_VER_V1            =3D 1,
         ACPI_MADT_GIC_VER_V2            =3D 2,
         ACPI_MADT_GIC_VER_V3            =3D 3,
         ACPI_MADT_GIC_VER_V4            =3D 4,
         ACPI_MADT_GIC_VER_RESERVED      =3D 5     /* 5 and greater are=
=20
reserved */
};

should we put it here, or locate it to ARM64 arch related head
file?

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
