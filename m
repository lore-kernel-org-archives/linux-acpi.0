From: "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Re: Radeon PM Support
Date: Thu, 19 Aug 2004 07:03:38 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <88056F38E9E48644A0F562A38C64FB6002A92B31@scsmsx403.amr.corp.intel.com>
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
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
>Pavel Machek
>Sent: Thursday, August 19, 2004 4:17 AM
>To: Stefan Seyfried
>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: [ACPI] Re: Radeon PM Support
>
>Hi!
>
>> > > Yes. If this patch works for tohers, then we can move it into
>> > > pci_default_resume during the cleanup.
>> >=20
>> >=20
>> > I'd rather not do that. Some cards are already posted after
>> > S3, some even preserve state over S3. It is okay to do VGAPOST
>> > for radeon and any card that needs it, but I'd rather not=20
>do it generically.
>>=20
>> what about "acpi_sleep=3Dvgapost"?
>
>Could work, too.
>
>BTW I tried vgapost here, and it did not work on 2 radeon machines I
>have here. Could you possibly do some testing on bigger number of
>machines to find one where it actually works?
>								Pavel
>--=20

I guess we need to do something like this "acpi_sleep=3Dvgapost",=20
rather than doing a generic vgapost for all display devices.=20
As the generic solution seems to have broken few systems=20
which were working before.

I have two systems with almost identical video setup, with=20
Radeon 9000M AGP adapter. vgapost works on one system and=20
fails on another. The failing system never returns=20
from real mode vgapost call. I also found that=20
the VBIOS is not same on these two systems. Probably=20
different versions of the firmware. I am digging further=20
to find out why it works on one Radeon 9000M and not=20
on another one.=20

-Venki


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
