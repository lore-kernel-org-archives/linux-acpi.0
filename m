From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] acpi: remove length check for large registers
Date: Fri, 15 Mar 2013 20:50:45 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E36F489B66@ORSMSX101.amr.corp.intel.com>
References: <1363377367-12813-1-git-send-email-linn@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363377367-12813-1-git-send-email-linn@hp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Linn Crosetto <linn@hp.com>, "rjw@sisk.pl" <rjw@sisk.pl>, "ming.m.lin@intel.com" <ming.m.lin@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Linn,

Can you explain in a bit more detail what brings this up?

I'm aware of the limitation of the generic address structure, but we are forced by the (current) ACPI specification to use it if it is present for a given register.

Thanks,
Bob


> -----Original Message-----
> From: Linn Crosetto [mailto:linn@hp.com]
> Sent: Friday, March 15, 2013 12:56 PM
> To: rjw@sisk.pl; Moore, Robert; ming.m.lin@intel.com; Zheng, Lv; linux-
> acpi@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; Linn Crosetto
> Subject: [PATCH] acpi: remove length check for large registers
> 
> The legacy bit width field in the Generic Address Structure is 1 byte,
> limiting the reportable register width to 255 bits. Larger registers will
> cause a length mismatch warning to be printed in acpi_tb_validate_fadt().
> 
> To avoid the warning, disable the length mismatch check for registers
> larger than 255 bits.
> 
> Signed-off-by: Linn Crosetto <linn@hp.com>
> ---
>  drivers/acpi/acpica/tbfadt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
> index 74181bf..e87abcd 100644
> --- a/drivers/acpi/acpica/tbfadt.c
> +++ b/drivers/acpi/acpica/tbfadt.c
> @@ -561,6 +561,7 @@ static void acpi_tb_validate_fadt(void)
>  		 * legacy length field and the corresponding 64-bit X length
> field.
>  		 */
>  		if (address64->address &&
> +		    ACPI_MUL_8(length) <= ACPI_UINT8_MAX &&
>  		    (address64->bit_width != ACPI_MUL_8(length))) {
>  			ACPI_BIOS_WARNING((AE_INFO,
>  					   "32/64X length mismatch in FADT/%s:
> %u/%u",
> --
> 1.7.11.3
