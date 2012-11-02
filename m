From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/4] ACPI: Remove the useless check in osl.c
Date: Fri, 02 Nov 2012 13:49:35 +0100
Message-ID: <4085291.uCdFhXEetO@vostro.rjw.lan>
References: <1351561961-23821-1-git-send-email-feng.tang@intel.com> <1351561961-23821-3-git-send-email-feng.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:52161 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761051Ab2KBMp2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 2 Nov 2012 08:45:28 -0400
In-Reply-To: <1351561961-23821-3-git-send-email-feng.tang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Feng Tang <feng.tang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Tuesday, October 30, 2012 09:52:40 AM Feng Tang wrote:
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  drivers/acpi/osl.c |    7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 9eaf708..e76a7f5 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -949,12 +949,7 @@ static acpi_status __acpi_os_execute(acpi_execute_type type,
>  		(type == OSL_NOTIFY_HANDLER ? kacpi_notify_wq : kacpid_wq);
>  	dpc->wait = hp ? 1 : 0;
>  
> -	if (queue == kacpi_hotplug_wq)
> -		INIT_WORK(&dpc->work, acpi_os_execute_deferred);
> -	else if (queue == kacpi_notify_wq)
> -		INIT_WORK(&dpc->work, acpi_os_execute_deferred);
> -	else
> -		INIT_WORK(&dpc->work, acpi_os_execute_deferred);
> +	INIT_WORK(&dpc->work, acpi_os_execute_deferred);
>  
>  	/*
>  	 * On some machines, a software-initiated SMI causes corruption unless

The check is not really useless, because it prevents lockdep from
complaining unnecessarily.

I have applied a different patch to document this.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
