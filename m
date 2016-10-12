From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Wed, 12 Oct 2016 12:00:03 +0300
Message-ID: <20161012090003.GR2774@lahna.fi.intel.com>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
 <20161005092215.GA20248@red-moon>
 <20161005114129.GI1765@lahna.fi.intel.com>
 <20161005150641.GA22282@red-moon>
 <20161005153229.GO1765@lahna.fi.intel.com>
 <20161011123532.GC24347@remoulade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:48121 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932105AbcJLJGj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Oct 2016 05:06:39 -0400
Content-Disposition: inline
In-Reply-To: <20161011123532.GC24347@remoulade>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, linux-acpi@vger.kernel.org, rafael@kernel.org, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

On Tue, Oct 11, 2016 at 01:35:32PM +0100, Mark Rutland wrote:
> On Wed, Oct 05, 2016 at 06:32:29PM +0300, Mika Westerberg wrote:
> > On Wed, Oct 05, 2016 at 04:06:41PM +0100, Lorenzo Pieralisi wrote:
> > > On Wed, Oct 05, 2016 at 02:41:29PM +0300, Mika Westerberg wrote:
> > > > On Wed, Oct 05, 2016 at 10:22:15AM +0100, Lorenzo Pieralisi wrote:
> > > > > On Wed, Oct 05, 2016 at 01:45:33AM +0300, Sakari Ailus wrote:
> > > > The whole purpose of PRP0001 ID is to allow DT bindings to be reused in
> > > > ACPI systems, so that the drivers can just call device_property_* and
> > > > get the properties regardless of the underlying firmware interface.
> > > > 
> > > > Are you saying that's not wanted?
> > > 
> > > Not wholesale DT bindings import into ACPI, just no way.
> > 
> > Of course not all DT bindings. Only those that do not have a native ACPI
> > representation.
> 
> ... yet.
> 
> For self-contained devices, this isn't much of a concern, but inter-device
> relationships are the sort of thing ACPI *needs* to know about, and define a
> model for. By trying to bodge this into _DSD, we're making matters worse by
> both delaying the inevitable and creating a tonne of technical debt that we
> have to deal with forever.

ACPI has had references from the beginning and most probably one reason
these "inter device" relationships are not in that spec, is because
nobody thinks it is relevant to put them there. If you check any
existing ACPI tables they have lots of references between devices. Some
of the ASL code even calls methods of another device through these
refences and it is not forbidden by the spec by any means.

A good example of this is the audio machine driver the other Mark
mentioned.

Here is an example from Microsoft Surface3:

  Device (AMCR)
  {
      Name (_HID, "AMCR22A8")
      ...

      Name (_DEP, Package (0x02)  // _DEP: Dependencies
      {
          GPO2,
          ^I2C2.RTEK
      })
      ...
  }

The _DEP method should be used for Operation Region dependencies but
here it is used for functional dependencies so that the audio machine
driver can find the corresponding codec. Why Microsoft used it like this
and not pushed it to ASWG to be added to the ACPI spec? Should we now
refuse to support it in Linux on the basis that it has not been
discussed with ASWG and it abuses _DEP?

Basically _DSD here is used to add relevant names for these links so
that they are compatible with the names used by the existing drivers in
Linux (this is the part that is missing from the ACPI spec). This makes
the same drivers to work with both DT and ACPI with minor modifications.

> By copying DT, but changing a few things, we're in effect creating a new
> ill-defined Linux-specific standard. If we're going to create a new standard,
> we should go through the ASWG, and make an actual standard. If we're not going
> to create a new standard, we should use DT directly, rather than trying to
> force DT into ACPI.

These boards we are talking about ship with ACPI based firmware. We
should not expect users of those boards to be cabable of replacing the
existing firmware with DT one.
