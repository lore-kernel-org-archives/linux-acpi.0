From: "Cagle, John (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>
Subject: RE: redhat comment about intel not taking patches?
Date: Fri, 14 Feb 2003 08:21:33 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C50AB9511EE59B49B2A503CB7AE1ABD10440E3E4@cceexc19.americas.cpqcorp.net>
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
To: Darren Benham <dbenham-FG1iuTdj8bisTnJN9+BGXg@public.gmane.org>, Brad Parker <brad-2nKKSigPee+ibv+y4V69FXNtEUiqdi9I@public.gmane.org>, Troy Schultz <tschultz-zzOxFVvAfJPQT0dZR+AlfA@public.gmane.org>, Herbert Nachtnebel <Herbert.Nachtnebel-8zxNtbQCHXIjuwv8T7myQQ@public.gmane.org>, Dave Jones <davej-l3A5Bk7waGM@public.gmane.org>, John K Luebs <jkluebs-/p0RJYZkKrsK3IM9cGFl5Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I would like to thank every one of you that responded to my posting
about ACPI.  This has been very productive.  I'm putting all your
comments together and will be discussing this issue with our worldwide
Linux director.  My hope is that her team can influence the laptop and
desktop groups to improve their ACPI implementations, at a minimum, by
testing their ASL code (DSDT's, etc.) using the Intel compiler.

If you are using an EVO or PRESARIO laptop that has an ACPI problem,
please send me a private email to let me know which model number you are
using.  I will use that info to create a prioritized list for the BIOS
developers if they decide to fix the ASL code and release BIOS updates.
Thank you in advance for that info.

Thanks again,
John
--------------------------------
John Cagle     john.cagle-VXdhtT5mjnY@public.gmane.org
Principal Member Technical Staff
   Industry Standard Servers
    Hewlett-Packard Company
    http://www.hp.com/linux
       jcagle-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org

> -----Original Message-----
> From: Cagle, John (ISS-Houston)=20
> Sent: Wednesday, February 12, 2003 10:11 PM
> To: Darren Benham
> Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: RE: [ACPI] redhat comment about intel not taking patches?
>=20
>=20
> Can you be more specific in your comments regarding Compaq=20
> hardware?  We test our ProLiant servers with Linux and ACPI,=20
> and our BIOS is designed for many different operating=20
> systems, including Linux, Unix and NetWare. On the other=20
> hand, it is unreasonable to expect that our laptop and=20
> desktop divisions test with Linux ACPI for two big reasons:=20
> first, the Linux OS has a very small share of those markets,=20
> and second, Red Hat's releases don't even have ACPI support.
>=20
> Thanks,
> John
>=20
> > -----Original Message-----
> > From: Darren Benham [mailto:dbenham-FG1iuTdj8bisTnJN9+BGXg@public.gmane.org]
> > Sent: Wednesday, February 12, 2003 8:55 PM
> > To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > Subject: RE: [ACPI] redhat comment about intel not taking patches?
> >=20
> >=20
> > Is ACPI going to be able to go mainstream in any of the major
> > releases w/o making some effort to work in non-standard BIOS=20
> > (read, the BIOSes written directly for Windows)?  Is it ever=20
> > likely that pressure would work against those Bios=20
> > manufacturers that dont' follow spec?  I mean, Compaq is on=20
> > the list of partners for ACPI and their DSDT's are crap, with=20
> > asterisks in names and functions returning values that=20
> > shouldn't, etc. Grover, Andrew said:
> > >> From: Kevin Fenzi [mailto:kevin-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org]
> > >> RedHat is playing with enabling ACPI in their next
> > release. (At least
> > >> in the beta for the next release: phoebe).
> > >>
> > >> Noticed this changelog comment in the phoebe kernel:
> > >>
> > >> * Thu Nov 07 2002 Arjan van de Ven <arjanv-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > >> - - remove ACPI again because Intel is unwilling to take patches
> > >>
> > >> What patches are they talking about?
> > >>
> > >> Is there any way we could fix up the communication
> > breakdown between
> > >> RedHat/Intel?
> > >>
> > >> It would be great if ACPI would work out of the box on my
> > laptop with
> > >> a RedHat kernel. At a minimum I guess it would require acpi to be
> > >> able to detect the compaq *PNP stuff and remove the * so=20
> the table=20
> > >> works.
> > >
> > > I have been in contact with a number of distributions concerning
> > > inclusion of ACPI support. I think the new licensing and=20
> > some recent
> > > source improvements helped a lot to make people feel better about
> > > ACPI, but there still are a number of critical bugs that=20
> > are affecting
> > > a significant percentage of systems. These need to be fixed. These
> > > have to do with *any* ACPI-related oopses, failure to boot=20
> > using ACPI,
> > > and failure to shutdown cleanly.
> > >
> > > ACPI is not going to be in the next RH release but we are really
> > > pushing to get it in subsequent releases, but we need to=20
> fix those=20
> > > critical bugs.
> > >
> > > Regards -- Andy
> > >
> > >
> >=20
> >=20
> > --
> > Darren
>=20
>=20
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
