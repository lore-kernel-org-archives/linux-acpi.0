From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: thermal zone causing insta-reboot on bootup of 2.6.3
Date: Thu, 11 Mar 2004 15:10:04 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8401CBB747@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, =?iso-8859-1?Q?Ois=EDn_Mac_Fheara=ED?= <destynova-iUB+o6dfpG8i1yMB4YHZDQ@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

The following patch is from Pavel, and maybe it is suitable for this =
case. --Luming

--- clean/drivers/acpi/thermal.c	2004-02-05 01:54:00.000000000 +0100
+++ linux/drivers/acpi/thermal.c	2004-02-05 02:24:15.000000000 +0100
@@ -223,8 +223,11 @@
 	tz->last_temperature =3D tz->temperature;
=20
 	status =3D acpi_evaluate_integer(tz->handle, "_TMP", NULL, =
&tz->temperature);
-	if (ACPI_FAILURE(status))
+	if (ACPI_FAILURE(status)) {
+		if (tz->temperature !=3D tz->last_temperature)
+			printk(KERN_ERR "temperature damaged while processing\n");
 		return -ENODEV;
+	}
=20
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Temperature is %lu dK\n", =
tz->temperature));
=20
@@ -457,7 +460,17 @@
 		return_VALUE(-EINVAL);
=20
 	if (tz->temperature >=3D tz->trips.critical.temperature) {
+		long old_temperature =3D tz->temperature;
 		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Critical trip point\n"));
+
+		result =3D acpi_thermal_get_temperature(tz);
+		if (!result) {
+			if (tz->temperature < (tz->trips.critical.temperature - 100)) {
+				printk(KERN_ALERT "ACPI changed its mind about temperature, was %ld =
C, now %ld C",=20
+				       KELVIN_TO_CELSIUS(old_temperature), =
KELVIN_TO_CELSIUS(tz->temperature));
+				return_VALUE(0);
+			}
+		}
 		tz->trips.critical.flags.enabled =3D 1;
 	}
 	else if (tz->trips.critical.flags.enabled)

 =20

> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
> Brown, Len
> Sent: Thursday, March 11, 2004 3:02 PM
> To: Ois=EDn Mac Fheara=ED
> Cc: ACPI Developers
> Subject: Re: [ACPI] thermal zone causing insta-reboot on=20
> bootup of 2.6.3
>=20
>=20
> if you delete the thermal module, this failure will go away
> (and so will our ability to debug it;-)
>=20
> perhaps you can file a bug at bugzilla.kernel.org
> category: ACPI
> component: Power-Thermal
>=20
> and attach the output from dmesg -s40000 with thermal installed.
>=20
> clearly we're getting a bogus temperature reading.
>=20
> thanks,
> -Len
>=20
> On Wed, 2004-03-10 at 19:37, Ois=EDn Mac Fheara=ED wrote:
> > After installing the 2.6.3 kernel on Mandrake 9.2 on an Acer Aspire
> > 1705SMi laptop, my machine repeatedly prints "Critical temperature
> > reached (255 C), shutting down." and reboots.
> > Installing the 20040220 patch to it seems to have made no difference
> > (and added no options that I could see to "make menuconfig"=20
> - in fact
> > it removed the options for relaxed something under the ACPI options
> > page, which wasn't doing anything anyway)...
> > =20
> > Can anyone advise? I'm quite inexperienced with linux, so I might be
> > doing something stupid (also, I'm having trouble finding which boot
> > messages are kept in which logfiles...).
> > I'm too scared by the "might damage your CPU" message to remove
> > thermal zone from the kernel ACPI settings.
> > =20
> > Ois=EDn
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=3Dick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
