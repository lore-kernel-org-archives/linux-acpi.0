From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: a bit confused
Date: Sat, 22 Nov 2003 00:16:34 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC886C@hdsmsx402.hd.intel.com>
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
To: mark-Wx4BgtDyjI+1Z/+hSey0Gg@public.gmane.org
Cc: Giorgenes Gelatti <giorgenes.canopus-y7mWNqJcIDpfJ/NunPodnw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

None of the OSDs are mentioned because the patch is against the 2.4.22
baseline kernel -- not any particular OSD's kernel.

patch --dry-run -Np1 < acpi.patch

Will tell you if it is going to apply cleanly.

Cheers,
-Len

> -----Original Message-----
> From: mark.acpi-Wx4BgtDyjI+1Z/+hSey0Gg@public.gmane.org [mailto:mark.acpi@winksmith.com]=20
> Sent: Friday, November 21, 2003 11:00 PM
> To: Brown, Len
> Cc: Giorgenes Gelatti; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] a bit confused
>=20
>=20
> On Thu, Nov 20, 2003 at 10:41:26PM -0500, Brown, Len wrote:
> > If it does not and you'd like to try the latest ACPI patch,=20
> the oldest
> > kernel we support is 2.4.22:
> >=20
> http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patche
s/release/2.4.22

i have a debian 2.4.22 (some small amount of magic foo patched in
already).  would you happen to know if that patch apply to my kernel?
i've read some conflicting stuff about it.

>
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/README.A
CPI

debian isn't mentioned in it.

thanks.

--=20
Mark Smith
mark-Wx4BgtDyjI+1Z/+hSey0Gg@public.gmane.org
mark at tux dot org
nova-instructor at tux dot org
F: 775-522-8479


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
