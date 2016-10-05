From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Wed, 5 Oct 2016 18:32:29 +0300
Message-ID: <20161005153229.GO1765@lahna.fi.intel.com>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
 <20161005092215.GA20248@red-moon>
 <20161005114129.GI1765@lahna.fi.intel.com>
 <20161005150641.GA22282@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:29477 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752512AbcJEPcj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 5 Oct 2016 11:32:39 -0400
Content-Disposition: inline
In-Reply-To: <20161005150641.GA22282@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-acpi@vger.kernel.org, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

On Wed, Oct 05, 2016 at 04:06:41PM +0100, Lorenzo Pieralisi wrote:
> On Wed, Oct 05, 2016 at 02:41:29PM +0300, Mika Westerberg wrote:
> > On Wed, Oct 05, 2016 at 10:22:15AM +0100, Lorenzo Pieralisi wrote:
> > > [ +MarkR, MarkB, Rob, Al - I suspect they may want to have a say]
> > > 
> > > On Wed, Oct 05, 2016 at 01:45:33AM +0300, Sakari Ailus wrote:
> > > > Hello everyone,
> > > > 
> > > > I've been working awhile with my collegue Mika Westerberg to bring
> > > > firmware graph support to ACPI based systems. In practice the
> > > > functionality achieved by these patches is very similar to what the Device
> > > > tree provides: the port and the endpoint concept are being employed. The
> > > > patches make use of the _DSD property and data extensions to achieve this.
> > > > The fwnode interface is extended by graph functionality; this way graph
> > > > information originating from both OF and ACPI may be accessed using the
> > > > same interface.
> > > 
> > > There is an ongoing effort to avoid wholesale import of DT bindings
> > > into ACPI, I am not a V4L2 expert but it seems to me that with patches
> > > like the one you have submitted we are getting closer and closer to
> > > achieving it instead of avoiding it.
> > 
> > The whole purpose of PRP0001 ID is to allow DT bindings to be reused in
> > ACPI systems, so that the drivers can just call device_property_* and
> > get the properties regardless of the underlying firmware interface.
> > 
> > Are you saying that's not wanted?
> 
> Not wholesale DT bindings import into ACPI, just no way.

Of course not all DT bindings. Only those that do not have a native ACPI
representation.

The PRP0001 is there so that we do not end up with drivers looking like
this:

	if (dev->of_node)
		device_property_read_xx(dev, "my-dt-property", &value);
	else if (has_acpi_handle(dev))
		device_property_read_xx(dev, "my-acpi-property", &value);
	else
		device_property_read_xx(dev, "my-builtin-property", &value)

but instead they can use the single "my-property" regardless from which
firmware interface is used.

If there exists a native ACPI representation, like a PowerResource or
GPIO, it should be used instead.

> > > For your information, Al is working on a process to submit _DSD
> > > bindings and this patchset should at least be vetted within that
> > > context.
> > 
> > Of course but is it more like "use these properties for our hardware
> > XYZ"? I mean remote endpoints is a generic concept and not tied to a
> > certain hardware.
> > 
> > > It is an RFC and my comment is that I do not like the direction
> > > this ACPI->_DSD->DT is taking, I would like to understand where
> > > this is intended to stop because I am getting worried.
> > 
> > I understand that if there is already an existing native ACPI way of
> > doing things, that should be used. However, we do not have such thing
> > for remote endpoints used between camera components, and on the other
> > hand there is an exiting DT binding which only requires small changes to
> > the v4l2 framework (convert it to use fwnodes) to get the thing
> > supported on both DT and ACPI systems.
> 
> FWIW I had a quick look at dts bindings with "compatible = nokia,smia"
> and related kernel driver.
> 
> Those nodes require properties like clocks and power supplies, it
> seems to me that there are already ACPI PM methods to control those
> properties and therefore they should not be handled with PRP0001,
> I am happy to be corrected if I am wrong.

Clocks and power supplies should be handled as native ACPI
PowerResources. We are not trying to represent those here.

> When you start matching whole subsystem through PRP0001 and related
> compatible strings you can end up in a situation where DT and ACPI
> FW handling clash and that's why we were opposed to mixing them from
> the beginning, in ARM world if we need a DT we boot with a devicetree.
> 
> If PRP0001 is used for leaf-nodes drivers properties it may work,
> everything else, frankly, is a bit of a gamble you are taking.

The hardware we are describing is exactly the same, only thing that
changes is the firmware interface. So if there is a hardware property
that cannot be discovered automatically it needs to be provided by the
firmware, like ACPI.

If it happens that the property already has an existing DT binding, why
do you think it is gambling to use it instead of inventing the same with
annother name for ACPI?
