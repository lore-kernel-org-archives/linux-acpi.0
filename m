From: Gunter Ohrner <G.Ohrner-6V9naDJErT6662+jY7v6MhvVK+yQ3ZXh@public.gmane.org>
Subject: Re: [Patch] DSDT in initrd v0.2
Date: Tue, 6 May 2003 19:56:52 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200305061957.00037@mail.CustomCDROM.de>
References: <Pine.LNX.4.53.0305061444120.1274@tweety.gaugusch.at>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.53.0305061444120.1274-qopfHk9/S+VQK2oVCIMtW7NldLUNz+W/@public.gmane.org>
Content-Description: clearsigned data
Content-Disposition: inline
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

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Dienstag, 6. Mai 2003 14:51 schrieb Markus Gaugusch:
> * Feature: Get DSDT from initrd without signature, if it starts with
>   "DSDT". This way one can just copy the DSDT.aml file and use it as
>   initrd

This doesn't work for me. How can I troubleshoot the problem? I've never us=
ed=20
an initrd before.
I fetched the patch and it applied cleanly. Then I compiled RAM disk suppor=
t=20
into the kernel and enabled initrd and ACPI initrd support. Next I copied m=
y=20
DSDT.aml file, which starts with the string "DSDT" to /boot/initrd, added=20
"initrd=3D/boot/initrd" to my kernel append line, installed the new kernel =
and=20
re-ran lilo. The new kernel works but it uses the BIOS' buggy DSDT and not =
my=20
just-being-fixed altered dump of it... :-(
dmesg does not seem to show any traces of something with initrd at all...

Greetings,

  Gunter

=2D --=20
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+                   PGP-verschl=FCsselte Mails bevorzugt!                 +
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
=2D - "What is it that a man may call the greatest things in life?"
=2D - "Hot water, good dentishtry and shoft lavatory paper."
        -- Cohen the Barbarian (about 90 years old) in conversation with=20
Discworld nomads           (Terry Pratchett, The Light Fantastic)
+-+-+-+-+-+-+-+-+-+-+-+-+ http://www.lspace.org +-+-+-+-+-+-+-+-+-+-+-+-+
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+t/dr0ORHvREo8l8RApU5AJ0Zq0Ab69ZaVjjZHzCFSr2B4q7nhQCfVxmX
JTvz+KRxZId4uoVJ2NoXuns=3D
=3DtWjY
=2D----END PGP SIGNATURE-----



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
