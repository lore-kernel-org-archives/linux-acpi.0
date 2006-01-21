From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] acpiphp: treat dck separate from dock bridge
Date: Sat, 21 Jan 2006 12:27:38 +0100
Message-ID: <20060121112738.GA1555@elf.ucw.cz>
References: <20060116200218.275371000@whizzy> <1137545819.19858.47.camel@whizzy> <1137808506.16192.69.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5316 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932123AbWAUL1v (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 21 Jan 2006 06:27:51 -0500
Content-Disposition: inline
In-Reply-To: <1137808506.16192.69.camel@whizzy>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, pcihpd-discuss@lists.sourceforge.net, len.brown@intel.com, linux-acpi@vger.kernel.org

Hi!
On P=E1 20-01-06 17:55:06, Kristen Accardi wrote:
> Here's an addition to the acpiphp dock station patch for interested
> people to try.  It has a problem that I've not solved yet that will
> cause the driver to oops if you boot your laptop docked, then load th=
e
> driver, then try to undock.  But, it works for me if you boot undocke=
d,
> then load the driver, then dock/undock etc.  This patch is different
> from the original in that I no longer assume that _DCK is defined und=
er
> the actual p2p dock bridge.  However, the solution I came up with is =
not
> actually very good.  I have to somehow find out which device is the
> actual p2p bridge, and what I try to do here is:
> 1) find the device that _DCK is defined under
> 2) if this is a bridged device, we are done (i.e. is has _ADR and is
> ejectable)
> 3) if not, then walk the namespace looking for _EJD.  If you find one=
,
> see if the dependency is on the dock device.  The dock bridge should =
be
> dependent on the dock device. =20
>=20
> 	- when you find something that is dependent on the dock device,
> 	  see if it has an _ADR and a _PRT entry.  If so, then it is the
> 	  p2p dock bridge.
>=20
> So, this is likely a wrong assumption, so I will be thinking some mor=
e
> about how to tell which acpi device is the dock bridge.  But meanwhil=
e,
> this patch could be tested/reviewed to see if it gets us a step furth=
er
> in the right direction.
>=20
> I patched against 2.6.16-rc1-mm2 because I wasn't sure if it was safe=
 to
> just drop my other patch (since actually trying to just revert the
> broken out patch didn't actually work).  So this patches the file wit=
h
> my original patch applied.

It oopsed on me while insmoding it: ... will try to investigate.

root@amd:/data/l/linux-mm/drivers/pci/hotplug# insmod acpiphp.ko
BUG: unable to handle kernel NULL pointer dereference at virtual addres=
s 00000044
 printing eip:
*pde =3D 00000000
Oops: 0000 [#1]
last sysfs file: /devices/system/cpu/cpu0/cpufreq/scaling_governor
Modules linked in: acpiphp
CPU:    0
EIP:    0060:[<f9990d20>]    Not tainted VLI
EFLAGS: 00010286   (2.6.16-rc1-mm2 #2)
EIP is at acpiphp_get_power_status+0x0/0x10 [acpiphp]
eax: 00000000   ebx: f796bbe0   ecx: f9995384   edx: f7edc2c0
esi: f796bca0   edi: 00000014   ebp: f9992c35   esp: f7b35e14
ds: 007b   es: 007b   ss: 0068
Process insmod (pid: 1520, threadinfo=3Df7b34000 task=3Dc1f36a50)
Stack: <0>f887e13a f9992e5c f9992c18 00000246 22222222 fffffff4 0000000=
0 f784e000
       f784e4ac f784e4d0 f9995380 c0135636 f99953c8 c05be852 f999538c 0=
0000008
       00000000 f999538c 0000001c 00000018 0000001c 00000018 f998bba8 f=
998ba90
Call Trace:
 [<f887e13a>] acpiphp_init+0x13a/0x290 [acpiphp]
 [<c0135636>] sys_init_module+0x146/0x1630
 [<c010f1b0>] acpi_register_ioapic+0x0/0x10
 [<c013fd87>] generic_file_aio_read+0x47/0x70
 [<c0168b93>] open_namei+0x83/0x560
 [<c012e930>] autoremove_wake_function+0x0/0x50
 [<c014d544>] do_brk+0x204/0x210
 [<c016f4fa>] dput_recursive+0x2a/0x1d0
 [<c015a891>] __fput+0xe1/0x140
 [<c017304b>] mntput_no_expire+0x1b/0x70
 [<c0102d1d>] syscall_call+0x7/0xb
Code: b9 ff ff ff ff b8 06 00 00 00 89 74 24 08 89 5c 24 04 c7 04 24 f0=
 0a 99 f9 e8 a6 f0 90 c6 8b 54 24 0c eb 9a 8d b4 26 00 00 00 00 <0f> b6=
 40 44 83 e0 01 c3 90 8d b4 26 00 00 00 00 e8 fb fc ff ff
 Segmentation fault
root@amd:/data/l/linux-mm/drivers/pci/hotplug#


--=20
Thanks, Sharp!
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
