From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Latest acpica
Date: Thu, 8 Sep 2005 12:35:48 -0700
Message-ID: <971FCB6690CD0E4898387DBF7552B90E02AA4005@orsmsx403.amr.corp.intel.com>
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
To: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
Cc: Frank <hugelmopf-S0/GAf8tV78@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

And this seems like a fairly relevant quote as well:

>Flex no longer conforms to the POSIX lex behaviour



> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Matthew Wilcox
> Sent: Thursday, September 08, 2005 12:31 PM
> To: Moore, Robert
> Cc: Frank; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] Latest acpica
>=20
> On Thu, Sep 08, 2005 at 12:23:50PM -0700, Moore, Robert wrote:
> > Tell me what needs to change in order to make it compatible.
>=20
> I've never looked into it in any detail.  From the Debian description:
>=20
>  The behaviour of Flex has undergone a major change since version
>  2.5.4a; Flex scanners are now reenterant, you may have multiple
>  scanners in the same program with differing sets of defaults, and
>  they play nicer with modern C and C++ compilers. The Flip side is
>  that Flex no longer conforms to the POSIX lex behaviour, and the
>  scanners require conforming implementations when flex is used in ANSI
>  C mode. The package flex-old provides the older behaviour.
>=20
> The GNU web page has some more detail:
>=20
>
http://www.gnu.org/software/flex/manual/html_chapter/flex_20.html#SEC20
>=20
> and there's a bug showing exactly this problem being encountered here:
>=20
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D191942
>=20
> The important bit is probably the quote:
>=20
> 	The relevant change in the new flex is that it's no longer valid
> 	to call unput() from the section after %%, only in actions or
> 	in the %{ ... %} section.
>=20
> HTH.
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
