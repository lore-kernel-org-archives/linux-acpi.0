From: Greg Sarjeant <greg-QNIYhHqVzB9kr2E5YSwMOQ@public.gmane.org>
Subject: RE: Gateway 200X (again) - No power button events
Date: Tue, 20 Jan 2004 19:07:32 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1074643651.5488.14.camel@localhost>
References: <F760B14C9561B941B89469F59BA3A8470255EFE4@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A8470255EFE4-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 2004-01-20 at 18:27, Grover, Andrew wrote:
> That is correct. So, the code ignores a CM power button if a FF button
> is found. There is a bit in the FADT that declares if the power button
> is fixed or control-method.
> 
> PWR_BUTTON A zero indicates the power button is handled as a fixed
> feature programming model; a one indicates the power
> button is handled as a control method device. If the system
> does not have a power button, this value would be "1" and
> no sleep button device would be present.
> 
> (I think that "sleep" should be "power" but anyways...)
> 
> So the FF pwr button gets priority. You can comment out a few lines in
> scan.c acpi_bus_scan_fixed(), and it should not register the FF power
> button. That might be interesting to try.
> 
> Regards -- Andy

Aha! That did the trick.

I commented out these three lines:

	if (acpi_fadt.pwr_button == 0)
		result = acpi_bus_add(&device, acpi_root, 
			NULL, ACPI_BUS_TYPE_POWER_BUTTON);


And now dmesg reports:

ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
ACPI: Lid Switch [LID0]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Power Button (CM) [PWRB]
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
[ACPI Debug] String: Not Support
ACPI: Thermal Zone [THRM] (50 C)
ACPI: Fan [FAN0] (on)

So, it is picking up the Control Method Power Button, and I get events
from it now. Outstanding.

When I was googling around, I saw a lot of references to a patch for 2.4
that ignores Fixed Feature buttons when Control Method buttons are
found. For example:

http://www.funet.fi/pub/Linux/PEOPLE/Linus/v2.4/patch-html/patch-2.4.14/linux_drivers_acpi_ospm_button_bn_osl.c.html

Hm - now that I look at it again, the author name is familiar :)

Is this something that might find its way into the main kernel tree?
Should I submit a bug for this behavior?

Thanks for the suggestion!
Greg



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
