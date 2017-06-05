From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 1/5] acpi, nfit: Switch to use new generic UUID API
Date: Mon, 5 Jun 2017 18:01:02 +0200
Message-ID: <20170605160102.GA29981@lst.de>
References: <20170531194152.65927-1-andriy.shevchenko@linux.intel.com> <20170531194152.65927-2-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:40756 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751238AbdFEQBE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 12:01:04 -0400
Content-Disposition: inline
In-Reply-To: <20170531194152.65927-2-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, "Rafael J . Wysocki " <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Borislav Petkov <bp@suse.de>, intel-gfx@lists.freedesktop.org

>  	for (i = 0; i < NFIT_UUID_MAX; i++)
> -		if (memcmp(to_nfit_uuid(i), spa->range_guid, 16) == 0)
> +		if (!guid_equal(to_nfit_uuid(i), (guid_t *)&spa->range_guid))
>  			return i;

I think this should be guid_equal without the "!"
