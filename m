From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [RFC] ACPI, APEI: Fix incorrect bit width + offset check
 condition
Date: Wed, 13 Jun 2012 10:46:51 +0200
Message-ID: <20120613104651.52ce8840@endymion.delvare>
References: <1339573184-3122-1-git-send-email-hui.xiao@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zoneX.GCU-Squad.org ([194.213.125.0]:27711 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532Ab2FMIrW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Jun 2012 04:47:22 -0400
In-Reply-To: <1339573184-3122-1-git-send-email-hui.xiao@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Xiao, Hui" <hui.xiao@linux.intel.com>
Cc: garyhade@us.ibm.com, tony.luck@intel.com, ying.huang@intel.com, lenb@kernel.org, pluto@agmk.net, linux-acpi@vger.kernel.org, Chen Gong <gong.chen@linux.intel.com>

Hi Xiao,

On Wed, 13 Jun 2012 15:39:44 +0800, Xiao, Hui wrote:
> Fix the incorrect bit width + offset check condition in apei_check_gar()
> function introduced by commit v3.3-5-g15afae6.
> 
> The bug caused regression on EINJ error injection with errors:
> 
> [Firmware Bug]: APEI: Invalid bit width + offset in GAR [0x1121a5000/64/0/3/0]
> 
> on a valid address region of:
>     - Register bit width: 64 bits
>     - Register bit offset: 0
>     - Access Size: 03 [DWord Access: 32]

I don't see how this is valid, sorry. If you have a 64-bit register,
you want 64-bit access, don't you?

If the access code is supposed to be able to read large registers in
smaller chunks and assemble them transparently to a larger value, then
there is no point in having any check at all, everything is valid. If
not, then the above is just as invalid as the firmware issue discussed
in bug #43282.

> 
> Signed-off-by: Xiao, Hui <hui.xiao@linux.intel.com>
> Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
> ---
>  drivers/acpi/apei/apei-base.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
> index 5577762..95e07b2 100644
> --- a/drivers/acpi/apei/apei-base.c
> +++ b/drivers/acpi/apei/apei-base.c
> @@ -586,9 +586,12 @@ static int apei_check_gar(struct acpi_generic_address *reg, u64 *paddr,
>  	}
>  	*access_bit_width = 1UL << (access_size_code + 2);
>  
> -	if ((bit_width + bit_offset) > *access_bit_width) {
> +	/* bit_width and bit_offset must be zero when addressing a data
> +	 * structure. So just check for non-zero case here */
> +	if ((bit_width != 0 && *access_bit_width > bit_width) ||
> +			bit_offset > *access_bit_width) {

I can't make any sense of this test, sorry. And it will trigger on
valid cases, starting with the most frequent case where
*access_bit_width == bit_width. So, nack.

>  		pr_warning(FW_BUG APEI_PFX
> -			   "Invalid bit width + offset in GAR [0x%llx/%u/%u/%u/%u]\n",
> +			   "Invalid bit width or offset in GAR [0x%llx/%u/%u/%u/%u]\n",
>  			   *paddr, bit_width, bit_offset, access_size_code,
>  			   space_id);
>  		return -EINVAL;


-- 
Jean Delvare
