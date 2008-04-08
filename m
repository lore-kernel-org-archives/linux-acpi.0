From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH] ACPI: check a return value correctly in
	acpi_power_get_context()
Date: Tue, 08 Apr 2008 16:38:26 +0800
Message-ID: <1207643906.7387.0.camel@yakui_zhao.sh.intel.com>
References: <47F9E1E2.5020506@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:26854 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753324AbYDHAvL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Apr 2008 20:51:11 -0400
In-Reply-To: <47F9E1E2.5020506@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Li Zefan <lizf@cn.fujitsu.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Mon, 2008-04-07 at 16:57 +0800, Li Zefan wrote:
> We should check *resource != NULL rather than resource != NULL,
> which will be always true.
> 
> Signed-off-by: Li Zefan <lizf@cn.fujitsu.com>
> ---
>  drivers/acpi/power.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> index 76bf6d9..f2a76ac 100644
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -121,7 +121,7 @@ acpi_power_get_context(acpi_handle handle,
>  	}
>  
>  	*resource = acpi_driver_data(device);
> -	if (!resource)
> +	if (!*resource)
>  		return -ENODEV;
>  
>  	return 0;
agreed.


