From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 2/5] ACPI / APEI: Switch to use new generic UUID API
Date: Mon, 5 Jun 2017 18:01:51 +0200
Message-ID: <20170605160151.GB29981@lst.de>
References: <20170531194152.65927-1-andriy.shevchenko@linux.intel.com> <20170531194152.65927-3-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:40776 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751170AbdFEQBw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 12:01:52 -0400
Content-Disposition: inline
In-Reply-To: <20170531194152.65927-3-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, "Rafael J . Wysocki " <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Borislav Petkov <bp@suse.de>, intel-gfx@lists.freedesktop.org

> -		if (!uuid_le_cmp(*(uuid_le *)gdata->section_type,
> -				 CPER_SEC_PLATFORM_MEM)) {
> +		if (!guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {

The "!" here seems incorrect.

>  #ifdef CONFIG_ACPI_APEI_PCIEAER
> -		else if (!uuid_le_cmp(*(uuid_le *)gdata->section_type,
> -				      CPER_SEC_PCIE)) {
> +		else if (!guid_equal(sec_type, &CPER_SEC_PCIE)) {

Same here.
