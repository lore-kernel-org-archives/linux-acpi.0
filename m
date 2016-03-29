From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 24/30] ACPICA: Hardware: Add access_width/bit_offset
 support in acpi_hw_read()
Date: Tue, 29 Mar 2016 08:14:18 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BB6599F@SHSMSX101.ccr.corp.intel.com>
References: <cover.1458714002.git.lv.zheng@intel.com>
 <c460156c8c91ae805f020562ac4901e90940d87f.1458714003.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c460156c8c91ae805f020562ac4901e90940d87f.1458714003.git.lv.zheng@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

Hi, Rafael

PATCH 24 and 25 are reported to have issues around mask generation:
https://bugs.acpica.org/show_bug.cgi?id=1270
Please drop them.
I'll re-send the 2 patches after the fix solution is determined.
Thanks in advance.

Best regards
-Lv

> From: Zheng, Lv
> Subject: [PATCH 24/30] ACPICA: Hardware: Add access_width/bit_offset
> support in acpi_hw_read()
> 
> ACPICA commit 96ece052d4d073aae4f935f0ff0746646aea1174
> ACPICA commit 3d8583a054e410f2ea4d73b48986facad9cfc0d4
> 
> This patch adds access_width/bit_offset support in acpi_hw_read().
> This also enables GAS definition where bit_width is not a power of
> two. Lv Zheng.
> 
> Link: https://github.com/acpica/acpica/commit/96ece052
> Link: https://github.com/acpica/acpica/commit/3d8583a0
> Link: https://bugs.acpica.org/show_bug.cgi?id=1240
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> Signed-off-by: Bob Moore <robert.moore@intel.com>
> ---
>  drivers/acpi/acpica/hwregs.c |   66 +++++++++++++++++++++++++++++++++---
> ------
>  1 file changed, 53 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
> index bc3f60a..12fed0c 100644
> --- a/drivers/acpi/acpica/hwregs.c
> +++ b/drivers/acpi/acpica/hwregs.c
> @@ -150,17 +150,19 @@ acpi_hw_validate_register(struct
> acpi_generic_address *reg,
>   *              64-bit values is not needed.
>   *
>   * LIMITATIONS: <These limitations also apply to acpi_hw_write>
> - *      bit_width must be exactly 8, 16, or 32.
>   *      space_ID must be system_memory or system_IO.
> - *      bit_offset and access_width are currently ignored, as there has
> - *          not been a need to implement these.
>   *
> 
> ****************************************************************
> **************/
> 
>  acpi_status acpi_hw_read(u32 *value, struct acpi_generic_address * reg)
>  {
>  	u64 address;
> +	u8 access_width;
> +	u32 bit_width;
> +	u8 bit_offset;
>  	u64 value64;
> +	u32 value32;
> +	u8 index;
>  	acpi_status status;
> 
>  	ACPI_FUNCTION_NAME(hw_read);
> @@ -172,28 +174,66 @@ acpi_status acpi_hw_read(u32 *value, struct
> acpi_generic_address * reg)
>  		return (status);
>  	}
> 
> -	/* Initialize entire 32-bit return value to zero */
> -
> +	/*
> +	 * Initialize entire 32-bit return value to zero, convert access_width
> +	 * into number of bits based
> +	 */
>  	*value = 0;
> +	access_width = reg->access_width ? reg->access_width : 1;
> +	access_width = 1 << (access_width + 2);
> +	bit_width = reg->bit_offset + reg->bit_width;
> +	bit_offset = reg->bit_offset;
> 
>  	/*
>  	 * Two address spaces supported: Memory or IO. PCI_Config is
>  	 * not supported here because the GAS structure is insufficient
>  	 */
> -	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
> -		status = acpi_os_read_memory((acpi_physical_address)
> -					     address, &value64, reg->bit_width);
> +	index = 0;
> +	while (bit_width) {
> +		if (bit_offset > access_width) {
> +			value32 = 0;
> +			bit_offset -= access_width;
> +		} else {
> +			if (reg->space_id ==
> ACPI_ADR_SPACE_SYSTEM_MEMORY) {
> +				status =
> +
> acpi_os_read_memory((acpi_physical_address)
> +							address +
> +							index *
> +							ACPI_DIV_8
> +							(access_width),
> +							&value64,
> access_width);
> +				value32 = (u32)value64;
> +			} else {	/* ACPI_ADR_SPACE_SYSTEM_IO, validated
> earlier */
> +
> +				status = acpi_hw_read_port((acpi_io_address)
> +							   address +
> +							   index *
> +							   ACPI_DIV_8
> +							   (access_width),
> +							   &value32,
> +							   access_width);
> +			}
> +
> +			if (bit_offset) {
> +				value32 &=
> ACPI_MASK_BITS_BELOW(bit_offset);
> +				bit_offset = 0;
> +			}
> +			if (bit_width < access_width) {
> +				value32 &=
> ACPI_MASK_BITS_ABOVE(bit_width);
> +			}
> +		}
> 
> -		*value = (u32)value64;
> -	} else {		/* ACPI_ADR_SPACE_SYSTEM_IO, validated earlier */
> +		ACPI_SET_BITS(value, index * access_width,
> +			      (1 << access_width) - 1, value32);
> 
> -		status = acpi_hw_read_port((acpi_io_address)
> -					   address, value, reg->bit_width);
> +		bit_width -=
> +		    bit_width > access_width ? access_width : bit_width;
> +		index++;
>  	}
> 
>  	ACPI_DEBUG_PRINT((ACPI_DB_IO,
>  			  "Read:  %8.8X width %2d from %8.8X%8.8X (%s)\n",
> -			  *value, reg->bit_width,
> ACPI_FORMAT_UINT64(address),
> +			  *value, access_width,
> ACPI_FORMAT_UINT64(address),
>  			  acpi_ut_get_region_name(reg->space_id)));
> 
>  	return (status);
> --
> 1.7.10
