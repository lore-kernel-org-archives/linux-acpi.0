From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 03/11] ACPI: SBS: remove useless acpi_cm_sbs_init() initcall
Date: Thu, 06 Nov 2008 15:31:30 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811061531250.3106@localhost.localdomain>
References: <20081105231710.26131.3110.stgit@bob.kio>
 <20081105231747.26131.11491.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:61166 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909AbYKFUif (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 15:38:35 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9X00KG2IB03S10@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 Nov 2008 14:30:37 -0600 (CST)
In-reply-to: <20081105231747.26131.11491.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org, Zhao Yakui <yakui.zhao@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>

applied.

thanks,
-len

On Wed, 5 Nov 2008, Bjorn Helgaas wrote:

> acpi_cm_sbs_init() doesn't do anything, so we can just remove it.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> ---
>  drivers/acpi/cm_sbs.c |    6 ------
>  1 files changed, 0 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/cm_sbs.c b/drivers/acpi/cm_sbs.c
> index 4441e84..80d5c88 100644
> --- a/drivers/acpi/cm_sbs.c
> +++ b/drivers/acpi/cm_sbs.c
> @@ -105,9 +105,3 @@ void acpi_unlock_battery_dir(struct proc_dir_entry *acpi_battery_dir_param)
>  	return;
>  }
>  EXPORT_SYMBOL(acpi_unlock_battery_dir);
> -
> -static int __init acpi_cm_sbs_init(void)
> -{
> -	return 0;
> -}
> -subsys_initcall(acpi_cm_sbs_init);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
