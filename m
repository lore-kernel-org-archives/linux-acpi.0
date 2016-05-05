From: Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: Re: [PATCH v11 5/5] nfit: add sysfs dimm 'family' and 'dsm_mask'
 attributes
Date: Thu, 5 May 2016 10:25:55 -0600
Message-ID: <20160505162555.GC6808@tevye.fc.hp.com>
References: <146189774241.29835.12947278159500915461.stgit@dwillia2-desk3.amr.corp.intel.com>
 <146189776923.29835.5521802180709532725.stgit@dwillia2-desk3.amr.corp.intel.com>
Reply-To: Jerry.Hoemann@hpe.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g9t1613g.houston.hp.com ([15.240.0.71]:58690 "EHLO
	g9t1613g.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755736AbcEEQZ7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 May 2016 12:25:59 -0400
Received: from g1t5424.austin.hp.com (g1t5424.austin.hp.com [15.216.225.54])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by g9t1613g.houston.hp.com (Postfix) with ESMTPS id 9205E63F67
	for <linux-acpi@vger.kernel.org>; Thu,  5 May 2016 16:25:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <146189776923.29835.5521802180709532725.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com

On Thu, Apr 28, 2016 at 07:42:49PM -0700, Dan Williams wrote:
> Communicate the command format and suppported functions to userspace

				     ^^^^ typo


> tooling.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/acpi/nfit.c |   26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
> index 30801fe3367b..24549ba217b5 100644
> --- a/drivers/acpi/nfit.c
> +++ b/drivers/acpi/nfit.c
> @@ -897,6 +897,30 @@ static ssize_t serial_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(serial);
>  
> +static ssize_t family_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct nvdimm *nvdimm = to_nvdimm(dev);
> +	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
> +
> +	if (nfit_mem->family < 0)
> +		return -ENXIO;
> +	return sprintf(buf, "%d\n", nfit_mem->family);
> +}
> +static DEVICE_ATTR_RO(family);
> +
> +static ssize_t dsm_mask_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct nvdimm *nvdimm = to_nvdimm(dev);
> +	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
> +
> +	if (nfit_mem->family < 0)
> +		return -ENXIO;
> +	return sprintf(buf, "%#lx\n", nfit_mem->dsm_mask);
> +}
> +static DEVICE_ATTR_RO(dsm_mask);
> +
>  static ssize_t flags_show(struct device *dev,
>  		struct device_attribute *attr, char *buf)
>  {
> @@ -920,6 +944,8 @@ static struct attribute *acpi_nfit_dimm_attributes[] = {
>  	&dev_attr_serial.attr,
>  	&dev_attr_rev_id.attr,
>  	&dev_attr_flags.attr,
> +	&dev_attr_family.attr,
> +	&dev_attr_dsm_mask.attr,
>  	NULL,
>  };
>  
> 
> _______________________________________________
> Linux-nvdimm mailing list
> Linux-nvdimm@lists.01.org
> https://lists.01.org/mailman/listinfo/linux-nvdimm

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
