From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI, APEI: Fixup incorrect 64-bit access width firmware bug
Date: Wed, 16 Jan 2013 23:54:54 +0100
Message-ID: <2313122.XO7091fHrU@vostro.rjw.lan>
References: <1358327009-14625-1-git-send-email-jia.zhang@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:42245 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758087Ab3APWtB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jan 2013 17:49:01 -0500
In-Reply-To: <1358327009-14625-1-git-send-email-jia.zhang@windriver.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lans Zhang <jia.zhang@windriver.com>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org, Myron Stowe <mstowe@redhat.com>, Huang Ying <ying.huang@intel.com>, Gary Hade <garyhade@us.ibm.com>

On Wednesday, January 16, 2013 05:03:29 PM Lans Zhang wrote:
> The bit width check was introduced by 15afae60 (ACPI, APEI: Fix
> incorrect APEI register bit width check and usage), and a fixup
> for incorrect 32-bit width memory address was given by f712c71
> (ACPI, APEI: Fixup common access width firmware bug). Now there
> is a similar symptom:
> 
> [Firmware Bug]: APEI: Invalid bit width + offset in GAR [0x12345000/64/0/3/0]
> 
> Another bogus BIOS reports an incorrect 64-bit width in trigger table.
> Thus, apply to a similar workaround for 64-bit width memory address.

This makes sense to me, but I'd like more people to have a look at it (Myron,
Ying, Gary CCed).

Thanks,
Rafael


> Signed-off-by: Lans Zhang <jia.zhang@windriver.com>
> ---
>  drivers/acpi/apei/apei-base.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
> index 00a7836..46f80e2 100644
> --- a/drivers/acpi/apei/apei-base.c
> +++ b/drivers/acpi/apei/apei-base.c
> @@ -590,6 +590,9 @@ static int apei_check_gar(struct acpi_generic_address *reg, u64 *paddr,
>  	if (bit_width == 32 && bit_offset == 0 && (*paddr & 0x03) == 0 &&
>  	    *access_bit_width < 32)
>  		*access_bit_width = 32;
> +	else if (bit_width == 64 && bit_offset == 0 && (*paddr & 0x07) == 0 &&
> +	    *access_bit_width < 64)
> +		*access_bit_width = 64;
>  
>  	if ((bit_width + bit_offset) > *access_bit_width) {
>  		pr_warning(FW_BUG APEI_PFX
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
