From: Jan Pogadl <pogadl.jan@googlemail.com>
Subject: Re: [BUG, REGRESSION] ACPI: Set _PDC
Date: Thu, 17 Jun 2010 09:51:26 +0200
Message-ID: <201006170951.26455.pogadl.jan@googlemail.com>
References: <201006170040.24736.pogadl.jan@googlemail.com> <20100617032413.GC2138@canonical.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57629 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756540Ab0FQHvg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jun 2010 03:51:36 -0400
Received: by fxm10 with SMTP id 10so1340281fxm.19
        for <linux-acpi@vger.kernel.org>; Thu, 17 Jun 2010 00:51:34 -0700 (PDT)
In-Reply-To: <20100617032413.GC2138@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@canonical.com>
Cc: linux-acpi@vger.kernel.org

On Thursday 17 June 2010 05:24:14 Alex Chiang wrote:

> > with commit commit 5d554a7bb0643a6151a84319bfeba8270bf5269e (ACPI: processor: 
> > add internal processor_physically_present()) a new function got introduced which 
> > always fails on machines with CONFIG_SMP disabled. Thus _PDC will never be 
> > initialized? set?. 
 
> Does this patch fix it?

works great 
thanks

> ---
> diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
> index 5128435..bcf0cf8 100644
> --- a/drivers/acpi/processor_core.c
> +++ b/drivers/acpi/processor_core.c
> @@ -223,7 +223,7 @@ static bool processor_physically_present(acpi_handle handle)
>  	type = (acpi_type == ACPI_TYPE_DEVICE) ? 1 : 0;
>  	cpuid = acpi_get_cpuid(handle, type, acpi_id);
>  
> -	if (cpuid == -1)
> +	if ((cpuid == -1) && (num_online_cpus() > 1))
>  		return false;
>  
>  	return true;
> 
