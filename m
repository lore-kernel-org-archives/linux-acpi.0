From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Wed, 5 Oct 2016 14:41:29 +0300
Message-ID: <20161005114129.GI1765@lahna.fi.intel.com>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
 <20161005092215.GA20248@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:24294 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752702AbcJELlf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 5 Oct 2016 07:41:35 -0400
Content-Disposition: inline
In-Reply-To: <20161005092215.GA20248@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-acpi@vger.kernel.org, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

On Wed, Oct 05, 2016 at 10:22:15AM +0100, Lorenzo Pieralisi wrote:
> [ +MarkR, MarkB, Rob, Al - I suspect they may want to have a say]
> 
> On Wed, Oct 05, 2016 at 01:45:33AM +0300, Sakari Ailus wrote:
> > Hello everyone,
> > 
> > I've been working awhile with my collegue Mika Westerberg to bring
> > firmware graph support to ACPI based systems. In practice the
> > functionality achieved by these patches is very similar to what the Device
> > tree provides: the port and the endpoint concept are being employed. The
> > patches make use of the _DSD property and data extensions to achieve this.
> > The fwnode interface is extended by graph functionality; this way graph
> > information originating from both OF and ACPI may be accessed using the
> > same interface.
> 
> There is an ongoing effort to avoid wholesale import of DT bindings
> into ACPI, I am not a V4L2 expert but it seems to me that with patches
> like the one you have submitted we are getting closer and closer to
> achieving it instead of avoiding it.

The whole purpose of PRP0001 ID is to allow DT bindings to be reused in
ACPI systems, so that the drivers can just call device_property_* and
get the properties regardless of the underlying firmware interface.

Are you saying that's not wanted?

> For your information, Al is working on a process to submit _DSD
> bindings and this patchset should at least be vetted within that
> context.

Of course but is it more like "use these properties for our hardware
XYZ"? I mean remote endpoints is a generic concept and not tied to a
certain hardware.

> It is an RFC and my comment is that I do not like the direction
> this ACPI->_DSD->DT is taking, I would like to understand where
> this is intended to stop because I am getting worried.

I understand that if there is already an existing native ACPI way of
doing things, that should be used. However, we do not have such thing
for remote endpoints used between camera components, and on the other
hand there is an exiting DT binding which only requires small changes to
the v4l2 framework (convert it to use fwnodes) to get the thing
supported on both DT and ACPI systems.
