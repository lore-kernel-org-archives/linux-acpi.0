From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/4] ACPI/ARM: Add ACPI to AMBA SPI driver
Date: Sun, 17 Nov 2013 22:42:48 +0100
Message-ID: <1912668.p3VZjfEjtH@vostro.rjw.lan>
References: <1384190170-8707-1-git-send-email-brandon.anderson@amd.com> <CE40542A5D952D47989966E71788B1840157C119@satlexdag05.amd.com> <20131112191445.GY22916@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62881 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751324Ab3KQVaN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 17 Nov 2013 16:30:13 -0500
In-Reply-To: <20131112191445.GY22916@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, "Anderson, Brandon" <Brandon.Anderson@amd.com>
Cc: "ssg.sos.patches" <ssg.sos.patches@amd.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tuesday, November 12, 2013 09:14:45 PM Mika Westerberg wrote:
> On Tue, Nov 12, 2013 at 05:26:39PM +0000, Anderson, Brandon wrote:
> > 
> > 
> > -----Original Message-----
> > From: Mika Westerberg [mailto:mika.westerberg@linux.intel.com] 
> > Sent: Tuesday, November 12, 2013 4:43 AM
> > To: Anderson, Brandon
> > Cc: ssg.sos.patches; linaro-acpi@lists.linaro.org; linux-acpi@vger.kernel.org
> > Subject: Re: [PATCH 3/4] ACPI/ARM: Add ACPI to AMBA SPI driver
> > 
> > On Mon, Nov 11, 2013 at 11:16:09AM -0600, Brandon Anderson wrote:
> > > +#ifdef CONFIG_ACPI
> > > +static struct pl022_ssp_controller *
> > > +acpi_pl022_get_platform_data(struct device *dev) {
> > > +	struct pl022_ssp_controller *pd, *ret;
> > > +	struct acpi_amba_dsm_entry entry;
> > > +
> > > +	pd = devm_kzalloc(dev, sizeof(struct pl022_ssp_controller), GFP_KERNEL);
> > > +	if (!pd) {
> > > +		dev_err(dev, "cannot allocate platform data memory\n");
> > > +		return NULL;
> > > +	}
> > > +	ret = pd;
> > > +
> > > +	pd->bus_id = -1;
> > > +	pd->enable_dma = 1;
> > > +	if (acpi_amba_dsm_lookup(ACPI_HANDLE(dev), "num-cs", 0, &entry) == 0) {
> > > +		if (kstrtou8(entry.value, 0, &pd->num_chipselect) != 0) {
> > > +			dev_err(dev, "invalid 'num-cs' in ACPI definition\n");
> > > +			ret = NULL;
> > > +		}
> > > +		kfree(entry.key);
> > > +		kfree(entry.value);
> > > +	}
> > > +	if (acpi_amba_dsm_lookup(ACPI_HANDLE(dev),
> > > +			"autosuspend-delay", 0, &entry) == 0) {
> > > +		if (kstrtoint(entry.value, 0, &pd->autosuspend_delay) != 0) {
> > > +			dev_err(dev, "invalid 'autosuspend-delay' in ACPI definition\n");
> > > +			ret = NULL;
> > > +		}
> > > +		kfree(entry.key);
> > > +		kfree(entry.value);
> > > +	}
> > > +	if (acpi_amba_dsm_lookup(ACPI_HANDLE(dev), "rt", 0, &entry) == 0) {
> > > +		pd->rt = (entry.value && strcmp(entry.value, "1") == 0);
> > > +		kfree(entry.key);
> > > +		kfree(entry.value);
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +#endif
> > 
> > If you add dummy stub acpi_pl022_get_platform_data() here in case of !CONFIG_ACPI...
> > 
> > > +
> > >  static int pl022_probe(struct amba_device *adev, const struct amba_id 
> > > *id)  {
> > >  	struct device *dev = &adev->dev;
> > > @@ -2081,6 +2125,11 @@ static int pl022_probe(struct amba_device 
> > > *adev, const struct amba_id *id)
> > >  
> > >  	dev_info(&adev->dev,
> > >  		 "ARM PL022 driver, device ID: 0x%08x\n", adev->periphid);
> > > +#ifdef CONFIG_ACPI
> > 
> > You don't need this ugly #ifdef here.
> > 
> > 
> > Ok, I understand the alternative. Is one way or the other required for
> > patch acceptance?
> 
> I guess it is up to the maintainer to decide in the end.

Well, if I were the maintainer in question, I'd ask that do be done the way
Mika suggested.

The same applies if my ACK under the patch is requisite (which I believe should
be the case here).

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
