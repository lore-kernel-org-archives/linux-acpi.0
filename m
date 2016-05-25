From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH v2 08/13] ACPICA: Hardware: Add optimized access bit width
 support
Date: Wed, 25 May 2016 15:17:00 -0400
Message-ID: <5745FA2C.8020303@oracle.com>
References: <cover.1462331120.git.lv.zheng@intel.com>
 <cover.1462418912.git.lv.zheng@intel.com>
 <fe932d47355c652fa7114c369a427b44626da92a.1462418912.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:39117 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbcEYTR0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 May 2016 15:17:26 -0400
In-Reply-To: <fe932d47355c652fa7114c369a427b44626da92a.1462418912.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Ian Jackson <ian.jackson@eu.citrix.com>, Jan Beulich <jbeulich@suse.com>, xen-devel <xen-devel@lists.xen.org>

On 05/05/2016 12:58 AM, Lv Zheng wrote:
> ACPICA commit c49a751b4dae7baec1790748a2b4b6e8ab599f51
>
> For Access Size = 0, it actually can use user expected access bit width.
> This patch implements this.
>
> Besides of the ACPICA upstream commit, this patch also includes a fix fixing
> the issue reported by the FreeBSD community.
> The old register descriptors are translated in acpi_tb_init_generic_address()
> with access_width being filled with 0. This breaks code in
> acpi_hw_get_access_bit_width() when the registers are 16-bit IO ports and their
> bit_width fields are filled with 16. The rapid fix is meant to make code
> written for acpi_hw_get_access_bit_width() regression safer before the issue is
> correctly fixed from acpi_tb_init_generic_address(). Reported by
> John Baldwin <jhb@freebsd.org>, fixed by Lv Zheng <lv.zheng@intel.com>, tested
> by Jung-uk Kim <jkim@freebsd.org>.
>
> Link: https://github.com/acpica/acpica/commit/c49a751b
> Reported-by: John Baldwin <jhb@freebsd.org>
> Tested-by Jung-uk Kim <jkim@freebsd.org>.
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> Signed-off-by: Bob Moore <robert.moore@intel.com>
> ---
>  drivers/acpi/acpica/hwregs.c |   49 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 47 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
> index 035fb52..892e677 100644
> --- a/drivers/acpi/acpica/hwregs.c
> +++ b/drivers/acpi/acpica/hwregs.c
> @@ -51,6 +51,10 @@ ACPI_MODULE_NAME("hwregs")
>  
>  #if (!ACPI_REDUCED_HARDWARE)
>  /* Local Prototypes */
> +static u8
> +acpi_hw_get_access_bit_width(struct acpi_generic_address *reg,
> +			     u8 max_bit_width);
> +
>  static acpi_status
>  acpi_hw_read_multiple(u32 *value,
>  		      struct acpi_generic_address *register_a,
> @@ -65,6 +69,48 @@ acpi_hw_write_multiple(u32 value,
>  
>  /******************************************************************************
>   *
> + * FUNCTION:    acpi_hw_get_access_bit_width
> + *
> + * PARAMETERS:  reg                 - GAS register structure
> + *              max_bit_width       - Max bit_width supported (32 or 64)
> + *
> + * RETURN:      Status
> + *
> + * DESCRIPTION: Obtain optimal access bit width
> + *
> + ******************************************************************************/
> +
> +static u8
> +acpi_hw_get_access_bit_width(struct acpi_generic_address *reg, u8 max_bit_width)
> +{
> +	u64 address;
> +
> +	if (!reg->access_width) {
> +		/*
> +		 * Detect old register descriptors where only the bit_width field
> +		 * makes senses. The target address is copied to handle possible
> +		 * alignment issues.
> +		 */
> +		ACPI_MOVE_64_TO_64(&address, &reg->address);
> +		if (!reg->bit_offset && reg->bit_width &&
> +		    ACPI_IS_POWER_OF_TWO(reg->bit_width) &&
> +		    ACPI_IS_ALIGNED(reg->bit_width, 8) &&
> +		    ACPI_IS_ALIGNED(address, reg->bit_width)) {
> +			return (reg->bit_width);
> +		} else {
> +			if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
> +				return (32);

This (together with "... Add access_width/bit_offset support in
acpi_hw_write") breaks Xen guests using older QEMU which doesn't support
4-byte IO accesses.

Why not return "reg->bit_width?:max_bit_width" ? This will preserve
original behavior.

-boris

> +			} else {
> +				return (max_bit_width);
> +			}
> +		}
> +	} else {
> +		return (1 << (reg->access_width + 2));
> +	}
> +}
> +
> +/******************************************************************************
> + *
>   * FUNCTION:    acpi_hw_validate_register
>   *
>   * PARAMETERS:  reg                 - GAS register structure
> @@ -122,8 +168,7 @@ acpi_hw_validate_register(struct acpi_generic_address *reg,
>  
>  	/* Validate the bit_width, convert access_width into number of bits */
>  
> -	access_width = reg->access_width ? reg->access_width : 1;
> -	access_width = 1 << (access_width + 2);
> +	access_width = acpi_hw_get_access_bit_width(reg, max_bit_width);
>  	bit_width =
>  	    ACPI_ROUND_UP(reg->bit_offset + reg->bit_width, access_width);
>  	if (max_bit_width < bit_width) {


