From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 3/4] ACPI/ARM: Add ACPI to AMBA SPI driver
Date: Tue, 12 Nov 2013 21:14:45 +0200
Message-ID: <20131112191445.GY22916@intel.com>
References: <1384190170-8707-1-git-send-email-brandon.anderson@amd.com>
 <1384190170-8707-4-git-send-email-brandon.anderson@amd.com>
 <20131112104321.GQ22916@intel.com>
 <CE40542A5D952D47989966E71788B1840157C119@satlexdag05.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:40288 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756419Ab3KLTJS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Nov 2013 14:09:18 -0500
Content-Disposition: inline
In-Reply-To: <CE40542A5D952D47989966E71788B1840157C119@satlexdag05.amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Anderson, Brandon" <Brandon.Anderson@amd.com>
Cc: "ssg.sos.patches" <ssg.sos.patches@amd.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, Nov 12, 2013 at 05:26:39PM +0000, Anderson, Brandon wrote:
> 
> 
> -----Original Message-----
> From: Mika Westerberg [mailto:mika.westerberg@linux.intel.com] 
> Sent: Tuesday, November 12, 2013 4:43 AM
> To: Anderson, Brandon
> Cc: ssg.sos.patches; linaro-acpi@lists.linaro.org; linux-acpi@vger.kernel.org
> Subject: Re: [PATCH 3/4] ACPI/ARM: Add ACPI to AMBA SPI driver
> 
> On Mon, Nov 11, 2013 at 11:16:09AM -0600, Brandon Anderson wrote:
> > +#ifdef CONFIG_ACPI
> > +static struct pl022_ssp_controller *
> > +acpi_pl022_get_platform_data(struct device *dev) {
> > +	struct pl022_ssp_controller *pd, *ret;
> > +	struct acpi_amba_dsm_entry entry;
> > +
> > +	pd = devm_kzalloc(dev, sizeof(struct pl022_ssp_controller), GFP_KERNEL);
> > +	if (!pd) {
> > +		dev_err(dev, "cannot allocate platform data memory\n");
> > +		return NULL;
> > +	}
> > +	ret = pd;
> > +
> > +	pd->bus_id = -1;
> > +	pd->enable_dma = 1;
> > +	if (acpi_amba_dsm_lookup(ACPI_HANDLE(dev), "num-cs", 0, &entry) == 0) {
> > +		if (kstrtou8(entry.value, 0, &pd->num_chipselect) != 0) {
> > +			dev_err(dev, "invalid 'num-cs' in ACPI definition\n");
> > +			ret = NULL;
> > +		}
> > +		kfree(entry.key);
> > +		kfree(entry.value);
> > +	}
> > +	if (acpi_amba_dsm_lookup(ACPI_HANDLE(dev),
> > +			"autosuspend-delay", 0, &entry) == 0) {
> > +		if (kstrtoint(entry.value, 0, &pd->autosuspend_delay) != 0) {
> > +			dev_err(dev, "invalid 'autosuspend-delay' in ACPI definition\n");
> > +			ret = NULL;
> > +		}
> > +		kfree(entry.key);
> > +		kfree(entry.value);
> > +	}
> > +	if (acpi_amba_dsm_lookup(ACPI_HANDLE(dev), "rt", 0, &entry) == 0) {
> > +		pd->rt = (entry.value && strcmp(entry.value, "1") == 0);
> > +		kfree(entry.key);
> > +		kfree(entry.value);
> > +	}
> > +
> > +	return ret;
> > +}
> > +#endif
> 
> If you add dummy stub acpi_pl022_get_platform_data() here in case of !CONFIG_ACPI...
> 
> > +
> >  static int pl022_probe(struct amba_device *adev, const struct amba_id 
> > *id)  {
> >  	struct device *dev = &adev->dev;
> > @@ -2081,6 +2125,11 @@ static int pl022_probe(struct amba_device 
> > *adev, const struct amba_id *id)
> >  
> >  	dev_info(&adev->dev,
> >  		 "ARM PL022 driver, device ID: 0x%08x\n", adev->periphid);
> > +#ifdef CONFIG_ACPI
> 
> You don't need this ugly #ifdef here.
> 
> 
> Ok, I understand the alternative. Is one way or the other required for
> patch acceptance?

I guess it is up to the maintainer to decide in the end.

> 
> 
> > +	if (!platform_info && ACPI_HANDLE(dev))
> > +		platform_info = acpi_pl022_get_platform_data(dev);
> > +	else
> > +#endif
> >  	if (!platform_info && IS_ENABLED(CONFIG_OF))
> >  		platform_info = pl022_platform_data_dt_get(dev);
> 
