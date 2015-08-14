From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: Re: [PATCH 1/3] Honor ACPI _CCA attribute setting
Date: Fri, 14 Aug 2015 08:45:22 +0700
Message-ID: <55CD4832.7070301@amd.com>
References: <1439416290-21228-1-git-send-email-jeremy.linton@arm.com>
 <1439416290-21228-2-git-send-email-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-by2on0141.outbound.protection.outlook.com ([207.46.100.141]:36256
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751740AbbHNBpi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Aug 2015 21:45:38 -0400
In-Reply-To: <1439416290-21228-2-git-send-email-jeremy.linton@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, stern@rowland.harvard.edu, linux@prisktech.co.nz, rafael.j.wysocki@intel.com, Catalin.Marinas@arm.com, Arnd Bergmann <arnd@arndb.de>

Hi Jeremy,

On 8/13/15 04:51, Jeremy Linton wrote:
> ACPI configurations can now mark devices as noncoherent,
> support that choice.
>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>   include/acpi/acpi_bus.h | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 83061ca..7ecb8e4 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -399,7 +399,7 @@ static inline bool acpi_check_dma(struct acpi_device *adev, bool *coherent)
>   	 * case 1. Do not support and disable DMA.
>   	 * case 2. Support but rely on arch-specific cache maintenance for
>   	 *         non-coherence DMA operations.
> -	 * Currently, we implement case 1 above.
> +	 * Currently, we implement case 2 above.
>   	 *
>   	 * For the case when _CCA is missing (i.e. cca_seen=0) and
>   	 * platform specifies ACPI_CCA_REQUIRED, we do not support DMA,
> @@ -407,7 +407,8 @@ static inline bool acpi_check_dma(struct acpi_device *adev, bool *coherent)
>   	 *
>   	 * See acpi_init_coherency() for more info.
>   	 */
> -	if (adev->flags.coherent_dma) {
> +	if (adev->flags.coherent_dma ||
> +	    (adev->flags.cca_seen && IS_ENABLED(CONFIG_ARM64))) {
>   		ret = true;
>   		if (coherent)
>   			*coherent = adev->flags.coherent_dma;
>

This change was in my earlier revisions for the original patch series to 
add ACPI CCA support. At the time, this was pushed back since we were 
not sure whether this would be a useful case, and whether such hardware 
exists.

Would it be useful to document somewhere (may be in the GIT commit 
message) about which hardware might need this?

Arnd/Catalin, any feedback on this?

Thanks,

Suravee
