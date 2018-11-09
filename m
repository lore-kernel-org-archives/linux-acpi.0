From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/4] of/property: Add of_fwnode_name()
Date: Fri, 9 Nov 2018 10:14:49 -0600
Message-ID: <CABGGiswFe92TLtU6YH3UsQJBbACbHu2w0rmc7FvwURqi_PU+7w@mail.gmail.com>
References: <20181108165156.60073-1-heikki.krogerus@linux.intel.com>
 <20181108165156.60073-4-heikki.krogerus@linux.intel.com> <CAL_Jsq+4momJb6EoXrAg2LRKzpXMFB30yhBigOiEJ16EjZ05pg@mail.gmail.com>
 <20181108192509.GW10650@smile.fi.intel.com> <CAL_JsqLMuiUc8FW=X_OAd5P_tcfPSTOox9Vh6faEwK+Z=S2mjw@mail.gmail.com>
 <20181109133442.GA28183@kuha.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181109133442.GA28183@kuha.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heikki.krogerus@linux.intel.com
Cc: Rob Herring <robh@kernel.org>, andriy.shevchenko@linux.intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, mika.westerberg@linux.intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 9, 2018 at 7:34 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Thu, Nov 08, 2018 at 03:18:21PM -0600, Rob Herring wrote:
> > On Thu, Nov 8, 2018 at 1:25 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Thu, Nov 08, 2018 at 12:23:51PM -0600, Rob Herring wrote:
> > > > On Thu, Nov 8, 2018 at 10:52 AM Heikki Krogerus
> > > > <heikki.krogerus@linux.intel.com> wrote:
> > > > >
> > > > > This implements get_name fwnode op for DT.
> > > > >
> > > > > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > > ---
> > > > >  drivers/of/property.c | 11 +++++++++++
> > > > >  1 file changed, 11 insertions(+)
> > > > >
> > > > > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > > > > index f46828e3b082..9bc8fe136fa3 100644
> > > > > --- a/drivers/of/property.c
> > > > > +++ b/drivers/of/property.c
> > > > > @@ -823,6 +823,16 @@ static void of_fwnode_put(struct fwnode_handle *fwnode)
> > > > >         of_node_put(to_of_node(fwnode));
> > > > >  }
> > > > >
> > > > > +static int of_fwnode_get_name(const struct fwnode_handle *fwnode, char *buf)
> > > > > +{
> > > > > +       const char *name = kbasename(to_of_node(fwnode)->full_name);
> > > > > +       size_t len = strchrnul(name, '@') - name;
> > > > > +
> > > > > +       snprintf(buf, len + 1, "%s", name);
> > > >
> > > > This can be simplified to:
> > > >
> > > > snprintf(..., "%pOFn", to_of_node(fwnode))
> > > >
> > > > But that presents a problem with knowing the length. Not passing in
> > > > the buf length is not good design because you can't tell if you
> > > > overflow the buffer. Either you can pass in the length of buf or do
> > > > the allocation here. In the latter case, then you can use kasnprintf.
> > > > The downside to doing the allocation here is then get_name() has side
> > > > effect of allocating memory that the caller needs to be aware of.
> > >
> > > Agree on matter of potential overflow.
> > >
> > > I wouldn't limit users with 32 characters for node name if it's not by both
> > > ACPI and DT specifications.
> >
> > While the DT spec says 31 characters, this has never been enforced. As
> > you might guess, we have node names longer than 31 characters. There's
> > been some discussion about what to do and the consensus seems to be
> > change the spec.
> >
> > > OTOH allocating and freeing memory in a loop each
> > > time when we would like to go through the child nodes sounds much worse
> > > scenario to me.
> >
> > Yes, I wrote that before looking at how you were using it... Of
> > course, if you want efficient, then you shouldn't use sprintf either
> > and use of_node_name_eq() as I've suggested.
>
> Since the fwnode API is just a wrapper layer (at least IMO), I don't
> think there should be any assumptions that it provides the optimal
> solution for anything. The low-level APIs should be the ones providing
> the optimal solutions.
>
> > > Thus, giving a length of the buffer is a good enough compromise.
>
> OK. That's what we'll do then.
>
> > > > However, I think the current API is better. It leaves low-level
> > > > details up to the firmware implementation. But as long as .get_name()
> > > > is not exposed to drivers I don't really care that much.
>
> Side note:
>
> I would prefer that we had something like of_node_name_get() function
> that of_fwnode_get_name() could simply call. I don't know how you want
> that implemented, but I'm expecting you will implement something like
> that in any case once you start removing that ->name member. I figured
> that at that point we can update of_fwnode_get_name() as well.

I don't plan to implement anything like that. Here's what I'm planning:
https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/log/?h=dt/testing

Which is eliminating the need to access .name by: using %pOFn (mostly
in 4.20), using of_node_name_eq() wrapper, or using full_name instead.
The last case generally is cases where the name is not important such
as request_irq() or irq_chip.name.

> > > I don't think this concept is changed by Heikki's patch series. It provides a
> > > common abstract function on top of more low-level firmware implementation which
> > > I consider a good approach.
> >
> > Generally, I would agree that's a worthwhile goal. However, in this
> > case you aren't saving anything. We still have at least a DT version
> > of the same thing (of_get_child_by_name). Maybe there's some dream
> > that the fwnode API will become the only one for both drivers and
> > non-drivers, but I really don't see that happening. As long as both DT
> > and fwnode APIs are in use, it is best to keep the APIs aligned.
>
> I don't think that anybody was planning to have the fwnode API as
> the only available API for the drivers. It's just a helper for the
> drivers on top of the low-level APIs, so the low-level APIs really
> need to always stay available for the drivers. There will always be
> corner cases.

So either it needs to be the only interface to drivers or the fwnode
and DT APIs need to have the same calls. We don't want drivers to use
different style/design of API based on picking fwnode or DT API. If
you have the same calls, there's no point to trying to copy the common
parts into fwnode code. Then you have 3 implementations of the same
thing instead of 2.

> > There's another aspect that the node name comparison is case
> > insensitive on powerpc (and until 4.20, was for everything but Sparc).
> > I changed it in 4.20 and hopefully don't have to revert. Patch 4 does
> > a case sensitive compare. That probably is fine (as lots of powerpc
> > code already does case sensitive name compares), but no one really
> > knows until we break users.
>
> I actually used stccasecmp() in the first version. I don't know how,
> or why, I've changed it to strcmp(). I'll fix that.

That's not what I'm suggesting. I'm saying that is a firmware level
detail that should remain in firmware code.

I'm actually hoping to move things over to be case sensitive in most
cases. That may mean having some work-around like:

if (IS_ENABLED(CONFIG_PPC_PMAC))
  ... strcasecmp()
else
  ... strcmp()

Or whatever system needs this. I think it is old PowerMacs, but am not
really sure. And yeah, that would be ugly, but at least we'd know what
exactly needs it. Do you want this crap is fwnode code?

Rob
