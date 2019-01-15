From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v6 05/11] platform/x86: intel_pmc: Make PCI dependency explicit
Date: Tue, 15 Jan 2019 19:40:45 +0100
Message-ID: <3717479.LUAfB5gYd9@aspire.rjw.lan>
References: <20190105100606.6673-1-okaya@kernel.org> <3184241.VH7flF4h5P@aspire.rjw.lan> <CAHp75VeKB_4Fc-G_QG0YnSqhAu9w8csASrgrg0cVAo_gYjeJ_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VeKB_4Fc-G_QG0YnSqhAu9w8csASrgrg0cVAo_gYjeJ_g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Sinan Kaya <okaya@kernel.org>, Andy Shevchenko <andy@infradead.org>, linux-next <linux-next@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, "open list:X86 PLATFORM DRIVERS" <platform-driver-x86@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday, January 9, 2019 12:10:45 PM CET Andy Shevchenko wrote:
> On Wed, Jan 9, 2019 at 12:48 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Saturday, January 5, 2019 11:06:00 AM CET Sinan Kaya wrote:
> > > After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
> > > CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
> > > satisfied implicitly through dependencies on CONFIG_ACPI have to be
> > > specified directly. Code relies on PCI for execution. Specify this
> > > in the Kconfig.
> > >
> > > Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> > > Signed-off-by: Sinan Kaya <okaya@kernel.org>
> > > ---
> > >  drivers/platform/x86/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> > > index b36ea14b41ad..7afb96cb1cd6 100644
> > > --- a/drivers/platform/x86/Kconfig
> > > +++ b/drivers/platform/x86/Kconfig
> > > @@ -1174,7 +1174,7 @@ config INTEL_SMARTCONNECT
> > >
> > >  config INTEL_PMC_IPC
> > >       tristate "Intel PMC IPC Driver"
> > > -     depends on ACPI
> > > +     depends on ACPI && PCI
> > >       ---help---
> > >       This driver provides support for PMC control on some Intel platforms.
> > >       The PMC is an ARC processor which defines IPC commands for communication
> >
> > Andy, you had some reservations regarding this patch IIRC.
> >
> > Should I apply it?
> 
> Let's do it as a quick fix with something like below being added to
> the commit message:
> 
> "For sake of a quick fix this introduces a new mandatory dependency to
> the driver which may survive without it. Otherwise we need to revisit
> the driver architecture to address this properly."

Done, thanks!
