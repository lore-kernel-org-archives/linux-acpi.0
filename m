From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Latest acpica
Date: Thu, 8 Sep 2005 12:23:50 -0700
Message-ID: <971FCB6690CD0E4898387DBF7552B90E02AA3FD6@orsmsx403.amr.corp.intel.com>
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
To: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>, Frank <hugelmopf-S0/GAf8tV78@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Tell me what needs to change in order to make it compatible.
Bob

> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Matthew Wilcox
> Sent: Thursday, September 08, 2005 11:39 AM
> To: Frank
> Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] Latest acpica
>=20
> On Thu, Sep 08, 2005 at 06:59:57PM +0200, Frank wrote:
> > I am having problems compiling this compiler on AMD64.
> > It throws the following error message:
> >
> > [compiler] $ make
> > cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -
> I../include
> > -c -o aslcompilerlex.o aslcompilerlex.c
> > aslcompiler.l: In function `comment':
> > aslcompiler.l:847: error: `yytext_ptr' undeclared (first use in this
> function)
> > aslcompiler.l:847: error: (Each undeclared identifier is reported
only
> once
> > aslcompiler.l:847: error: for each function it appears in.)
> > make: *** [aslcompilerlex.o] Error 1
>=20
> Are you on Debian?  I think this means you need to install flex-old.
>=20
> Do Intel have any plans to make this compatible with versions of GNU
flex
> after 2.5.4a?
>=20
>=20
>=20
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle
> Practices
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing
& QA
> Security * Process Improvement & Measurement *
http://www.sqe.com/bsce5sf
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
