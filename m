From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: Re: swsusp fails with
 "FATAL: cannot find swap device, try swapon -a!"
Date: Tue, 01 Mar 2005 12:05:18 +0100
Message-ID: <873bvfk4nl.fsf@gismo.pca.it>
References: <42225F85.1000302@gmx.net> <20050228000401.GK1441@elf.ucw.cz>
Reply-To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
 protocol="application/pgp-signature"
In-reply-to: <20050228000401.GK1441-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-=-=

Hello!

On Mon 28 Feb 2005 01:04 +0100, Pavel Machek wrote:
> And you have resume= on command line, right? CONFIG_..._STD_PARTITION
> should not be required, but I have it set like this:

I don't have 'resume' on my command line, but I've
CONFIG_..._STD_PARTITION, it works great with 2.6.10 and 2.6.11-rc4:
=====
luca@gismo:~$ cat /proc/cmdline
root=/dev/hda2 ro acpi_sleep=s3_bios
luca@gismo:~$ grep STD_PARTITION /boot/config-2.6.10-mh4
CONFIG_PM_STD_PARTITION="/dev/hda5"
luca@gismo:~$
=====

Just my 0.02c...

Thx, bye,
Gismo / Luca

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCJExvVAp7Xm10JmkRAjD6AJsFnjB9eNfTZy3/NPp1HdnPlbhzOQCeMajS
jssl+JoLklazdhOE4s/GEv0=
=BA3J
-----END PGP SIGNATURE-----
--=-=-=--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
