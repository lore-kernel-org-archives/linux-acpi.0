From: "Nakajima, Jun" <jun.nakajima-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI high interrupt rate with vanilla 2.4.22
Date: Tue, 26 Aug 2003 15:12:49 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <7F740D512C7C1046AB53446D3720017304AED6@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: Marc Giger <gigerstyle-OI3hZJvNYWs@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Is this ASUS P4T533 based system?=20

   PCI: No IRQ known for interrupt pin A of device 02:0a.0

   02:0a.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xd800. Vers
LK1.1.18-ac
   00:50:04:07:23:f6, IRQ 9

Looks like the kernel fails to find the PCI interrupt link for the NIC.
Can you send acpidmp of the machine to linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org?

BTW, we realized "pci=3Dnoacpi" does not work well. Please "acpi=3Doff" =
in
the meantime. We are working on the patch.

Thanks,
Jun


> -----Original Message-----
> From: Marc Giger [mailto:gigerstyle-OI3hZJvNYWs@public.gmane.org]
> Sent: Tuesday, August 26, 2003 3:44 AM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] ACPI high interrupt rate with vanilla 2.4.22
>=20
> Hi All,
>=20
> Today I installed 2.4.22. First thing what I noticed was the very high
> interrupt rate on acpi.
>=20
> After
> 11:43:53 up 12 min,  0 users,  load average: 0.32, 0.63, 0.39
>=20
>            CPU0
>   0:      73491    IO-APIC-edge  timer
>   1:       3783    IO-APIC-edge  keyboard
>   2:          0          XT-PIC  cascade
>   8:          2    IO-APIC-edge  rtc
>   9:          2    IO-APIC-edge  eth0
>  14:        919    IO-APIC-edge  ide0
>  15:          9    IO-APIC-edge  ide1
>  20:      11779   IO-APIC-level  aic7xxx
>  22:   60376810   IO-APIC-level  acpi
> NMI:          0
> LOC:      73449
> ERR:          0
> MIS:          0
>=20
> This high interrupt rate slowdowns the box noticeable.
>=20
> Next problem is that eth0 doesn't work if acpi enabled. See attached
> dmesg
>=20
> When I type pci=3Dnoacpi on lilo prompt then I can't boot the machine.
It
> hangs while detecting the scsi drives on aic7xxx.
>=20
> So I had to type acpi=3Doff but the machine doesn't poweroff itself:-(
>=20
> The same problem exists of course with 2.6.0-testX kernels.
>=20
> Another thing is /proc/acpi/processor/
> There are 2 CPU entries...?!?
>=20
> greets
>=20
> Marc


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
