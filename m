From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/4] of/property: Add of_fwnode_name()
Date: Thu, 8 Nov 2018 15:18:21 -0600
Message-ID: <CAL_JsqLMuiUc8FW=X_OAd5P_tcfPSTOox9Vh6faEwK+Z=S2mjw@mail.gmail.com>
References: <20181108165156.60073-1-heikki.krogerus@linux.intel.com>
 <20181108165156.60073-4-heikki.krogerus@linux.intel.com> <CAL_Jsq+4momJb6EoXrAg2LRKzpXMFB30yhBigOiEJ16EjZ05pg@mail.gmail.com>
 <20181108192509.GW10650@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181108192509.GW10650@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Nov 8, 2018 at 1:25 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Nov 08, 2018 at 12:23:51PM -0600, Rob Herring wrote:
> > On Thu, Nov 8, 2018 at 10:52 AM Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> > >
> > > This implements get_name fwnode op for DT.
> > >
> > > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > ---
> > >  drivers/of/property.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >
> > > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > > index f46828e3b082..9bc8fe136fa3 100644
> > > --- a/drivers/of/property.c
> > > +++ b/drivers/of/property.c
> > > @@ -823,6 +823,16 @@ static void of_fwnode_put(struct fwnode_handle *fwnode)
> > >         of_node_put(to_of_node(fwnode));
> > >  }
> > >
> > > +static int of_fwnode_get_name(const struct fwnode_handle *fwnode, char *buf)
> > > +{
> > > +       const char *name = kbasename(to_of_node(fwnode)->full_name);
> > > +       size_t len = strchrnul(name, '@') - name;
> > > +
> > > +       snprintf(buf, len + 1, "%s", name);
> >
> > This can be simplified to:
> >
> > snprintf(..., "%pOFn", to_of_node(fwnode))
> >
> > But that presents a problem with knowing the length. Not passing in
> > the buf length is not good design because you can't tell if you
> > overflow the buffer. Either you can pass in the length of buf or do
> > the allocation here. In the latter case, then you can use kasnprintf.
> > The downside to doing the allocation here is then get_name() has side
> > effect of allocating memory that the caller needs to be aware of.
>
> Agree on matter of potential overflow.
>
> I wouldn't limit users with 32 characters for node name if it's not by both
> ACPI and DT specifications.

While the DT spec says 31 characters, this has never been enforced. As
you might guess, we have node names longer than 31 characters. There's
been some discussion about what to do and the consensus seems to be
change the spec.

> OTOH allocating and freeing memory in a loop each
> time when we would like to go through the child nodes sounds much worse
> scenario to me.

Yes, I wrote that before looking at how you were using it... Of
course, if you want efficient, then you shouldn't use sprintf either
and use of_node_name_eq() as I've suggested.

> Thus, giving a length of the buffer is a good enough compromise.
>
> > However, I think the current API is better. It leaves low-level
> > details up to the firmware implementation. But as long as .get_name()
> > is not exposed to drivers I don't really care that much.
>
> I don't think this concept is changed by Heikki's patch series. It provides a
> common abstract function on top of more low-level firmware implementation which
> I consider a good approach.

Generally, I would agree that's a worthwhile goal. However, in this
case you aren't saving anything. We still have at least a DT version
of the same thing (of_get_child_by_name). Maybe there's some dream
that the fwnode API will become the only one for both drivers and
non-drivers, but I really don't see that happening. As long as both DT
and fwnode APIs are in use, it is best to keep the APIs aligned.

There's another aspect that the node name comparison is case
insensitive on powerpc (and until 4.20, was for everything but Sparc).
I changed it in 4.20 and hopefully don't have to revert. Patch 4 does
a case sensitive compare. That probably is fine (as lots of powerpc
code already does case sensitive name compares), but no one really
knows until we break users.

Another issue is how are disabled nodes dealt with by different
firmwares? It's a frequent bug that we don't honor the 'status'
property (such as in the very code we're discussing). But then there
are some cases were want to ignore it so we can't just go add that
check in and we end up needing 2 flavors of everything. You're
probably okay though. Most devices with child nodes are
enabled/disabled only in the parent device node.

Rob
Rob
