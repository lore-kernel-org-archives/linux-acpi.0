From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Acpi on compaq evo N1000v
Date: Mon, 12 May 2003 15:50:01 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F842722F4@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: oystein.olsen-rcBQPNaXqvV2YatnTvQNog@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On this mailing list, I saw some similar battery issues on various =
Compaq laptop, such as (Presario 1500, 1505us, 2800T).
I'm interested in the dsdt tables that can make battery status work on =
your presario 2800T. Would you please share it with us?=20
To let us better understand the original problme you ran into, would you =
please send me the orginal DSDT on N800v as well as the fixed one.
I hope guys who were defeated by battery could absorb some useful =
information from your experience.  :)
If you still have problem, please file it on bugzilla.kernel.org.

Thanks
Luming

-----Original Message-----
From: Oeystein Olsen [mailto:oystein.olsen-rcBQPNaXqvV2YatnTvQNog@public.gmane.org]
Sent: 2003?5?11? 0:02
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: Re: [ACPI] Acpi on compaq evo N1000v


Followup to my own post now.

I've finally gotten battery status on my laptop:-) Acpi seems to fully=20
functional now. I solved my last problems by looking at how dsdt-table =
from=20
evo N800v and presario 2800T loaded. I was rather suprised to see that =
the=20
presario-table produced battery-status. Hence I rewrote parts of my =
original=20
dsdt-table to reflect the battery part in the presario table and bingo! =
I=20
still get these errors at boot though:
>
> psparse-1121: *** Error: Method execution failed
> [\_SB_.C03B.C04E.C0CF.C0D3] (Node c185e728), AE_NOT_EXIST
>
> Method execution failed [\_SB_.C03B.C04E.C0CF._INI] (Node c185b6a8),
> AE_NOT_EXIST
>
> nsinit-0397 [06] ns_init_one_device    : \_SB_.C03B.C04E.C0CF._INI =
failed:
> AE_NOT_EXIST
>
>  .........................................evrgnini-0261: *** Error: =
Could
> not install pci_config handler for C03B, AE_ALREADY_EXISTS
>
=20
but I'm happy for now.

--=20
=D8ystein Olsen, oystein.olsen-rcBQPNaXqvV2YatnTvQNog@public.gmane.org, http://folk.uio.no/oeysteio
Institute of Theoretical Astrophysics, http://www.astro.uio.no
University of Oslo, Norway









-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
