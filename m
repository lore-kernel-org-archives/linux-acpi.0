From: Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>
Subject: Re: acpi_processor_get_per: Unsupported address space
Date: Tue, 22 Jul 2003 11:14:28 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m2znj677jv.fsf@tnuctip.rychter.com>
References: <m2oezpghjy.fsf@tnuctip.rychter.com>
	<20030722121119.GA1964@brodo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

>>>>> "Dominik" =3D=3D Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org> writes:
 Dominik> On Sun, Jul 20, 2003 at 11:49:05AM -0700, Jan Rychter wrote:
 >> On a Toshiba Dynabook SS S7/290LNKW (Centrino-based), kernel
 >> 2.4.22-pre7 (also tested with pre5).
 >>
 >> I am getting the following message at bootup:
 >>
 >> acpi_processor-0899 [31] acpi_processor_get_per: Unsupported address
 >> space [127] (control_register) ACPI: Processor [CPU0] (supports C1
 >> C2 C3) ACPI: Thermal Zone [THRM] (44 C)
 >>
 >> What does this mean? Does it indicate problems?

 Dominik> It means that the "performance states" =3D=3D SpeedStep states are
 Dominik> only available using the binary-only processor.o replacement
 Dominik> module available at Intel's ACPI site, or using the cpufreq
 Dominik> speedstep-centrino module [patches in 2.5., or at
 Dominik> http://www.codemonkey.org.uk/cpufreq/ once davej's server is
 Dominik> back online]

Dave's server is still down, it seems. Is there a 2.4 port of these
drivers? I don't think I'm ready for 2.5 yet, having just achieved a
stable 2.4 kernel on my laptop, which took about 1.5 years.

The binary-only driver is for 2.4.21-rc1 only, so it's of no use to me
(I have 2.4.22-pre7 and have to follow the -pre series because of USB
bugs).

I have to say I feel kind of silly playing this hide and seek game with
Intel. On one hand Intel says they support Linux
(http://news.com.com/2100-1006-993896.html). On the other hand we get no
support for speedstep (what on earth do you lose by telling people how
to program your hardware?), no support for Centrino wireless LAN. I find
it both ridiculous and sad.

=2D-J.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/HX8JLth4/7/QhDoRAnPhAJ9qZocJ5c3fhNs0AJ+HVlIkvE4vsgCgnN8/
pRft4w3J7nxvsXn85Okc59c=
=mG3C
-----END PGP SIGNATURE-----
--=-=-=--


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
