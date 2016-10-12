From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Wed, 12 Oct 2016 14:12:30 +0300
Message-ID: <20161012111230.GX2774@lahna.fi.intel.com>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
 <20161005092215.GA20248@red-moon>
 <20161005114129.GI1765@lahna.fi.intel.com>
 <20161005150641.GA22282@red-moon>
 <20161005153229.GO1765@lahna.fi.intel.com>
 <20161011123532.GC24347@remoulade>
 <20161012090003.GR2774@lahna.fi.intel.com>
 <20161012102836.wng5g4lb5ouvc3lc@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:54974 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751171AbcJLLPj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Oct 2016 07:15:39 -0400
Content-Disposition: inline
In-Reply-To: <20161012102836.wng5g4lb5ouvc3lc@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, linux-acpi@vger.kernel.org, rafael@kernel.org, robh@kernel.org, ahs3@redhat.com

On Wed, Oct 12, 2016 at 12:28:36PM +0200, Mark Brown wrote:
> On Wed, Oct 12, 2016 at 12:00:03PM +0300, Mika Westerberg wrote:
> 
> > The _DEP method should be used for Operation Region dependencies but
> > here it is used for functional dependencies so that the audio machine
> > driver can find the corresponding codec. Why Microsoft used it like this
> > and not pushed it to ASWG to be added to the ACPI spec? Should we now
> > refuse to support it in Linux on the basis that it has not been
> > discussed with ASWG and it abuses _DEP?
> 
> The fact that the ACPI community hasn't been doing a good job of working
> together is essentially the issue that people are pushing back on here.  
> We appear to not even be trying to set a better standard for how to do
> things here.

Why using _DSD and the existing, well tested, DT properties (remote
endpoints) is not even considered making a better standard?

> Sitting externally to the group at Intel doing this it really looks like
> there's been a decision to mirror DT into ACPI en masse.

There has been no such decision as far as I can tell.

> If we really want to do that we should actually take that decision,
> preferrably with at least buy in from other ACPI users on Linux and
> with some review of existing ACPI standardization efforts to make sure
> we're not duplicating work there.  Ideally we'd also be pushing
> anything we do towards ASWG even if just as a fiat accomplait.

Agreed.

> > > By copying DT, but changing a few things, we're in effect creating a new
> > > ill-defined Linux-specific standard. If we're going to create a new standard,
> > > we should go through the ASWG, and make an actual standard. If we're not going
> > > to create a new standard, we should use DT directly, rather than trying to
> > > force DT into ACPI.
> 
> > These boards we are talking about ship with ACPI based firmware. We
> > should not expect users of those boards to be cabable of replacing the
> > existing firmware with DT one.
> 
> Since we're still at the point of defining bindings hopefully we're not
> shipping yet...

No, those systems are already out there. See Intel Joule for one example
(there are many others). You can connect your own camera sensor there.
