From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 3/4] of/property: Introduce of_fwnode_name()
Date: Tue, 6 Nov 2018 12:58:03 +0200
Message-ID: <20181106105803.GS10650@smile.fi.intel.com>
References: <20181105091727.25544-1-heikki.krogerus@linux.intel.com>
 <20181105091727.25544-4-heikki.krogerus@linux.intel.com>
 <CAL_Jsq+aRAv+9gDKwVi9xYQPYzXK4NMPjzfkuYB08+K6KTYXFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+aRAv+9gDKwVi9xYQPYzXK4NMPjzfkuYB08+K6KTYXFg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 05, 2018 at 12:50:02PM -0600, Rob Herring wrote:
> On Mon, Nov 5, 2018 at 3:17 AM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:

> > +static const char *of_fwnode_name(const struct fwnode_handle *fwnode)
> > +{
> > +       return to_of_node(fwnode)->name;
> 
> I'm trying to get rid of the DT name ptr, so please don't add one. You
> can use of_node_full_name() here instead if "<name>@<unit-address>"
> instead of <name> is fine. Otherwise, you've got to allocate your own
> storage and use "%pOFn" printf specifier.

If we do this here, we will change a behaviour of the entire set of
of_fwnode_get_named_child_node() users.

I think this is out of scope of the series.


-- 
With Best Regards,
Andy Shevchenko
