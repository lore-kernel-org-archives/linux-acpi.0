From: Bob McElrath <mcelrath-/+vdk8Lzq6wBYXXUC76CrNADJCGDAxhI@public.gmane.org>
Subject: New problem reading battery
Date: Thu, 25 Jul 2002 12:59:25 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020725125925.D29757@draal.physics.wisc.edu>
References: <20020719120155.F26885@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pQhZXvAqiZgbeUkD"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020719120155.F26885-/+vdk8Lzq6wBYXXUC76CrNADJCGDAxhI@public.gmane.org>; from mcelrath-/+vdk8Lzq6wBYXXUC76CrNADJCGDAxhI@public.gmane.org on Fri, Jul 19, 2002 at 12:01:55PM -0500
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--pQhZXvAqiZgbeUkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

After about a day of uptime, ACPI on my laptop seems to die, and is no
longer able to read the battery, as well as leaving several error
messages in the logs.  Note that on bootup, everything seems to work
fine (and continues to work fine for about a day).

I'm running acpi-0702 + nocorruption.2 patch + omnibook module +
toshiba3k module.  System is a Compal ACL00 (same as Toshiba 3000
series, same manufacturer as HP omnibook).  Note that the omnibook
module (/proc/omnibook/battery) is still able to read the battery status
because it doesn't depend on ACPI, but reads the hardware directly.  So
this is an ACPI problem, and probably not hardware.  ;)

I suspect that this may be the cause of the hard-system lockup I
sometimes see, with the same frequency -- ~once/day.  No oops, system
just hangs, or sometimes turns itself off.  But when it hangs I can
still ping it, though not ssh in to it.

Here are a log of all the relevant messages this boot (uptime 1 day, 14 hou=
rs),
Boot was at Jul 23 19:49:49 (scroll to bottom to see the errors):

Jul 23 19:49:49 localhost kernel: ACPI: RSDP (v000 TOSCPL                  =
   ) @ 0x000f6ed0
Jul 23 19:49:49 localhost kernel: ACPI: RSDT (v001 TOSCPL   RSDT   01540.00=
000) @ 0x1fef9be0
Jul 23 19:49:49 localhost kernel: ACPI: FADT (v001 TOSCPL 888M2    01540.00=
000) @ 0x1fefef8c
Jul 23 19:49:49 localhost kernel: ACPI: MADT not present
Jul 23 19:49:49 localhost kernel: Local APIC disabled by BIOS -- reenabling.
Jul 23 19:49:49 localhost kernel: Found and enabled local APIC!
Jul 23 19:49:49 localhost kernel: ACPI: Subsystem revision 20020702
Jul 23 19:49:49 localhost kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd=
96a, last bus=3D2
Jul 23 19:49:49 localhost kernel: PCI: Using configuration type 1
Jul 23 19:49:49 localhost kernel:  tbxface-0099 [03] Acpi_load_tables      =
: ACPI Tables successf
ully loaded
Jul 23 19:49:49 localhost random: Initializing random number generator:  su=
cceeded
Jul 23 19:49:49 localhost kernel: Parsing Methods:.........................=
......................
=2E........................................................................=
........................
=2E....................................
Jul 23 19:49:49 localhost kernel: Table [DSDT] - 579 Objects with 57 Device=
s 181 Methods 16 Regio
ns
Jul 23 19:49:49 localhost kernel: ACPI Namespace successfully loaded at roo=
t c033973c
Jul 23 19:49:49 localhost kernel: evxfevnt-0076 [04] Acpi_enable           =
: Transition to ACPI m
ode successful
Jul 23 19:49:49 localhost kernel: Executing all Device _STA and_INI methods=
:.....................
=2E...................................
Jul 23 19:49:49 localhost kernel: 57 Devices found containing: 57 _STA, 1 _=
INI methods
Jul 23 19:49:49 localhost acpid: acpid startup succeeded
Jul 23 19:49:49 localhost kernel: Completing Region/Field/Buffer/Package in=
itialization:.........
=2E.....................................................
Jul 23 19:49:50 localhost kernel: Initialized 11/16 Regions 0/0 Fields 34/3=
4 Buffers 18/18 Packag
es (579 nodes)
Jul 23 19:49:50 localhost kernel: ACPI: Interpreter enabled
Jul 23 19:49:50 localhost kernel: ACPI: Using PIC for interrupt routing
Jul 23 19:49:50 localhost kernel: ACPI: System [ACPI] (supports S0 S1 S4 S5)
Jul 23 19:49:50 localhost kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Jul 23 19:49:50 localhost kernel: PCI: Probing PCI hardware (bus 00)
Jul 23 19:49:50 localhost pcmcia: Starting PCMCIA services:=20
Jul 23 19:49:50 localhost kernel: Unknown bridge resource 0: assuming trans=
parent
Jul 23 19:49:50 localhost kernel: Unknown bridge resource 2: assuming trans=
parent
Jul 23 19:49:50 localhost kernel: pci_bind-0191 [103] acpi_pci_bind        =
 : Device 00:02:00.01=20
not present in PCI namespace
Jul 23 19:49:50 localhost kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4=
 5 7 9 *10 11 12 14 15
)
Jul 23 19:49:50 localhost kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4=
 5 7 9 *10 11 12 14 15
)
Jul 23 19:49:50 localhost kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4=
 5 7 *9 10 11 12 14 15
)
Jul 23 19:49:50 localhost kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4=
 5 7 *9 10 11 12 14 15
)
Jul 23 19:49:50 localhost kernel: ACPI: Embedded Controller [EC0] (gpe 28)

Jul 23 19:49:50 localhost kernel: ACPI: Battery Slot [BAT1] (battery presen=
t)
Jul 23 19:49:50 localhost kernel: ACPI: Power Button (FF) [PWRF]
Jul 23 19:49:50 localhost kernel: ACPI: Lid Switch [LID]
Jul 23 19:49:50 localhost kernel: ACPI: Sleep Button (CM) [SLPB]
Jul 23 19:49:50 localhost kernel: ACPI: Processor [CPU0] (supports C1, 2 pe=
rformance states)
Jul 23 19:49:50 localhost kernel: Serial driver version 5.05c (2001-07-08) =
with MANY_PORTS SHARE_
IRQ SERIAL_PCI SERIAL_ACPI enabled
Jul 24 19:48:49 localhost kernel:  dsutils-0349 [87827] Ds_create_operand  =
   : Object name [PBST] was not found in namespace
Jul 24 19:48:49 localhost kernel:  dsutils-0512 [87826] Ds_create_operands =
   : While creating Arg 1 - AE_AML_NAME_NOT_FOUND
Jul 24 20:04:10 localhost kernel:   utmisc-0608 [87835] Ut_acquire_mutex   =
   : Thread 6D11 couldnot acquire Mutex [ACPI_MTX_Namespace] AE_ERROR
Jul 24 20:04:10 localhost kernel: acpi_battery-0195 [87833] acpi_battery_ge=
t_statu: Error evaluating _BST
Jul 24 20:32:40 localhost kernel: acpi_utils-0071 [87914] acpi_extract_pack=
age  : Invalid 'package' argument
Jul 24 20:32:40 localhost kernel: acpi_battery-0205 [87913] acpi_battery_ge=
t_statu: Error extracting _BST
Jul 24 23:35:15 localhost kernel: exresnte-0103 [87888] Ex_resolve_node_to_=
val: No object attached to node c1832968
Jul 24 23:35:15 localhost kernel: acpi_battery-0195 [87883] acpi_battery_ge=
t_statu: Error evaluating _BST
Jul 24 23:35:15 localhost kernel: exresnte-0103 [87888] Ex_resolve_node_to_=
val: No object attached to node c1832968
Jul 24 23:35:15 localhost kernel: acpi_battery-0195 [87883] acpi_battery_ge=
t_statu: Error evaluating _BST
Jul 25 00:13:08 localhost kernel: exresnte-0103 [87891] Ex_resolve_node_to_=
val: No object attached to node c1832968
Jul 25 00:13:08 localhost kernel: acpi_battery-0195 [87886] acpi_battery_ge=
t_statu: Error evaluating _BST
Jul 25 00:13:08 localhost kernel: exresnte-0103 [87891] Ex_resolve_node_to_=
val: No object attached to node c1832968
Jul 25 00:13:08 localhost kernel: acpi_battery-0195 [87886] acpi_battery_ge=
t_statu: Error evaluating _BST
Jul 25 00:44:13 localhost kernel: exresnte-0103 [87891] Ex_resolve_node_to_=
val: No object attached to node c1832968
Jul 25 00:44:13 localhost kernel: acpi_battery-0195 [87886] acpi_battery_ge=
t_statu: Error evaluating _BST
Jul 25 00:44:13 localhost kernel: exresnte-0103 [87891] Ex_resolve_node_to_=
val: No object attached to node c1832968
Jul 25 00:44:13 localhost kernel: acpi_battery-0195 [87886] acpi_battery_ge=
t_statu: Error evaluating _BST
Jul 25 10:16:33 localhost kernel: exresnte-0103 [87984] Ex_resolve_node_to_=
val: No object attached to node c1832968
Jul 25 10:16:33 localhost kernel: acpi_battery-0195 [87979] acpi_battery_ge=
t_statu: Error evaluating _BST
Jul 25 10:16:33 localhost kernel: exresnte-0103 [87984] Ex_resolve_node_to_=
val: No object attached to node c1832968
Jul 25 10:16:33 localhost kernel: acpi_battery-0195 [87979] acpi_battery_ge=
t_statu: Error evaluating _BST
Jul 25 10:19:23 localhost kernel:   utmisc-0608 [87991] Ut_acquire_mutex   =
   : Thread 4B01 couldnot acquire Mutex [ACPI_MTX_Namespace] AE_ERROR
Jul 25 10:19:23 localhost kernel: acpi_battery-0134 [87989] acpi_battery_ge=
t_info : Error evaluating _BIF
Jul 25 10:19:31 localhost kernel:   utmisc-0608 [87991] Ut_acquire_mutex   =
   : Thread 4B02 couldnot acquire Mutex [ACPI_MTX_Namespace] AE_ERROR
Jul 25 10:19:31 localhost kernel: acpi_battery-0134 [87989] acpi_battery_ge=
t_info : Error evaluating _BIF
Jul 25 10:19:59 localhost kernel:   utmisc-0608 [87991] Ut_acquire_mutex   =
   : Thread 4B05 couldnot acquire Mutex [ACPI_MTX_Namespace] AE_ERROR
Jul 25 10:19:59 localhost kernel: acpi_battery-0134 [87989] acpi_battery_ge=
t_info : Error evaluating _BIF

The last few messages occur when I type=20
    cat /proc/acpi/battery/BAT1/state=20
(which hangs) and then I type ctrl-C.  The message does not appear in
the log until I hit gtrl-C.

Note that I am running wmacpi, which is attempting to read the battery
status on a regular basis.

Cheers,
-- Bob

Bob McElrath (rscelrath-9geRo0GdX4mkVGS65fRQmodd74u8MsAO@public.gmane.org)=20
Univ. of Wisconsin at Madison, Department of Physics

"No nation could preserve its freedom in the midst of continual warfare."
    --James Madison, April 20, 1795

--pQhZXvAqiZgbeUkD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj1APH0ACgkQjwioWRGe9K20UgCgrvdCvZJB4cSXPDlVmtNwH+MQ
15QAoOlSZ3oSJ6YdjO/uqLOVkoxi7b6g
=C7+r
-----END PGP SIGNATURE-----

--pQhZXvAqiZgbeUkD--


-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
