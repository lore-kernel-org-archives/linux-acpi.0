From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: BUG: power button doesn't generate events
Date: Fri, 8 Aug 2003 16:32:02 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720ACA@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
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
To: Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Andy has announced that bugzilla at osdl.org is the dedicated place for =
ACPI bug report (including 2.4 bug).
Thanks,
Luming

-----Original Message-----
From: Jan Rychter [mailto:jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org]
Sent: 2003=C4=EA8=D4=C28=C8=D5 4:11
To: Yu, Luming
Subject: Re: BUG: power button doesn't generate events


> Would you please file this issue on http://bugme.osdl.org/
> Thanks,

I'd be happy to, except this is with 2.4, not 2.5, and bugme.osdl.org
seems to be 2.5 only.

--J.

> -----Original Message-----
> From: Jan Rychter [mailto:jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org]
> Sent: 2003=C4=EA8=D4=C27=C8=D5 10:57
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] Re: BUG: power button doesn't generate events
>=20
>=20
>  >> From: Jan Rychter [mailto:jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org] I get LID button events
>  >> fine, but the power button doesn't seem to generate any events
>  >>
>  >> Does the following bit of DSDT mean the power button should =
generate
>  >> events?
>  >>
>  >> Device (PWRB) { Name (_HID, EisaId ("PNP0C0C")) Name (_PRW, =
Package
>  >> (0x02) { 0x08, 0x04 }) Name (_STA, 0x0B)
>  >> }
>=20
>  Andrew> ACPI: Power Button (FF) [PWRF]
>=20
>  Andrew> It looks like it is finding a fixed-feature power button =
before
>  Andrew> the control method power button, and therefore the CM power
>  Andrew> button isn't being set up. So this raises in my mind 2
>  Andrew> questions:
>=20
>  Andrew> 1) Why isn't the FF power button working?
>  Andrew> 2) On a system with both, is the current behavior (favor FF
>  Andrew>    over CM) the
>  Andrew> proper behavior?
>=20
> I hope these questions weren't addressed to me, because I certainly
> can't answer them. I just thought a bug report might be useful. And =
I'd
> like my power button to work some day :-)
>=20
> --J.
>=20


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
