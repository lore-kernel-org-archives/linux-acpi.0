From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH V2] ACPI, APEI: Fixup incorrect 16-bit access width
 firmware bug
Date: Mon, 31 Jul 2017 02:09:10 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CEE8FF8@SHSMSX101.ccr.corp.intel.com>
References: <1501122668-53948-1-git-send-email-liwei.song@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:64957 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751586AbdGaCMV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 30 Jul 2017 22:12:21 -0400
In-Reply-To: <1501122668-53948-1-git-send-email-liwei.song@windriver.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, "Song, Liwei (Wind River)" <liwei.song@windriver.com>, "Moore, Robert" <robert.moore@intel.com>

Hi,

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Song
> liwei
> Subject: [PATCH V2] ACPI, APEI: Fixup incorrect 16-bit access width firmware bug
> 
> From: Liwei Song <liwei.song@windriver.com>
> 
> This is a follow up to commit f712c71f7b2b ("ACPI, APEI: Fixup common
> access width firmware bug") fix the following firmware bug:
> 
> [Firmware Bug]: APEI: Invalid bit width + offset in GAR [0xb2/16/0/1/1]
> 
> This is due to an 8-bit access width is specified for a 16-bit register,
> Rearrange the condition and add 8-bit width check.
> 
> Signed-off-by: Liwei Song <liwei.song@windriver.com>
> ---
>  drivers/acpi/apei/apei-base.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
> index da370e1..eca3d7a 100644
> --- a/drivers/acpi/apei/apei-base.c
> +++ b/drivers/acpi/apei/apei-base.c
> @@ -604,12 +604,12 @@ static int apei_check_gar(struct acpi_generic_address *reg, u64 *paddr,
>  	*access_bit_width = 1UL << (access_size_code + 2);
> 
>  	/* Fixup common BIOS bug */
> -	if (bit_width == 32 && bit_offset == 0 && (*paddr & 0x03) == 0 &&
> -	    *access_bit_width < 32)
> -		*access_bit_width = 32;
> -	else if (bit_width == 64 && bit_offset == 0 && (*paddr & 0x07) == 0 &&
> -	    *access_bit_width < 64)
> -		*access_bit_width = 64;
> +	if (*access_bit_width < bit_width && bit_offset == 0) {
> +		if ((bit_width == 16 && (*paddr & 0x01) == 0) ||
> +		    (bit_width == 32 && (*paddr & 0x03) == 0) ||
> +		    (bit_width == 64 && (*paddr & 0x07) == 0))
> +			*access_bit_width = bit_width;
> +	}
> 
>  	if ((bit_width + bit_offset) > *access_bit_width) {
>  		pr_warning(FW_BUG APEI_PFX

IMO, such problem could also be fixed by this commit and a cleanup of APEI
GAR code to invoke generic ACPICA GAR API - acpi_read()/acpi_write() directly.
https://github.com/acpica/acpica/pull/209

Thanks and best regards
Lv

