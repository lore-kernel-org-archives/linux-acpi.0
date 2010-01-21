From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/2] x86: Unify reboot_type selection
Date: Thu, 21 Jan 2010 10:29:34 -0800
Message-ID: <4B589D0E.2010601@zytor.com>
References: <alpine.LFD.2.00.1001200007560.4265@localhost.localdomain> <1264094323-7187-1-git-send-email-ch@zeha.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:60412 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752273Ab0AUSdo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Jan 2010 13:33:44 -0500
In-Reply-To: <1264094323-7187-1-git-send-email-ch@zeha.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christian Hofstaedtler <ch@zeha.at>
Cc: x86@kernel.org, lenb@kernel.org, tglx@linutronix.de, linux-acpi@vger.kernel.org, venkatesh.pallipadi@intel.com, arjan@infradead.org, bruce.w.allan@intel.com, linux-kernel@vger.kernel.org

On 01/21/2010 09:18 AM, Christian Hofstaedtler wrote:
> Unify x86_32-only and x86_32+x86_64 reboot quirks selection functions,
> so the code path is a bit easier to understand and gets a predefined
> execution order.

>  
> -static struct dmi_system_id __initdata reboot_dmi_table[] = {
> +/*
> + * This table only gets used on x86_32, so only use with
> + * set_bios_reboot.
> + */
> +static struct dmi_system_id __initdata reboot_dmi_table_x86_32[] = {
>  	{	/* Handle problems with rebooting on Dell E520's */
>  		.callback = set_bios_reboot,
>  		.ident = "Dell E520",
> @@ -270,13 +274,6 @@ static struct dmi_system_id __initdata reboot_dmi_table[] = {
>  	{ }
>  };
>  

I think it would make more sense to just #ifdef off a section of a
single table, instead of having an #ifdef for a separate table and an
#ifdef for a table entry.

I don't know how big these tables are -- this is initdata after all, so
unless the tables are really small, we could just make set_bios_reboot a
noop on x86-64.

	-hpa
