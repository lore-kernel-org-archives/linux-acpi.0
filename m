From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: acpi=off & /proc entries
Date: Wed, 14 May 2003 16:07:45 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8427230B@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
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
To: =?iso-8859-2?Q?Zden=ECk_OGAR_Skal=E1k?= <skalak-Bh/+Xfn7orxQjibfaplwYw@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Try latest patch please. If you still have problem, would you please =
file it on bugzilla.kernel.org  (Both 2.4 and 2.5)=20

Thanks,
Luming

-----Original Message-----
From: Zden=A8=A7k OGAR Skal=A8=A2k [mailto:skalak-Bh/+Xfn7orxQjibfaplwYw@public.gmane.org]
Sent: 2003?5?12? 23:19
To: Grover, Andrew
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [ACPI] acpi=3Doff & /proc entries


Hi,

	I'm using kernel 2.4.20 with ACPI version 20021205 (with additional =
patch as:
custom corrected DSDT, DSDT in initrd, \_OS override, .....). I find out =
a small
bug:
	if you boot with acpi=3Doff argument, acpi isn't activated (as you =
would expect),
but proc-entries in /proc/acpi (as battery & so on), appears just below =
/proc
:-{

cat /var/log/dmesg:
...
ACPI: Subsystem revision 20021205
ACPI: Disabled via command line (acpi=3Doff)
...
acpi_button-0466 [0001] [02] acpi_button_init      : ----Entry
acpi_bus-1247 [0001] [03] acpi_bus_register_driv: ----Entry
acpi_bus-1259 [0001] [03] acpi_bus_register_driv: ----Exit- =
0000000000000000
acpi_button-0478 [0001] [02] acpi_button_init      : ----Exit- =
0000000000000000
...

Reason:
	there's global struct proc_dir_entry *acpi_root_dir in bus.c=20
	if you boot with acpi=3Doff, it has it's implicit value of NULL
	all drivers (ex. button) has their init functions with this sequence:
		acpi_xxx_dir =3D proc_mkdir(ACPI_xxx_CLASS, acpi_root_dir);=20
		// this success, (but acpi_root_dir=3D=3DNULL :-{
		result =3D acpi_bus_register_driver(&acpi_xxx_driver);=09
		// this returns 0, should it ?
		if (result<0){
			// we don't get here
			remove_proc_entry(ACPI_xxx_CLASS, acpi_root_dir);
			return_VALUE(-ENODEV);
		}
		return_VALUE(0);

	I think, we should (in each such driver) test the acpi_disabled =
variable & if
it's on, don't even bother with mkdir, register_bus_driver  .... Or =
don't allow
acpi_bus_register_driver to return success if acpi=3D=3Doff (test of =
acpi_disabled
there :-)

	Sorry, but don't have time (and even not the correct kernel tree & =
correct acpi
version) to make patch ...

	Bye
		Zdenek OGAR Skalak

--=20
Ing. Zden=ECk OGAR Skal=E1k
Monet+ a.s.
Z=E1meck=E1 365
763 14 Zl=EDn - =A9t=EDpa, CZ
Tel: +420 / 577 110 411,  Fax: +420 / 577 914 557


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
