From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPICA / hardware: Fix address check in
 acpi_hw_get_access_bit_width()
Date: Fri, 27 May 2016 03:53:16 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BBB1483@SHSMSX101.ccr.corp.intel.com>
References: <1464320450-5175-1-git-send-email-lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:10248 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753538AbcE0DxW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 May 2016 23:53:22 -0400
In-Reply-To: <1464320450-5175-1-git-send-email-lv.zheng@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>, "Jan Beulich (JBeulich@suse.com)" <JBeulich@suse.com>
Cc: Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>

Hi, Boris

Can you help to confirm if this can fix all of the issues you saw in the older qemu.

Thanks and best regards
-Lv

> From: Zheng, Lv
> Subject: [PATCH] ACPICA / hardware: Fix address check in
> acpi_hw_get_access_bit_width()
> 
> The address check in acpi_hw_get_access_bit_width() should be byte size
> based, not bit width based. This patch fixes this mistake.
> 
> Reported-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Suggested-by: Jan Beulich <jbeulich@suse.com>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> ---
>  drivers/acpi/acpica/hwregs.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
> index 0f18dbc..74a591b 100644
> --- a/drivers/acpi/acpica/hwregs.c
> +++ b/drivers/acpi/acpica/hwregs.c
> @@ -95,7 +95,7 @@ acpi_hw_get_access_bit_width(struct
> acpi_generic_address *reg, u8 max_bit_width)
>  		if (!reg->bit_offset && reg->bit_width &&
>  		    ACPI_IS_POWER_OF_TWO(reg->bit_width) &&
>  		    ACPI_IS_ALIGNED(reg->bit_width, 8) &&
> -		    ACPI_IS_ALIGNED(address, reg->bit_width)) {
> +		    ACPI_IS_ALIGNED(address, reg->bit_width >> 3)) {
>  			return (reg->bit_width);
>  		} else {
>  			if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO)
> {
> --
> 1.7.10

