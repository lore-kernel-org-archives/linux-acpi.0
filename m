From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPICA: cleanup method properly on error
Date: Tue, 26 Jul 2016 14:39:51 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E4CD2A1@ORSMSX110.amr.corp.intel.com>
References: <1469201709-10518-1-git-send-email-vegard.nossum@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:32836 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756568AbcGZOjy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Jul 2016 10:39:54 -0400
In-Reply-To: <1469201709-10518-1-git-send-email-vegard.nossum@oracle.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vegard Nossum <vegard.nossum@oracle.com>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>

We'll look at this.
Thanks.


> -----Original Message-----
> From: Vegard Nossum [mailto:vegard.nossum@oracle.com]
> Sent: Friday, July 22, 2016 8:35 AM
> To: Moore, Robert <robert.moore@intel.com>; Zheng, Lv
> <lv.zheng@intel.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>
> Cc: linux-acpi@vger.kernel.org; devel@acpica.org; linux-
> kernel@vger.kernel.org; Vegard Nossum <vegard.nossum@oracle.com>;
> stable@vger.kernel.org
> Subject: [PATCH] ACPICA: cleanup method properly on error
> 
> If the call to acpi_ds_init_aml_walk() fails, then we have to undo the
> walk state push done by acpi_ds_create_walk_state(). Otherwise, the new
> walk state (which has just been freed) will remain on the thread's
> walk_state_list and be dereferenced in acpi_ps_parse_aml() when we try
> to get the new state.
> 
> You can observe this when reading e.g.
> 
>     /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0F:01/status
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  drivers/acpi/acpica/dsmethod.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/acpica/dsmethod.c
> b/drivers/acpi/acpica/dsmethod.c index 47c7b52..44b50a6 100644
> --- a/drivers/acpi/acpica/dsmethod.c
> +++ b/drivers/acpi/acpica/dsmethod.c
> @@ -596,6 +596,8 @@ cleanup:
>  	/* On error, we must terminate the method properly */
> 
>  	acpi_ds_terminate_control_method(obj_desc, next_walk_state);
> +	if (thread)
> +		acpi_ds_pop_walk_state(thread);
>  	acpi_ds_delete_walk_state(next_walk_state);
> 
>  	return_ACPI_STATUS(status);
> --
> 1.9.1

