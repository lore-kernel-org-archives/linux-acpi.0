From: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 01/19] ACPI: Clear GPE before disabling it
Date: Fri, 22 Dec 2006 20:16:34 -0800
Message-ID: <20061222201634.da221536.akpm@osdl.org>
References: <200612192056.kBJKu9BE010008@shell0.pdx.osdl.net>
	<200612222115.50505.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:38750 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752513AbWLWERO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Dec 2006 23:17:14 -0500
In-Reply-To: <200612222115.50505.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, william.morrow@amd.com, jordan.crouse@amd.com, luming.yu@intel.com, robert.moore@intel.com

On Fri, 22 Dec 2006 21:15:50 -0500
Len Brown <lenb@kernel.org> wrote:

> NAK
> 
> Per previous discussions, I continue to have no plans to apply this patch as it stands,
> and am awaiting reply from the author if the latest ACPICA code
> works properly on their machine without this patch.
> 

Well I'm fed up with maintaining the thing in the presence of continuous
underlying churn and apparent non-communication from involved parties, so
I'll drop it.


> 
> On Tuesday 19 December 2006 15:56, akpm@osdl.org wrote:
> > From: William Morrow <william.morrow@amd.com>
> > 
> > On some BIOSen, the GPE bit will remain set even if it is disabled,
> > resulting in a interrupt storm.  This patch clears the bit before disabling
> > it.
> > 
> > Signed-off-by: William Morrow <william.morrow@amd.com>
> > Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
> > Cc: "Yu, Luming" <luming.yu@intel.com>
> > Cc: "Brown, Len" <len.brown@intel.com>
> > Cc: "Moore, Robert" <robert.moore@intel.com>
> > Signed-off-by: Andrew Morton <akpm@osdl.org>
> > ---
> > 
> >  drivers/acpi/events/evgpe.c |   14 +++++++++++++-
> >  1 files changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff -puN drivers/acpi/events/evgpe.c~acpi-clear-gpe-before-disabling-it drivers/acpi/events/evgpe.c
> > --- a/drivers/acpi/events/evgpe.c~acpi-clear-gpe-before-disabling-it
> > +++ a/drivers/acpi/events/evgpe.c
> > @@ -677,10 +677,22 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_eve
> >  	case ACPI_GPE_DISPATCH_METHOD:
> >  
> >  		/*
> > -		 * Disable GPE, so it doesn't keep firing before the method has a
> > +		 * Clear GPE, so it doesn't keep firing before the method has a
> >  		 * chance to run.
> >  		 */
> > +		status = acpi_hw_clear_gpe(gpe_event_info);
> > +		if (ACPI_FAILURE(status)) {
> > +			ACPI_EXCEPTION((AE_INFO, status,
> > +					"Unable to clear GPE[%2X]",
> > +					gpe_number));
> > +			return_UINT32(ACPI_INTERRUPT_NOT_HANDLED);
> > +		}
> > +		/*
> > +		 * Disable GPE, so it doesn't keep happen again.
> > +		 */
> > +
> >  		status = acpi_ev_disable_gpe(gpe_event_info);
> > +
> >  		if (ACPI_FAILURE(status)) {
> >  			ACPI_EXCEPTION((AE_INFO, status,
> >  					"Unable to disable GPE[%2X]",
> > _
> > 
