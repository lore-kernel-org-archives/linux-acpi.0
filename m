From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v7 1/2] ACPI / bus: Introduce a list of ids for "always present" devices
Date: Fri, 21 Apr 2017 12:40:35 +0200
Message-ID: <2704999.lztfqqMbc1@aspire.rjw.lan>
References: <20170419120408.25037-1-hdegoede@redhat.com> <1789483.xWIoVTSXvK@aspire.rjw.lan> <c3b147ee-c9e4-6dd1-69b3-c30a53950a97@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:46423 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1037553AbdDUKqn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Apr 2017 06:46:43 -0400
In-Reply-To: <c3b147ee-c9e4-6dd1-69b3-c30a53950a97@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <j.w.r.degoede@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Jani Nikula <jani.nikula@linux.intel.com>, Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, Len Brown <lenb@kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, Robert Moore <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Friday, April 21, 2017 12:42:31 PM Hans de Goede wrote:
> HI,
> 

[cut]

> >>> And in that path, which I seem to have overlooked before, the
> >>> acpi_set_device_status() call is too early for invoking
> >>> acpi_device_always_present(adev), so the latter should be called
> >>> directly from acpi_add_single_object() like
> >>>
> >>>       acpi_init_device_object(device, handle, type, sta);
> >>>       if (acpi_device_always_present(adev))
> >>>           acpi_set_device_status(adev, ACPI_STA_DEFAULT);
> >>
> >> That is not necessary, the place(s) where we care about status being
> >> fixed-up for always-present devices, so that they get scanned / their
> >> platform device initiated, is in acpi_bus_attach() which
> >> already calls acpi_bus_get_status() and thus gets the
> >> acpi_device_always_present() check applied before checking.
> >>
> >> For hotplugged devices there are acpi_scan_bus_check and
> >> acpi_scan_device_check but those both also already call
> >> acpi_bus_get_status() before checking adev->status.
> > 
> > OK
> > 
> > Which probably means that we don't need to initialize adev->status
> > in acpi_init_device_object() to anything meaningful, do we?
> 
> Right, I don't think that is necessary. But maybe it is necessary
> for some special cases (e.g. power resources) ?

For power resources _STA is defined differently at all and we don't
even call acpi_add_single_object() for them. :-)

Are there any other special cases in which that may matter?

Thanks,
Rafael

