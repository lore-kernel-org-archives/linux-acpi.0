From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH 091/171] ACPI: GPE enabling should happen after
	EC	installation
Date: Sun, 04 May 2008 18:28:20 +0800
Message-ID: <1209896900.28197.65.camel@yakui_zhao.sh.intel.com>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org>
	 <1209551134.12515.47.camel@yakui_zhao.sh.intel.com>
	 <200804300758.54778.carlos@strangeworlds.co.uk>
	 <200804300817.53800.carlos@strangeworlds.co.uk>
	 <1209573782.16111.32.camel@yakui_zhao.sh.intel.com>
	 <4818441D.2010800@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:26925 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750834AbYEDChM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 3 May 2008 22:37:12 -0400
In-Reply-To: <4818441D.2010800@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>

On Wed, 2008-04-30 at 14:04 +0400, Alexey Starikovskiy wrote:
> Zhao Yakui wrote:
> > On Wed, 2008-04-30 at 08:17 +0100, Carlos Corbacho wrote:
> >> On Wednesday 30 April 2008 07:58:53 Carlos Corbacho wrote:
> >>> On Wednesday 30 April 2008 11:25:34 Zhao Yakui wrote:
> >>>> On Tue, 2008-04-29 at 04:44 -0400, Len Brown wrote:
> >>>>> From: Alexey Starikovskiy <astarikovskiy@suse.de>
> >>>>>
> >>>>> GPE could try to access EC region, so should not be enabled before
> >>>>> EC is installed
> >>>> It is caused by broken bios if GPE method tries to access EC region
> >>>> before EC is initialized correctly. It is more appropriate to fix this
> >>>> issue by upgrading bios rather than by the patch.
> >>>> And this patch will cause some potential problems.
> >>> 1) Does the BIOS in question work under Windows?
> >> ^^^
> >> that should be 'not work'
> > For the laptop in bug 9916:
> > Windows can work on the BIOS in question. In fact only warning message
> > is printed for Linux and it won't break anything. (Maybe the warning
> > message also exists on windows. But we can't see them.)
> This is generally a stupid idea to enable interrupt before you have handler for it ready,
> even if you are able to _survive_ unhandled interrupt.
> 
> Your other issue about WAKE GPEs, which could be wrongly enabled, could be solved by
> moving WAKE GPE init closer to RUNTIME GPE one:
Thanks for the so quick response. 
The following patch can solve the issue about the WAKE GPEs.

But after the patch is applied, it seems that we make a lot of changes
about the GPE initialization flowchart in ACPICA. Will these be easily
accepted by ACPICA author?
At the same time some RUNTIME GPEs will be enabled twice. When
acpi_enable_gpe is called in the course of EC installation, some RUNTIME
GPEs will also be enabled. In fact when the acpi_ev_install_fadt_gpes is
called, all the RUNTIME GPEs will be enabled. In such case it brings
that some RUNTIME GPEs are enabled twice. Of course the patch should
work fine if it is safe to enable RUNTTME GPEs twice. 

Best regards.
    Yakui
> Regards,
> Alex.
> 
> 
> 
> diff --git a/drivers/acpi/events/evgpeblk.c b/drivers/acpi/events/evgpeblk.c
> index 361ebe6..37c68ae 100644
> --- a/drivers/acpi/events/evgpeblk.c
> +++ b/drivers/acpi/events/evgpeblk.c
> @@ -940,6 +940,27 @@ acpi_ev_create_gpe_block(struct acpi_namespace_node *gpe_device,
>  					acpi_ev_save_method_info, gpe_block,
>  					NULL);
>  
> +	/*
> +	 * Runtime option: Should wake GPEs be enabled at runtime?  The default
> +	 * is no, they should only be enabled just as the machine goes to sleep.
> +	 */
> +	if (acpi_gbl_leave_wake_gpes_disabled) {
> +		/*
> +		 * Differentiate runtime vs wake GPEs, via the _PRW control methods.
> +		 * Each GPE that has one or more _PRWs that reference it is by
> +		 * definition a wake GPE and will not be enabled while the machine
> +		 * is running.
> +		 */
> +		gpe_info.gpe_block = gpe_block;
> +		gpe_info.gpe_device = gpe_device;
> +
> +		status =
> +		    acpi_ns_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
> +					   ACPI_UINT32_MAX, ACPI_NS_WALK_UNLOCK,
> +					   acpi_ev_match_prw_and_gpe, &gpe_info,
> +					   NULL);
> +	}
> +
>  	/* Return the new block */
>  
>  	if (return_gpe_block) {
> @@ -995,27 +1016,6 @@ acpi_ev_initialize_gpe_block(struct acpi_namespace_node *gpe_device,
>  	}
>  
>  	/*
> -	 * Runtime option: Should wake GPEs be enabled at runtime?  The default
> -	 * is no, they should only be enabled just as the machine goes to sleep.
> -	 */
> -	if (acpi_gbl_leave_wake_gpes_disabled) {
> -		/*
> -		 * Differentiate runtime vs wake GPEs, via the _PRW control methods.
> -		 * Each GPE that has one or more _PRWs that reference it is by
> -		 * definition a wake GPE and will not be enabled while the machine
> -		 * is running.
> -		 */
> -		gpe_info.gpe_block = gpe_block;
> -		gpe_info.gpe_device = gpe_device;
> -
> -		status =
> -		    acpi_ns_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
> -					   ACPI_UINT32_MAX, ACPI_NS_WALK_UNLOCK,
> -					   acpi_ev_match_prw_and_gpe, &gpe_info,
> -					   NULL);
> -	}
> -
> -	/*
>  	 * Enable all GPEs in this block that have these attributes:
>  	 * 1) are "runtime" or "run/wake" GPEs, and
>  	 * 2) have a corresponding _Lxx or _Exx method
> 

