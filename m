From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 4/8] donot allow to eject the memory device if it is
 being used
Date: Tue, 26 Jun 2012 21:21:03 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1206262118070.24245@chino.kir.corp.google.com>
References: <4FE97DD5.6030205@cn.fujitsu.com> <4FE97EEC.6060008@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54766 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806Ab2F0EVG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Jun 2012 00:21:06 -0400
Received: by dady13 with SMTP id y13so826596dad.19
        for <linux-acpi@vger.kernel.org>; Tue, 26 Jun 2012 21:21:05 -0700 (PDT)
In-Reply-To: <4FE97EEC.6060008@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Wen Congyang <wency@cn.fujitsu.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yasuaki ISIMATU <isimatu.yasuaki@jp.fujitsu.com>

On Tue, 26 Jun 2012, Wen Congyang wrote:

> diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> index a325bb9..2e5d5ab 100644
> --- a/drivers/acpi/acpi_memhotplug.c
> +++ b/drivers/acpi/acpi_memhotplug.c
> @@ -78,6 +78,7 @@ struct acpi_memory_info {
>  	unsigned short caching;	/* memory cache attribute */
>  	unsigned short write_protect;	/* memory read/write attribute */
>  	unsigned int enabled:1;
> +	unsigned int failed:1;
>  };
>  
>  struct acpi_memory_device {
> @@ -251,9 +252,19 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
>  			node = memory_add_physaddr_to_nid(info->start_addr);
>  
>  		result = add_memory(node, info->start_addr, info->length);
> -		if (result)
> +
> +		/*
> +		 * If the memory block has been used by the kernel, add_memory()
> +		 * returns -EEXIST. If add_memory() returns the other error, it
> +		 * means that this memory block is not used by the kernel.
> +		 */
> +		if (result && result != -EEXIST) {
> +			info->failed = 1;
>  			continue;
> -		info->enabled = 1;
> +		}
> +
> +		if (!result)
> +			info->enabled = 1;
>  		num_enabled++;
>  	}
>  	if (!num_enabled) {

num_enabled should only be incremented for result == 0.
