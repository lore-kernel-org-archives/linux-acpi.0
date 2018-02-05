From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 4/6] ACPI / bus: Rename acpi_get_match_data() to acpi_device_get_match_data()
Date: Mon, 05 Feb 2018 17:53:12 +0100
Message-ID: <2321755.Q8kbrBtMh0@aspire.rjw.lan>
References: <20180201202012.36524-1-andriy.shevchenko@linux.intel.com> <CAJZ5v0hssSqBDE8emBqKFQn9gXK1dBJwB4L0y=M5===YUXjTbQ@mail.gmail.com> <1517847122.22495.35.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:46453 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752722AbeBEQyw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Feb 2018 11:54:52 -0500
In-Reply-To: <1517847122.22495.35.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, dmaengine <dmaengine@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Sinan Kaya <okaya@codeaurora.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

On Monday, February 5, 2018 5:12:02 PM CET Andy Shevchenko wrote:
> On Sun, 2018-02-04 at 08:23 +0100, Rafael J. Wysocki wrote:
> > On Thu, Feb 1, 2018 at 9:20 PM, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > Do the renaming to be consistent with its sibling, i.e.
> > > of_device_get_match_data().
> > > 
> > > No functional change.
> > > 
> > > Fixes: 80212a162329 ("ACPI / bus: Introduce acpi_get_match_data()
> > > function")
> > > Fixes: 146b4dbb0eef ("ACPI: properties: Implement get_match_data()
> > > callback")
> > 
> > Why are you adding the Fixes: tags to a patch that doesn't make any
> > functional changes?
> > 
> > What are they useful for?
> 
> Because next patch depends on this one and fixes API. 
> So, here the Fixes tags to be sure that next will apply cleanly.

They may mislead people to belive that the patch needs to be backported,
so I'd rather not add them.

