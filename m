From: Roman I Khimov <rik-MdmE8JOsREphl2p70BpVqQ@public.gmane.org>
Subject: Re: 2.6.15-rc5-mm3
Date: Thu, 15 Dec 2005 14:24:26 +0300
Message-ID: <200512151424.29986.rik@osrc.info>
References: <20051214234016.0112a86e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2852387.oganBcToFV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20051214234016.0112a86e.akpm-3NddpPZAyC0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--nextPart2852387.oganBcToFV
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

15 =D0=B4=D0=B5=D0=BA=D0=B0=D0=B1=D1=80=D1=8F 2005 10:40 | Andrew Morton:
>   - Roman I Khimov <rik-MdmE8JOsREphl2p70BpVqQ@public.gmane.org>: "Something went wrong with ACPI, my
>     fan is blowing constantly."

Just built 2.6.15-rc5-mm3, C2 state is back and everything is fine! Thanks.

rik@pu-erh:~> cat /proc/acpi/processor/CPU0/power
active state:            C2
max_cstate:              C8
bus master activity:     00000000
states:
    C1:                  type[C1] promotion[C2] demotion[--] latency[000] u=
sage[00057690]
   *C2:                  type[C2] promotion[--] demotion[C1] latency[090] u=
sage[00251887]

=2D-=20
                            Roman
 ,---------------------------. ,--------------------------.
/     http://www.3os.ru/      V    http://www.osrc.info/   \         .o.
\    mailto: rik-EZ1ikkraMFw@public.gmane.org       ^   mailto: rik-MdmE8JOsREphl2p70BpVqQ@public.gmane.org    /         ..o
 `---------------------------' `--------------------------'          ooo
gpg --recv-keys 0xE5E055C3 --keyserver hkp://subkeys.pgp.net

--nextPart2852387.oganBcToFV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBDoVJtXJ70z+XgVcMRAj7hAJ9rBnGCJL5W3Pg5onKi2BWIsXb5jACfY5Mb
F+pYHm9QtWTFWuzrTgBofX4=
=438J
-----END PGP SIGNATURE-----

--nextPart2852387.oganBcToFV--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
