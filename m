From: Aishwarya Pant <aishpant@gmail.com>
Subject: Re: [PATCH 1/2] acpi/dptf: document sysfs atttributes
Date: Fri, 9 Feb 2018 16:24:25 +0530
Message-ID: <20180209105425.GA24487@mordor.localdomain>
References: <cover.1518009225.git.aishpant@gmail.com>
 <01eb929d8dbfa3e2041d33619a7d30a6b0f4748c.1518009225.git.aishpant@gmail.com>
 <CAJZ5v0i5=EdmR_6Kcg=r5XUBtt8yaQX_yHt_qRfZLU-q85gkBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:34295 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750878AbeBIKyf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Feb 2018 05:54:35 -0500
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i5=EdmR_6Kcg=r5XUBtt8yaQX_yHt_qRfZLU-q85gkBQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>, Julia Lawall <julia.lawall@lip6.fr>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Fri, Feb 09, 2018 at 11:31:35AM +0100, Rafael J. Wysocki wrote:
> On Wed, Feb 7, 2018 at 2:18 PM, Aishwarya Pant <aishpant@gmail.com> wrote:
> > The descriptions have been collected from git commit logs and reading
> > through code.
> >
> > Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
> > ---
> >  Documentation/ABI/testing/sysfs-platform-dptf | 30 +++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-platform-dptf
> >
> > diff --git a/Documentation/ABI/testing/sysfs-platform-dptf b/Documentation/ABI/testing/sysfs-platform-dptf
> > new file mode 100644
> > index 000000000000..e8168e5198d7
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-platform-dptf
> > @@ -0,0 +1,30 @@
> > +sysfs interface for ACPI DPTF platform power driver
> > +---------------------------------------------------
> 
> The header isn't necessary.
> 
> > +
> > +What:          /sys/bus/platform/devices/INT3407:00/dptf_power/charger_type
> > +What:          /sys/bus/platform/devices/INT3407:00/dptf_power/adapter_rating_mw
> > +What:          /sys/bus/platform/devices/INT3407:00/dptf_power/max_platform_power_mw
> > +What:          /sys/bus/platform/devices/INT3407:00/dptf_power/platform_power_source
> > +What:          /sys/bus/platform/devices/INT3407:00/dptf_power/battery_steady_power
> 
> There should be one entry per attribute AFAICS.

I grouped attributes by the date in which they were added for brevity, because
otherwise fields like Date added, KernelVersion and Contact information are the
same.

I can split them up if it makes more sense...

Aishwarya

> 
> Also I need Srinivas to tell me whether or not the descriptions are
> accurate enough.
> 
> > +Date:          Jul, 2016
> > +KernelVersion: v4.10
> > +Contact:       linux-acpi@vger.kernel.org
> > +Description:
> > +               charger_type:           (RO) The charger type- Traditional,
> > +                                       Hybrid or NVDC.
> > +
> > +               adapter_rating_mw:      (RO) Adapter rating in milliwatts (the
> > +                                       maximum Adapter power). Must be 0 if no
> > +                                       AC Adaptor is plugged in.
> > +
> > +               max_platform_power_mw:  (RO) Maximum platform power that can be
> > +                                       supported by the battery in milliwatts.
> > +
> > +               platform_power_source:  (RO) Display the platform power source
> > +                                       0x00 = DC
> > +                                       0x01 = AC
> > +                                       0x02 = USB
> > +                                       0x03 = Wireless Charger
> > +
> > +               battery_steady_power_mw:(RO) The maximum sustained power for
> > +                                       battery in milliwatts.
> > --
