From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: RE: preparing toshiba_acpi driver release
Date: Mon, 26 Jan 2004 13:54:38 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC8A51@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: John Belmonte <john-wanGne27zNesTnJN9+BGXg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> > Note that the strategy going forward is to create a generic=20
> acpi/video
> > extensions driver that works on all platforms.  When it is=20
> available, we
> > should remove the video functionality from toshiba_extras and
> > asus_extras.
> > http://bugzilla.kernel.org/show_bug.cgi?id=3D1944
> >=20
> > If anybody is excited about doing this, I'd be happy to work with a
> > volunteer.
> >=20
>=20
> ATM I'm more excited with the support of processor _CST (with a patch
> I already send to you and Dominik for first testing purpose), but
> if nobody else want to volunteer, why not?

Cool.  Go ahead and "ACCEPT" the bug to let others know you're looking
at it.

I think it would be good to get acpi video standardized to defuse the
need for more platform-specific code...  Indeed, the next piece of the
puzzle it to figure out how to properly do hot-keys correctly.  Surely
Windows doesn't have a driver for each OEM's buttons...

I think video brightness control will be a very popular and visible
feature -- no pun intened;-)

In the back of my head I'm also wondering if we've got a missing piece
of the suspend/resume puzzle here too -- and I'd hate for ACPI to be the
"missing link" to get that key feature working.

Thanks,
-Len


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
