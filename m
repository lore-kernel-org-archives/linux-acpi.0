From: <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Subject: Re: acpi breaking synaptics mouse support on Acer Travelmate
 260
Date: Thu, 21 Aug 2003 10:42:12 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.33.0308211034040.581-100000@frog.athome>
References: <20030820210235.GD5127@man.beta.es>
Reply-To: <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030820210235.GD5127-COUDbPDYh58xAGwisGp4zA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Santiago Garcia Mantinan <manty-gaW6/AuhO2xeoWH0uzbU5w@public.gmane.org>
Cc: Peter Osterlund <petero2-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut Garcia,
maybe your interrupts are routed differently depending on acpi compiled in
or not.
What does
 cat /proc/interrupts
differ for both setups? What are the respectively acpi-versions?
 cat /proc/acpi/info |grep version
Did you check the /var/log/boot.msg for error-messages, especially related
to ACPI?

On Wed, 20 Aug 2003, Santiago Garcia Mantinan wrote:
> Well, to sum up, for what I see looking at /proc/interrupts both 2.4 using
> the X synaptics driver, and 2.6 using the synaptics driver, produce
> aproximately the same interrupt behaviour, however 2.6 looses sync when acpi
> is compiled and works ok when acpi is not compiled :-(

cheers
  hartwig felger

Hartwig Felger informatics

- -- 
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/RIXp9bBoTzOf1pMRAkIGAJ9aSdR8AcAMDi2NfwVBUIWeZmVF8ACg3AtT
DaRAlqB8mSWUuK42dCXs2Qk=
=ha6j
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
