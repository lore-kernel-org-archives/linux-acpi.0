From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: Support for "standby" in ACPI4Linux
Date: Thu, 17 Nov 2005 10:16:30 +0100
Message-ID: <87ek5fr5w1.fsf@gismo.pca.it>
References: <437C1EF2.1090806@earthlink.net>
Reply-To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
 protocol="application/pgp-signature"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <437C1EF2.1090806-ihVZJaRskl1bRRN4PJnoQQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-=-=
Content-Transfer-Encoding: quoted-printable

Hello!

On Thu 17 Nov 2005 07:10 +0100, Spam Guard wrote:
> I'm have a Thinkpad T42, and on it I'm running a kernel compiled
[...]
> Suspend2 (www.suspend2.net), in case that's of consequence.=20

I've a T42p with Debian unstable, vanilla kernels 2.6.13, 2.6.14 and
2.6.15-rc1, compiled with the Debian-way (make-kpkg).

> ACPI "sleeping" to memory works pretty well on my computer, but I
> was wondering about the "standby" mode.  My /sys/power/state reports
> that it's capable of both "mem" and "standby,"

AFAIK, S1 (aka standby) is not supported on the T42p:
=3D=3D=3D=3D=3D
luca@gismo:~$ grep S3 /var/log/syslog
Nov 17 08:44:46 gismo kernel: ACPI: (supports S0 S3 S4 S5)
Nov 17 09:02:47 gismo kernel: ACPI: (supports S0 S3 S4 S5)
luca@gismo:~$=20
=3D=3D=3D=3D=3D

But strangely:
=3D=3D=3D=3D=3D
luca@gismo:~$ cat /sys/power/state=20
standby mem disk=20
luca@gismo:~$=20
=3D=3D=3D=3D=3D

IIRC this is a bug in the sleep state showing function.

> but "mem" is the only option that seems to work.  With "standby" all
> I get is a message that reads "acpi_pm_prepare does not support 1"
> on virtual terminal 63.

I use S3 (suspend-to-ram) and S4 (suspend-to-disk) without any problem
since 2.6.12 (or before, I don't remember), directly from X.org with
the FLOSS radeon driver (and with all the driver but the modem
installed, included the ipw2100).  And the machine survives to multiple
sleep cycles :-D

I've never tried suspend2, because the vanilla ACPI is working
perfectly.

Thx, bye,
Gismo / Luca

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDfEpwVAp7Xm10JmkRAiD4AJ9SmflTis73CNfzv9zQTX6jPK0rmgCeI9d/
ut4E56wh7eGNlS9Gpfl6y7o=
=ZDH1
-----END PGP SIGNATURE-----
--=-=-=--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
