From: Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>
Subject: Re: VMware and ACPI
Date: Fri, 19 Sep 2003 10:51:02 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m2n0d0r7jt.fsf@tnuctip.rychter.com>
References: <m2k789sotw.fsf@tnuctip.rychter.com>
	<200309161100.52454.fm3@os.inf.tu-dresden.de>
	<m24qzcr03p.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
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

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Transfer-Encoding: quoted-printable

>>>>> "Jan" =3D=3D Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org> writes:
>>>>> "Frank" =3D=3D Frank Mehnert <fm3-IG//nw+yl+iQIjdd1DhZXWfrygkm6VTR@public.gmane.org> writes:
 Frank> On Monday 15 September 2003 23:51, Jan Rychter wrote:
 > Hmm... just wondering: what happened to the VMware/ACPI interaction
 > issues that some people were reporting here?
 >
 > There were some discussions and it seemed that ACPI idling the
 > processor while VMware really wanted to use it was the cuplrit. Any
 > resulting changes?
 >
 > I'm running 2.4.22-pre10 now and my WindowsXP inside VMware runs
 > horribly slow. It gets considerably better if I leave an USB device
 > plugged in (which causes ACPI to use C2 only and never go into C3),
 > but it still isn't full speed.

 Frank> Yes, there is still a problem. I use the appending patch since
 Frank> ages. Before starting VMware, I do

 Frank> echo -n "0" > /proc/acpi/processor/CPU/power
 Jan> [...]

 Jan> Thanks. I'll apply this patch.

 Jan> Is there any chance that this kind of patch could make it into the
 Jan> mainline? It is really needed for some of us (everybody running
 Jan> VMware, for one).

Here is the patch slightly fixed for the ACPI in 2.4.22 (the old one did
not compile).

Could we please make it go in as a temporary workaround, so that people
can actually use VMware on Linux?

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

iD8DBQA/a0ILLth4/7/QhDoRAsvyAJ0ZTfy5D1QxnkwzTjWct9o+nJJqAQCfVoA1
CyZvDyJPAu5cJmMLWO5OprE=
=Wm7Z
-----END PGP SIGNATURE-----
--==-=-=--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
