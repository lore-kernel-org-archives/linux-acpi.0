From: Andrew Ross <aross-ncau/BB9MAPvnOemgxGiVw@public.gmane.org>
Subject: dsdt resources for acpi newbies
Date: Tue, 20 Jul 2004 21:45:53 +1000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1090323953.7894.13.camel@localhost>
References: <E1BmOT2-0007Em-1a@sc8-sf-list2.sourceforge.net>
	 <200407192003.20851.gaesferr@libero.it>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200407192003.20851.gaesferr-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 2004-07-20 at 04:03, Gaetano Sferra wrote:
> On Monday 19 July 2004 05:04, acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org wrote:
> > If you can not find a fixed DSDT at
> > http://acpi.sourceforge.net/dsdt/index.php or via google, I imagine you
> > will have to correct it yourself.
> >
> > Cheers
> >
> > Andrew
> 
> Thank you Andrew but I'm a newbie in the ACPI world so I don't know how to 
> correct it. Have you any suggestions?

Having just purchased a laptop (Astone Z7, which appears to be a
rebranded ASUS M6N), I am also feeling my way through the wonderful
world of ACPI.

There are some excellent resources for patching broken DSDTs, most of
which are linked to from (or present on) acpi.sf.net 

Don't forget to check out
http://forums.gentoo.org/viewtopic.php?t=122145

These guides can help normal users fix common breakages in DSDTs, but
for more serious problems (eg. my laptop's DSDT, which has over 200
errors) you will need time and patience. I am currently learning ASL
from the official ACPI spec (http://www.acpi.info/spec.htm) so I can fix
my DSDT. Hopefully, yours won't be as bad as mine :-)

Good luck!

Andrew



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
