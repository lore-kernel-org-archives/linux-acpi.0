From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 0/5] ACPI et al: convert to use new UUID API
Date: Wed, 31 May 2017 21:45:21 +0200
Message-ID: <20170531194521.GA7103@lst.de>
References: <20170531194152.65927-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:41850 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751000AbdEaTpX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 31 May 2017 15:45:23 -0400
Content-Disposition: inline
In-Reply-To: <20170531194152.65927-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, "Rafael J . Wysocki " <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Borislav Petkov <bp@suse.de>, intel-gfx@lists.freedesktop.org

On Wed, May 31, 2017 at 10:41:47PM +0300, Andy Shevchenko wrote:
> This series converts ACPI and users of acpi_evaluate_dsm() to new UUID
> API which includes new types and methods.
> 
> Patches are based on uuid tree [1] from Christoph Hellwig and supposed to
> go through it.
> 
> (Christoph, I think it would be nice to attach them to your stuff)

I'd be fine with that in general, as long as we have enough reviewers.
