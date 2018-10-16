From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC PATCH 0/5] device property: Introducing software nodes
Date: Tue, 16 Oct 2018 10:44:45 +0200
Message-ID: <CAJZ5v0gYk1=jOkmF5z2WCCyHCu6ZWX8zOoLSkStvYqHMY2PZnA@mail.gmail.com>
References: <20181012113934.29942-1-heikki.krogerus@linux.intel.com>
 <CACRpkdZddvkgL1qwO=35y_Jps0+=QD3nPKQwgMEH+zcCH2NPdg@mail.gmail.com>
 <CAJZ5v0h3uENUqbcb=0HH1wT_0MYQzcHct2d19tiarvXEdRay+Q@mail.gmail.com> <20181016084050.GF24771@kuha.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181016084050.GF24771@kuha.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Oct 16, 2018 at 10:40 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Tue, Oct 16, 2018 at 09:36:33AM +0200, Rafael J. Wysocki wrote:
> > On Tue, Oct 16, 2018 at 9:35 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > >
> > > On Fri, Oct 12, 2018 at 1:39 PM Heikki Krogerus
> > > <heikki.krogerus@linux.intel.com> wrote:
> > >
> > > > To continue the discussion started by Dmitry [1], this is my proposal
> > > > that I mentioned in my last mail. In short, the idea is that instead
> > > > of trying to extend the support for the currently used struct
> > > > property_set, I'm proposing that we introduce a completely new,
> > > > independent type of fwnode, and replace the struct property_set with
> > > > it. I'm calling the type "software node" here.
> > >
> > > I'm a big fan of this approach.
> > > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > > for all patches.
> > >
> > > I don't know who can finally review and merge this though,
> > > I guess Rafael?
> >
> > Yes, that would be me. :-)
> >
> > I no one speaks up against them, I'll pick them up.
>
> Let me send a final version of these.
>
> I need to add one more patch to the series where I remove an extra
> device_remove_properties() call from platform_device_del().
>
> It's unnecessary in any case as device_del() calls
> device_remove_properties() for every device, but as the properties are
> removed there before the device is removed, we're unable to deduct
> the final ref count in the "remove" platform notification since our
> node is no longer bind to the device.

OK, I'll wait for an update, then.

Thanks,
Rafael
