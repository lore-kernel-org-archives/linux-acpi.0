From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Wed, 5 Oct 2016 16:06:41 +0100
Message-ID: <20161005150641.GA22282@red-moon>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
 <20161005092215.GA20248@red-moon>
 <20161005114129.GI1765@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:43126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752476AbcJEPG1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 5 Oct 2016 11:06:27 -0400
Content-Disposition: inline
In-Reply-To: <20161005114129.GI1765@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-acpi@vger.kernel.org, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

On Wed, Oct 05, 2016 at 02:41:29PM +0300, Mika Westerberg wrote:
> On Wed, Oct 05, 2016 at 10:22:15AM +0100, Lorenzo Pieralisi wrote:
> > [ +MarkR, MarkB, Rob, Al - I suspect they may want to have a say]
> > 
> > On Wed, Oct 05, 2016 at 01:45:33AM +0300, Sakari Ailus wrote:
> > > Hello everyone,
> > > 
> > > I've been working awhile with my collegue Mika Westerberg to bring
> > > firmware graph support to ACPI based systems. In practice the
> > > functionality achieved by these patches is very similar to what the Device
> > > tree provides: the port and the endpoint concept are being employed. The
> > > patches make use of the _DSD property and data extensions to achieve this.
> > > The fwnode interface is extended by graph functionality; this way graph
> > > information originating from both OF and ACPI may be accessed using the
> > > same interface.
> > 
> > There is an ongoing effort to avoid wholesale import of DT bindings
> > into ACPI, I am not a V4L2 expert but it seems to me that with patches
> > like the one you have submitted we are getting closer and closer to
> > achieving it instead of avoiding it.
> 
> The whole purpose of PRP0001 ID is to allow DT bindings to be reused in
> ACPI systems, so that the drivers can just call device_property_* and
> get the properties regardless of the underlying firmware interface.
> 
> Are you saying that's not wanted?

Not wholesale DT bindings import into ACPI, just no way.

> > For your information, Al is working on a process to submit _DSD
> > bindings and this patchset should at least be vetted within that
> > context.
> 
> Of course but is it more like "use these properties for our hardware
> XYZ"? I mean remote endpoints is a generic concept and not tied to a
> certain hardware.
> 
> > It is an RFC and my comment is that I do not like the direction
> > this ACPI->_DSD->DT is taking, I would like to understand where
> > this is intended to stop because I am getting worried.
> 
> I understand that if there is already an existing native ACPI way of
> doing things, that should be used. However, we do not have such thing
> for remote endpoints used between camera components, and on the other
> hand there is an exiting DT binding which only requires small changes to
> the v4l2 framework (convert it to use fwnodes) to get the thing
> supported on both DT and ACPI systems.

FWIW I had a quick look at dts bindings with "compatible = nokia,smia"
and related kernel driver.

Those nodes require properties like clocks and power supplies, it
seems to me that there are already ACPI PM methods to control those
properties and therefore they should not be handled with PRP0001,
I am happy to be corrected if I am wrong.

When you start matching whole subsystem through PRP0001 and related
compatible strings you can end up in a situation where DT and ACPI
FW handling clash and that's why we were opposed to mixing them from
the beginning, in ARM world if we need a DT we boot with a devicetree.

If PRP0001 is used for leaf-nodes drivers properties it may work,
everything else, frankly, is a bit of a gamble you are taking.

At least you should CC devicetree mailing lists and reach out to a
wider audience than linux-acpi, you will get the comments you are
requesting then.

Thanks,
Lorenzo
