From: "Cagle, John (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>
Subject: RE: redhat comment about intel not taking patches?
Date: Wed, 12 Feb 2003 22:11:26 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C50AB9511EE59B49B2A503CB7AE1ABD10440E3DB@cceexc19.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Darren Benham <dbenham-FG1iuTdj8bisTnJN9+BGXg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Can you be more specific in your comments regarding Compaq hardware?  We
test our ProLiant servers with Linux and ACPI, and our BIOS is designed
for many different operating systems, including Linux, Unix and NetWare.
On the other hand, it is unreasonable to expect that our laptop and
desktop divisions test with Linux ACPI for two big reasons: first, the
Linux OS has a very small share of those markets, and second, Red Hat's
releases don't even have ACPI support.

Thanks,
John
--------------------------------
John Cagle     john.cagle-VXdhtT5mjnY@public.gmane.org
Principal Member Technical Staff
   Industry Standard Servers
    Hewlett-Packard Company
    http://www.hp.com/linux
       jcagle-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org

> -----Original Message-----
> From: Darren Benham [mailto:dbenham-FG1iuTdj8bisTnJN9+BGXg@public.gmane.org]=20
> Sent: Wednesday, February 12, 2003 8:55 PM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: RE: [ACPI] redhat comment about intel not taking patches?
>=20
>=20
> Is ACPI going to be able to go mainstream in any of the major=20
> releases w/o making some effort to work in non-standard BIOS=20
> (read, the BIOSes written directly for Windows)?  Is it ever=20
> likely that pressure would work against those Bios=20
> manufacturers that dont' follow spec?  I mean, Compaq is on=20
> the list of partners for ACPI and their DSDT's are crap, with=20
> asterisks in names and functions returning values that=20
> shouldn't, etc. Grover, Andrew said:
> >> From: Kevin Fenzi [mailto:kevin-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org]
> >> RedHat is playing with enabling ACPI in their next=20
> release. (At least=20
> >> in the beta for the next release: phoebe).
> >>
> >> Noticed this changelog comment in the phoebe kernel:
> >>
> >> * Thu Nov 07 2002 Arjan van de Ven <arjanv-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> >> - - remove ACPI again because Intel is unwilling to take patches
> >>
> >> What patches are they talking about?
> >>
> >> Is there any way we could fix up the communication=20
> breakdown between=20
> >> RedHat/Intel?
> >>
> >> It would be great if ACPI would work out of the box on my=20
> laptop with=20
> >> a RedHat kernel. At a minimum I guess it would require acpi to be=20
> >> able to detect the compaq *PNP stuff and remove the * so the table=20
> >> works.
> >
> > I have been in contact with a number of distributions concerning=20
> > inclusion of ACPI support. I think the new licensing and=20
> some recent=20
> > source improvements helped a lot to make people feel better about=20
> > ACPI, but there still are a number of critical bugs that=20
> are affecting=20
> > a significant percentage of systems. These need to be fixed. These=20
> > have to do with *any* ACPI-related oopses, failure to boot=20
> using ACPI,=20
> > and failure to shutdown cleanly.
> >
> > ACPI is not going to be in the next RH release but we are really=20
> > pushing to get it in subsequent releases, but we need to fix those=20
> > critical bugs.
> >
> > Regards -- Andy
> >
> >
>=20
>=20
> --=20
> Darren


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
