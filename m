From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: disable stray gpe correctly
Date: Wed, 12 Mar 2008 16:09:45 -0400
Message-ID: <200803121609.46134.lenb@kernel.org>
References: <1205114649.10256.200.camel@acpi-hp-zz.sh.intel.com> <200803110206.45590.lenb@kernel.org> <47D8351F.7080802@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55767 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752347AbYCLUKi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Mar 2008 16:10:38 -0400
In-Reply-To: <47D8351F.7080802@redhat.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>, robert.moore@intel.com, davej@redhat.com


> > On Sunday 09 March 2008, Zhang, Rui wrote:
> >> Disable stray GPE correctly
> >> https://bugzilla.redhat.com/show_bug.cgi?id=251744
> >> http://bugzilla.kernel.org/show_bug.cgi?id=6217
> >>
> >> Sighed-off-by: Zhang Rui <rui.zhang@intel.com>
> >> ---
> >>  drivers/acpi/events/evgpe.c |    3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> Index: linux-2.6/drivers/acpi/events/evgpe.c
> >> ===================================================================
> >> --- linux-2.6.orig/drivers/acpi/events/evgpe.c
> >> +++ linux-2.6/drivers/acpi/events/evgpe.c
> >> @@ -248,7 +248,8 @@ acpi_status acpi_ev_disable_gpe(struct a
> >>  
> >>  	ACPI_FUNCTION_TRACE(ev_disable_gpe);
> >>  
> >> -	if (!(gpe_event_info->flags & ACPI_GPE_ENABLE_MASK)) {
> >> +	if (gpe_event_info->flags &&
> >> +		(!(gpe_event_info->flags & ACPI_GPE_ENABLE_MASK))) {
> >>  		return_ACPI_STATUS(AE_OK);
> >>  	}
> >>  
> 
> Causes ACPI battery problems...
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=436959

Okay, i've droppped it until 436959 can be figured out.

thanks Chuck,
-Len



