From: <liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Subject: Re: Problem with ACPI-patch
Date: Mon, 23 Jun 2003 22:44:32 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.33.0306232244001.2066-100000@frog.athome>
References: <Pine.LNX.4.33.0306231456340.11371-600000@dark.pcgames.pl>
Reply-To: <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.33.0306231456340.11371-600000-WueNddHYZwu1SRXUKfATMw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?ISO-8859-2?Q?Krzysztof_Ol=EAdzki?= <ole-gcSpNFQc7Gg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut list,
there is one thing in the /proc/interrupts that is not right, and it is
not a MP problem. I also got this with a single-processor board with
ioapic.
The point I mean is, that some PCI devices got an edge-driven IRQ, what i=
s
wrong (only the ones that are not connected through the XT-PIC). And
surprise, this devices will not work this way :-((( Am I right Krzysztof?

Where does it come from? Is this a bad written DSDT in the BIOS, or is
this a Linux issue?

On Mon, 23 Jun 2003, [ISO-8859-2] Krzysztof Ol=EAdzki wrote:
> I have problem with acpi-patch for linux kernel 2.4.x on one of my
> servers. It is 2xP4 Xeon 2.4 GHz with Intel Mainboard. Last
> working version is AFAIR 20030228. New versions have problem
> with with initialisation of IO-APICs controlers. I attached
> /proc/interrupts (acpi.*.int) and dmesg (acpi.*.dmesg) outputs from
> 2.4.21-rc4 with both patches: 20030228 (*.ok.*) and 20030522 (*.err.*) =
and
> ".config" file.

Cheers
  hartwig felger

Hartwig Felger informatics

- --=20
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint =3D FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+92a19bBoTzOf1pMRAmzTAKCIxLNf7+JLiL60k9CJHqYm5Mj+1QCeNrVk
jIN0QjhoVQEvo6hjUIPh1lI=3D
=3Dbs+M
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
