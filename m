From: "Jared Jones" <jared.jones-2fML+01oaiNBDgjK7y7TUQ@public.gmane.org>
Subject: Compaq Deskpro EN SFF P500 DSDT Compile Error 1022
Date: Fri, 15 Jul 2005 17:02:36 -0400 (EDT)
Message-ID: <11957.137.71.23.54.1121461356.squirrel@www.briarhood.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I am trying to debug two issues on my machine:
1) WOL not working in Linux; maybe ACPI screws it up
2) Poweroff only occurs when acpi=3Dforce in Linux kernel option

So I wanted to check the machine's DSDT, which, go figure, was compiled
using the Microsoft compiler and fails with the Intel compiler.  Can
anyone please assist me in editing the DSDT?  I have never done this
before.  Thanks!


deskpro_en_dsdt.dsl   263:                 Add (MLEN, 0x00100000, RAMT)
Error    1022 -              Object does not exist ^  (MLEN)


This line of code is from the following snippet of the DSDT:

    Scope (\_SB)
    {
        Device (PCI0)
        {
            Name (_HID, EisaId ("PNP0A03"))
            Name (_ADR, 0x00)
            Name (CRES, ResourceTemplate ()
            {

            ... a bunch of other code regarding addresses ...

            Method (_CRS, 0, NotSerialized)
            {
                CreateDWordField (CRES, 0x76, RAMT)
                CreateDWordField (CRES, 0x82, PCIT)
                Add (MLEN, 0x00100000, RAMT)
                Subtract (0xFFE00000, RAMT, PCIT)
                Return (CRES)
            }




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclic=
k
