From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/3] spi / ACPI: add ACPI enumeration support
Date: Thu, 8 Nov 2012 21:34:01 +0000
Message-ID: <CACxGe6sGgOKeQWSkCC1ZCpUoMmh9Lm8UANRPtCXJMwQ_XZrzDw@mail.gmail.com>
References: <1351928793-14375-1-git-send-email-mika.westerberg@linux.intel.com>
 <20121107095842.GY24532@intel.com> <CACxGe6sUXWLZVBpD1we_ZAXA7wvMg72DQpyCw5f+E8c5_ox++w@mail.gmail.com>
 <8738296.8fuPoPcrrF@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:53570 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756665Ab2KHVeX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Nov 2012 16:34:23 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so1355315dak.19
        for <linux-acpi@vger.kernel.org>; Thu, 08 Nov 2012 13:34:22 -0800 (PST)
In-Reply-To: <8738296.8fuPoPcrrF@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org, lenb@kernel.org, rafael.j.wysocki@intel.com, broonie@opensource.wolfsonmicro.com, linus.walleij@linaro.org, khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, mathias.nyman@linux.intel.com, linux-acpi@vger.kernel.org

On Thu, Nov 8, 2012 at 9:06 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Thursday, November 08, 2012 06:05:23 PM Grant Likely wrote:
>> On Wed, Nov 7, 2012 at 9:58 AM, Mika Westerberg
>> <mika.westerberg@linux.intel.com> wrote:
>> > On Tue, Nov 06, 2012 at 11:36:08PM +0100, Rafael J. Wysocki wrote:
>> >> >
>> >> > OK, but then we need to pass the information obtained from _CRS
>> >> > (presumably after some adjustments through _SRS) to drivers, or rather to
>> >> > things like the SPI core, I2C core etc. so that they can create device
>> >> > objects for drivers to bind to and quite frankly I don't see why not to use
>> >> > ACPI resources for that.
>> >>
>> >> Nevertheless, the routines for parsing those resources should belong
>> >> to the ACPI core, mostly to avoid code duplication.
>> >
>> > Rafael,
>> >
>> > So is the idea now that the ACPI core parses the resources and passes them
>> > forward via struct acpi_device?
>
> Not exactly.  The idea is to execute _CRS in the core and attach the result
> as a list of resources the struct acpi_device object representing the given
> device node.
>
>> > I'm just wondering how to proceed with these I2C and SPI enumeration patches.
>>
>> From my experience with device tree, that seems the wrong way around.
>> Device Tree used to have a separate "of_device" which is analogous to
>> an acpi_device.
>
> No, it is not.  If anything, struct acpi_device is a counterpart of struct
> device_node. :-)
>
> Yes, the name is misleading and it should be something like struct acpi_dev_node.
> Yes, these objects _are_ registered as devices with the driver model and there
> are drivers that bind to some of them.  Yes, this is a mistake, but fixing it
> will take quite some time, because it involves converting the drivers in
> question.

Okay, fair enough. I was indeed thrown off by the fact that it embeds
a struct device and there are drivers that bind against it. At least
that is the sort of thing that can be fixed over the long haul without
undue pain.

I can certainly see the advantage of having acpi nodes appear in
sysfs. Interestingly enough I'm currently playing with a patch set
that makes struct device_node  a kobject so it can do the same. It is
quite nice to get a back symlink from a struct device to a struct
device_node when the pointer is populated.

>> Plus individual drivers can call the same functions if (and only if) the
>> needed resources cannot fit into the bus type's native format.
>
> I'm kind of cautious about this particular thing.

I've seen enough cases where something doesn't quite fit into the
model provided by a subsystem and it requires the driver to go asking
for something specific. But I completely agree that caution is
absolutely required and it shouldn't be done casually.

g.
