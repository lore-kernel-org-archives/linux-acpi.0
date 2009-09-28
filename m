From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] PM / PCMCIA: Drop second argument of pcmcia_socket_dev_suspend()
Date: Mon, 28 Sep 2009 22:16:53 +0200
Message-ID: <200909282216.53633.rjw@sisk.pl>
References: <200909260122.59030.rjw@sisk.pl> <200909260125.11149.rjw@sisk.pl> <20090928113112.GA5602@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20090928113112.GA5602@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Linux PCI <linux-pci@vger.kernel.org>, linux-pcmcia@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Florian <fs-kernelbugzilla@spline.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

On Monday 28 September 2009, Wolfram Sang wrote:
> On Sat, Sep 26, 2009 at 01:25:11AM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > pcmcia_socket_dev_suspend() doesn't use its second argument, so it
> > may be dropped safely.
> > 
> > This change is necessary for the subsequent yenta suspend/resume fix.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >  drivers/pcmcia/at91_cf.c        |    2 +-
> >  drivers/pcmcia/au1000_generic.c |    2 +-
> >  drivers/pcmcia/bfin_cf_pcmcia.c |    2 +-
> >  drivers/pcmcia/cs.c             |    2 +-
> >  drivers/pcmcia/i82092.c         |    2 +-
> >  drivers/pcmcia/i82365.c         |    2 +-
> >  drivers/pcmcia/m32r_cfc.c       |    2 +-
> >  drivers/pcmcia/m32r_pcc.c       |    2 +-
> >  drivers/pcmcia/m8xx_pcmcia.c    |    2 +-
> >  drivers/pcmcia/omap_cf.c        |    2 +-
> >  drivers/pcmcia/pd6729.c         |    2 +-
> >  drivers/pcmcia/pxa2xx_base.c    |    2 +-
> >  drivers/pcmcia/sa1100_generic.c |    2 +-
> >  drivers/pcmcia/sa1111_generic.c |    2 +-
> >  drivers/pcmcia/tcic.c           |    2 +-
> >  drivers/pcmcia/vrc4171_card.c   |    2 +-
> >  include/pcmcia/ss.h             |    2 +-
> 
> Hmm, you are not converting yenta_socket here. Won't that break building the
> kernel (git bisect)?

You're right, I should have modified yenta_socket.c here as well.  Will fix.

Thanks,
Rafael
