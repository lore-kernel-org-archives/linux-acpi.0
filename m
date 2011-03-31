From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 1/2] memblock: add error return when CONFIG_HAVE_MEMBLOCK
 is not set
Date: Wed, 30 Mar 2011 18:40:06 -0700
Message-ID: <AANLkTi=eRgp0wqpwq-W=E7ptrnQuM837+J+enEA2wey-@mail.gmail.com>
References: <20110225180633.857892225@gulag1.americas.sgi.com>
	<20110225180634.017570095@gulag1.americas.sgi.com>
	<20110227120949.GF16453@elte.hu>
	<20110227121518.GA19165@elte.hu>
	<4D6AFBB0.70401@kernel.org>
	<4D6BF63D.2020404@sgi.com>
	<AANLkTi=Sn6DKAjGHQjtWGiLGh8vpuS-vmXK=TMDrbjdv@mail.gmail.com>
	<4D6BFF46.3050001@sgi.com>
	<AANLkTi=Xf5RaF559QsRNijmG0YP7amkG569NZFhpt4QY@mail.gmail.com>
	<4D93CDD7.8000708@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58025 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932823Ab1CaBkH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Mar 2011 21:40:07 -0400
In-Reply-To: <4D93CDD7.8000708@sgi.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mike Travis <travis@sgi.com>
Cc: Ingo Molnar <mingo@elte.hu>, David Rientjes <rientjes@google.com>, Jack Steiner <steiner@sgi.com>, Robin Holt <holt@sgi.com>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Mar 30, 2011 at 5:41 PM, Mike Travis <travis@sgi.com> wrote:
> Subject: memblock: add error return when CONFIG_HAVE_MEMBLOCK is not =
set
> Author: Yinghai Lu <yinghai@kernel.org>
>
> =A0 =A0 =A0 =A0Add an error return if CONFIG_HAVE_MEMBLOCK is not set=
 instead
> =A0 =A0 =A0 =A0of having to add #ifdef CONFIG_HAVE_MEMBLOCK around bl=
ocks of
> =A0 =A0 =A0 =A0code calling that function.
>
> Signed-off-by: Mike Travis <travis@sgi.com>
> ---
> include/linux/memblock.h | =A0 =A09 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)
>
> --- linux.orig/include/linux/memblock.h
> +++ linux/include/linux/memblock.h
> @@ -2,6 +2,8 @@
> #define _LINUX_MEMBLOCK_H
> #ifdef __KERNEL__
>
> +#define MEMBLOCK_ERROR 0
> +
> #ifdef CONFIG_HAVE_MEMBLOCK
> /*
> =A0* Logical memory blocks.
> @@ -20,7 +22,6 @@
> #include <asm/memblock.h>
>
> #define INIT_MEMBLOCK_REGIONS =A0 128
> -#define MEMBLOCK_ERROR =A0 =A0 =A0 =A0 0
>
> struct memblock_region {
> =A0 =A0 =A0 =A0phys_addr_t base;
> @@ -160,6 +161,12 @@ static inline unsigned long memblock_reg
> #define __initdata_memblock
> #endif
>
> +#else
> +static inline phys_addr_t memblock_alloc(phys_addr_t size, phys_addr=
_t
> align)
> +{
> + =A0 =A0 =A0 return MEMBLOCK_ERROR;
> +}
> +
> #endif /* CONFIG_HAVE_MEMBLOCK */
>
> #endif /* __KERNEL__ */
>

setup_log_buf will pass function pointer, So this one is not needed, ri=
ght?

Thanks

Yinghai
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
