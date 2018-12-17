From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v6 3/3] of/property: Add of_fwnode_name()
Date: Mon, 17 Dec 2018 14:15:18 +0200
Message-ID: <20181217121518.GB14121@kuha.fi.intel.com>
References: <20181211131451.52832-1-heikki.krogerus@linux.intel.com>
 <20181211131451.52832-4-heikki.krogerus@linux.intel.com>
 <CAJZ5v0hvGL8DnxFAtp3NiuT7ubTBuoKbTzbD9UaZYNpgZLiWaQ@mail.gmail.com>
 <CAL_JsqLn3dbt-8Hjoja5AJip7FxLoWLAh0Cuk1eqE3Z8RiaO1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqLn3dbt-8Hjoja5AJip7FxLoWLAh0Cuk1eqE3Z8RiaO1A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Frank Rowand <frowand.list@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Dec 14, 2018 at 11:46:02AM -0600, Rob Herring wrote:
> On Fri, Dec 14, 2018 at 3:36 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Dec 11, 2018 at 2:15 PM Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> > >
> > > This implements get_name fwnode op for DT.
> > >
> > > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> >
> > Rob, any objections here?
> 
> Yes, what I said in v5.

I did address your comment in v5? The helper no longer tries to read
"name" property if the callback fails.

> At one point this series had a user which was finding a matching node
> by name. Now there is no user, so I can't really say whether this API
> makes sense or not.

That is a fair point. I choose to not to convert
fwnode_get_named_child_node() to use this helper because it would mean
we would have to allocate the buffer there, and I don't know if it's
worth it.

Let's forget about this for now. I was planning to use this helper for
matching a requested remote-endpoint (graph) device, but I'm not sure
if the node name is usable there.

I'll resend these as part of a real user for the API, if I ever have
one.


thanks,

-- 
heikki
