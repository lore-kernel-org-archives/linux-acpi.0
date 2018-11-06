From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 3/4] of/property: Introduce of_fwnode_name()
Date: Tue, 6 Nov 2018 17:05:03 +0200
Message-ID: <20181106150503.GE13048@kuha.fi.intel.com>
References: <20181105091727.25544-1-heikki.krogerus@linux.intel.com>
 <20181105091727.25544-4-heikki.krogerus@linux.intel.com>
 <CAL_Jsq+aRAv+9gDKwVi9xYQPYzXK4NMPjzfkuYB08+K6KTYXFg@mail.gmail.com>
 <20181106105803.GS10650@smile.fi.intel.com>
 <20181106122734.GC13048@kuha.fi.intel.com>
 <CAL_Jsq+kspp1GYrMjG1cC=CyCa2_jO1suFdD9fn+gOwKRYdhtw@mail.gmail.com>
 <20181106144037.GD13048@kuha.fi.intel.com>
 <20181106145537.GB10650@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181106145537.GB10650@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 06, 2018 at 04:55:37PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 06, 2018 at 04:40:37PM +0200, Heikki Krogerus wrote:
> > On Tue, Nov 06, 2018 at 07:18:14AM -0600, Rob Herring wrote:
> 
> > > Looking at patch 4, if matching the name is what you want to do, then
> > > use the DT name matching functions. They were added in 4.19.
> > 
> > That is something that the of_fwnode_get_named_child_node() needs
> > to use (would have needed).
> > 
> > Regardless of what we do with that callback, fwnode_name() needs to
> > return the name in from that for example of_node_name_eq() takes as
> > the second parameter. So "node-name@unit-address" is not OK. Sorry for
> > not realizeing that before.
> > 
> > So I guess we need to either get the "node-name" from that full_name
> > member in of_fwnode_name() (Andy, are you OK with that?), or is there
> > already a helper that does it for us?
> 
> Looking into existing API I think we need something like
> 
> of_node_name_extract()
> 
> of_node_name_eq()
> {
> 	name = of_node_name_extract();
> 	return strlen()...strncmp()...;
> }
> 
> The question is who is going to allocate and free memory for the name out of it.

Maybe it would be best to just read the "name" device property in
fwnode_name() and not have of_fwnode_name at all.

> OTOH, of_fwnode_get_named_child_node() might need to copy that code which
> brings the consistency issue (several places to maintain the same set of rules,
> i.e. how we extract name out of full_name).
> 
> So, removal of name field shouldn't be done until we resolve the issue with
> of_fwnode_get_named_child_node().

thanks,

-- 
heikki
