From: Damien Sandras <dsandras-AvcYnRpcIedBDgjK7y7TUQ@public.gmane.org>
Subject: Re: If your ACPI-enabled machine does clean shutdown
	randomly...
Date: Mon, 01 Dec 2003 11:08:27 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1070273290.927.16.camel@golgoth01>
References: <20031128145249.GA563@elf.ucw.cz>
	 <3FCB0F13.7010908@sbox.tugraz.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3FCB0F13.7010908-ArvQUR6U0fYD0fefG/KofA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Gerfried Maier <moali-ArvQUR6U0fYD0fefG/KofA@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I also have the same problem with my ACER. However only with kernels 2.6
test 10 and test 11; but I don't know what patch to revert....



Le lun 01/12/2003 =E0 10:51, Gerfried Maier a =E9crit :
> Pavel Machek wrote:
> > ...then you probably need this one. (One notebook I have here
> > certainly needs it).
> >=20
> > It seems that acpi likes to report completely bogus value from time t=
o
> > time...
>=20
> As you perhapps remember, I reported a similar problem with my Acer TM=20
> 630 some time ago.
>=20
> I was now able to log such a shutdown with temperature-printouts at the=
=20
> important places.
>=20
> When reading the log, I can state two things:
> * The temp-value causing the shutdown is definitly bogus, as the entrie=
s=20
> before and after the trip-causing check are far below that value but=20
> occuring at nearly the same time.
> * Unfortunately the value is not as ingredible as your 200C, so=20
> distingushing between a bogus and a non-bogus value is not that simple.
>=20
> I attached a cut from the syslog.
>=20
> Regards,
> Maier Gerfried
>=20
>=20
> PS:
> I archieved the temperature-printouts by adding some lines (marked with=
=20
> ^^^^^^^) to thermal.c (2.4.22-version):
>=20
>=20
> static int
> acpi_thermal_critical (
> 	struct acpi_thermal	*tz)
> {
> 	int			result =3D 0;
> 	struct acpi_device	*device =3D NULL;
>=20
> 	ACPI_FUNCTION_TRACE("acpi_thermal_critical");
>=20
> 	if (!tz || !tz->trips.critical.flags.valid)
> 		return_VALUE(-EINVAL);
>=20
> 	if (tz->temperature >=3D tz->trips.critical.temperature) {
> 		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Critical trip point\n"));
> 		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Trip-Point: %lu, Temperature: %lu\n"=
,=20
>   tz->trips.critical.temperature, tz->temperature));
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^
>=20
> 		tz->trips.critical.flags.enabled =3D 1;
> 	}
> 	else if (tz->trips.critical.flags.enabled)
> 		tz->trips.critical.flags.enabled =3D 0;
>=20
>=20
> 	result =3D acpi_bus_get_device(tz->handle, &device);
> 	if (result)
> 		return_VALUE(result);
>=20
> 	acpi_bus_generate_event(device, ACPI_THERMAL_NOTIFY_CRITICAL,=20
> tz->trips.critical.flags.enabled);
> =09
> 	acpi_thermal_call_usermode("/bin/logger ACPI poweroff");
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^
> # Unfortunately, this line does not generate the log-enty I expect it
> # to.
>=20
> 	acpi_thermal_call_usermode(ACPI_THERMAL_PATH_POWEROFF);
>=20
> 	return_VALUE(0);
> }
>=20
>=20
>=20
>=20
>=20
>=20
> static void
> acpi_thermal_check (
> 	void                    *data)
> {
> 	int			result =3D 0;
> 	struct acpi_thermal	*tz =3D (struct acpi_thermal *) data;
> 	unsigned long		sleep_time =3D 0;
> 	int			i =3D 0;
> 	struct acpi_thermal_state state =3D tz->state;
>=20
> 	ACPI_FUNCTION_TRACE("acpi_thermal_check");
>=20
> 	if (!tz) {
> 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid (NULL) context.\n"));
> 		return_VOID;
> 	}
>=20
> 	result =3D acpi_thermal_get_temperature(tz);
> 	if (result)
> 		return_VOID;
> =09
> 	memset(&tz->state, 0, sizeof(tz->state));
> =09
> 	/*
> 	 * Check Trip Points
> 	 * -----------------
> 	 * Compare the current temperature to the trip point values to see
> 	 * if we've entered one of the thermal policy states.  Note that
> 	 * this function determines when a state is entered, but the
> 	 * individual policy decides when it is exited (e.g. hysteresis).
> 	 */
> 	if (tz->trips.critical.flags.valid)
> 		state.critical |=3D (tz->temperature >=3D tz->trips.critical.temperat=
ure);
> 	if (tz->trips.hot.flags.valid)
> 		state.hot |=3D (tz->temperature >=3D tz->trips.hot.temperature);
> 	if (tz->trips.passive.flags.valid)
> 		state.passive |=3D (tz->temperature >=3D tz->trips.passive.temperatur=
e);
> 	for (i=3D0; i<ACPI_THERMAL_MAX_ACTIVE; i++)
> 		if (tz->trips.active[i].flags.valid)
> 			state.active |=3D (tz->temperature >=3D tz->trips.active[i].temperat=
ure);
>=20
>=20
>=20
> 	ACPI_DEBUG_PRINT((ACPI_DB_WARN, "%s: Temperature: %lu\n", tz->name,=20
> tz->temperature));
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> ...
>=20
> ______________________________________________________________________
> Nov 16 20:19:49 acer kernel: [ACPI Debug] String: ----------------- The=
rmal event -------------------
> Nov 16 20:19:49 acer kernel: [ACPI Debug] Integer: 000000000000002B
> Nov 16 20:19:49 acer kernel: [ACPI Debug] String: SYST of _TMP =3D
> Nov 16 20:19:49 acer kernel: [ACPI Debug] Integer: 000000000000002E
> Nov 16 20:19:49 acer kernel: acpi_thermal-0637 [1547] acpi_thermal_chec=
k    : THRS: Temperature: 3192
> Nov 16 20:19:49 acer kernel: [ACPI Debug] String: CPU _TMP =3D
> Nov 16 20:19:49 acer kernel: [ACPI Debug] Integer: 000000000000002B
> Nov 16 20:19:49 acer kernel: acpi_thermal-0637 [1547] acpi_thermal_chec=
k    : THRC: Temperature: 3162
> Nov 16 20:19:49 acer kernel: [ACPI Debug] String: ----------------- The=
rmal event -------------------
> Nov 16 20:19:49 acer kernel: [ACPI Debug] Integer: 000000000000002B
> Nov 16 20:19:49 acer kernel: [ACPI Debug] String: CPU _TMP =3D
> Nov 16 20:19:49 acer kernel: [ACPI Debug] Integer: 000000000000002B
> Nov 16 20:19:49 acer kernel: acpi_thermal-0637 [1546] acpi_thermal_chec=
k    : THRC: Temperature: 3162
> Nov 16 20:19:49 acer kernel: [ACPI Debug] String: SYST of _TMP =3D
> Nov 16 20:19:49 acer kernel: [ACPI Debug] Integer: 000000000000002E
> Nov 16 20:19:49 acer kernel: acpi_thermal-0637 [1547] acpi_thermal_chec=
k    : THRS: Temperature: 3192
> Nov 16 20:19:49 acer kernel: [ACPI Debug] String: CPU _TMP =3D
> Nov 16 20:19:49 acer kernel: [ACPI Debug] Integer: 000000000000002B
> Nov 16 20:19:49 acer kernel: acpi_thermal-0637 [1547] acpi_thermal_chec=
k    : THRC: Temperature: 3162
> Nov 16 20:19:49 acer kernel: [ACPI Debug] String: ----------------- The=
rmal event -------------------
> Nov 16 20:19:49 acer kernel: [ACPI Debug] Integer: 000000000000002B
> Nov 16 20:19:49 acer kernel: [ACPI Debug] String: CPU _TMP =3D
> Nov 16 20:19:49 acer kernel: [ACPI Debug] Integer: 000000000000002B
> Nov 16 20:19:49 acer kernel: acpi_thermal-0637 [1546] acpi_thermal_chec=
k    : THRC: Temperature: 3162
> Nov 16 20:19:49 acer kernel: [ACPI Debug] String: SYST of _TMP =3D
> Nov 16 20:19:49 acer kernel: [ACPI Debug] Integer: 000000000000002E
> Nov 16 20:19:49 acer kernel: acpi_thermal-0637 [1547] acpi_thermal_chec=
k    : THRS: Temperature: 3192
> Nov 16 20:19:49 acer kernel: [ACPI Debug] String: CPU _TMP =3D
> Nov 16 20:19:49 acer kernel: [ACPI Debug] String: BAT0_BST_RETURN:
> Nov 16 20:19:49 acer kernel: [ACPI Debug] String: BAT0_BST_RETURN:
> Nov 16 20:19:49 acer kernel: [ACPI Debug] String: ---------------------=
------------------ AC Present  =20
> Nov 16 20:19:49 acer kernel: [ACPI Debug] Integer: 0000000000000064
> Nov 16 20:19:49 acer kernel: acpi_thermal-0637 [1547] acpi_thermal_chec=
k    : THRC: Temperature: 3732
> Nov 16 20:19:49 acer kernel: acpi_thermal-0398 [1548] acpi_thermal_crit=
ical : Critical trip point
> Nov 16 20:19:49 acer kernel: acpi_thermal-0399 [1548] acpi_thermal_crit=
ical : Trip-Point: 3732, Temperature: 3732
> Nov 16 20:19:49 acer kernel: acpi_processor-1095 [1551] acpi_processor_=
set_per: Transition failed
> Nov 16 20:19:49 acer kernel: acpi_processor-1426 [1550] acpi_processor_=
apply_l: Unable to set limit
> Nov 16 20:19:49 acer kernel: acpi_processor-1527 [1549] acpi_processor_=
set_the: Unable to set thermal limit
> Nov 16 20:19:49 acer kernel: [ACPI Debug] String: CPU _TMP =3D
> Nov 16 20:19:49 acer kernel: [ACPI Debug] Integer: 000000000000002B
> Nov 16 20:19:49 acer kernel: acpi_thermal-0637 [1548] acpi_thermal_chec=
k    : THRC: Temperature: 3162
> Nov 16 20:19:50 acer kernel: [ACPI Debug] String: CPU _TMP =3D
> Nov 16 20:19:50 acer kernel: [ACPI Debug] Integer: 000000000000002B
> Nov 16 20:19:50 acer kernel: [ACPI Debug] String: SYST of _TMP =3D
> Nov 16 20:19:50 acer kernel: [ACPI Debug] Integer: 000000000000002E
> Nov 16 20:19:50 acer kernel: [ACPI Debug] String: CPU _TMP =3D
> Nov 16 20:19:50 acer kernel: [ACPI Debug] Integer: 000000000000002B
> Nov 16 20:19:50 acer kernel: [ACPI Debug] String: SYST of _TMP =3D
> Nov 16 20:19:50 acer kernel: [ACPI Debug] Integer: 000000000000002E
> Nov 16 20:19:51 acer init: Switching to runlevel: 0
> Nov 16 20:20:07 acer cardmgr[548]: exiting
> Nov 16 20:20:07 acer kernel: unloading Kernel Card Services
> Nov 16 20:20:08 acer kernel: Kernel logging (proc) stopped.
> Nov 16 20:20:08 acer kernel: Kernel log daemon terminating.
> Nov 16 20:20:09 acer exiting on signal 15
> N
--=20
 _      Damien Sandras
(o-    =20
//\     It-Optics s.a.
v_/_    GnomeMeeting: http://www.gnomemeeting.org/
        FOSDEM 2004:  http://www.fosdem.org
        H.323 phone:  callto:ils.seconix.com/dsandras-AvcYnRpcIedBDgjK7y7TUQ@public.gmane.org



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
