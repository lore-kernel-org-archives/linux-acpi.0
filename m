From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: FW: ACPI too sensitive about critical temperature
Date: Mon, 19 Jan 2004 00:50:36 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84702C9321E@orsmsx401.jf.intel.com>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

=20

-----Original Message-----
From: Julius Volz [mailto:julius.volz-cOr7zazyEW0f8UlNpKJ8ow@public.gmane.org]=20
Sent: Sunday, January 18, 2004 6:26 AM
To: Grover, Andrew; Diefenbaugh, Paul S
Subject: ACPI too sensitive about critical temperature

Hi,

I didn't want to bug the whole lkml with this, so I'm sending this to=20
you guys who wrote "drivers/acpi/thermal.c". I hope that's okay...

A friend of mine has a mainboard (I can find out the specific type if=20
you want to know) which reports inaccurately high temperature "peaks"=20
from time to time.
Looking at /proc/acpi/thermal_zone/THR1/temperature every second might=20
look something like this: 45, 43, 47, 42, 90, 43, 41, 45

This is of course bad when CONFIG_ACPI_THERMAL is enabled and the=20
computer just randomly shuts down when you are working. The problem with =

detecting this bug for normal users is that the temperature reported in=20
the shutdown message is already taken from a next measurement and looks=20
ok again.
So you might get a shutdown message saying,
"Critical temperature reached (43 C)..."
and wonder why the system shuts down although you set critical=20
temperature to 85=B0C in the BIOS.

I've looked at thermal.c and thought that it would be better to look at=20
temperature measurements over a range of, say, three seconds (if that is =

possible) to sort out these false peaks.

As there might be many mainboards out there that do this and=20
CONFIG_ACPI_THERMAL should normally be enabled, this could turn out to=20
be a problem for many people otherwise.

What do you think?

Julius


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
