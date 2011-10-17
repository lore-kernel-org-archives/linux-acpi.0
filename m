From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFH] Power Management mini-summit during the Kernel Summit 2011
Date: Tue, 18 Oct 2011 00:06:32 +0200
Message-ID: <201110180006.32877.rjw@sisk.pl>
References: <201110122211.21638.rjw@sisk.pl> <201110161642.14109.rjw@sisk.pl> <CACxGe6ttS-f2ugNE-GJFox3TiKjz7f63j=BSMjJ_cKaH6QF7Mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:46788 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752486Ab1JQWEK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Oct 2011 18:04:10 -0400
In-Reply-To: <CACxGe6ttS-f2ugNE-GJFox3TiKjz7f63j=BSMjJ_cKaH6QF7Mg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Greg KH <gregkh@suse.de>, Linux PM list <linux-pm@vger.kernel.org>, Daniel Drake <dsd@laptop.org>, mark gross <markgross@thegnar.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, "Len Brown (Intel)" <len.brown@intel.com>, Magnus Damm <magnus.damm@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Arjan van de Ven <arjan@infradead.org>, Tejun Heo <tj@kernel.org>, jean.pihet@newoldbits.com, Kevin Hilman <khilman@ti.com>, ming.lei@canonical.com, Mark Brown <broonie@sirena.org.uk>, John Stultz <john.stultz@linaro.org>, Chris Ball <cjb@laptop.org>

On Monday, October 17, 2011, Grant Likely wrote:
> On Sun, Oct 16, 2011 at 8:42 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Sunday, October 16, 2011, Grant Likely wrote:
> >> Send me this list of topics that you have.  Some of them are relevant
> >> to the ARM community, and we can fit them into the ARM workshop which
> >> your are more than welcome to attend.
> >
> > My topics are, more or less:
> >
> > - Handling off-the-tree dependencies of devices.
> > - Per-device PM QoS (most importantly, how it is supposed to interact with user
> >  space).
> > - Universal platform drivers idea (common bus type for ACPI, PNP and "platform"
> >  devices).
> > - Suspend vs wakeup events.
> 
> Okay, I think these are interesting and I've added them to the list.
> I'm hoping to meet with Nicolas and Arnd tomorrow to hammer out the
> schedule for Sunday.  You'll be able to find it here[1] when it is
> complete.
> 
> [1] http://elinux.org/Events/Kernel_Summit_2011_ARM_Subarch_Maintainership_Workshop
> 
> Also, since the topic was mentioned, I'd like to take this oportunity
> to jot down my thoughts about the universal platform drivers topic.  I
> was talking to Matthew Garret about this exact thing in Vancouver when
> we were comparing the ACPI and FDT implementations in the kernel, and
> I was noticing that they use a very similar data model.  However,
> about a year ago the FDT-specific bus type was eliminated and we moved
> to the model where an FDT node pointer can be attached to any struct
> device; regardless of bus_type.  It turned out to make a great deal of
> sense because nodes in the device tree could be any kind of device;
> i2c, spi, platform, usb, pci, etc.  With this model, there doesn't
> need to be a different driver for each data source (static
> registration, or FDT, or whatever).  A single platform_driver (or
> i2c_driver, or spi_driver) could handle all data sources. I think it
> is a very useful model to treat data provided by firmware as
> supplemental data that can either create or be attached to any device
> in the system, but does not have a 1:1 mapping from the firmware
> structure to the Linux internal device hierarchy.
> 
> Also, since there are strong similarities between the ACPI and FDT
> models, I'd like to investigate sharing core infrastructure code
> between the subsystems.  From the quick look that Matthew and I had, I
> think it is certainly possible.

I agree and that's why I'd like to discuss those things.

Thanks,
Rafael
