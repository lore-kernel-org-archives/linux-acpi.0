From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Tue, 11 Oct 2016 13:35:32 +0100
Message-ID: <20161011123532.GC24347@remoulade>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
 <20161005092215.GA20248@red-moon>
 <20161005114129.GI1765@lahna.fi.intel.com>
 <20161005150641.GA22282@red-moon>
 <20161005153229.GO1765@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:32822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751672AbcJKMfi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Oct 2016 08:35:38 -0400
Content-Disposition: inline
In-Reply-To: <20161005153229.GO1765@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, linux-acpi@vger.kernel.org, rafael@kernel.org, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

On Wed, Oct 05, 2016 at 06:32:29PM +0300, Mika Westerberg wrote:
> On Wed, Oct 05, 2016 at 04:06:41PM +0100, Lorenzo Pieralisi wrote:
> > On Wed, Oct 05, 2016 at 02:41:29PM +0300, Mika Westerberg wrote:
> > > On Wed, Oct 05, 2016 at 10:22:15AM +0100, Lorenzo Pieralisi wrote:
> > > > On Wed, Oct 05, 2016 at 01:45:33AM +0300, Sakari Ailus wrote:
> > > The whole purpose of PRP0001 ID is to allow DT bindings to be reused in
> > > ACPI systems, so that the drivers can just call device_property_* and
> > > get the properties regardless of the underlying firmware interface.
> > > 
> > > Are you saying that's not wanted?
> > 
> > Not wholesale DT bindings import into ACPI, just no way.
> 
> Of course not all DT bindings. Only those that do not have a native ACPI
> representation.

... yet.

For self-contained devices, this isn't much of a concern, but inter-device
relationships are the sort of thing ACPI *needs* to know about, and define a
model for. By trying to bodge this into _DSD, we're making matters worse by
both delaying the inevitable and creating a tonne of technical debt that we
have to deal with forever.

By copying DT, but changing a few things, we're in effect creating a new
ill-defined Linux-specific standard. If we're going to create a new standard,
we should go through the ASWG, and make an actual standard. If we're not going
to create a new standard, we should use DT directly, rather than trying to
force DT into ACPI.

Thanks,
Mark.
