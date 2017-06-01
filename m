From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 5/5] ACPI: Switch to use generic guid_t in
        acpi_evaluate_dsm()
Date: Thu, 1 Jun 2017 08:03:35 +0200
Message-ID: <20170601060335.GA16248@lst.de>
References: <20170531194152.65927-1-andriy.shevchenko@linux.intel.com> <20170531194152.65927-6-andriy.shevchenko@linux.intel.com> <1607580.J10jKUyf1a@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:44220 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750848AbdFAGDh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 1 Jun 2017 02:03:37 -0400
Content-Disposition: inline
In-Reply-To: <1607580.J10jKUyf1a@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Borislav Petkov <bp@suse.de>, intel-gfx@lists.freedesktop.org, Amir Goldstein <amir73il@gmail.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Ben Skeggs <bskeggs@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Yisen Zhuang <yisen.zhuang@huawei.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>

On Thu, Jun 01, 2017 at 12:42:30AM +0200, Rafael J. Wysocki wrote:
> On Wednesday, May 31, 2017 10:41:52 PM Andy Shevchenko wrote:
> > acpi_evaluate_dsm() and friends take a pointer to a raw buffer of 16
> > bytes. Instead we convert them to use guid_t type. At the same time we
> > convert current users.
> > 
> > acpi_str_to_uuid() becomes useless after the conversion and it's safe to
> > get rid of it.
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> with one caveat.
> 
> I have a pending patch that will use acpi_evaluate_dsm(), so I'd like this to
> be made available in an immutable branch once applied.

I hope to make the current uuid-types branch immutable soon, I just
want to collect a few more reviews.
