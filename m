From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Gateway 200X (again) - No power button events
Date: Tue, 20 Jan 2004 15:27:34 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A8470255EFE4@orsmsx401.jf.intel.com>
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
To: Greg Sarjeant <greg-QNIYhHqVzB9kr2E5YSwMOQ@public.gmane.org>
Cc: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Greg Sarjeant [mailto:greg-QNIYhHqVzB9kr2E5YSwMOQ@public.gmane.org]=20
> I think it may be detecting a Fixed Feature power button. Here are the
> relevant dmesg lines:
>=20
> ACPI: Power Button (FF) [PWRF]
> ACPI: Lid Switch [LID0]
> ACPI: Sleep Button (CM) [SLPB]
> ACPI: AC Adapter [ADP1] (on-line)
> ACPI: Battery Slot [BAT1] (battery present)
> [ACPI Debug] String: Not Support
> ACPI: Thermal Zone [THRM] (47 C)
> ACPI: Fan [FAN0] (on)
>=20
> (That "Not Support" is raised by the thermal zone's _SCP Method in the
> DSDT. Guess I can't set the cooling policy on this machine).
>=20
> So, unless the FF cleverly stands for something other than Fixed
> Feature, I imagine that that is what I've got. I was just starting to
> read up about Fixed vs Control Method Power Buttons, and I am a bit
> confused. It seems from the spec that a Fixed Feature Power Button
> shouldn't have an implementation in the DSDT. Is that correct, or am I
> misreading? I do see methods for the Power button in the DSDT. Here is
> the _Q50 method, which is defined in the Embedded Control block:

That is correct. So, the code ignores a CM power button if a FF button
is found. There is a bit in the FADT that declares if the power button
is fixed or control-method.

PWR_BUTTON A zero indicates the power button is handled as a fixed
feature programming model; a one indicates the power
button is handled as a control method device. If the system
does not have a power button, this value would be "1" and
no sleep button device would be present.

(I think that "sleep" should be "power" but anyways...)

So the FF pwr button gets priority. You can comment out a few lines in
scan.c acpi_bus_scan_fixed(), and it should not register the FF power
button. That might be interesting to try.

Regards -- Andy


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
