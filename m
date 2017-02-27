From: Tobias Schumacher <tobe.schumacher@gmail.com>
Subject: Re: [PATCH] Fix lock up when switching off discrete graphics card
 in Dell XPS 9560 https://bugzilla.kernel.org/show_bug.cgi?id=156341
Date: Mon, 27 Feb 2017 23:30:21 +0100
Message-ID: <1488234621.2393.1.camel@gmail.com>
References: <20170221003625.17551-1-tobe.schumacher@gmail.com>
         <20170221094133.7qfs6p7uwatlj3rp@lenoch>
         <1487705618.3670.1.camel@gmail.com>
         <CAJZ5v0j9FjS=wa2yEXTXWp1EhSnesuc4X4dkQrOMTJwM-4tYoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0j9FjS=wa2yEXTXWp1EhSnesuc4X4dkQrOMTJwM-4tYoA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ladislav Michl <ladis@linux-mips.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Rafael,

Am Montag, den 27.02.2017, 23:19 +0100 schrieb Rafael J. Wysocki:
> On Tue, Feb 21, 2017 at 8:33 PM, Tobias Schumacher
> <tobe.schumacher@gmail.com> wrote:
> > Hi Ladislav,
> > 
> > Am Dienstag, den 21.02.2017, 10:41 +0100 schrieb Ladislav Michl:
> > > Hi Tobias,
> > > 
> > > On Tue, Feb 21, 2017 at 01:36:25AM +0100, Tobias Schumacher
> > > wrote:
> > > > Signed-off-by: Tobias Schumacher <tobe.schumacher@gmail.com>
> > > > ---
> > > >  drivers/acpi/blacklist.c | 14 ++++++++++++++
> > > >  1 file changed, 14 insertions(+)
> > > > 
> > > > diff --git a/drivers/acpi/blacklist.c
> > > > b/drivers/acpi/blacklist.c
> > > > index 4421f7c..7945f2f 100644
> > > > --- a/drivers/acpi/blacklist.c
> > > > +++ b/drivers/acpi/blacklist.c
> > > > @@ -188,6 +188,20 @@ static struct dmi_system_id
> > > > acpi_rev_dmi_table[] __initdata = {
> > > >                   DMI_MATCH(DMI_PRODUCT_NAME, "Latitude
> > > > 3350"),
> > > >             },
> > > >     },
> > > > +   /*
> > > > +    * Resolves issues that cause the system to lock up
> > > > +    * under certain conditions when the discrete graphics
> > > > +    * card is turned off
> > > > +    */
> > > > +   {
> > > > +    .callback = dmi_enable_rev_override,
> > > > +    .ident = "DELL XPS 15 (2017)",
> > > > +    .matches = {
> > > > +                   DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > > > +                   DMI_MATCH(DMI_PRODUCT_NAME, "XPS 15
> > > > 9560"),
> > > > +           },
> > > > +   },
> > > > +
> > > >  #endif
> > > >     {}
> > > >  };
> > > 
> > > I thought conclusion was _not_ adding any new devices into this
> > > evergrowing
> > > list. Or am I mistaken? As otherwise I'll sent similar patch for
> > > my
> > > laptop ;-)
> > 
> > I don't know to be honest - I recently switched back from Mac to
> > Linux
> > and searched for a way to get things working properly. Without any
> > kernel parameters and patches switching off the discrete graphics
> > will
> > lead to lockups when executing for example lspci. Booting with
> > 'acpi_osi=! acpi_osi="Windows 2009"' fixes this, but unfortunately
> > the
> > touchpad will stop working properly. With this patch both things
> > work.
> > 
> > If the conclusion is not adding new devices here, is there also a
> > prefered way of fixing this? I guess getting Dell to fix this would
> > be
> > the ideal solution, but what can we do in the meantime? Would
> > adding a
> > kernel parameter like acpi_rev that overrides the reported ACPI
> > revision be acceptable? The only other solution I could thing of
> > would
> > be patching the ACPI tables.
> 
> Did you try to boot with acpi_rev_override in the kernel command
> line?

I actually searched for an option like that but didn't find it, that's
why I came up with the patch. Now I tried, looks like it works great!
Thanks a lot!

Tobias
