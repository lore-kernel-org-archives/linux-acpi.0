From: Gerfried Maier <moali-ArvQUR6U0fYD0fefG/KofA@public.gmane.org>
Subject: Re: If your ACPI-enabled machine does clean shutdown randomly...
Date: Mon, 01 Dec 2003 10:51:15 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FCB0F13.7010908@sbox.tugraz.at>
References: <20031128145249.GA563@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060606080205050601070802"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031128145249.GA563-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------060606080205050601070802
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Pavel Machek wrote:
> ...then you probably need this one. (One notebook I have here
> certainly needs it).
> 
> It seems that acpi likes to report completely bogus value from time to
> time...

As you perhapps remember, I reported a similar problem with my Acer TM 
630 some time ago.

I was now able to log such a shutdown with temperature-printouts at the 
important places.

When reading the log, I can state two things:
* The temp-value causing the shutdown is definitly bogus, as the entries 
before and after the trip-causing check are far below that value but 
occuring at nearly the same time.
* Unfortunately the value is not as ingredible as your 200C, so 
distingushing between a bogus and a non-bogus value is not that simple.

I attached a cut from the syslog.

Regards,
Maier Gerfried


PS:
I archieved the temperature-printouts by adding some lines (marked with 
^^^^^^^) to thermal.c (2.4.22-version):


static int
acpi_thermal_critical (
	struct acpi_thermal	*tz)
{
	int			result = 0;
	struct acpi_device	*device = NULL;

	ACPI_FUNCTION_TRACE("acpi_thermal_critical");

	if (!tz || !tz->trips.critical.flags.valid)
		return_VALUE(-EINVAL);

	if (tz->temperature >= tz->trips.critical.temperature) {
		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Critical trip point\n"));
		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Trip-Point: %lu, Temperature: %lu\n", 
  tz->trips.critical.temperature, tz->temperature));
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

		tz->trips.critical.flags.enabled = 1;
	}
	else if (tz->trips.critical.flags.enabled)
		tz->trips.critical.flags.enabled = 0;


	result = acpi_bus_get_device(tz->handle, &device);
	if (result)
		return_VALUE(result);

	acpi_bus_generate_event(device, ACPI_THERMAL_NOTIFY_CRITICAL, 
tz->trips.critical.flags.enabled);
	
	acpi_thermal_call_usermode("/bin/logger ACPI poweroff");
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# Unfortunately, this line does not generate the log-enty I expect it
# to.

	acpi_thermal_call_usermode(ACPI_THERMAL_PATH_POWEROFF);

	return_VALUE(0);
}






static void
acpi_thermal_check (
	void                    *data)
{
	int			result = 0;
	struct acpi_thermal	*tz = (struct acpi_thermal *) data;
	unsigned long		sleep_time = 0;
	int			i = 0;
	struct acpi_thermal_state state = tz->state;

	ACPI_FUNCTION_TRACE("acpi_thermal_check");

	if (!tz) {
		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid (NULL) context.\n"));
		return_VOID;
	}

	result = acpi_thermal_get_temperature(tz);
	if (result)
		return_VOID;
	
	memset(&tz->state, 0, sizeof(tz->state));
	
	/*
	 * Check Trip Points
	 * -----------------
	 * Compare the current temperature to the trip point values to see
	 * if we've entered one of the thermal policy states.  Note that
	 * this function determines when a state is entered, but the
	 * individual policy decides when it is exited (e.g. hysteresis).
	 */
	if (tz->trips.critical.flags.valid)
		state.critical |= (tz->temperature >= tz->trips.critical.temperature);
	if (tz->trips.hot.flags.valid)
		state.hot |= (tz->temperature >= tz->trips.hot.temperature);
	if (tz->trips.passive.flags.valid)
		state.passive |= (tz->temperature >= tz->trips.passive.temperature);
	for (i=0; i<ACPI_THERMAL_MAX_ACTIVE; i++)
		if (tz->trips.active[i].flags.valid)
			state.active |= (tz->temperature >= tz->trips.active[i].temperature);



	ACPI_DEBUG_PRINT((ACPI_DB_WARN, "%s: Temperature: %lu\n", tz->name, 
tz->temperature));
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
...

--------------060606080205050601070802
Content-Type: text/plain;
 name="messages-cut"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="messages-cut"

Nov 16 20:19:49 acer kernel: [ACPI Debug] String: ----------------- Thermal event -------------------
Nov 16 20:19:49 acer kernel: [ACPI Debug] Integer: 000000000000002B
Nov 16 20:19:49 acer kernel: [ACPI Debug] String: SYST of _TMP =
Nov 16 20:19:49 acer kernel: [ACPI Debug] Integer: 000000000000002E
Nov 16 20:19:49 acer kernel: acpi_thermal-0637 [1547] acpi_thermal_check    : THRS: Temperature: 3192
Nov 16 20:19:49 acer kernel: [ACPI Debug] String: CPU _TMP =
Nov 16 20:19:49 acer kernel: [ACPI Debug] Integer: 000000000000002B
Nov 16 20:19:49 acer kernel: acpi_thermal-0637 [1547] acpi_thermal_check    : THRC: Temperature: 3162
Nov 16 20:19:49 acer kernel: [ACPI Debug] String: ----------------- Thermal event -------------------
Nov 16 20:19:49 acer kernel: [ACPI Debug] Integer: 000000000000002B
Nov 16 20:19:49 acer kernel: [ACPI Debug] String: CPU _TMP =
Nov 16 20:19:49 acer kernel: [ACPI Debug] Integer: 000000000000002B
Nov 16 20:19:49 acer kernel: acpi_thermal-0637 [1546] acpi_thermal_check    : THRC: Temperature: 3162
Nov 16 20:19:49 acer kernel: [ACPI Debug] String: SYST of _TMP =
Nov 16 20:19:49 acer kernel: [ACPI Debug] Integer: 000000000000002E
Nov 16 20:19:49 acer kernel: acpi_thermal-0637 [1547] acpi_thermal_check    : THRS: Temperature: 3192
Nov 16 20:19:49 acer kernel: [ACPI Debug] String: CPU _TMP =
Nov 16 20:19:49 acer kernel: [ACPI Debug] Integer: 000000000000002B
Nov 16 20:19:49 acer kernel: acpi_thermal-0637 [1547] acpi_thermal_check    : THRC: Temperature: 3162
Nov 16 20:19:49 acer kernel: [ACPI Debug] String: ----------------- Thermal event -------------------
Nov 16 20:19:49 acer kernel: [ACPI Debug] Integer: 000000000000002B
Nov 16 20:19:49 acer kernel: [ACPI Debug] String: CPU _TMP =
Nov 16 20:19:49 acer kernel: [ACPI Debug] Integer: 000000000000002B
Nov 16 20:19:49 acer kernel: acpi_thermal-0637 [1546] acpi_thermal_check    : THRC: Temperature: 3162
Nov 16 20:19:49 acer kernel: [ACPI Debug] String: SYST of _TMP =
Nov 16 20:19:49 acer kernel: [ACPI Debug] Integer: 000000000000002E
Nov 16 20:19:49 acer kernel: acpi_thermal-0637 [1547] acpi_thermal_check    : THRS: Temperature: 3192
Nov 16 20:19:49 acer kernel: [ACPI Debug] String: CPU _TMP =
Nov 16 20:19:49 acer kernel: [ACPI Debug] String: BAT0_BST_RETURN:
Nov 16 20:19:49 acer kernel: [ACPI Debug] String: BAT0_BST_RETURN:
Nov 16 20:19:49 acer kernel: [ACPI Debug] String: --------------------------------------- AC Present   
Nov 16 20:19:49 acer kernel: [ACPI Debug] Integer: 0000000000000064
Nov 16 20:19:49 acer kernel: acpi_thermal-0637 [1547] acpi_thermal_check    : THRC: Temperature: 3732
Nov 16 20:19:49 acer kernel: acpi_thermal-0398 [1548] acpi_thermal_critical : Critical trip point
Nov 16 20:19:49 acer kernel: acpi_thermal-0399 [1548] acpi_thermal_critical : Trip-Point: 3732, Temperature: 3732
Nov 16 20:19:49 acer kernel: acpi_processor-1095 [1551] acpi_processor_set_per: Transition failed
Nov 16 20:19:49 acer kernel: acpi_processor-1426 [1550] acpi_processor_apply_l: Unable to set limit
Nov 16 20:19:49 acer kernel: acpi_processor-1527 [1549] acpi_processor_set_the: Unable to set thermal limit
Nov 16 20:19:49 acer kernel: [ACPI Debug] String: CPU _TMP =
Nov 16 20:19:49 acer kernel: [ACPI Debug] Integer: 000000000000002B
Nov 16 20:19:49 acer kernel: acpi_thermal-0637 [1548] acpi_thermal_check    : THRC: Temperature: 3162
Nov 16 20:19:50 acer kernel: [ACPI Debug] String: CPU _TMP =
Nov 16 20:19:50 acer kernel: [ACPI Debug] Integer: 000000000000002B
Nov 16 20:19:50 acer kernel: [ACPI Debug] String: SYST of _TMP =
Nov 16 20:19:50 acer kernel: [ACPI Debug] Integer: 000000000000002E
Nov 16 20:19:50 acer kernel: [ACPI Debug] String: CPU _TMP =
Nov 16 20:19:50 acer kernel: [ACPI Debug] Integer: 000000000000002B
Nov 16 20:19:50 acer kernel: [ACPI Debug] String: SYST of _TMP =
Nov 16 20:19:50 acer kernel: [ACPI Debug] Integer: 000000000000002E
Nov 16 20:19:51 acer init: Switching to runlevel: 0
Nov 16 20:20:07 acer cardmgr[548]: exiting
Nov 16 20:20:07 acer kernel: unloading Kernel Card Services
Nov 16 20:20:08 acer kernel: Kernel logging (proc) stopped.
Nov 16 20:20:08 acer kernel: Kernel log daemon terminating.
Nov 16 20:20:09 acer exiting on signal 15
N

--------------060606080205050601070802--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
