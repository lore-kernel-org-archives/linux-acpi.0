From: Francis Yom <fyom-NeBS1MF9zuBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Problem with ACPI and vmware
Date: 21 Nov 2002 12:49:11 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1037900951.1713.27.camel@localhost>
References: <1037834173.1868.10.camel@localhost>
	 <1037895243.2221.9.camel@p2710>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1037895243.2221.9.camel-QUVSR2uV0NY@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Troy Schultz <tschultz-zzOxFVvAfJPQT0dZR+AlfA@public.gmane.org>
Cc: ACPI Development - Sourceforge <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Troy,

Pardon me on the idle patch.  When I looked at my processor.c file, I
realized I was looking at the wrong place and sure enough I did not
disable my 'pm_idle=acpi_pm_idle;' line as directed.  This fixed the
problem completely for me.  Now I just have to get the battstat program
to work ;)

FWIW, I have a Presario 2700 and I am running kernel 2.4.19 with xfs and
rmap14a.  I am running it with the 20021101 ACPI patch and it is working
fine.  I get battery, thermal zones, everything! :)  What made it work
was upgrading the BIOS to the latest F.12 revision which you can get
from compaq.  The F.12 bios has a fixed ACPI implementation and now my
laptop has working ACPI :)  

The only bug I have is that thermal zones are not always picked up at
boot.  I have to reboot (sometimes 2-3 times) and the thermal zones will
get discovered.  I am wondering what might be causing this.  Hmmmm...
Any ideas?

Many thanks!
Francis

On Thu, 2002-11-21 at 11:14, Troy Schultz wrote:
> I am not sure what Idle patch you refer to, but I have found that you
> must hack processor.c to disable the CPU idle handler in the ACPI
> drivers to got VMware to work properly.
> 
> The problem seems to be that when VMware's guest is using the CPU the
> CPU stays at C2 and is not promoted to C1.  This causes very high delays
> in some of the apps.
> 
> I am running VMware 3.2 with kernel 2.4.19 and ACPI 20020821, I have
> been reluctant to try the newer ACPI drivers since I finally have things
> on my Presario 2710CA working quite well.  When I do get some time I do
> intend to try the newer ACPI driver though.  It has been a pain to go
> through each version and determine where I must hack to disable the CPU
> idle handler.
> 
> I have also found that I must use a "corrected" DSDT since the one in
> the notebook is buggy.
> 
> For what it is worth I too think this is an issue that VMware must
> correct.  I have sent them emails regarding this issue but have never
> seen any response.  I think more people have to complain about this
> problem before they will do anything to fix it.
> 
> Feel free to email me if I can be of any assistance to you.
> 
> Best Regards
> - Troy
> 
> On Wed, 2002-11-20 at 18:16, Francis Yom wrote:
> > Hey guys,
> > 
> > I'm having a problem with ACPI and VMWare.  I am using ACPI 20021101 and
> > VMWare 3.0 on kernel 2.4.19 with xfs and rmap14a.  My laptop is a Compaq
> > presario 2700T.
> > 
> > When I include processor and thermal support in the kernel, I can see my
> > battery and thermal zones just fine.  However, My Win2K and openbsd 3.2
> > VMWare sessions stutter and are slow.  YES!  I did install the Idle
> > patch.  In fact, with 20021101 ACPI it seems this patch is already in
> > place.
> > 
> > When I remove processor and thermal support, I cannot see my battery any
> > more, but VMWare sessions run fine without problems.
> > 
> > I am looking for a solution that will give me my battery support back
> > and let me run VMWare without sluggishness.
> > 
> > Can anyone suggest a solution?  Thanks!
> > Francis
> > 
> > 
> > 
> > 
> > -------------------------------------------------------
> > This sf.net email is sponsored by: 
> > Battle your brains against the best in the Thawte Crypto 
> > Challenge. Be the first to crack the code - register now: 
> > http://www.gothawte.com/rd521.html
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
