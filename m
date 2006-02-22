From: Thomas Renninger <trenn@suse.de>
Subject: Re: "Device is not power manageable"
Date: Wed, 22 Feb 2006 12:44:41 +0100
Message-ID: <200602221244.42339.trenn@suse.de>
References: <20060221042708.653944c1.akpm@osdl.org> <20060221185920.df65a7e3.rdunlap@xenotime.net> <20060221190840.5e67d07e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:59811 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750791AbWBVLoo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Feb 2006 06:44:44 -0500
In-Reply-To: <20060221190840.5e67d07e.akpm@osdl.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-acpi@vger.kernel.org, rdunlap@xenotime.net

On Wednesday 22 February 2006 04:08, you wrote:
> "Randy.Dunlap" <rdunlap@xenotime.net> wrote:
> >
> > Here's the patch that I have used.
> > 
> >  -- 
> > 
> >  From: Jae-hyeon Park <jhpark@tuhep.phys.tohoku.ac.jp>
> > 
> >  Identify which device is not power-manageable to make
> >  the message more useful.
> > 
> >  Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> >  ---
> >   drivers/acpi/bus.c |    5 +++--
> >   1 files changed, 3 insertions(+), 2 deletions(-)
> > 
> >  --- linux-2616-rc4.orig/drivers/acpi/bus.c
> >  +++ linux-2616-rc4/drivers/acpi/bus.c
> >  @@ -197,8 +197,9 @@ int acpi_bus_set_power(acpi_handle handl
> >   	/* Make sure this is a valid target state */
> >   
> >   	if (!device->flags.power_manageable) {
> >  -		ACPI_DEBUG_PRINT((ACPI_DB_WARN,
> >  -				  "Device is not power manageable\n"));
> >  +		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> >  +				  "Device '%s' is not power manageable\n",
> >  +					device->kobj.name));
> >   		return_VALUE(-ENODEV);
> >   	}
> >   	/*
> 
> Thanks.  I guess that won't be very popular due to using linux-specific
> stuff in a generic file, but I'll merge it.

That will conflict with latest patches:
ACPI_DEBUG_PRINT((ACPI_DB_WARN, ...)) have been converted to 
ACPI_WARNING((AE_INFO, ...)).

This was done because a lot real error/warning messages were only printed with
ACPI_DEBUG=y (like all ACPI_DEBUG_PRINT messages).

In this case I used ACPI_INFO((AE_INFO,...)) as I knew the message
pops up here and there.

This one lets the message vanish totally and only shows it with ACPI_DEBUG=y and 
acpi_dbg_level | ACPI_DEBUG_INFO:


signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
signed-off-by: Thomas Renninger <trenn@suse.de>

bus.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6.15/drivers/acpi/bus.c
===================================================================
--- linux-2.6.15.orig/drivers/acpi/bus.c
+++ linux-2.6.15/drivers/acpi/bus.c
@@ -196,7 +196,9 @@ int acpi_bus_set_power(acpi_handle handl
 	/* Make sure this is a valid target state */
 
 	if (!device->flags.power_manageable) {
-		ACPI_INFO((AE_INFO, "Device is not power manageable"));
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+			      "Device %s is not power manageable",
+			      device->kobj.name));
 		return_VALUE(-ENODEV);
 	}
 	/*

