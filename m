From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: ASUS M6800N: processor has only C1
Date: Sat, 20 Mar 2004 19:39:04 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <405C8FC8.3050701@pca.it>
References: <404459FD.1000406@pca.it>  <405C1D0F.3030209@pca.it> <1079803656.32419.15.camel@djinn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1079803656.32419.15.camel-l85cmlzfk8I@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

on 03/20/04 18:27, Herman Sheremetyev wrote:
> With a little DSDT tweak I get the following output:
<cut>
> The fix requires simply changing one value in the DSDT from:
>
> Processor (CPU1, 0x01, 0x00000410, 0x07)
>
> to:
>
> Processor (CPU1, 0x01, 0x00000410, 0x06)
this hack was already known
	http://sourceforge.net/mailarchive/message.php?msg_id=7451801

But the same can be achieved using Bruno Ducrot's at
	http://bugzilla.kernel.org/show_bug.cgi?id=1958

Please read the whole thread here
	http://sourceforge.net/mailarchive/message.php?msg_id=7451789

AFAIK Bruno's patches are a /cleaner/ solution, as you can have C1 & C2 without
hacking your DSDT. On the other hand, it seems that our laptop support C4 state
(via _CST), which is the final objective of Bruno's patches IIRC.

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAXI/HVAp7Xm10JmkRAoieAJ9wkCvoWudcEGXu+Kq78AmqGkoYJQCfThQg
H84lZKxoXpvApZHLilJkA9Y=
=iyHh
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
