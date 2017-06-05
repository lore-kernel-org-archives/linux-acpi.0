From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 4/5] ACPI / extlog: Switch to use new generic UUID
        API
Date: Mon, 5 Jun 2017 23:23:46 +0200
Message-ID: <20170605212346.GB3772@lst.de>
References: <20170531194152.65927-1-andriy.shevchenko@linux.intel.com> <20170531194152.65927-5-andriy.shevchenko@linux.intel.com> <20170605160626.GD29981@lst.de> <1496679785.22624.19.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:42391 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751153AbdFEVXs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 17:23:48 -0400
Content-Disposition: inline
In-Reply-To: <1496679785.22624.19.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Borislav Petkov <bp@suse.de>, intel-gfx@lists.freedesktop.org

On Mon, Jun 05, 2017 at 07:23:05PM +0300, Andy Shevchenko wrote:
> > From a quick look over the tree it seems like both fru_id and
> > section_type should be declared as guid_t in
> > struct acpi_hest_generic_data.
> 
> 
> They are arrays of 16 u8:s.

As is the guid_t.

> And since it's defined in ACPI table definition I'm not sure we can
> change it.

If we always use 16 u8s as guid_t we might as well define the structure
as such, instead of all the casts that remove type safety.
