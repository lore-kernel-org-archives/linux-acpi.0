From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Subject: [PATCH] ACPI: Battery: Update info for inserted
 battery
Date: Mon, 22 Dec 2008 19:34:35 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812221934250.20902@localhost.localdomain>
References: <alpine.LFD.2.00.0812221748020.20902@localhost.localdomain>
 <20081222234454.758.6653.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:48650 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752592AbYLWAei (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Mon, 22 Dec 2008 19:34:38 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KCB004QK07LVN51@vms173007.mailsrvcs.net> for
 Linux-acpi@vger.kernel.org; Mon, 22 Dec 2008 18:33:21 -0600 (CST)
In-reply-to: <20081222234454.758.6653.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Linux-acpi@vger.kernel.org

Applied

-- Len Brown, Intel Open Source Technology Center

On Tue, 23 Dec 2008, Alexey Starikovskiy wrote:

> Newly inserted battery might differ from one just removed, so
> update of battery info fields is required.
> 
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> Acked-by: Andy Neitzke <neitzke@ias.edu>
> 
> Signed-off-by: Alexey Starikovskiy <astarikovskiy <at> suse.de>
> ---
> 
>  drivers/acpi/battery.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> 
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 1423b0c..65132f9 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -471,7 +471,7 @@ static void sysfs_remove_battery(struct acpi_battery *battery)
>  
>  static int acpi_battery_update(struct acpi_battery *battery)
>  {
> -	int result;
> +	int result, old_present = acpi_battery_present(battery);
>  	result = acpi_battery_get_status(battery);
>  	if (result)
>  		return result;
> @@ -482,7 +482,8 @@ static int acpi_battery_update(struct acpi_battery *battery)
>  		return 0;
>  	}
>  #endif
> -	if (!battery->update_time) {
> +	if (!battery->update_time ||
> +	    old_present != acpi_battery_present(battery)) {
>  		result = acpi_battery_get_info(battery);
>  		if (result)
>  			return result;
> 
