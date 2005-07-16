From: "Jared Jones" <jared.jones-2fML+01oaiNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Compaq Deskpro EN SFF P500 DSDT Compile Error 1022
Date: Sat, 16 Jul 2005 02:39:27 -0400 (EDT)
Message-ID: <1749.192.168.1.3.1121495967.squirrel@www.briarhood.com>
References: <11957.137.71.23.54.1121461356.squirrel@www.briarhood.com>
    <20050716060825.GA4330@tangens.sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050716060825.GA4330-hxMeMO63rIAUgFT2KJq8fg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

  MLEN is never defined in my DSDT.  It is only used once in the line of
the compile error.

What does this line and section of code do?
What bogus value can be used to define MLEN?
Could this have anything to do with WOL?

Thanks,
Jared


>> I am trying to debug two issues on my machine:
>> 1) WOL not working in Linux; maybe ACPI screws it up
>> 2) Poweroff only occurs when acpi=3Dforce in Linux kernel option
>>
>> So I wanted to check the machine's DSDT, which, go figure, was compile=
d
>> using the Microsoft compiler and fails with the Intel compiler.  Can
>> anyone please assist me in editing the DSDT?  I have never done this
>> before.  Thanks!
>>
>>
>> deskpro_en_dsdt.dsl   263:                 Add (MLEN, 0x00100000, RAMT=
)
>> Error    1022 -              Object does not exist ^  (MLEN)
> Hi!
>   Try to find the MLEN name using Your text editor. Does it occur also =
at
> another place than in the snippet below ? If yes, post it also here...
> There should be sometihng like Name (MLEN, 0x100) or whatever what defi=
nes
> MLEN. If there isn't such a thing, I'm curious how the M$ compiler can
> compile this (maybe some internal symbol ?)
>                                         With regards, Pavel Troller
>>
>>
>> This line of code is from the following snippet of the DSDT:
>>
>>     Scope (\_SB)
>>     {
>>         Device (PCI0)
>>         {
>>             Name (_HID, EisaId ("PNP0A03"))
>>             Name (_ADR, 0x00)
>>             Name (CRES, ResourceTemplate ()
>>             {
>>
>>             ... a bunch of other code regarding addresses ...
>>
>>             Method (_CRS, 0, NotSerialized)
>>             {
>>                 CreateDWordField (CRES, 0x76, RAMT)
>>                 CreateDWordField (CRES, 0x82, PCIT)
>>                 Add (MLEN, 0x00100000, RAMT)
>>                 Subtract (0xFFE00000, RAMT, PCIT)
>>                 Return (CRES)
>>             }
>>
>
>




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclic=
k
