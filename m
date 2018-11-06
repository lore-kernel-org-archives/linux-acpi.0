From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 3/4] of/property: Introduce of_fwnode_name()
Date: Tue, 6 Nov 2018 10:45:42 +0200
Message-ID: <20181106084542.GA13048@kuha.fi.intel.com>
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
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 05, 2018 at 12:50:02PM -0600, Rob Herring wrote:
> On Mon, Nov 5, 2018 at 3:17 AM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > Instead of always being forced to read the "name" property
> > in fwnode_name() with of_nodes, implementing the fwnode
> > operation meant for getting the node name.
> >
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Cc: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/of/property.c | 6 ++++++
> 
> Please Cc the DT list for DT changes.

OK.

> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > index f46828e3b082..ac7b0b6c2d4d 100644
> > --- a/drivers/of/property.c
> > +++ b/drivers/of/property.c
> > @@ -823,6 +823,11 @@ static void of_fwnode_put(struct fwnode_handle *fwnode)
> >         of_node_put(to_of_node(fwnode));
> >  }
> >
> > +static const char *of_fwnode_name(const struct fwnode_handle *fwnode)
> > +{
> > +       return to_of_node(fwnode)->name;
> 
> I'm trying to get rid of the DT name ptr, so please don't add one. You
> can use of_node_full_name() here instead if "<name>@<unit-address>"
> instead of <name> is fine. Otherwise, you've got to allocate your own
> storage and use "%pOFn" printf specifier.

OK, I'll use of_node_full_name().

thanks,

-- 
heikki
