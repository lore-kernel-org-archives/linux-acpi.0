From: Preston Lord <webmaster-xSlfl9GhdHA@public.gmane.org>
Subject: Re: Suse 8.1 on Acer TM430
Date: 12 May 2003 16:40:40 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1052779239.4204.16.camel@zipur.doublet>
References: <1052719668.7794.10.camel@zipur.doublet>
	 <Pine.LNX.4.53.0305120908440.438@dynast.gaugusch.at>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.53.0305120908440.438-sxQ525G0OhRQK2oVCIMtW7NldLUNz+W/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

ok, 

I have downloaded and installed the latest RPM k_deflt-2.4.20-62.src.rpm
from the location ftp://ftp.suse.com/pub/people/mantel/next/

I now read kernel version 2.4.20-4GB / i686

All power management areas still report the following:

Your computer seems to have a partial ACPI installation
brobably ACPI was enabled, but some of the sub-options
were not enabled - you need to enable at least 'AC Adaptor'
and 'Control Method Battery' and rebuild your kernel.

I also notice that since the upgrading of my kernel I get some driver
errors on bootup for devices that are not on my system... and my desktop
does not respond at all. So all my desktop contents are not showing
unless I navigate to my ~/Desktop folder manually and right clicking on
the desktop does nothing.

Thanks again for any help

Preston



On Mon, 2003-05-12 at 01:10, Markus Gaugusch wrote:
> On May 12, Preston Lord <webmaster-xSlfl9GhdHA@public.gmane.org> wrote:
> > I have read info in many places trying to find the answers to getting
> > acpi to run on my SuSE 8.1 Pro installation.
> After installing acpid, run "insserv acpid" and "rcacpid start"
> (or reboot).
> This will load processor/fan/thermal/... modules.
> But ACPI on SuSE 8.1 is from August 2002, which is quite old. You can also
> try a kernel from ftp://ftp.suse.com/pub/people/mantel/next/, which should
> have newer ACPI included.
> 
> Markus
-- 
Preston Lord
Programmer/Developer/Network Specialist
Double "T" Computer Services
SK, CA Ph.1.306.773.2054
==============================
http://www.t2.net (Hosting)
http://www.dinamicweb.com (iHTML Driven Dropsites)
http://www.ebboard.ca (iHTML Discussion Forum Software)





-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
