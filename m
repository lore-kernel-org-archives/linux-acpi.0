From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH V2 3/3] PCI/ACPI: hisi: Add ACPI support for HiSilicon SoCs Host Controllers
Date: Wed, 31 Aug 2016 13:48:16 +0200
Message-ID: <5406169.iVLlEcSJ8X@wuerfel>
References: <1472644094-82731-1-git-send-email-liudongdong3@huawei.com> <1472644094-82731-4-git-send-email-liudongdong3@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:62785 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932988AbcHaLsd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Aug 2016 07:48:33 -0400
In-Reply-To: <1472644094-82731-4-git-send-email-liudongdong3@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: helgaas@kernel.org, rafael@kernel.org, Lorenzo.Pieralisi@arm.com, tn@semihalf.com, wangzhou1@hisilicon.com, pratyush.anand@gmail.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, jcm@redhat.com, gabriele.paoloni@huawei.com, charles.chenxin@huawei.com, hanjun.guo@linaro.org, linuxarm@huawei.com

On Wednesday, August 31, 2016 7:48:14 PM CEST Dongdong Liu wrote:
> +static struct hisi_rc_res rc_res[] = {
> +       {
> +               HIP05,
> +               {
> +                       DEFINE_RES_MEM(0xb0070000, SZ_4K),
> +                       DEFINE_RES_MEM(0xb0080000, SZ_4K),
> +                       DEFINE_RES_MEM(0xb0090000, SZ_4K),
> +                       DEFINE_RES_MEM(0xb00a0000, SZ_4K)
> +               }
> +       },
> +       {
> +               HIP06,
> +               {
> +                       DEFINE_RES_MEM(0xa0090000, SZ_4K),
> +                       DEFINE_RES_MEM(0xa0200000, SZ_4K),
> +                       DEFINE_RES_MEM(0xa00a0000, SZ_4K),
> +                       DEFINE_RES_MEM(0xa00b0000, SZ_4K)
> +               }
> +       },
> +       {
> +               HIP07,
> +               {
> +                       DEFINE_RES_MEM(0xa0090000, SZ_4K),
> +                       DEFINE_RES_MEM(0xa0200000, SZ_4K),
> +                       DEFINE_RES_MEM(0xa00a0000, SZ_4K),
> +                       DEFINE_RES_MEM(0xa00b0000, SZ_4K),
> +                       DEFINE_RES_MEM(0x8a0090000UL, SZ_4K),
> +                       DEFINE_RES_MEM(0x8a0200000UL, SZ_4K),
> +                       DEFINE_RES_MEM(0x8a00a0000UL, SZ_4K),
> +                       DEFINE_RES_MEM(0x8a00b0000UL, SZ_4K),
> +                       DEFINE_RES_MEM(0x600a0090000UL, SZ_4K),
> +                       DEFINE_RES_MEM(0x600a0200000UL, SZ_4K),
> +                       DEFINE_RES_MEM(0x600a00a0000UL, SZ_4K),
> +                       DEFINE_RES_MEM(0x600a00b0000UL, SZ_4K),
> +                       DEFINE_RES_MEM(0x700a0090000UL, SZ_4K),
> +                       DEFINE_RES_MEM(0x700a0200000UL, SZ_4K),
> +                       DEFINE_RES_MEM(0x700a00a0000UL, SZ_4K),
> +                       DEFINE_RES_MEM(0x700a00b0000UL, SZ_4K)
> +               }
> +       },

I don't know much about ACPI, but I'm pretty sure this is not
the normal way to find MMIO resources. Why not read them from
the ACPI tables?

	Arnd
