From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ASUS M6800N: problem when removing 'ac' module
Date: Mon, 22 Mar 2004 10:04:10 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <571ACEFD467F7749BC50E0A98C17CDD803300B9D@PDSMSX403.ccr.corp.intel.com>
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
To: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Cc: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,
Please let me know if below patch helps.
Thanks,
David

--- a/drivers/acpi/scan.c	8 Jan 2004 10:39:37 -0000	1.1.1.2
+++ b/drivers/acpi/scan.c	17 Jan 2004 01:34:23 -0000
@@ -311,8 +311,10 @@ static int acpi_driver_detach(struct acp
 		struct acpi_device * dev =3D container_of(node,struct
acpi_device,g_list);
=20
 		if (dev->driver =3D=3D drv) {
+			spin_unlock(&acpi_device_lock);
 			if (drv->ops.remove)
=20
drv->ops.remove(dev,ACPI_BUS_REMOVAL_NORMAL);
+			spin_lock(&acpi_device_lock);
 			dev->driver =3D NULL;
 			dev->driver_data =3D NULL;
 			atomic_dec(&drv->references);

> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Luca Capello
> Sent: Saturday, March 20, 2004 8:26 PM
> To: ML ACPI-devel
> Subject: Re: [ACPI] ASUS M6800N: problem when removing 'ac' module
>=20
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> Hello,
>=20
> on 03/20/04 12:10, Luca Capello wrote:
> > I'm on '2.6.5-rc1 + ACPI DSDT in initrd + eciadsl USB patch' and I
get
> this
> > message when I 'rmmod ac' or 'modprobe -r ac':
> actually, this happens with all ACPI modules:
> =3D=3D=3D=3D=3D
> Badness in remove_proc_entry at fs/proc/generic.c:664
> Call Trace:
>  [<c0182b4c>] remove_proc_entry+0x11c/0x160
>  [<e20df328>] acpi_ac_remove_fs+0x49/0x6d [ac]
>  [<e20df5e9>] acpi_ac_remove+0x86/0xa5 [ac]
>  [<c02e920a>] acpi_driver_detach+0x64/0xbd
>  [<c02e9352>] acpi_bus_unregister_driver+0x3d/0x93
>  [<e20df63d>] cleanup_module+0x35/0x55 [ac]
>  [<c01326fb>] sys_delete_module+0x12b/0x170
>  [<c014905a>] do_munmap+0x13a/0x180
>  [<c01490e3>] sys_munmap+0x43/0x70
>  [<c010935b>] syscall_call+0x7/0xb
>=20
> Badness in remove_proc_entry at fs/proc/generic.c:664
> Call Trace:
>  [<c0182b4c>] remove_proc_entry+0x11c/0x160
>  [<e2177eb5>] acpi_battery_remove_fs+0x49/0x6d [battery]
>  [<e2178185>] acpi_battery_remove+0x86/0xa5 [battery]
>  [<c02e920a>] acpi_driver_detach+0x64/0xbd
>  [<c02e9352>] acpi_bus_unregister_driver+0x3d/0x93
>  [<e21781d9>] acpi_battery_exit+0x35/0x55 [battery]
>  [<c01326fb>] sys_delete_module+0x12b/0x170
>  [<c01490e3>] sys_munmap+0x43/0x70
>  [<c010935b>] syscall_call+0x7/0xb
>=20
> Badness in remove_proc_entry at fs/proc/generic.c:664
> Call Trace:
>  [<c0182b4c>] remove_proc_entry+0x11c/0x160
>  [<e2177eb5>] acpi_battery_remove_fs+0x49/0x6d [battery]
>  [<e2178185>] acpi_battery_remove+0x86/0xa5 [battery]
>  [<c02e920a>] acpi_driver_detach+0x64/0xbd
>  [<c02e9352>] acpi_bus_unregister_driver+0x3d/0x93
>  [<e21781d9>] acpi_battery_exit+0x35/0x55 [battery]
>  [<c01326fb>] sys_delete_module+0x12b/0x170
>  [<c01490e3>] sys_munmap+0x43/0x70
>  [<c010935b>] syscall_call+0x7/0xb
>=20
> Badness in remove_proc_entry at fs/proc/generic.c:664
> Call Trace:
>  [<c0182b4c>] remove_proc_entry+0x11c/0x160
>  [<e2212c1a>] acpi_thermal_remove_fs+0x49/0x6d [thermal]
>  [<e22130a4>] acpi_thermal_remove+0xce/0xea [thermal]
>  [<c02e920a>] acpi_driver_detach+0x64/0xbd
>  [<c02e9352>] acpi_bus_unregister_driver+0x3d/0x93
>  [<e22130f5>] acpi_thermal_exit+0x35/0x55 [thermal]
>  [<c01326fb>] sys_delete_module+0x12b/0x170
>  [<c01490e3>] sys_munmap+0x43/0x70
>  [<c010935b>] syscall_call+0x7/0xb
>=20
> Badness in remove_proc_entry at fs/proc/generic.c:664
> Call Trace:
>  [<c0182b4c>] remove_proc_entry+0x11c/0x160
>  [<e2204561>] acpi_processor_remove_fs+0x49/0x6d [processor]
>  [<e2204abc>] acpi_processor_remove+0x96/0xc3 [processor]
>  [<c02e920a>] acpi_driver_detach+0x64/0xbd
>  [<c02e9352>] acpi_bus_unregister_driver+0x3d/0x93
>  [<e2204b8f>] acpi_processor_exit+0x3f/0x5f [processor]
>  [<c01326fb>] sys_delete_module+0x12b/0x170
>  [<c01490e3>] sys_munmap+0x43/0x70
>  [<c010935b>] syscall_call+0x7/0xb
>=20
> Badness in remove_proc_entry at fs/proc/generic.c:664
> Call Trace:
>  [<c0182b4c>] remove_proc_entry+0x11c/0x160
>  [<e218d865>] acpi_button_exit+0x45/0x55 [button]
>  [<c01326fb>] sys_delete_module+0x12b/0x170
>  [<c01490e3>] sys_munmap+0x43/0x70
>  [<c010935b>] syscall_call+0x7/0xb
>=20
> Badness in remove_proc_entry at fs/proc/generic.c:664
> Call Trace:
>  [<c0182b4c>] remove_proc_entry+0x11c/0x160
>  [<e216e861>] asus_acpi_exit+0x1d/0x2a [asus_acpi]
>  [<c01326fb>] sys_delete_module+0x12b/0x170
>  [<c01490e3>] sys_munmap+0x43/0x70
>  [<c010935b>] syscall_call+0x7/0xb
> =3D=3D=3D=3D=3D
>=20
> Please take care that it doesn't happen with other modules (like
> 'ehci_hcd' or
> 'joydev').
>=20
> Solutions?
>=20
> Thx, bye,
> Gismo / Luca
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.4 (GNU/Linux)
> Comment: Using GnuPG with Debian - http://enigmail.mozdev.org
>=20
> iD8DBQFAXDhhVAp7Xm10JmkRAhABAJ44Z2VbSQgZN9zxS/Bzl16s67CmEACfa+PA
> GCw83WzhvIBLpfJoIuh7qjI=3D
> =3DFMOT
> -----END PGP SIGNATURE-----
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> =
administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dcli=
ck
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
