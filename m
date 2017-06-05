From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 4/5] ACPI / extlog: Switch to use new generic UUID
        API
Date: Mon, 5 Jun 2017 18:06:26 +0200
Message-ID: <20170605160626.GD29981@lst.de>
References: <20170531194152.65927-1-andriy.shevchenko@linux.intel.com> <20170531194152.65927-5-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:40797 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751112AbdFEQG2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 12:06:28 -0400
Content-Disposition: inline
In-Reply-To: <20170531194152.65927-5-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, "Rafael J . Wysocki " <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Borislav Petkov <bp@suse.de>, intel-gfx@lists.freedesktop.org

> @@ -165,11 +165,11 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
>  	err_seq++;
>  	gdata = (struct acpi_hest_generic_data *)(tmp + 1);
>  	if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
> -		fru_id = (uuid_le *)gdata->fru_id;
> +		fru_id = (guid_t *)gdata->fru_id;
>  	if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
>  		fru_text = gdata->fru_text;
> -	sec_type = (uuid_le *)gdata->section_type;
> -	if (!uuid_le_cmp(*sec_type, CPER_SEC_PLATFORM_MEM)) {
> +	sec_type = (guid_t *)gdata->section_type;

>From a quick look over the tree it seems like both fru_id and
section_type should be declared as guid_t in
struct acpi_hest_generic_data.

> +	if (!guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {

The "!" seems incorrect here.
