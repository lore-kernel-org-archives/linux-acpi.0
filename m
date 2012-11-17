From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPICA: Use hweight8() and hweight16()
Date: Sat, 17 Nov 2012 10:49:04 +0100
Message-ID: <1500669.vRL5UXvquv@vostro.rjw.lan>
References: <1353144784-6717-1-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:50431 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750803Ab2KQJol (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 17 Nov 2012 04:44:41 -0500
In-Reply-To: <1353144784-6717-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Bob Moore <robert.moore@intel.com>

On Saturday, November 17, 2012 06:33:03 PM Akinobu Mita wrote:
> Replace homemade hamming weight function with hweight8() and hweight16().
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: linux-acpi@vger.kernel.org

Normally, it would be a good change, but in the case of ACPICA it is not.

ACPICA is a separate project, which is used by multiple other operating
system (basically everyone except for Windows) and we take that code
from the ACPICA upstream.  If we make changes like this in the kernel
alone, we'll start to diverge from the upstream which is not a good thing.
We've done it for a few times and we're still feeling the pain.

The right approach to do this change would be to modify the ACPICA upstream
so that it uses OS-provided bit-counting primitives, if available.  I'm
not sure if it's worth it, though.

Thanks,
Rafael


> ---
>  drivers/acpi/acpica/rscalc.c | 36 ++----------------------------------
>  1 file changed, 2 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/rscalc.c b/drivers/acpi/acpica/rscalc.c
> index de12469..bdddb7d 100644
> --- a/drivers/acpi/acpica/rscalc.c
> +++ b/drivers/acpi/acpica/rscalc.c
> @@ -49,9 +49,6 @@
>  #define _COMPONENT          ACPI_RESOURCES
>  ACPI_MODULE_NAME("rscalc")
>  
> -/* Local prototypes */
> -static u8 acpi_rs_count_set_bits(u16 bit_field);
> -
>  static acpi_rs_length
>  acpi_rs_struct_option_length(struct acpi_resource_source *resource_source);
>  
> @@ -60,35 +57,6 @@ acpi_rs_stream_option_length(u32 resource_length, u32 minimum_total_length);
>  
>  /*******************************************************************************
>   *
> - * FUNCTION:    acpi_rs_count_set_bits
> - *
> - * PARAMETERS:  bit_field       - Field in which to count bits
> - *
> - * RETURN:      Number of bits set within the field
> - *
> - * DESCRIPTION: Count the number of bits set in a resource field. Used for
> - *              (Short descriptor) interrupt and DMA lists.
> - *
> - ******************************************************************************/
> -
> -static u8 acpi_rs_count_set_bits(u16 bit_field)
> -{
> -	u8 bits_set;
> -
> -	ACPI_FUNCTION_ENTRY();
> -
> -	for (bits_set = 0; bit_field; bits_set++) {
> -
> -		/* Zero the least significant bit that is set */
> -
> -		bit_field &= (u16) (bit_field - 1);
> -	}
> -
> -	return bits_set;
> -}
> -
> -/*******************************************************************************
> - *
>   * FUNCTION:    acpi_rs_struct_option_length
>   *
>   * PARAMETERS:  resource_source     - Pointer to optional descriptor field
> @@ -439,7 +407,7 @@ acpi_rs_get_list_length(u8 * aml_buffer,
>  			 * Get the number of bits set in the 16-bit IRQ mask
>  			 */
>  			ACPI_MOVE_16_TO_16(&temp16, buffer);
> -			extra_struct_bytes = acpi_rs_count_set_bits(temp16);
> +			extra_struct_bytes = hweight16(temp16);
>  			break;
>  
>  		case ACPI_RESOURCE_NAME_DMA:
> @@ -447,7 +415,7 @@ acpi_rs_get_list_length(u8 * aml_buffer,
>  			 * DMA Resource:
>  			 * Get the number of bits set in the 8-bit DMA mask
>  			 */
> -			extra_struct_bytes = acpi_rs_count_set_bits(*buffer);
> +			extra_struct_bytes = hweight8(*buffer);
>  			break;
>  
>  		case ACPI_RESOURCE_NAME_VENDOR_SMALL:
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
