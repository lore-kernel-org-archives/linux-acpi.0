From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: thermal shutdown
Date: Wed, 3 Mar 2004 19:51:34 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8401CBB71C@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: Jakob Praher <jpraher-LWAfsSFWpa4@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

It's known issue!

Pavel has the following solution. Let me know whether it works for you

--Luming

--- clean/drivers/acpi/thermal.c	2004-02-05 01:54:00.000000000
+0100
+++ linux/drivers/acpi/thermal.c	2004-02-05 02:24:15.000000000
+0100
@@ -223,8 +223,11 @@
 	tz->last_temperature =3D tz->temperature;
=20
 	status =3D acpi_evaluate_integer(tz->handle, "_TMP", NULL,
&tz->temperature);
-	if (ACPI_FAILURE(status))
+	if (ACPI_FAILURE(status)) {
+		if (tz->temperature !=3D tz->last_temperature)
+			printk(KERN_ERR "temperature damaged while
processing\n");
 		return -ENODEV;
+	}
=20
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Temperature is %lu dK\n",
tz->temperature));
=20
@@ -457,7 +460,17 @@
 		return_VALUE(-EINVAL);
=20
 	if (tz->temperature >=3D tz->trips.critical.temperature) {
+		long old_temperature =3D tz->temperature;
 		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Critical trip
point\n"));
+
+		result =3D acpi_thermal_get_temperature(tz);
+		if (!result) {
+			if (tz->temperature <
(tz->trips.critical.temperature - 100)) {
+				printk(KERN_ALERT "ACPI changed its mind
about temperature, was %ld C, now %ld C",=20
+
KELVIN_TO_CELSIUS(old_temperature), KELVIN_TO_CELSIUS(tz->temperature));
+				return_VALUE(0);
+			}
+		}
 		tz->trips.critical.flags.enabled =3D 1;
 	}
 	else if (tz->trips.critical.flags.enabled)



> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
> Jakob Praher
> Sent: Wednesday, March 03, 2004 7:42 PM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] thermal shutdown
>=20
>=20
> hi,
>=20
> my system: 2.6.3 acpi patched
>=20
> I have noticed, that at some sudden point in time (especially=20
> when I am
> not working actively ( I mean using input devices )), I receive a
> thermal shutdown, because of a (false?) temperature value.
>=20
> looking under /var/log/kern.log I found =20
>=20
> jaques2:/var/log# cat  kern.log | grep  Critical
> Feb 19 16:11:21 jaques2 kernel: Critical temperature reached (123 C),
> shutting down.
> Feb 19 16:11:22 jaques2 kernel: Critical temperature reached (46 C),
> shutting down.
> Feb 20 10:47:02 jaques2 kernel: Critical temperature reached (123 C),
> shutting down.
> Feb 20 10:47:02 jaques2 kernel: Critical temperature reached (44 C),
> shutting down.
> Mar  2 22:38:27 jaques2 kernel: Critical temperature reached (123 C),
> shutting down.
> Mar  2 22:38:27 jaques2 kernel: Critical temperature reached (44 C),
> shutting do
>=20
> this temperature always happens to be 123 C.
> How is that possible?
> I noticed that the acpi_thermal_critical method uses some kind of flag
> for enabled disabled, but apparently in any case the shutdown=20
> user space
> app (/sbin/poweroff) is called.
> Should this only be the case when the temperature is too high and the
> flag (enabled) is set to !=3D 0? Otherwise, what is the point in the
> enabled thing. [tz->trips.critical.flags.enabled]
>=20
> As you can see from my kern.log, the second value is=20
> drastically lower,
> so could this be a weekness in the system, that one sporadically high
> value can trigger a shutdown?
>=20
> thanks
> -- Jakob
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> SF.Net is sponsored by: Speed Start Your Linux Apps Now.
> Build and deploy apps & Web services for Linux with
> a free DVD software kit from IBM. Click Now!
> http://ads.osdn.com/?ad_id=3D1356&alloc_id=3D3438&op=3Dclick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
