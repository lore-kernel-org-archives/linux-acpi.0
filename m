From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [patch 05/13] ACPI: Make bay depend on dock
Date: Fri, 23 Feb 2007 13:37:58 -0800
Message-ID: <20070223133758.f330dab3.kristen.c.accardi@intel.com>
References: <200702060010.l160AE0G003732@shell0.pdx.osdl.net>
	<200702090050.10271.lenb@kernel.org>
	<20070208220152.7f62b6c1.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39527 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933212AbXBWVkN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 23 Feb 2007 16:40:13 -0500
In-Reply-To: <20070208220152.7f62b6c1.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Thu, 8 Feb 2007 22:01:52 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri, 9 Feb 2007 00:50:10 -0500 Len Brown <lenb@kernel.org> wrote:
> 
> > Did you intend to make ACPI_BAY depend on ACPI_DOCK
> > instead of making ACPI_DOCK depend on ACPI_DOCK?
> > 
> > -Len
> > 
> > On Monday 05 February 2007 19:09, akpm@linux-foundation.org wrote:
> > > From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
> > > 
> > > Since the bay driver depends on the dock driver for proper notification, make
> > > this driver depend on the dock driver.
> > > 
> > > Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
> > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > > ---
> > > 
> > >  drivers/acpi/Kconfig |    1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff -puN drivers/acpi/Kconfig~acpi-make-bay-depend-on-dock drivers/acpi/Kconfig
> > > --- a/drivers/acpi/Kconfig~acpi-make-bay-depend-on-dock
> > > +++ a/drivers/acpi/Kconfig
> > > @@ -151,6 +151,7 @@ config ACPI_FAN
> > >  config ACPI_DOCK
> > >  	tristate "Dock"
> > >  	depends on EXPERIMENTAL
> > > +	depends on ACPI_DOCK
> > >  	help
> > >  	  This driver adds support for ACPI controlled docking stations
> 
> I dunno what's going on with this one - it might have got mangled.  Please
> drop.
> 

Eh - we do need this patch after all - here it is again - ACPI_BAY should
be dependent on ACPI_DOCK.


Subject: ACPI: Make bay depend on dock

Since the bay driver depends on the dock driver for proper notification,
make this driver depend on the dock driver. 

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
---
 drivers/acpi/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- kristen-2.6.orig/drivers/acpi/Kconfig
+++ kristen-2.6/drivers/acpi/Kconfig
@@ -142,6 +142,7 @@ config ACPI_DOCK
 config ACPI_BAY
 	tristate "Removable Drive Bay"
 	depends on EXPERIMENTAL
+	depends on ACPI_DOCK
 	help
 	  This driver adds support for ACPI controlled removable drive
 	  bays such as the IBM ultrabay or the Dell Module Bay.
