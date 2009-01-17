From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [PATCH] ACPI: Fix crash on ASUS laptops
Date: Sat, 17 Jan 2009 20:20:02 +0300
Message-ID: <49721342.40305@suse.de>
References: <alpine.LFD.2.00.0901171303040.3032@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:53269 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1763100AbZAQRUD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 17 Jan 2009 12:20:03 -0500
In-Reply-To: <alpine.LFD.2.00.0901171303040.3032@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tero Roponen <tero.roponen@gmail.com>
Cc: linux-acpi@vger.kernel.org, len.brown@intel.com

Thanks, ACK
Alex.
Tero Roponen wrote:
> This patch fixes the crash I experienced in 2.6.29-rc2.
> Tested on ASUS M50vm.
> 
> Signed-off-by: Tero Roponen <tero.roponen@gmail.com>
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index a2b82c9..5c2f5d3 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -982,7 +982,7 @@ int __init acpi_ec_ecdt_probe(void)
>  		saved_ec = kmalloc(sizeof(struct acpi_ec), GFP_KERNEL);
>  		if (!saved_ec)
>  			return -ENOMEM;
> -		memcpy(&saved_ec, boot_ec, sizeof(saved_ec));
> +		memcpy(saved_ec, boot_ec, sizeof(*saved_ec));
>  	/* fall through */
>  	}
>  	/* This workaround is needed only on some broken machines,

