From: Baris Metin <baris-HcGUqKqhBWRyhfBGqJeJzQ@public.gmane.org>
Subject: Dell Inspiron 2650
Date: Mon, 5 Aug 2002 10:05:34 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020805070534.GA859@gelecek.com.tr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=iso-8859-9
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I'm new to the list and don't know much about ACPI. This is my firt
post. I have tried to search the list archive but all I got is :
"Please check back in 10-15 minutes. We're sorry for the inconvenience.
". I don't know if this is the right place to ask. I'm not a kernel
developer just a user seeking for help.

I'm running kernel 2.4.18+acpi-20020726 on my inspiron 2650.

Shutting down works fine but I can't get information from battery :

# cat /proc/acpi/battery/BAT1/info=20
present:                 yes
ERROR: Unable to read battery information

Also after I applied the acpi path I can't send my machine to sleep.
"# echo 1 > /proc/acpi/sleep" doesn't works any more.

I've seen the page
http://www.intel.com/technology/IAPC/acpi/bios_override.htm but could
not download the ad.exe utility. The link seems to be broken. Is there
an other way to disassemble th DSDT ?

My dmesg : http://metin.org/dmesg
My /proc/acpi/dsdt : http://metin.org/dsdt

I'm using the last Bios update (A03) that Dell released.

best regards,
--=20
Baris Metin
GELECEK A.S.

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Baris Metin - http://metin.org

iD8DBQE9TiO+9d0Ui5CybXkRAmm3AJ9wHk25eBURUmzS57qRUQolRrowtQCgme+u
a7NPSgtqlZLgaOS5GBuUBMY=
=av58
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
