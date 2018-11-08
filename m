From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 3/4] of/property: Add of_fwnode_name()
Date: Thu, 8 Nov 2018 21:25:09 +0200
Message-ID: <20181108192509.GW10650@smile.fi.intel.com>
References: <20181108165156.60073-1-heikki.krogerus@linux.intel.com>
 <20181108165156.60073-4-heikki.krogerus@linux.intel.com>
 <CAL_Jsq+4momJb6EoXrAg2LRKzpXMFB30yhBigOiEJ16EjZ05pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+4momJb6EoXrAg2LRKzpXMFB30yhBigOiEJ16EjZ05pg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Nov 08, 2018 at 12:23:51PM -0600, Rob Herring wrote:
> On Thu, Nov 8, 2018 at 10:52 AM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > This implements get_name fwnode op for DT.
> >
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> >  drivers/of/property.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > index f46828e3b082..9bc8fe136fa3 100644
> > --- a/drivers/of/property.c
> > +++ b/drivers/of/property.c
> > @@ -823,6 +823,16 @@ static void of_fwnode_put(struct fwnode_handle *fwnode)
> >         of_node_put(to_of_node(fwnode));
> >  }
> >
> > +static int of_fwnode_get_name(const struct fwnode_handle *fwnode, char *buf)
> > +{
> > +       const char *name = kbasename(to_of_node(fwnode)->full_name);
> > +       size_t len = strchrnul(name, '@') - name;
> > +
> > +       snprintf(buf, len + 1, "%s", name);
> 
> This can be simplified to:
> 
> snprintf(..., "%pOFn", to_of_node(fwnode))
> 
> But that presents a problem with knowing the length. Not passing in
> the buf length is not good design because you can't tell if you
> overflow the buffer. Either you can pass in the length of buf or do
> the allocation here. In the latter case, then you can use kasnprintf.
> The downside to doing the allocation here is then get_name() has side
> effect of allocating memory that the caller needs to be aware of.

Agree on matter of potential overflow.

I wouldn't limit users with 32 characters for node name if it's not by both
ACPI and DT specifications. OTOH allocating and freeing memory in a loop each
time when we would like to go through the child nodes sounds much worse
scenario to me. Thus, giving a length of the buffer is a good enough compromise.

> However, I think the current API is better. It leaves low-level
> details up to the firmware implementation. But as long as .get_name()
> is not exposed to drivers I don't really care that much.

I don't think this concept is changed by Heikki's patch series. It provides a
common abstract function on top of more low-level firmware implementation which
I consider a good approach.

-- 
With Best Regards,
Andy Shevchenko
