From: <liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Subject: Re: Re: Possible quick fix for ACPI routing problem on Nforce2
Date: Sun, 13 Jul 2003 11:19:05 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.33.0307131118210.561-100000@frog.athome>
References: <200307130218.44398.adq_dvb@lidskialf.net>
Reply-To: <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200307130218.44398.adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut Andrew,
On Sun, 13 Jul 2003, Andrew de Quincey wrote:
> Anyway, IRQs > 15 get set to Active low/Level Sensitive in the IO-APIC on
> my board.
>
> The fix (No patch as this is NOT a proper fix):
> Edit arch/i386/kernel/io_apic.c
> Find the function io_apic_set_pci_routing() (its the last one in 2.5.74).
> Change the line:
> entry.polarity = 1;         /* Low active */
>
> To:
> entry.polarity = 0;         /* High active */
>
> For me, this makes everything work fine. Originally, I also forced these
> IRQs to be edge sensitive, but leaving them at level seems to work fine as
> well.
Only ISA-IRQs are edge ones. As PCI has interrup-sharing, they need to be
level ones. I am pretty sure, that your irq > 15 are not for ISA
devices...

cheers
  hartwig felger

Hartwig Felger informatics

- -- 
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/ESQP9bBoTzOf1pMRAjJVAJ99bGTXXRiw/iBojCWYDiNNMtrUbQCg4XcL
merVrl51er6HGA9qFIk0gig=
=H/M+
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
