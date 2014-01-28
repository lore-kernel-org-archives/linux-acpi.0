From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] ACPI: reduce log level for message "ACPI: \_PR_.CPU4:
 failed to get CPU APIC ID"
Date: Mon, 27 Jan 2014 16:18:17 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1401271615580.17114@chino.kir.corp.google.com>
References: <CADDKRnDZt9Q4XKyJcO1htMrCJYj6_5yECURBHsJ7O==hup7ZRw@mail.gmail.com> <1390804498-30311-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:64161 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121AbaA1AST (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jan 2014 19:18:19 -0500
Received: by mail-pd0-f175.google.com with SMTP id w10so6330641pde.6
        for <linux-acpi@vger.kernel.org>; Mon, 27 Jan 2014 16:18:19 -0800 (PST)
In-Reply-To: <1390804498-30311-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Jorg Otte <jrg.otte@gmail.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 27 Jan 2014, Jiang Liu wrote:

> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index c9311be..c29c2c3 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -261,7 +261,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
>  
>  	apic_id = acpi_get_apicid(pr->handle, device_declaration, pr->acpi_id);
>  	if (apic_id < 0) {
> -		acpi_handle_err(pr->handle, "failed to get CPU APIC ID.\n");
> +		acpi_handle_debug(pr->handle, "failed to get CPU APIC ID.\n");
>  		return -ENODEV;
>  	}

Don't we already leave some artifact in the kernel log at boot about apic 
ids that don't get registered?  I'm wondering if we should have this 
warning at all.
