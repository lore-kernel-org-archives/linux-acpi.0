From: Thomas Renninger <trenn@suse.de>
Subject: Re: [Resend] [PATCH]: ACPI: Rename ACPI processor device bus ID
Date: Tue, 2 Jun 2009 15:19:28 +0200
Message-ID: <200906021519.29217.trenn@suse.de>
References: <1243737111.3634.168.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:48483 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752757AbZFBNT2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Jun 2009 09:19:28 -0400
In-Reply-To: <1243737111.3634.168.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Sunday 31 May 2009 04:31:51 yakui_zhao wrote:

> +	/*
> +	 * On some boxes several processors use the same processor bus id.
> +	 * But they are located in different scope. For example:
> +	 * \_SB.SCK0.CPU0
> +	 * \_SB.SCK1.CPU0
> +	 * Rename the processor device bus id. And the new bus id will be
> +	 * generated as the following format:
> +	 * CPU+CPU ID.
> +	 */
> +	sprintf(acpi_device_bid(device), "CPU%X", pr->id);
Hm, there were several attempts to get rid of acpi_device_bid and 
friends.
Especially here, sprintfing into something function like looks really 
wrong.
Len, do you agree that not introducing new ones and at some point of
time replacing:
acpi_device_bid(device)
with
device->pnp.bus_id
is the way to go?

Thanks,

    Thomas

>  	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Processor [%d:%d]\n", pr->id,
>  			  pr->acpi_id));
>  
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


