From: Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>
Subject: Re: VMware and ACPI
Date: Mon, 22 Sep 2003 12:56:09 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m28yoglhra.fsf@tnuctip.rychter.com>
References: <20030919203214.GA579@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030919203214.GA579-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org> (Pavel Machek's message of
 "Fri, 19 Sep 2003 22:32:15 +0200")
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

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Transfer-Encoding: quoted-printable

>>>>> "Pavel" =3D=3D Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> writes:
 >> Hmm... just wondering: what happened to the VMware/ACPI interaction
 >> issues that some people were reporting here?
 >>
 >> There were some discussions and it seemed that ACPI idling the
 >> processor while VMware really wanted to use it was the cuplrit. Any
 >> resulting changes?
 >>
 >> I'm running 2.4.22-pre10 now and my WindowsXP inside VMware runs
 >> horribly slow. It gets considerably better if I leave an USB device
 >> plugged in (which causes ACPI to use C2 only and never go into C3),
 >> but it still isn't full speed.

 Pavel> What about something like

 Pavel> nice -n 19 while1

"something like" this doesn't do the job nearly as well, because:

  1) performance is better than with an otherwise idle machine, but
     not as good as with the C-state handling turned off

  2) it eats more power, keeping the cpu in C1 is not the same as
     keeping it busy

Please, can we have the patch (attached here again, for everyone's
convenience) applied? It doesn't do anything harmful to people that do
not use it, it just gives us the option of actually running VMware on
Linux.

=2D-J.

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=acpi_no_idle.diff
Content-Transfer-Encoding: quoted-printable

=2D-- drivers/acpi/processor.c.orig	2003-09-18 20:31:59.000000000 -0700
+++ drivers/acpi/processor.c	2003-09-18 20:48:51.000000000 -0700
@@ -1677,6 +1677,39 @@
=20
=20
 static int
+acpi_processor_write_power (
+        struct file  *file,
+        const char  *buffer,
+        unsigned long  count,
+        void   *data)
+{
+ struct acpi_processor *pr =3D (struct acpi_processor *) data;
+ char   state_string[2] =3D {'\0'};
+=09
+ ACPI_FUNCTION_TRACE("acpi_processor_write_power");
+
+ if (!pr || (count > sizeof(state_string) - 1))
+  return_VALUE(-EINVAL);
+=20
+ if (copy_from_user(state_string, buffer, count))
+  return_VALUE(-EFAULT);
+=20
+ state_string[count] =3D '\0';
+
+ if (state_string[0] =3D=3D '1') {
+     printk(KERN_INFO PREFIX "enabling acpi idle\n");
+     pm_idle =3D acpi_processor_idle;
+ } else {
+     printk(KERN_INFO PREFIX "disabling acpi idle\n");
+     pm_idle =3D pm_idle_save;
+     acpi_processor_power_activate(pr, ACPI_STATE_C1);
+ }
+
+ return_VALUE(count);
+}
+
+
+static int
 acpi_processor_read_performance (
 	char			*page,
 	char			**start,
@@ -1982,6 +2015,7 @@
 			ACPI_PROCESSOR_FILE_POWER));
 	else {
 		entry->read_proc =3D acpi_processor_read_power;
+		entry->write_proc =3D acpi_processor_write_power;
 		entry->data =3D acpi_driver_data(device);
 	}
=20

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/b1PeLth4/7/QhDoRAg0hAKDSXjlAxYA9+onUTO0A8ypKSQcAbACg80M0
5Xp/XLiu/vFNE4TClFfVnzk=
=3Ehc
-----END PGP SIGNATURE-----
--==-=-=--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
