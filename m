From: "Harald Brennich" <harald.brennich@gmx.de>
Subject: Battery is not detected on start of Linux
Date: Mon, 17 Oct 2011 22:27:31 +0200
Message-ID: <op.v3ii35ofxk5j3o@hatosh.brennich>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:47094 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751511Ab1JQU1o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Oct 2011 16:27:44 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,
bugzilla.kernel.org now being down for several weeks I am hoping I have=
 =20
found the correct place to discuss my issue with battery detection. I h=
ave =20
found a solution to the problem (see solutions 3.), but if a patch is =20
already available, please let me know so.
Regards
Harald Brennich

Problem:
The battery is not automatically detected on starting the system. =20
/sys/class/power_supply/BAT1/ is empty.

Environment:
Hardware: Toshiba Satellite L755-161 notebook
System: openSuse 11.4
Kernel: 3.1.0-rc5-1-vanilla

Symptoms:
On start of Windows 7, the battery state is shown correctly. On start o=
f =20
Linux, the system says battery not present. The battery is present and =
=20
correctly described only after one of the following actions is taken wi=
th =20
Linux:
1. Open the lid of the notebook
2. Unplug an plug the external power ("AC")
3. Start the system without the battery. Shutdown and start again with =
=20
battery.
The first two are to be done with a running system, of course. The thir=
d =20
only shows the battery for the first start after the shutdown.

Cause:
Methods _STA and _BST of device BAT1 (Battery) return the current value=
 =20
only if flag BTIN has been set. This flag is set by method BSTA of devi=
ce =20
BAT1. BSTA is called by methods _Q09 and _Q20 of device EC (Embedded =20
Control).

Solutions:
1. Call method BSTA in function acpi_battery_add of drivers/acpi/batter=
y.c
This works fine.
However, this is specific code and will not work with other hardware.

2. When a query method of Embedded Control is registered =20
(acpi_ec_register_query_methods), immediately call it =20
(acpi_evaluate_object(handle, NULL, NULL, NULL)).
This also works fine.
Compared to procedure (1) this has the advantage that it is not hardwar=
e =20
specific. It possibly has the disadvantage that calling a query method =
=20
might be harmful.

3. Though proceeding as in (1) or (2) works and (2) is not explicitly =20
dependent on hardware specifics, considering the freedom that the DSDT =
=20
language grants to implement features not mentioned in the specs (like =
the =20
above mentioned BSTA method), to achieve the goals cited in
"In the early days of Linux/ACPI, DSDT modifications were common to wor=
k =20
around both BIOS bugs and Linux bugs. However, the stated goal of the =20
Linux/ACPI project today is that Linux should run on un-modified firmwa=
re. =20
Thus, the DSDT database at the old http://acpi.sourceforge.net web site=
 is =20
now largely a historical artifact."
(cited from http://www.lesswatts.org/projects/acpi/overridingDSDT.php)
it may be necessary to use kernel parameters to control DSDT handling. =
=20
Therefore, I have defined kernel parameters acpi.ec_query_on_register =20
and/or acpi.bat_init_state_method.
3.1 When acpi.ec_query_on_register is defined, on registering a query =20
method  of Embedded Control(acpi_ec_register_query_methods), depending =
on =20
the contents of acpi.ec_query_on_register the following is done:
- acpi.ec_register_query_methods is empty:
   All query methods of Embedded Control are called
- acpi.ec_register_query_methods is not empty and does not start with !=
:
   Query method of Embedded Control is called if its name (something li=
ke =20
_QXX where the Xs are hexadecimal digits) is in =20
acpi.ec_register_query_methods
- acpi.ec_register_query_methods is not empty and does start with !:
   Query method of Embedded Control is called if its name is not in =20
acpi.ec_register_query_methods
3.2 In function acpi_battery_add the function acpi_battery_init_state w=
ith =20
parameter acpi.bat_init_state_method is called if =20
acpi.bat_init_state_method is not null and not empty. The function =20
acpi_battery_init_state calls the DSTD method with the name =20
acpi.bat_init_state_method.
Both methods work fine and allow to take care of DSTS specifics via ker=
nel =20
parameters.


--=20
Erstellt mit Operas revolution=C3=A4rem E-Mail-Modul: http://www.opera.=
com/mail/
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
