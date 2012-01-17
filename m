From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/5] ACPI processor: Avoid WARN message on processor driver
 removal
Date: Tue, 17 Jan 2012 06:02:39 -0500
Message-ID: <4F15554F.8040900@kernel.org>
References: <1321569421-46220-1-git-send-email-trenn@suse.de> <1321569421-46220-3-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qw0-f53.google.com ([209.85.216.53]:60454 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753258Ab2AQLCn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2012 06:02:43 -0500
Received: by qadc16 with SMTP id c16so1802912qad.19
        for <linux-acpi@vger.kernel.org>; Tue, 17 Jan 2012 03:02:42 -0800 (PST)
In-Reply-To: <1321569421-46220-3-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>

On 11/17/2011 05:36 PM, Thomas Renninger wrote:

> Only unregister acpi_idle driver if acpi_idle driver got
> registered.
> 
> Also add a static acpi_idle_active variable for easy and nicer
> checking whether acpi_idle_driver is active (as suggested by
> Bjorn).
> 
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> CC: Len Brown <lenb@kernel.org>
> CC: linux-acpi@vger.kernel.org
> CC: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/acpi/processor_driver.c |   11 +++++++----
>  1 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
> index 3a4fc0c..790623f 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -110,6 +110,7 @@ static struct cpuidle_driver acpi_idle_driver = {
>  	.name =		"acpi_idle",
>  	.owner =	THIS_MODULE,
>  };
> +static int acpi_idle_active;
>  
>  #define INSTALL_NOTIFY_HANDLER		1
>  #define UNINSTALL_NOTIFY_HANDLER	2
> @@ -508,8 +509,7 @@ static int __cpuinit acpi_processor_add(struct acpi_device *device)
>  	acpi_processor_get_throttling_info(pr);
>  	acpi_processor_get_limit_info(pr);
>  
> -
> -	if (cpuidle_get_driver() == &acpi_idle_driver)
> +	if (acpi_idle_active)
>  		acpi_processor_power_init(pr, device);


I think the old cold reads better than the new code,
since I don't have to guess what "acpi_idle_active" means...

Perhaps you can use the existing mechanism where
it is missing to guard the unregister and re-fresh?

thanks,
-Len

