From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [-mm patch] make drivers/misc/thinkpad_acpi:fan_mutex static
Date: Sun, 29 Apr 2007 04:50:08 +0200
Message-ID: <20070429025008.GK3468@stusta.de>
References: <20070425225716.8e9b28ca.akpm@linux-foundation.org> <20070428191938.GO3468@stusta.de> <20070428195821.GC2392@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:37711 "EHLO
	mailhub.stusta.mhn.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754094AbXD2Ct6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Apr 2007 22:49:58 -0400
Content-Disposition: inline
In-Reply-To: <20070428195821.GC2392@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Andrew Morton <akpm@linux-foundation.org>, lenb@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Sat, Apr 28, 2007 at 04:58:21PM -0300, Henrique de Moraes Holschuh wrote:
> On Sat, 28 Apr 2007, Adrian Bunk wrote:
>...
> > BTW: Prototypes for static versions and static variables in a header
> >      file are really wrong, but the mess is bigger than what I'm
> >      willing to clean up...
> 
> It is a private header file, only one file uses it and it is not supposed to
> be used by any other file ever, either.  I can certainly do a cleaning up
> and a lot can be removed (at least 70% of it), but the driver is not linear
> (it is some infrastructure and various subdrivers) and there is a bunch of
> stuff that will need forward declarations regardless.

Forward declarations of static functions (if required) and actual 
variables (like fan_mutex) belong into the C file, not the header.

> Maybe I should just break the driver into multiple files in a subdirectory?
> That would certainly make it *much* cleaner...

But even more in this case, you will not want to have actual variables 
or prototypes of static functions in the header file.

> > --- linux-2.6.21-rc7-mm2/drivers/misc/thinkpad_acpi.h.old	2007-04-27 00:55:58.000000000 +0200
> > +++ linux-2.6.21-rc7-mm2/drivers/misc/thinkpad_acpi.h	2007-04-28 01:32:54.000000000 +0200
> > @@ -382,7 +382,7 @@
> >  static u8 fan_control_desired_level;
> >  static int fan_watchdog_maxinterval;
> >  
> > -struct mutex fan_mutex;
> > +static struct mutex fan_mutex;
> >  
> >  static acpi_handle fans_handle, gfan_handle, sfan_handle;
> >  
>   Henrique Holschuh

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

