From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: OperationRegion outside scope
Date: Tue, 16 Nov 2004 07:40:17 -0800
Message-ID: <37F890616C995246BE76B3E6B2DBE05502A865AF@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Paulo da Silva <pvmagacho78-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Version 20040715 of the compiler inadvertently truncates some constants
that appear at the module level.

There are newer versions of the compiler that fix this problem.
However, the web site is still under update.

Bob


> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Paulo da Silva
> Sent: Tuesday, November 16, 2004 3:47 AM
> To: Bruno Ducrot
> Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] OperationRegion outside scope
>=20
> Hi,
>=20
>   I've tryed my AML file compiled with version
> 20040427 of iasl and it seems to work fine. So I think
> the version 20040715 of iasl doesn't seem to handle
> operation regions that are outside any scope.
>=20
> Paulo
>=20
> --- Paulo da Silva <pvmagacho78-/E1597aS9LQAvxtiuMwx3w@public.gmane.org> wrote:
>=20
> >
> > Hello,
> >
> >   the version I was using was 20040715. I've tryed
> > with version 20040427 and the problem seems to have
> > disapperead. Looking at the compiled file it's
> > possible to see that the operation regions don't
> > have
> > zero size anymore. I will try later today to reboot
> > my
> > computer with the file compiled with version
> > 20040427
> > to see if everything goes ok. I will post the
> > results
> > later.
> >   Thank you for your answer.
> >
> > Regards,
> > Paulo
> >
> > --- Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org> wrote:
> >
> > > On Fri, Nov 12, 2004 at 06:22:16PM +0100, Bruno
> > > Ducrot wrote:
> > > >
> > > > I would say this is a bug in iasl or else a
> > *lot*
> > > of DSDT are buggy as
> > > > well though never got that kind of report
> > > before...
> > > >
> > > > Which iasl version are you using?  Could you
> > post
> > > to me the DSDT.aml produced?
> > >
> > > I can reproduce this trouble with current iasl,
> > but
> > > not with the
> > > 20040427.  I will send you (privately due to the
> > > size) the iasl I'm using.
> > >
> > > --
> > > Bruno Ducrot
> > >
> > > --  Which is worse:  ignorance or apathy?
> > > --  Don't know.  Don't care.
> > >
> >
> >
> >
> >
> > __________________________________
> > Do you Yahoo!?
> > Check out the new Yahoo! Front Page.
> > www.yahoo.com
> >
> >
> >
> >
> >
> -------------------------------------------------------
> > This SF.Net email is sponsored by: InterSystems
> > CACHE
> > FREE OODBMS DOWNLOAD - A multidimensional database
> > that combines
> > robust object and relational technologies, making it
> > a perfect match
> > for Java, C++,COM, XML, ODBC and JDBC.
> > www.intersystems.com/match8
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> >
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> >
>=20
>=20
>=20
>=20
> __________________________________
> Do you Yahoo!?
> Meet the all-new My Yahoo! - Try it today!
> http://my.yahoo.com
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: InterSystems CACHE
> FREE OODBMS DOWNLOAD - A multidimensional database that combines
> robust object and relational technologies, making it a perfect match
> for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
