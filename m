From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: Simplify conditional that has the same effect no matter what.
Date: Thu, 25 Oct 2012 00:19:20 +0200
Message-ID: <1661887.Vj6oUkKfTO@vostro.rjw.lan>
References: <alpine.DEB.2.02.1210221738310.5975@oneiric>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:35776 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161255Ab2JXWPY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Oct 2012 18:15:24 -0400
In-Reply-To: <alpine.DEB.2.02.1210221738310.5975@oneiric>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, Feng Tang <feng.tang@intel.com>

On Monday 22 of October 2012 17:40:36 Robert P. J. Day wrote:
> 
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

Tentatively applied an equivalent (but older) patch from Feng Tang to
linux-pm.git/acpi-next as v3.8 material.

Thanks,
Rafael


> ---
> 
>   not sure if there's something weirdly subtle happening here, but
> this looks like a straightforward simplification.
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
> 
> 
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
