From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: `ucsi_acpi: probe of USBC000:00 failed with error -12` on Dell
 XPS 13 9360/9370
Date: Sat, 19 May 2018 00:28:57 +0300
Message-ID: <20180518212857.GA21732@kuha.fi.intel.com>
References: <69da4aa4-3d4b-0ffc-81ce-500713cd3743@molgen.mpg.de>
 <20180516080226.GC3536@kroah.com>
 <20180516115814.GB11469@kuha.fi.intel.com>
 <df6610738db046e9bd1db77d4346cfc3@ausx13mpc120.AMER.DELL.COM>
 <20180517085930.GD11469@kuha.fi.intel.com>
 <40707f34-e0a6-3114-36a3-6603bdcd8d82@molgen.mpg.de>
 <20180518104000.GA13595@kuha.fi.intel.com>
 <20180518150823.GA14756@kuha.fi.intel.com>
 <20180518151543.GA6501@kroah.com>
 <CAJZ5v0hbpgvvmvCvxEVGed8VcOXoO1TTEXK9zsXxCGP4wLqrZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hbpgvvmvCvxEVGed8VcOXoO1TTEXK9zsXxCGP4wLqrZA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Paul Menzel <pmenzel+linux-usb@molgen.mpg.de>, Mario Limonciello <mario.limonciello@dell.com>, "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" <linux-usb@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thorsten Leemhuis <linux@leemhuis.info>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, May 18, 2018 at 10:04:02PM +0200, Rafael J. Wysocki wrote:
> On Fri, May 18, 2018 at 5:15 PM, Greg Kroah-Hartman
> > Given that Windows works with this same set of ACPI tables, perhaps the
> > requirement isn't that this memory location be uncached?
> >
> > We shouldn't have to fix up ACPI tables just for Linux, we've been down
> > that path before :(
> 
> Yes, pretty much.

That's not what I'm suggesting. AFAIK these Dell laptops are the only
ones with this problem, so if we accept this, I fear it means we have
to start maintaining DMI quirk table in the driver, and then:

if (dell)
        ioremap_cache()
else
        ioremap_nocache()

I was really hoping we could avoid that. Or is there something else we
can do in the driver?

I have no idea how the windows driver works, so I will double check
and test this next week, but our driver has really worked fine so far.


Thanks,

-- 
heikki
