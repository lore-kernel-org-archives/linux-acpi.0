From: Nigel Nigel <nigels@hotmail.com>
Subject: RE: [repost] acpi on gentoo
Date: Mon, 12 Mar 2007 11:26:48 +0000
Message-ID: <BAY123-W214EDC3E723EFE3C0B5E8FD57D0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bay0-omc3-s16.bay0.hotmail.com ([65.54.246.216]:23731 "EHLO
	bay0-omc3-s16.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965655AbXCLL0t convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Mar 2007 07:26:49 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: linux-acpi@vger.kernel.org








----------------------------------------
> Date: Mon, 12 Mar 2007 14:16:51 +0300
> From: alexey.y.starikovskiy@linux.intel.com
> To: nigels@hotmail.com
> CC: linux-acpi@vger.kernel.org
> Subject: Re: [repost] acpi on gentoo
> 
> Nigel wrote:
> >
> > > Date: Sun, 11 Mar 2007 18:57:58 +0300
> > > From: alexey.y.starikovskiy@linux.intel.com
> > > To: nigels@hotmail.com
> > > CC: luming.yu@gmail.com; linux-acpi@vger.kernel.org
> > > Subject: Re: [repost] acpi on gentoo
> > >
> > > Nigel wrote:
> > > > response inline
> > > >
> > > > Luming Yu said on 11/3/2007 3:12 PM:
> > > >> On 3/11/07, Nigel  wrote:
> > > >>>
> > > >>> Trying again to see if anyone had any other ideas.
> > > >>>
> > > >>> In addition:
> > > >>> The acpid daemon is running.
> > > >>> The same machine when booted into windows will automatically go to
> > > >>> powersave mode when the power cable is removed.
> > > >>>
> > > >>
> > > >> what condition is your battery in? It makes sense if battery 
> > power is
> > > >> very low.
> > > > Battery #1 : present
> > > > Remaining capacity : 47822 mWh, 100.0%
> > > > Design capacity : 50760 mWh
> > > > Last full capacity : 47822 mWh, 94.21% of design capacity
> > > > (similar output was included in the original post)
> > > >
> > > > Regardless of battery condition should I not still get an event for
> > > > removing and reinserting the power cable? (Obviously waiting for a
> > > > minute or two in-between )
> > > >
> > > >> If battery is still full, then it sounds like a bug. You need to 
> > test
> > > >> the latest base kernel before entering a acpi bug into
> > > >> bugzilla.kernel.org.
> > > >
> > > > It works just fine on 2.6.19-r5 (gentoo)
> > > > Whilst is *may* have been a bug, the issue should no longer exist 
> > on a
> > > > newer kernel.
> > > >
> > > >>
> > > >>> One interesting though, if I do : modprobe button
> > > >>> then every 30 seconds or so I get:
> > > >>> received event "battery BAT1 00000080 00000001"
> > > >>>
> > > >>> Even when i do rmmod button I still keep getting these events.
> > > >>> The only way to go back to "normal" behaviour is to reboot.
> > > >>>
> > > >>> Any suggestions as to what might be my problem here ?
> > > >>>
> > > >> I guess your battery power level is low.
> > > >
> > > > Nope, that's not it.
> > > > Don't really get your logic either. *Only* when a certain module is
> > > > loaded and after that *only* a reboot stops these messages means that
> > > > the battery is low?
> > > >
> > > >>  > > >>
> > > >
> > > > So, I take it that my choice is limited to using the newer kernel ?
> > > > I would normally not hesitate to use the newer kernel but my
> > > > employer's vpn client is limited to 2.6.17
> > > >
> > > > Nigel.
> > > > -
> > > > To unsubscribe from this list: send the line "unsubscribe 
> > linux-acpi" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at http://vger.kernel.org/majordomo-info.html
> > >
> > > 2.6.19-rc5 has EC driver almost re-written (drivers/acpi/ec.c). Please
> > > check if putting it into 2.6.17 works/helps. You may also try to put an
> > > 2.6.20/21-rc version of the same file... It has even more changes.
> > >
> > >
> > > Regards,
> > > Alex.
> >
> > I tried copying all of the directories with "acpi" and a few .h files 
> > as well (from 2.6.19-rc5) . This is what I get:
> >
> > [skipped]
> I asked if copying of single file helps... I didn't ask you to copy all 
> acpi files two kernel releases back and make it work...
> > If there is a relatively simple way to get this to work. Let me know.
> Copy one file: drivers/acpi/ec.c

Sorry, I should have explained in more detail. I did copy just the one file to start with, and  got this :
CHK     include/linux/version.h
CHK     include/linux/compile.h
CC      drivers/acpi/ec.o
drivers/acpi/ec.c: In function 'acpi_ec_gpe_handler':
drivers/acpi/ec.c:467: warning: implicit declaration of function
'acpi_os_execute'
drivers/acpi/ec.c:467: error: 'OSL_EC_BURST_HANDLER' undeclared (first
use in this function)
drivers/acpi/ec.c:467: error: (Each undeclared identifier is reported
only once
drivers/acpi/ec.c:467: error: for each function it appears in.)
make[2]: *** [drivers/acpi/ec.o] Error 1
make[1]: *** [drivers/acpi] Error 2
make: *** [drivers] Error 2


Is there something I can do to get this going ?

> > Otherwise I'll just leave it, and hopefully in a year or so I'll be 
> > able  to upgrade.
> >
> Ok.
> > Thanks,
> > Nigel.
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

_________________________________________________________________
Explore the seven wonders of the world
http://search.msn.com/results.aspx?q=7+wonders+world&mkt=en-US&form=QBRE