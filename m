From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 5/5] ACPI: Switch to use generic guid_t in
 acpi_evaluate_dsm()
Date: Fri, 2 Jun 2017 15:25:03 +0300
Message-ID: <71db99f1-edfc-db56-d05f-515b859c893e@intel.com>
References: <20170531194152.65927-1-andriy.shevchenko@linux.intel.com>
 <20170531194152.65927-6-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:11566 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751141AbdFBMbE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 2 Jun 2017 08:31:04 -0400
In-Reply-To: <20170531194152.65927-6-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Borislav Petkov <bp@suse.de>, intel-gfx@lists.freedesktop.org
Cc: Amir Goldstein <amir73il@gmail.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Ben Skeggs <bskeggs@redhat.com>, Yisen Zhuang <yisen.zhuang@huawei.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>

On 31/05/17 22:41, Andy Shevchenko wrote:
> acpi_evaluate_dsm() and friends take a pointer to a raw buffer of 16
> bytes. Instead we convert them to use guid_t type. At the same time we
> convert current users.
> 
> acpi_str_to_uuid() becomes useless after the conversion and it's safe to
> get rid of it.
> 
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Acked-by: Joerg Roedel <jroedel@suse.de>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Yisen Zhuang <yisen.zhuang@huawei.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/acpi/acpi_extlog.c                         |  4 ++--
>  drivers/acpi/bus.c                                 | 23 ----------------------
>  drivers/acpi/nfit/core.c                           |  6 +++---
>  drivers/acpi/utils.c                               | 16 +++++++--------
>  drivers/char/tpm/tpm_crb.c                         |  9 ++++-----
>  drivers/char/tpm/tpm_ppi.c                         | 20 ++++++++-----------
>  drivers/gpu/drm/i915/intel_acpi.c                  | 14 +++++--------
>  drivers/gpu/drm/nouveau/nouveau_acpi.c             | 20 +++++++++----------
>  drivers/gpu/drm/nouveau/nvkm/subdev/mxm/base.c     |  9 ++++-----
>  drivers/hid/i2c-hid/i2c-hid.c                      |  9 ++++-----
>  drivers/iommu/dmar.c                               | 11 +++++------
>  drivers/mmc/host/sdhci-pci-core.c                  |  9 ++++-----

<SNIP>

> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 92fc3f7c538d..c942ec102c6a 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -404,10 +404,9 @@ struct intel_host {
>  	bool	d3_retune;
>  };
>  
> -const u8 intel_dsm_uuid[] = {
> -	0xA5, 0x3E, 0xC1, 0xF6, 0xCD, 0x65, 0x1F, 0x46,
> -	0xAB, 0x7A, 0x29, 0xF7, 0xE8, 0xD5, 0xBD, 0x61,
> -};
> +const guid_t intel_dsm_guid =
> +	GUID(0xF6C13EA5, 0x65CD, 0x461F,
> +	     0xAB, 0x7A, 0x29, 0xF7, 0xE8, 0xD5, 0xBD, 0x61);
>  
>  static int __intel_dsm(struct intel_host *intel_host, struct device *dev,
>  		       unsigned int fn, u32 *result)
> @@ -416,7 +415,7 @@ static int __intel_dsm(struct intel_host *intel_host, struct device *dev,
>  	int err = 0;
>  	size_t len;
>  
> -	obj = acpi_evaluate_dsm(ACPI_HANDLE(dev), intel_dsm_uuid, 0, fn, NULL);
> +	obj = acpi_evaluate_dsm(ACPI_HANDLE(dev), &intel_dsm_guid, 0, fn, NULL);
>  	if (!obj)
>  		return -EOPNOTSUPP;
>  

For sdhci:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
