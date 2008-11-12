From: Thomas Renninger <trenn@suse.de>
Subject: Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
Date: Wed, 12 Nov 2008 17:58:37 -0600
Message-ID: <200811121758.39105.trenn@suse.de>
References: <200810192350.57993.trenn@suse.de> <20081111005856.GA10535@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:50852 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752009AbYKLX6p (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Nov 2008 18:58:45 -0500
In-Reply-To: <20081111005856.GA10535@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "devel@acpica.org" <devel@acpica.org>

On Monday 10 November 2008 06:58:56 pm Matthew Garrett wrote:
> I've now had confirmation from multiple sources that Vista still uses
> the 32-bit addresses for the GPE blocks.
Are you sure that Windows Server implementations also use 32-bit addresses?
Are you sure that upcoming Windows implementations will always use 32-bit 
addresses?
Do all X86 machines support Windows or could there be machines, especially 
servers which only support Mac OS, Solaris/Linux or other OSes which stick to 
the spec which you break with this change?
> We're actually seeing the same 
> bug on some currently shipping machines
Which ones?
> , so again I'm going to suggest 
> that the blacklist model isn't going to scale and we should just behave
> like Windows. How about this patch instead? It does some sanity
> checking, so I doubt that there's any way it could break a legitimate
> system. I've left IA64 as-is because it seems more likely that there'd
> be a requirement for 64-bit setups there.

If at all, this should not be added for .28, but for .29 and stay in 
linux-next for a while.
I wonder why all (hmm, hard to say, at least a lot) recent machines have valid 
64 bit addresses.
I also disagree with violating the spec unconditionally, breaking machines 
which would stick to it. It's likely that machines do not get a latest 
mainline kernel tests. Once this change is in distributions and machines do 
break, people are busted. There should at least be a boot param to switch 
back.

We might come away with it. But I have the strong feeling that there are 
machines running better using 32-bit and machines running better with 64-bit 
addresses used.

       Thomas

> Signed-off-by: Matthew Garrett <mjg@redhat.com>
>
> ---
>
> Are there even any ACPI platforms where a system io address can be
> greater than 32 bits? It's limited to 16 bits on x86, so I *really*
> don't think this is going to break anything. The FADTs I've checked from
> Thinkpads all seem to have valid 32-bit addresses even using the one
> obtained from the XSDT.
>
> diff --git a/drivers/acpi/events/evgpeblk.c
> b/drivers/acpi/events/evgpeblk.c index 73c058e..eed35d7 100644
> --- a/drivers/acpi/events/evgpeblk.c
> +++ b/drivers/acpi/events/evgpeblk.c
> @@ -1107,6 +1107,32 @@ acpi_status acpi_ev_gpe_initialize(void)
>  	 */
>
>  	/*
> +	 * The ACPI specification says that we should use the 64-bit
> +	 * address offset for the GPE blocks if it exists. However,
> +	 * Windows uses the legacy address. Various vendors have left
> +	 * incorrect values in the 64-bit field, which then causes
> +	 * problems later. Since the vast majority of machines have
> +	 * never been tested with an OS that uses the 64-bit value by
> +	 * default, we should behave like Windows and ignore the spec
> +	 * by only using the 64-bit address if it contains something
> +	 * that can't be represented in the legacy field. Since system
> +	 * io space is only 16 bits on x86, this should be entirely
> +	 * safe.
> +	 */
> +
> +#ifdef CONFIG_X86
> +	if (acpi_gbl_FADT.gpe0_block &&
> +	    acpi_gbl_FADT.xgpe0_block.space_id == ACPI_ADR_SPACE_SYSTEM_IO)
> +		acpi_gbl_FADT.xgpe0_block.address =
> +			(u64)acpi_gbl_FADT.gpe0_block;
> +
> +	if (acpi_gbl_FADT.gpe1_block &&
> +	    acpi_gbl_FADT.xgpe1_block.space_id == ACPI_ADR_SPACE_SYSTEM_IO)
> +		acpi_gbl_FADT.xgpe1_block.address =
> +			(u64)acpi_gbl_FADT.gpe1_block;
> +#endif
> +
> +	/*
>  	 * Determine the maximum GPE number for this machine.
>  	 *
>  	 * Note: both GPE0 and GPE1 are optional, and either can exist without


