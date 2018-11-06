From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 3/4] of/property: Introduce of_fwnode_name()
Date: Tue, 6 Nov 2018 14:27:34 +0200
Message-ID: <20181106122734.GC13048@kuha.fi.intel.com>
References: <20181105091727.25544-1-heikki.krogerus@linux.intel.com>
 <20181105091727.25544-4-heikki.krogerus@linux.intel.com>
 <CAL_Jsq+aRAv+9gDKwVi9xYQPYzXK4NMPjzfkuYB08+K6KTYXFg@mail.gmail.com>
 <20181106105803.GS10650@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181106105803.GS10650@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 06, 2018 at 12:58:03PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 05, 2018 at 12:50:02PM -0600, Rob Herring wrote:
> > On Mon, Nov 5, 2018 at 3:17 AM Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> 
> > > +static const char *of_fwnode_name(const struct fwnode_handle *fwnode)
> > > +{
> > > +       return to_of_node(fwnode)->name;
> > 
> > I'm trying to get rid of the DT name ptr, so please don't add one. You
> > can use of_node_full_name() here instead if "<name>@<unit-address>"
> > instead of <name> is fine. Otherwise, you've got to allocate your own
> > storage and use "%pOFn" printf specifier.
> 
> If we do this here, we will change a behaviour of the entire set of
> of_fwnode_get_named_child_node() users.
> 
> I think this is out of scope of the series.

You have a point. We must use the same member that was used in
of_fwnode_get_named_child_node().

The goal of this series if most likely not clear from this patch
alone, so I'll send a second version and make sure to CC the DT list
and Rob.

But in any case, I'll keep this part as it is.


thanks,

-- 
heikki
