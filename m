From: <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Subject: Re: Located the problem with the VIA KT400 board
Date: Mon, 14 Jul 2003 17:32:24 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.33.0307141730001.1166-100000@frog.athome>
References: <200307140208.07975.adq_dvb@lidskialf.net>
Reply-To: <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200307140208.07975.adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Cc: thunder7-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut Andrew,
might it be a good idea to then step back to try creating an normal IRQ
resource if the extended one failed?

On Mon, 14 Jul 2003, Andrew de Quincey wrote:
> It does something like:
> if (irq <= 15) {
>   ... create an IRQ resource
> } else {
>   ... create an extended IRQ resource
> }
>....
> This assumes the resource passed to it is a normal IRQ resource, and cannot
> cope with extended ones. It only checks bytes 1&2 of the argument. For an
> extended argument, it would have to check bytes 5,6,7,8.
>
> In linux, the call to acpi_pci_link_set() from acpi_pci_link_check() does not
> check the return status of the call. Otherwise this error would be detected.

Cheers
  hartwig felger

Hartwig Felger informatics

- -- 
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/Es0M9bBoTzOf1pMRAsLIAJ9SdnVbiHY9ScbvxplWivH0EAn8tQCePiLt
44cnbVelAe/Qax3A5TeJHrQ=
=nDFX
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
