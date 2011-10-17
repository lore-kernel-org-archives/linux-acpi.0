From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFH] Power Management mini-summit during the Kernel Summit 2011
Date: Sun, 16 Oct 2011 21:46:02 -0600
Message-ID: <CACxGe6ttS-f2ugNE-GJFox3TiKjz7f63j=BSMjJ_cKaH6QF7Mg@mail.gmail.com>
References: <201110122211.21638.rjw@sisk.pl> <201110160035.34980.rjw@sisk.pl>
 <20111016042017.GA4901@ponder.secretlab.ca> <201110161642.14109.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:60733 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754487Ab1JQDqW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 16 Oct 2011 23:46:22 -0400
In-Reply-To: <201110161642.14109.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <gregkh@suse.de>, Linux PM list <linux-pm@vger.kernel.org>, Daniel Drake <dsd@laptop.org>, mark gross <markgross@thegnar.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, "Len Brown (Intel)" <len.brown@intel.com>, Magnus Damm <magnus.damm@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Arjan van de Ven <arjan@infradead.org>, Tejun Heo <tj@kernel.org>, jean.pihet@newoldbits.com, Kevin Hilman <khilman@ti.com>, ming.lei@canonical.com, Mark Brown <broonie@sirena.org.uk>, John Stultz <john.stultz@linaro.org>, Chris Ball <cjb@laptop.org>

On Sun, Oct 16, 2011 at 8:42 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Sunday, October 16, 2011, Grant Likely wrote:
>> Send me this list of topics that you have. =A0Some of them are relev=
ant
>> to the ARM community, and we can fit them into the ARM workshop whic=
h
>> your are more than welcome to attend.
>
> My topics are, more or less:
>
> - Handling off-the-tree dependencies of devices.
> - Per-device PM QoS (most importantly, how it is supposed to interact=
 with user
> =A0space).
> - Universal platform drivers idea (common bus type for ACPI, PNP and =
"platform"
> =A0devices).
> - Suspend vs wakeup events.

Okay, I think these are interesting and I've added them to the list.
I'm hoping to meet with Nicolas and Arnd tomorrow to hammer out the
schedule for Sunday.  You'll be able to find it here[1] when it is
complete.

[1] http://elinux.org/Events/Kernel_Summit_2011_ARM_Subarch_Maintainers=
hip_Workshop

Also, since the topic was mentioned, I'd like to take this oportunity
to jot down my thoughts about the universal platform drivers topic.  I
was talking to Matthew Garret about this exact thing in Vancouver when
we were comparing the ACPI and FDT implementations in the kernel, and
I was noticing that they use a very similar data model.  However,
about a year ago the FDT-specific bus type was eliminated and we moved
to the model where an FDT node pointer can be attached to any struct
device; regardless of bus_type.  It turned out to make a great deal of
sense because nodes in the device tree could be any kind of device;
i2c, spi, platform, usb, pci, etc.  With this model, there doesn't
need to be a different driver for each data source (static
registration, or FDT, or whatever).  A single platform_driver (or
i2c_driver, or spi_driver) could handle all data sources. I think it
is a very useful model to treat data provided by firmware as
supplemental data that can either create or be attached to any device
in the system, but does not have a 1:1 mapping from the firmware
structure to the Linux internal device hierarchy.

Also, since there are strong similarities between the ACPI and FDT
models, I'd like to investigate sharing core infrastructure code
between the subsystems.  From the quick look that Matthew and I had, I
think it is certainly possible.

g.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
