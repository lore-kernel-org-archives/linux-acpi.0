From: Thomas Kosch <t.kosch-7+EO1k1ndLmazgQtNeiOUg@public.gmane.org>
Subject: Problem with pcmcia and ide-scsi with kernel 2.4.20-pre5 and
 acpi-20020829
Date: Wed, 18 Sep 2002 15:36:31 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <microsoft-free.m3sn07ifmo.fsf@grisu.cyvermail.de>
References: <E174ny3-0008Hy-00@usw-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <E174ny3-0008Hy-00-HKCwXBn57GynvZpeIfgr/KQD96bmaF075NbjCUgZEJk@public.gmane.org> (acpi-devel-request@lists.sourceforge.net's
 message of "Mon, 06 May 2002 12:15:32 -0700")
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I use the acpi-20020829-2.4.20-pre5.diff with Ducrot Bruno's DSTD on a
Toshiba Satellite 3000-214.
When I start the cardmanager i get=20

,----
| Sep 18 15:18:46 grisu kernel: unloading Kernel Card Services
| Sep 18 15:18:53 grisu rcpcmcia: /sbin/insmod /lib/modules/2.4.20-pre5/ker=
nel/drivers/pcmcia/pcmcia_core.o
| Sep 18 15:18:53 grisu kernel: Linux Kernel Card Services 3.1.22
| Sep 18 15:18:53 grisu kernel:   options:  [pci] [cardbus] [pm]
| Sep 18 15:18:53 grisu rcpcmcia: /sbin/insmod /lib/modules/2.4.20-pre5/ker=
nel/drivers/pcmcia/pcmcia_core.o
| Sep 18 15:18:53 grisu rcpcmcia: /sbin/insmod /lib/modules/2.4.20-pre5/ker=
nel/drivers/pcmcia/yenta_socket.o
| Sep 18 15:18:54 grisu kernel: Yenta IRQ list 0818, PCI irq10
| Sep 18 15:18:54 grisu kernel: Socket status: 30000006
| Sep 18 15:18:54 grisu kernel: Yenta IRQ list 0818, PCI irq10
| Sep 18 15:18:54 grisu kernel: Socket status: 30000006
| Sep 18 15:18:54 grisu rcpcmcia: /sbin/insmod /lib/modules/2.4.20-pre5/ker=
nel/drivers/pcmcia/pcmcia_core.o
| Sep 18 15:18:54 grisu rcpcmcia: /sbin/insmod /lib/modules/2.4.20-pre5/ker=
nel/drivers/pcmcia/ds.o
| Sep 18 15:18:54 grisu cardmgr[2481]: starting, version is 3.1.28
| Sep 18 15:18:54 grisu cardmgr[2481]: modpath =3D /lib/modules/2.4.20-pre5/
| Sep 18 15:18:54 grisu cardmgr[2481]: modsubdir =3D pcmcia
| Sep 18 15:18:54 grisu cardmgr[2481]: watching 2 sockets
| Sep 18 15:18:54 grisu cardmgr[2481]: could not adjust resource: IO ports =
0xc00-0xcff: Device or resource busy
| Sep 18 15:18:54 grisu cardmgr[2481]: could not adjust resource: IO ports =
0x800-0x8ff: Device or resource busy
| Sep 18 15:18:54 grisu cardmgr[2481]: could not adjust resource: IO ports =
0x100-0x4ff: Device or resource busy
| Sep 18 15:18:54 grisu cardmgr[2481]: could not adjust resource: memory 0x=
c0000-0xfffff: Input/output error
| Sep 18 15:18:54 grisu cardmgr[2481]: could not adjust resource: memory 0x=
60000000-0x60ffffff: Input/output error
| Sep 18 15:18:54 grisu cardmgr[2481]: could not adjust resource: memory 0x=
a0000000-0xa0ffffff: Input/output error
| Sep 18 15:18:54 grisu cardmgr[2481]: could not adjust resource: IO ports =
0xa00-0xaff: Device or resource busy
`----

When i start the cardmanager on startup i can load the cardmanager but
when i insert a card i get these messages for example

,----
| Sep 17 09:34:42 grisu kernel: orinoco_cs.c 0.11b (David Gibson <hermes@gi=
bson.dropbear.id.au> and others)
| Sep 17 09:34:42 grisu kernel: orinoco_cs: RequestIRQ: Resource in use
`----

The second is, when i try to access the CD-Rom after a wake up from an S1 s=
leep
the computer freezes without any messages in the syslog. When i reload
the ide-scsi module it works



ttyl8er, t.k.

=2D-=20
Slowly and surely the unix crept up on the Nintendo user ...


-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
