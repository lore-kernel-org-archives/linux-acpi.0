From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 3/5] ACPI / bus: Switch to use new generic UUID API
Date: Tue, 6 Jun 2017 11:58:49 +0200
Message-ID: <20170606095849.GB20590@lst.de>
References: <20170531194152.65927-1-andriy.shevchenko@linux.intel.com> <20170531194152.65927-4-andriy.shevchenko@linux.intel.com> <20170605160331.GC29981@lst.de> <1496679616.22624.16.camel@linux.intel.com> <CAJZ5v0jv_RKwiDLD_bDOxZfe_mZnaxfGkcwLaB8WvWncDvx6PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:45360 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751329AbdFFJ6v (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 6 Jun 2017 05:58:51 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jv_RKwiDLD_bDOxZfe_mZnaxfGkcwLaB8WvWncDvx6PA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Christoph Hellwig <hch@lst.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Borislav Petkov <bp@suse.de>, intel-gfx <intel-gfx@lists.freedesktop.org>

On Mon, Jun 05, 2017 at 10:37:41PM +0200, Rafael J. Wysocki wrote:
> On Mon, Jun 5, 2017 at 6:20 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, 2017-06-05 at 18:03 +0200, Christoph Hellwig wrote:
> >> > +   in_params[0].buffer.pointer     = (u8 *)&guid;
> >>
> >> Any idea why the pointer is defined as a u8 * in union acpi_object
> >> instead of a void?
> >
> > I guess this question to Rafael.
> 
> That data type is defined in upstream ACPICA and the reason why it is
> defined the way it is has something to do with history I suppose.

Ok, I'll send a patch to fix it - just about every user of the field
currently requires a cast, which is not a good thing.
