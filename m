From: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Subject: Re: C states on AMD SMP
Date: Sat, 10 Sep 2005 12:01:13 +0200
Message-ID: <20050910100113.GA2582@tangens.sinus.cz>
References: <1126178956.24699.42.camel@localhost.localdomain> <43202621.9080600@tzi.de> <1126182374.4397.8.camel@localhost.localdomain> <43215F09.7030909@tzi.de> <1126339733.22979.2.camel@localhost.localdomain> <4322A06D.8050804@tzi.de> <1126343826.4766.29.camel@localhost.localdomain>
Reply-To: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1126343826.4766.29.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Erik Slagter <erik-KW7PGP3XNp7a5EbDDlwbIw@public.gmane.org>
Cc: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> On Sat, 2005-09-10 at 10:59 +0200, Janosch Machowinski wrote:
> 
> > > Is there a way to patch the FADT or to fool linux-acpi into it does
> > > actually work (to at least be able to test the thing)?
> > Shure, patch the verify functions in processor_idle.c ...
> > But actually I think this is no good idea...
> 
> Testing purposes ;-)
> 
> BTW amd76x_pm does work, so you never know... I'd really be happy if I
> could get something off the 190 Watts the machine now dissipates
> constantly!

Hi!
  AFAIK, the Cx state transition mechanism described in the ACPI spec is
designed just very simply: CPU accesses the "sleep register" stated in the
FACP for the particular sleep level, does the dummy operation, and hardware
puts CPU to the desired sleep level. But, what to do, if the chipset is 
designed that it requires more than a single access ? I'm afraid that it will
then require a specialized driver for that purpose. 
  Did You look at the amd76x_pm sources ? I did, just to see what it
does. There is a plenty of registers accessed, bits set/cleared from them,
simply something, which is not present in plain processor_idle.c . Why this
code is there ? Probably because it is necessary to handle sleep states on this
chipset. I'm afraid that using just the "plain method" from ACPI spec
implemented in the kernel is not enough. It is also the reason why this method
is disabled in BIOS.
  I'm also using amd76x_pm and it's really wonderful, the CPUs cool down to 45C
from 75C, I can even stop the fans and the temp doesn't go above 60C if the
CPUs are idling. I've written a small script using lm_sensors and controlling
fans, it's nice - You start a compilation and fans turn on 5 seconds later,
it's finished and they stop almost immediately. Nice accoustic indication :-).
   THe same problem as with this machine I have with my notebook, Clevo D610SU,
with SiS650 chipset. The C2/3 lats are set to 190/1900 in FADT. I patched the
lat limits in include/acpi/processor.h to 200/2000. Now CPU enters C2 but it
doesn't save more power than in C1. C3 is not entered at all because of bus 
mastering issues.
   I would be very glad for some "sis650_pm" driver but I don't have any. 
   Windows can run about two times longer than my Linux on the same hardware
   :-(.
                     With regards, Pavel Troller


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
