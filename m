From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: AE_BAD_HEX_CONSTANT
Date: Fri, 12 Nov 2004 15:08:37 -0800
Message-ID: <37F890616C995246BE76B3E6B2DBE055029F9D83@orsmsx403.amr.corp.intel.com>
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
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>, Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Paulo da Silva <pvmagacho78-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I'm looking at this.
Bob


> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Nate Lawson
> Sent: Friday, November 12, 2004 2:57 PM
> To: Bruno Ducrot
> Cc: Paulo da Silva; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] AE_BAD_HEX_CONSTANT
>=20
> Bruno Ducrot wrote:
> > On Tue, Nov 09, 2004 at 11:49:44AM -0800, Nate Lawson wrote:
> >
> >>                        Name (BT0I, Package (0x0D)
> >>                        {
> >>                            0x01,
> >>                            0x19C8,
> >>                            0x19C8,
> >>                            0x01,
> >>                            0x39D0,
> >>                            0x014A,
> >>                            0xDC,
> >>                            0x012C,
> >>                            0x0294,
> >>                            "ANA",
> >>                            "110",
> >>                            "Lion",
> >>                            0x00
> >>                        })
> >>
> >>Looking more carefully, it looks like commenting out just the last
line
> >>("Acer") would suffice.  Index 0xC is actually an integer (0x00) so
this
> >>is what triggers the Integer conversion.  I'm not sure how the
> >>conversion rules should be modified to take this into account.
> >>
> >
> >
> > I suggest to replace the last integer with a string like "Acer".
Since
> > anyway BT0I is expected to be a package returned by a _BIF method,
it
> > must be compatible with ACPI spec (look at 11.2.2.1).
> >
>=20
> I agree to test this, but I'd also like to see acpi-ca improved to
> handle this case with the stock ASL.
>=20
> --
> Nate
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
