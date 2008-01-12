From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: Fix acpi_pm_device_sleep_state()
Date: Sat, 12 Jan 2008 18:24:31 -0500
Message-ID: <200801121824.31193.lenb@kernel.org>
References: <200801110010.38658.rjw@sisk.pl> <200801112346.04744.lenb@kernel.org> <200801121236.52430.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51229 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750860AbYALXZE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 Jan 2008 18:25:04 -0500
In-Reply-To: <200801121236.52430.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>


> > BTW.  We currently don't use *d_min_p
> > and I can't imagine when and why we ever would,
> > so it would be fine with me if you simplify by deleting it.
> 
> It was requested by someone.  I can imagine that if _SxW > _SxD, a driver can
> decide which state to choose on the basis of some policy we don't know of.

I think that for the S3 and S4 states, we'll always use the deepest
state that the constraints allow while not breaking system wake.

I haven't thought much about "device wake" -- ie _PRW in S0.
Maybe some non-trivial device specific policy would be useful there
some day.  Of course the device would have to know the relative latency
of the different D-states for such a policy to make a useful.
And I guess they can infer that Dx state latency on a class basis...

-Len

> > Also, the last line of this block comment can be deleted,
> > though that was true before this patch also:
> 
> Not sure what you mean here ...
>  
> > acpi_pci_choose_state() block comment can now be updated to delete this line:
> > 
> > * currently we simply return _SxD, if present.
> 
> Yes, I'll do that in a separate patch.
> 
> Thanks,
> Rafael
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
