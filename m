From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: Re: ACPI freezes laptop
Date: Wed, 21 Apr 2004 20:21:21 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1082575281.26454.21.camel@darkstar>
References: <200404211639.20459.emejia@ieee.org>
Reply-To: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200404211639.20459.emejia-EkmVulN54Sk@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: emejia-EkmVulN54Sk@public.gmane.org
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Finally we found this errors, could be the root of the problems:

acpi_power-0392 [25] acpi_power_transition : Error transitioning device [FA=
N] to D3
Apr 21 15:30:46 microstar kernel: acpi_bus-0258 [24] acpi_bus_set_power    =
: Error transitioning device [FAN] to D3
Apr 21 15:30:46 microstar kernel: acpi_thermal-0630 [23] acpi_thermal_activ=
e   : Unable to turn cooling device [d6f57388] 'off'
Apr 21 15:30:46 microstar kernel: [ACPI Debug] String: Length 0x22, "______=
____________________________"
Apr 21 15:30:46 microstar kernel: [ACPI Debug] String: Length 0x00, ""
Apr 21 15:30:46 microstar kernel: [ACPI Debug] String: Length 0x08, "THRM_T=
MP"
Apr 21 15:30:46 microstar kernel: [ACPI Debug] String: Length 0x22, "______=
____________________________"
Apr 21 15:30:46 microstar kernel: acpi_bus-0258 [24] acpi_bus_set_power    =
: Error transitioning device [FAN] to D3
Apr 21 15:30:46 microstar kernel: acpi_thermal-0630 [23] acpi_thermal_activ=
e   : Unable to turn cooling device [d6f57388] 'off'

well maybe the better is open a ticket on bugzilla with this errors.

not related with acpi but what is this can't be turned off ?
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio=
0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.

On Wed, 2004-04-21 at 15:39, Emilio Mejia Fernandez de Velasco wrote:
> Hello,
> I have compiled kernel 2.4.26, and also 2.6.5 with acpi, with the .config=
 file=20
> that you sent me, that is, taking care not to use APIC or SMP options, bu=
t=20
> there was no luck.
> The computer freezes after some time. Here I send you one copy of the=20
> file /var/log/messages after the following proceedings:
>=20
> At 15:12:11, after booting with the new kernel 2.4.26, I unplug and plug =
back=20
> the AC adapter, and so the computer is blocked. It doesn't respond to the=
=20
> keyboard, so I have to reboot.
> At 15:29:28 the system reboots after fsck caused for the former hard rebo=
ot.
> This time I try kernel 2.6.5 in order to check the behaivour when pluggin=
g and=20
> unplugging the AC adapter:
> >From 15:29:37 to 15:41:17 I unplug and plug again several times -more th=
an 20=20
> times- the AC adapter to see if it blocks, but everything keeps alive, un=
til=20
> 15:41:17, then is the last time I'm able to check the file /var/log/messa=
ges
> After this the system is again frozen, completely blocked.
>=20
> Can you please check the copy of /var/log/messages that I send attached?
> So you can check the events around the refered times and see if it tells =
you=20
> why it gets blocked.
> Thank you
>=20
>=20
> Emilio
--=20
S=E9rgio M. B.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
