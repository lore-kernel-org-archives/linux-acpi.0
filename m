From: Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH] acpi/hmat: Update acpi_hmat_type enum with
 ACPI_HMAT_TYPE_PROXIMITY
Date: Fri, 19 Apr 2019 11:09:59 -0600
Message-ID: <20190419170958.GA9331@localhost.localdomain>
References: <20190417181310.27613-1-alison.schofield@intel.com>
 <20190418145640.GA7659@localhost.localdomain>
 <CAJZ5v0g1EZbzr6BJhVBVb8JZGnVQg2Sz8NHtz_0Ji9R_58wMbA@mail.gmail.com>
 <20190419165435.GA2284@alison-desk.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190419165435.GA2284@alison-desk.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alison Schofield <alison.schofield@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, "Schmauss, Erik" <erik.schmauss@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Apr 19, 2019 at 09:54:35AM -0700, Alison Schofield wrote:
> On Thu, Apr 18, 2019 at 05:07:12PM +0200, Rafael J. Wysocki wrote:
> > On Thu, Apr 18, 2019 at 5:02 PM Keith Busch <keith.busch@intel.com> wrote:
> > >
> > > On Wed, Apr 17, 2019 at 11:13:10AM -0700, Alison Schofield wrote:
> > > > ACPI 6.3 changed the subtable "Memory Subsystem Address Range Structure"
> > > > to "Memory Proximity Domain Attributes Structure".
> > > >
> > > > Updating and renaming of the structure was included in commit:
> > > > ACPICA: ACPI 6.3: HMAT updates (9a8d961f1ef835b0d338fbe13da03cb424e87ae5)
> > >
> > > I was not really happy with that HMAT update. Platforms implementing
> > > 6.2's HMAT continue to exist even if 6.3 isn't backward compatible. We
> > > just lost the original subtable definition.
> > 
> > Well, that's true, sadly, but the question is what to do in the kernel.
> > 
> > Definitely, the 6.3 format needs to be supported, but if the 6.2 ships
> > anywhere in practice, that will need to be supported too.
> 
> So, what's the usual practice when ACPI tables are updated?
> Do we define separate 6.2 and 6.3 versions of this subtable and let
> the kernel figure out which one its looking at?

Yeah, I think either new struct definitions for incompatible versions,
or unions for conflicting members would be good.

But I think Rafael is saying we only care if someone's shipping platform
implements a particular version. I don't happen to know which ACPI
version platforms I'm interested are going to release with, so I have
HMAT supporting either right now. The 6.3 update wasn't difficult to
handle this time.
