From: Al <al-PoJXY7Eze0c@public.gmane.org>
Subject: Re: CALL FOR TESTING
Date: Thu, 19 Sep 2002 16:44:30 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020919164430.46e66351.al@bglug.it>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE80@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha1; boundary="=.+GM1?)XAEad5Rj"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DE80-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--=.+GM1?)XAEad5Rj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Cosi' scrisse "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>:

> - DOES IT BOOT?
> - DOES IT ASSIGN INTERRUPTS PROPERLY?

Me again. Tested on laptop now (Asus B1520D) and it works (boot and IRQ).
One thing from dmsg:

pci_bind-0194 [08] acpi_pci_bind : Device 00:00:13.00 not present in PCI
   namespace

Attached: lspci -v, dmesg (relevant part).


Regards,


        Luca Amigoni


-- 

If you wrap the Internet around every person on the planet and spin the
planet, software flows in the network. [...] The resistance of the net-
work is directly proportional to the field strength of the intellectual
property system. (Eben Moglen)

--=.+GM1?)XAEad5Rj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE9ieLUhoX7z7O0EJERAqIZAJ48LFhPAMtkkl8+zndX9HULRH/AEACfSWVj
/Q/XyzZsaB0zpHoLiVo2lLI=
=nUlT
-----END PGP SIGNATURE-----

--=.+GM1?)XAEad5Rj--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
