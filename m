From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: bug report: multi-byte access in indexfields broken
Date: Tue, 23 Sep 2003 09:46:36 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <571ACEFD467F7749BC50E0A98C17CDD8E84D68@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
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
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Robert Vollmert <rvollmert-lists-hi6Y0CQ0nG0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,
    I opened a track in OSDL 1260. Please add you in the CC list.

Thanks,
Shaohua


-----Original Message-----
From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org =
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Ducrot =
Bruno
Sent: 2003=C4=EA9=D4=C222=C8=D5 22:03
To: Robert Vollmert
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: Re: [ACPI] bug report: multi-byte access in indexfields broken

On Sun, Sep 21, 2003 at 10:05:25PM +0200, Robert Vollmert wrote:
> Hello,
>=20
> it appears the problems I mailed about earlier are due to a bug in the
> ACPI code. Reading from multi-byte fields in a ByteAccess-IndexField
> seems to be broken.
>=20
> When I replace
>=20
> IndexField (EIND, EDAT, ByteAcc, NoLock, Preserve)
> {
>     Offset (0x10),=20
>     IKFG,   8,=20
>     FRPN,   16,=20
>     RAMB,   32,
>     AVOL,   8,=20
> ...
> }
>=20
> Method (CRMB, 0, NotSerialized)
> {
>     Return (RAMB)
> }
>=20

After some testing, I found that this bug happens with word access
as well, and only when the field is not aligned with 8 (in case
of dword), which do not make sence as a buggy ASL due to the ByteAcc.

I consider that bug being critical.  I'm not sure if that happens for
other types other than Index one (that piece of code being shared =
between
4 kind of OR).

Anyway, most of use done by IndexField is to access CMOS data.  I prefer
not to think what happens if a write is done, and if the write is buggy
as well.

--=20
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
