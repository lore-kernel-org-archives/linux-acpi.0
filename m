From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: NO_RETURN_VALUE w/ 20040715
Date: Mon, 23 Aug 2004 14:54:24 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <37F890616C995246BE76B3E6B2DBE05501C72022@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Cc: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Reply from Phoenix:

Unless they can provide an error case for these operators, I'm not
convinced. Aren't they talking about driver clients? I'm not sure how
this affects the stated ASL case and I'm not willing to overhaul the
conversion rules yet again (which is what he's proposing)

Take a look at the cited cases: _FDE: evaluated by drivers. In this
case, the ACPI interpreter may have an issue with bad ASL and the fact
that old MS interpeters gave a pointer to data in both cases without
careful error checking. But this isn't an ASL issue, it is a
driver-level issue.

Tim





> -----Original Message-----
> From: Nate Lawson [mailto:nate-Y6VGUYTwhu0@public.gmane.org]
> Sent: Monday, August 23, 2004 2:27 PM
> To: Moore, Robert
> Cc: Alex Williamson; acpi-devel
> Subject: Re: [ACPI] NO_RETURN_VALUE w/ 20040715
>=20
> I don't think that approach will be helpful.  Instead, I think it
should
> be "if argument types differ and any arg is an integer, convert the
> other to an integer."  If not, error AE_TYPE.  We have something like
> this in FreeBSD where we found on older systems many methods that are
> supposed to return an integer returned a buffer instead.  So many that
> we added an automatic conversion for this to acpi_GetInteger().  Also,
I
> found a system that uses a package of integers for _FDE instead a
buffer
> of integers.
>=20
> In summary, I've seen a lot of buffers used where integers were
expected
> but never an integer expected to be converted to a buffer.
>=20
> -Nate
>=20
> Moore, Robert wrote:
> > I will prototype this using the existing internal mechanisms for
> > implicit object conversion.
> >
> > However, I'm not sure how or if this statement will work as
expected:
> >
> >
> >>>>>If (LEqual (Local0, 0x00))
> >>>>>{
> >
> >
> > since Local0 is a buffer, 0x00 will be converted to a buffer before
the
> > compare.
> >
> >
> >
> >>-----Original Message-----
> >>From: Alex Williamson [mailto:alex.williamson-VXdhtT5mjnY@public.gmane.org]
> >>Sent: Monday, August 23, 2004 1:34 PM
> >>To: Moore, Robert
> >>Cc: acpi-devel
> >>Subject: RE: [ACPI] NO_RETURN_VALUE w/ 20040715
> >>
> >>Bob,
> >>
> >>  Great, I was looking through the history of the LEqual operator
> >
> > across
> >
> >>the ACPI specs and it got rather convoluted, this seems like a good
> >>compromise.  Will there be a CA update to support this (preferably
in
> >>Linus' tree before 2.6.9 is tagged)?  I'd be happy to test on this
box
> >>if needed.  Thanks,
> >>
> >>	Alex
> >>
> >>On Mon, 2004-08-23 at 13:22 -0700, Moore, Robert wrote:
> >>
> >>>We are going to update the ACPI spec to something like this:
> >>>
> >>>*	For the following operators, the data type of the first operand
> >>>dictates both the required type of the second operand and the type
> >
> > of
> >
> >>>the result object.  (The second operator is converted, if
necessary,
> >
> > to
> >
> >>>match the type of the first operand.)
> >>>    Concatenate
> >>>    LEqual
> >>>    LGreater
> >>>    LGreaterEqual
> >>>    LLess
> >>>    LLessEqual
> >>>    LNotEqual



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
