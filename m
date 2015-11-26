From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] wmi: Set wmi devices' parents
Date: Fri, 27 Nov 2015 00:22:49 +0100
Message-ID: <5696452.v4IW8cBceG@vostro.rjw.lan>
References: <7c58f0a208e0c903008989aec457230e5e58608e.1448306649.git.luto@kernel.org> <18585447.G9NSpqgJyj@vostro.rjw.lan> <CALCETrVf1kpGhY_2GtkVd9kWhs6MqcbyEL0jUja_y0YA9wXY2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <CALCETrVf1kpGhY_2GtkVd9kWhs6MqcbyEL0jUja_y0YA9wXY2A@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Darren Hart <dvhart@infradead.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Lutomirski <luto@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thursday, November 26, 2015 07:53:20 AM Andy Lutomirski wrote:
> On Thu, Nov 26, 2015 at 6:09 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Wednesday, November 25, 2015 05:28:54 PM Andy Lutomirski wrote:
> >> On Mon, Nov 23, 2015 at 11:37 AM, Darren Hart <dvhart@infradead.org> wrote:
> >> > On Mon, Nov 23, 2015 at 11:25:30AM -0800, Andy Lutomirski wrote:
> >> >> Without this patch, wmi devices are in /sys/virtual/wmi.  They're
> >> >> logically children of the ACPI WMI device, so slot them into the
> >> >> device hierarchy.  With this change, on my laptop, they end up in
> >> >> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C14:00/wmi and
> >> >> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C14:01/wmi.
> >> >>
> >> >> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> >> >
> >> > I'd like to hear from some of the main contributors to this driver:
> >> >
> >> > Matthew?
> >> > Carlos?
> >> > Len?
> >> >
> >> > Any cocnerns on this change?
> >> >
> >> > My initial concern is about changign how we expose this to userspace, but I
> >> > believe where it appears in the /sys/devices FS is NOT part of the
> >> > kernel-userspace interface commitment (per sysfs-rules.txt).
> >>
> >>
> >> Let's drop this, actually.  I have mostly-working patches to make wmi
> >> into an actual bus driver, and this intermediate step seems like it'll
> >> just confuse people.
> >>
> >> Question, though: where do the WMI devices belong?  Multiple choice:
> >>
> >> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C14:01/[GUID]
> >>
> >> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C14:01/wmi/[GUID]
> >>
> >> /sys/devices/platform/PNP0C14:01/[GUID]
> >>
> >> /sys/devices/platform/PNP0C14:01/wmi/[GUID]
> >>
> >> Currently I've implemented the first one because it's the smallest diff.
> >
> > That probably is not the right choice, though.
> >
> > ACPI "devices" are counterparts of DT device nodes and having other things
> > exported under them would be quite confusing.  In fact, you can argue that
> > the whole /sys/devices/LNXSYSTM:00/ directory should be located under
> > /sys/firmware/acpi, but it turns out to be difficult to move it there
> > for various reasons.
> >
> > Personally, I'd go for the last one.
> 
> Mechanically, how do I do that?  Should I register as just a platform
> driver and use acpi_device_install_notify_handler to get the ACPI
> notifications, or should I register as *both* a platform driver and
> ACPI driver?

If you have a platform device for this thing, registering an ACPI driver for it
is pretty much as valid as registering a driver for a DT device node.

So yes, a platform driver is a way to go here IMO.

Thanks,
Rafael
