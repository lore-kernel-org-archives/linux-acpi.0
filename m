From: "Herbert Nachtnebel" <Herbert.Nachtnebel-8zxNtbQCHXIjuwv8T7myQQ@public.gmane.org>
Subject: Re: Compaq Armada 1500c
Date: Thu, 10 Apr 2003 16:55:48 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B900970C7DD9474C972986EB3EC7C58F0D4097@andromeda.agcad.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Florian Schilhabel <florian.schilhabel-S0/GAf8tV78@public.gmane.org>, Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Florian!

> still weird are the entries in thermal_zone/.../trip_points;

They are defined in the DSDT, if I remember correctly the names are =
_TC1, _TC2, _HOT etc.
(have a look into thermal.c, function acpi_thermal_get_trip_points). You =
can override these=20
values during runtime (support by Pavel Machek) or change them directly =
in your DSDT.

> i still have a problem with FAN CONTROL...
> i DO have 2 entries in /proc/acpi/fan;
> along with a state file.
> cat state gives me a "on", indicating, that the fan is running - this =
is _NOT_ true
> there is also no possibility to switch manually to off and back to on;

Ouch, weird. Time for debugging. Turn it on during kernel compilation. =
If this is flooding your
syslog with too much messages you can individually control which =
messages are written out via
/proc/acpi/debug - if I remember correctly (have a look at =
utilities/utdebug.c).=20
Generally you have to check whether the acpi subsystem correctly gets =
called during changes of
the sensed temperature, if after that acpi_thermal_active is called and =
whether acpi_bus_set_power
on the fan objects correctly changes the speed of the fan.

> battery status is now great, with one problem left:
> during system boot, the correct battery status is recognized ( for =
example 2 batteries available )
> if i pull out on battery, the acpi system still indicates 2 available =
batteries,

That's also something which is handled by code in the DSDT. Check for =
battery events.

> nevertheless, at least a cat temperature seems to give me the correct =
values for CPU temp;
> at least, if i stress the CPU, the temp rises, when idle temp goes =
down.
> so there's a way for me to shut down the system, if the CPU should =
become too hot ;-))

If a change of the temperature correctly gets notified than at least the =
passive cooling mode
should save the life of your CPU.

>=20
> i think, someone's written a FAN-control patch; i just can't find it =
in mail-archive;
> would anyone please be so kind to send it to me ???
> thanks a lot....

Last year I found some errors in the handling of the thermal zone. If =
you mean them,=20
they have been merged.

>=20
> at last:
> if nothing helps, my final solution is to cut the wires to the fan and =
solder it to
> voltage supply of my fdd drive - *;-))

Pfff, don't do that. In some notebooks the fan control isn't handled =
directly with the help
of the DSDT but instead by the embedded controller (I don't know if =
Compaq has one of them).
Maybe you have to disassemble a windows driver to have a look how the =
fan is controlled=20
in this case.

>=20
> greetings
>=20
> florian

Servus, Herbert.


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
