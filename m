From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Acer 1703 and DSDT fixing questions
Date: Thu, 12 Feb 2004 10:09:17 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8401CBB6A4@PDSMSX403.ccr.corp.intel.com>
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
To: John <cirrus-m8NPtmh9OiN1HeySrBk8eLVCufUGDwFn@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> Yes in this instant the battery was full, but still:
> $ cat /proc/acpi/battery/BAT1/state
> present:                 yes
> capacity state:          ok
> charging state:          discharging
> present rate:            unknown
> remaining capacity:      5524 mAh
> present voltage:         16249 mV
>=20

The following _BST is cut from your DSDT, if i didn't miss somthing
it shows Battery Present Rate is always 0xFFFFFFFF, which is
Unknown rate. (According to  ACPI spec 2.0b 11.2.2.2)

            Method (_BST, 0, NotSerialized)
            {
	...
                If (LEqual (And (Local0, 0x01), 0x00))
                {
	....
                    Store (0xFFFFFFFF, Index (PBST, 0x01))
                }
	...
                Store (0xFFFFFFFF, Index (PBST, 0x01))
	....
                Return (PBST)
            }

> The present rate is unknown. Also alarms are not working.=20
> $ cat /proc/acpi/battery/BAT1/alarm
> alarm:                   unsupported
>=20

It's not strange that _BTP is not defined in your DSDT.
So it's right to say alam is unsupported. Maybe it is defined
in SSDT, but it's unlikely. You can check it.

So there is no Linux ACPI bug here. If you still treat them as
bug, Maybe you need to contact vendor.

--Luming



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
