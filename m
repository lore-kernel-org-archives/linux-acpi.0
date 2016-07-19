From: Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: Re: [PATCH] acpi, nfit: fix acpi_check_dsm() vs zero functions
 implemented
Date: Tue, 19 Jul 2016 16:46:44 -0600
Message-ID: <20160719224644.GJ140413@tevye.fc.hp.com>
References: <146679026571.24395.11569929364936343871.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20160719171153.GA121461@tevye.fc.hp.com>
 <cfd9968d-9835-0ef1-fafd-54fd3b892d1c@hpe.com>
 <CAPcyv4gqmjMFveV+iE2NbvWnTb5kdy8w54VDgLYxeMJ5NJyzbw@mail.gmail.com>
 <CAPcyv4hbyq7MVQrTxYixo+fP7R=wV-Nt84NNfVJKrYWwUSJg=Q@mail.gmail.com>
Reply-To: Jerry.Hoemann@hpe.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g9t5008.houston.hpe.com ([15.241.48.72]:34685 "EHLO
	g9t5008.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845AbcGSWqr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Jul 2016 18:46:47 -0400
Content-Disposition: inline
In-Reply-To: <CAPcyv4hbyq7MVQrTxYixo+fP7R=wV-Nt84NNfVJKrYWwUSJg=Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linda Knippers <linda.knippers@hpe.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, Xiao Guangrong <guangrong.xiao@linux.intel.com>, Len Brown <lenb@kernel.org>, Marvin Spinhirne <spin@hpe.com>

On Tue, Jul 19, 2016 at 01:01:16PM -0700, Dan Williams wrote:
> On Tue, Jul 19, 2016 at 11:52 AM, Dan Williams <dan.j.williams@intel.com> wrote:
> > On Tue, Jul 19, 2016 at 11:50 AM, Linda Knippers <linda.knippers@hpe.com> wrote:
> >> On 7/19/2016 1:11 PM, Jerry Hoemann wrote:
> [..]
> >>> As nfit_mem->family always equals NVDIMM_FAMILY_INTEL, no subsequent
> >>> DSM call will succeed for NVDIMM_FAMILY_HPE1 or any other
> >>> family.
> >>>
> >>> I don't have a fix as of yet, but wanted to make you aware of
> >>> the problem.
> >>
> >> Could we try the all known UUIDs looking for one that returns a non-zero
> >> value?
> >>
> >
> > Yes, that seems like the way forward, and also make not finding a DSM
> > family non-fatal.
> 
> Actually, all we need is that last bit...  Jerry, Xiao, can you try
> the attached patch on top for v4.7-rc6 to see if it works in both HPe
> and QEMU 2.6 environments respectively?

Dan,

I applied this patch on top of the SLES 12 sp2 kernel I was testing
with last night.

The proposed patch below works for HPE nvdimms.

Jerry


> From 367f4468b349a9ed22fc0e6382a52c18c6775472 Mon Sep 17 00:00:00 2001
> From: Dan Williams <dan.j.williams@intel.com>
> Date: Tue, 19 Jul 2016 12:32:39 -0700
> Subject: [PATCH] nfit: make DIMM DSMs optional
> 
> Commit 4995734e973a "acpi, nfit: fix acpi_check_dsm() vs zero functions
> implemented" attempted to fix a QEMU regression by supporting its usage
> of a zero-mask as a valid response to a DSM-family probe request.
> However, this behavior breaks HP platforms that return a zero-mask by
> default causing the probe to misidentify the DSM-family.
> 
> Instead, the QEMU regression can be fixed by simply not requiring the DSM
> family to be identified.
> 
> This effectively reverts commit 4995734e973a, and removes the DSM
> requirement from the init path.
> 
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> Cc: Linda Knippers <linda.knippers@hpe.com>
> Fixes: 4995734e973a ("acpi, nfit: fix acpi_check_dsm() vs zero functions implemented")
> Reported-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/acpi/nfit.c  | 11 ++++++-----
>  drivers/acpi/utils.c |  6 +++---
>  2 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
> index ac6ddcc080d4..1f0e06065ae6 100644
> --- a/drivers/acpi/nfit.c
> +++ b/drivers/acpi/nfit.c
> @@ -1131,11 +1131,11 @@ static int acpi_nfit_add_dimm(struct acpi_nfit_desc *acpi_desc,
>  
>  	/*
>  	 * Until standardization materializes we need to consider up to 3
> -	 * different command sets.  Note, that checking for zero functions
> -	 * tells us if any commands might be reachable through this uuid.
> +	 * different command sets.  Note, that checking for function0 (bit0)
> +	 * tells us if any commands are reachable through this uuid.
>  	 */
>  	for (i = NVDIMM_FAMILY_INTEL; i <= NVDIMM_FAMILY_HPE2; i++)
> -		if (acpi_check_dsm(adev_dimm->handle, to_nfit_uuid(i), 1, 0))
> +		if (acpi_check_dsm(adev_dimm->handle, to_nfit_uuid(i), 1, 1))
>  			break;
>  
>  	/* limit the supported commands to those that are publicly documented */
> @@ -1151,9 +1151,10 @@ static int acpi_nfit_add_dimm(struct acpi_nfit_desc *acpi_desc,
>  		if (disable_vendor_specific)
>  			dsm_mask &= ~(1 << 8);
>  	} else {
> -		dev_err(dev, "unknown dimm command family\n");
> +		dev_dbg(dev, "unknown dimm command family\n");
>  		nfit_mem->family = -1;
> -		return force_enable_dimms ? 0 : -ENODEV;
> +		/* DSMs are optional, continue loading the driver... */
> +		return 0;
>  	}
>  
>  	uuid = to_nfit_uuid(nfit_mem->family);
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index b4de130f2d57..22c09952e177 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -680,6 +680,9 @@ bool acpi_check_dsm(acpi_handle handle, const u8 *uuid, u64 rev, u64 funcs)
>  	u64 mask = 0;
>  	union acpi_object *obj;
>  
> +	if (funcs == 0)
> +		return false;
> +
>  	obj = acpi_evaluate_dsm(handle, uuid, rev, 0, NULL);
>  	if (!obj)
>  		return false;
> @@ -692,9 +695,6 @@ bool acpi_check_dsm(acpi_handle handle, const u8 *uuid, u64 rev, u64 funcs)
>  			mask |= (((u64)obj->buffer.pointer[i]) << (i * 8));
>  	ACPI_FREE(obj);
>  
> -	if (funcs == 0)
> -		return true;
> -
>  	/*
>  	 * Bit 0 indicates whether there's support for any functions other than
>  	 * function 0 for the specified UUID and revision.
> -- 
> 2.5.5
> 


-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
