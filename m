From: <liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Subject: Re: ACPI (20030522, 20030619) breaks 3c59x in 2.4, 2.5
Date: Tue, 24 Jun 2003 11:38:32 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.33.0306241137250.996-100000@frog.athome>
References: <3EF81563.9080409@relex.ru>
Reply-To: <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3EF81563.9080409-343whMTK1pU@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Yaroslav Rastrigin <yarick-343whMTK1pU@public.gmane.org>
Cc: ACPI-Devel mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut Yaroslav,
I am curios what the /proc/interrupts diff looks like...

On Tue, 24 Jun 2003, Yaroslav Rastrigin wrote:
> I've posted this message on lkml, but it went practically unnoticed.
> Well, realising this list is a more appropriate place  - I'm (re)posting it
> here, with some additional info.
> The problem is:
> with ACPI patches mentioned in Subject and ACPI enabled in kernel, NIC in my
> laptop (3c556 Laptop Hurricane, according to driver output) fails to detect
> proper card configuration, including, but not limited to, media it is working
> with, availability of MII transceiver(s), and other important parameters.
> Kernels tested:
> 2.4.20, 2.4.21-rc7, 2.4.21, 2.4.21-ac, 2.5.70, 2.5.72
> What I've tried to fix this (apparently wrong) behaviour:
> pci=noacpi and  pci=biosint kernel cmdline arguments,  enabling/disabling
> different PCI access modes (BIOS/Direct/Any).
Hartwig Felger

Hartwig Felger informatics

- -- 
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE++Bwc9bBoTzOf1pMRAjqqAJ47GizHR+QnL0Nn+8OzBaEZiORUbQCfdYC5
tHoto2CY1WpDlhswYBlOAqA=
=gqlR
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
