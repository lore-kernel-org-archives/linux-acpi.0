From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [patch] pci-acpi: handle multiple _OSC
Date: Thu, 08 May 2008 21:54:36 +0900
Message-ID: <4822F80C.2060704@jp.fujitsu.com>
References: <1210238510.23649.2.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:42426 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752911AbYEHM5A (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 May 2008 08:57:00 -0400
In-Reply-To: <1210238510.23649.2.camel@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>, linux acpi <linux-acpi@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>

Shaohua Li wrote:
> There is an IA64 system here which have two pci root bridges with _OSC.
> One _OSC disables SHPC control bit but the other not. Below patch makes
> _OSC data per-device instead of one global, otherwise linux takes both
> root bridges don't support SHPC
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 72f7476..8f17064 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -19,8 +19,29 @@
>  #include <linux/pci-acpi.h>
>  #include "pci.h"
>  
> -static u32 ctrlset_buf[3] = {0, 0, 0};
> -static u32 global_ctrlsets = 0;
> +#define MAX_ACPI_OSC 30 /* Should be enough */
> +struct acpi_osc_data {
> +	acpi_handle handle;
> +	u32 ctrlset_buf[3];
> +	u32 global_ctrlsets;
> +} acpi_osc_data_array[MAX_ACPI_OSC];
> +
> +struct acpi_osc_data *acpi_get_osc_data(acpi_handle handle)
> +{

One nit pick.
I think this should be static.

Thanks,
Kenji Kaneshige

