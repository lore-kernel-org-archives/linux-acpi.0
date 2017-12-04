From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / LPSS: Add device link for CHT SD card dependency on I2C
Date: Mon, 04 Dec 2017 16:00:43 +0100
Message-ID: <2244973.KDCVUlUVYl@aspire.rjw.lan>
References: <1512390731-11171-1-git-send-email-adrian.hunter@intel.com> <626a88b4-cf71-fd94-d78f-3947bfc5f024@redhat.com> <ea27da62-aa15-24ed-d35f-73ca9a5f40b8@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:44977 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752163AbdLDPBQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Dec 2017 10:01:16 -0500
In-Reply-To: <ea27da62-aa15-24ed-d35f-73ca9a5f40b8@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Carlo Caione <carlo@endlessm.com>

On Monday, December 4, 2017 3:41:45 PM CET Adrian Hunter wrote:
> On 04/12/17 16:33, Hans de Goede wrote:
> > Hi,
> > 
> > On 04-12-17 15:30, Adrian Hunter wrote:
> >> On 04/12/17 15:48, Hans de Goede wrote:
> >>> Hi,
> >>>
> >>> Wouldn't it be easier to use the ACPI _DEP tracking for this, e.g.
> >>
> >> It is using _DEP, see acpi_lpss_dep()
> >>
> >>> add something like this to the the probe function:
> >>>
> >>>      struct acpi_device = ACPI_COMPANION(device);
> >>>
> >>>      if (acpi_device->dep_unmet)
> >>>          return -EPROBE_DEFER;
> >>>
> >>> No idea if this will work, but if it does work, using the deps described
> >>> in the ACPI tables seems like a better solution then hardcoding this.
> >>
> >> That would not work because there are other devices listed in the _DEP
> >> method so dep_unmet is always true.  So we are left checking _DEP but only
> >> for specific device dependencies.
> > 
> > Ugh, understood thank you for explaining this. Perhaps it is a good idea
> > to mention in the commit message why acpi_dev->dep_unmet cannot be used
> > here?
> 
> dep_unmet predates device links, but now we have device links, they are
> better anyway.

Right (they cover PM too, for example), but it would be good to note why
it is necessary to hardcode the links information in the code.

Thanks,
Rafael

