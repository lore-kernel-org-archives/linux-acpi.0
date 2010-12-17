From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: acpi_battery_init() boot speed
Date: Fri, 17 Dec 2010 08:02:35 -0800
Message-ID: <20101217080235.50838925@infradead.org>
References: <alpine.LFD.2.00.1012150308260.4878@x980>
	<20101215030054.0aae9e1e@infradead.org>
	<alpine.LFD.2.00.1012170341160.20940@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:33686 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755521Ab0LQP7x (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Dec 2010 10:59:53 -0500
In-Reply-To: <alpine.LFD.2.00.1012170341160.20940@x980>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Fri, 17 Dec 2010 03:46:12 -0500 (EST)
Len Brown <lenb@kernel.org> wrote:

> > wonder if the code could do just enough to register the device, and
> > do everything else in the background?
> 
> or do it later on demand...

that makes complete sense...

but you can even just do that async.. to cut down the time of first
use....

if you want I can propose a patch for that based on the patch below...
> 
> This patch reduces acpi_battery_init() time
> on the Lenovo S10-3 from 901,603 usec to 657 usec.
> 
> AFAICT, the battery monitor etc worked fine.
> 
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 95649d3..79e8ba3 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -943,7 +943,6 @@ static int acpi_battery_add(struct acpi_device
> *device) if (ACPI_SUCCESS(acpi_get_handle(battery->device->handle,
>  			"_BIX", &handle)))
>  		set_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags);
> -	acpi_battery_update(battery);
>  #ifdef CONFIG_ACPI_PROCFS_POWER
>  	result = acpi_battery_add_fs(device);
>  #endif
> 
> 
> 


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
