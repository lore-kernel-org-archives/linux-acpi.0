Return-Path: <SRS0=pQwn=XT=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3035C432C1
	for <linux-acpi@archiver.kernel.org>; Tue, 24 Sep 2019 12:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A3EC2168B
	for <linux-acpi@archiver.kernel.org>; Tue, 24 Sep 2019 12:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbfIXMRC (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 24 Sep 2019 08:17:02 -0400
Received: from mga18.intel.com ([134.134.136.126]:31404 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbfIXMRB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 24 Sep 2019 08:17:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 05:17:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,544,1559545200"; 
   d="scan'208";a="203368825"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 24 Sep 2019 05:16:58 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iCjkW-0001ct-P5; Tue, 24 Sep 2019 15:16:56 +0300
Date:   Tue, 24 Sep 2019 15:16:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 5/5] iommu/amd: Switch to use acpi_dev_hid_uid_match()
Message-ID: <20190924121656.GV2680@smile.fi.intel.com>
References: <20190924120153.8382-1-andriy.shevchenko@linux.intel.com>
 <20190924120153.8382-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924120153.8382-5-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 24, 2019 at 03:01:53PM +0300, Andy Shevchenko wrote:
> Since we have a generic helper, drop custom implementation in the driver.

Actually we may get rid of match_hid_uid() completely and thus slightly speed
up get_acpihid_device_id().

I'll wait for other comments and then send v2.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iommu/amd_iommu.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 61de81965c44..bad1bcea4ea1 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -129,24 +129,11 @@ static inline int match_hid_uid(struct device *dev,
>  				struct acpihid_map_entry *entry)
>  {
>  	struct acpi_device *adev = ACPI_COMPANION(dev);
> -	const char *hid, *uid;
>  
>  	if (!adev)
>  		return -ENODEV;
>  
> -	hid = acpi_device_hid(adev);
> -	uid = acpi_device_uid(adev);
> -
> -	if (!hid || !(*hid))
> -		return -ENODEV;
> -
> -	if (!uid || !(*uid))
> -		return strcmp(hid, entry->hid);
> -
> -	if (!(*entry->uid))
> -		return strcmp(hid, entry->hid);
> -
> -	return (strcmp(hid, entry->hid) || strcmp(uid, entry->uid));
> +	return acpi_dev_hid_uid_match(adev, entry->hid, entry->uid) ? 0 : -ENODEV;
>  }
>  
>  static inline u16 get_pci_device_id(struct device *dev)
> -- 
> 2.23.0
> 

-- 
With Best Regards,
Andy Shevchenko


