From: "James H. Cloos Jr." <cloos-GRsvFm/Gh/pBDgjK7y7TUQ@public.gmane.org>
Subject: Re: CALL FOR TESTING
Date: 27 Sep 2002 19:44:43 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m31y7ff15g.fsf@lugabout.jhcloos.org>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE80@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DE80-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Another success story.  I'm now booted with 2.4.20-pre8 w/ acpi on a
dell i8100 (with radeon 7500m video and A07 bios).  Interupt routing
is the same as marcello's tree (w/ apm rather than acpi).  The files
under /proc/acpi all seem good.

OTOH, the sum of design capacity in /proc/acpi/battery/*/info divided
by the mW ratings in /proc/acpi/processor/CPU0/performance is
significantly less than the duration apm claimed.

The two batteries have 57420 mWh and the pIIIm has power states:

   *P0:                  1000 MHz, 15800 mW, 500 uS
    P1:                  733 MHz, 12500 mW, 500 uS

making 7.27 or 9.19 hours on two full batteries.  Apmd claimed 11.50
hours on two full batteries.

(I'm inclined to consider apmd's promise optimistic, so the above is
probably accurate.  But the difference is IMO worth a mention.)

The exact kernel I'm running can be duplicated by:

bk clone \
  -r'marcelo-h0V4oybiq0/QsHzvN0qAKK/+n4cY9krw@public.gmane.org|ChangeSet|20020925091643|62826' \
   bk://linux.bkbits.net/linux-2.4 linux-2.4.20-pre8
bk clone \
   -r'agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org|ChangeSet|20020924011021|60855' \
   bk://linux-acpi.bkbits.net/linux-2.4-acpi
bk clone -l linux-2.4-acpi linux-2.4.20-pre8-acpi
cd linux-2.4.20-pre8-acpi
bk pull ../linux-2.4.20-pre8
bk edit Makefile
perl -pi 's/EXTRAVERSION = -pre8/EXTRAVERSION = -pre8-acpi/' Makefile
bk citool Makefile

(Ie, grab Marcello's tree up to the cset where EXTRAVERSION became
-pre8, grab the linux-2.4-acpi up to where it was when I last pulled,
make a working clone, pull from the clone of Marcello, and fixup
EXTRAVERSION to differentiate from a 2.4.20-pre8 install.)


One thing not mentioned in the call for testing is what daemon(s)
should be run on top of the driver?  I saw ospmd-20020509.tar.gz
on the sf site; is that the most current?

-JimC



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
