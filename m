From: "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Re: Radeon PM Support
Date: Thu, 19 Aug 2004 09:03:34 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <88056F38E9E48644A0F562A38C64FB6002A92BF9@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: stefandoesinger-RbZlAiThDcE@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


>-----Original Message-----
>From: Stefan D=F6singer [mailto:stefandoesinger-RbZlAiThDcE@public.gmane.org]=20
>Sent: Thursday, August 19, 2004 8:55 AM
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Cc: Pallipadi, Venkatesh; Pavel Machek; Stefan Seyfried
>Subject: Re: [ACPI] Re: Radeon PM Support
>
>
>> I have two systems with almost identical video setup, with
>> Radeon 9000M AGP adapter. vgapost works on one system and
>> fails on another. The failing system never returns
>> from real mode vgapost call. I also found that
>> the VBIOS is not same on these two systems. Probably
>> different versions of the firmware. I am digging further
>> to find out why it works on one Radeon 9000M and not
>> on another one.
>Interesting: vgapost failes on my Acer Travelmate 803(radeon=20
>mobility 9000)=20
>and Ole and I couldn't find any reason so far. How did you=20
>check what vbios=20
>your radeon card has?
>
>Does user-mode vgapost work for you? Strangely it does on my system.
>
>Stefan


I used the patch that exports vbios through sysfs and got=20
hexdump of vbios on the two systems.=20
[Look for Jon Smirl's patch in lkml, subject - "add PCI ROMs to sysfs"]

I somehow assumed that user-mode vgapost wont work on this system =
either.
I need to go and check it now...

-Venki


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
