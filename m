From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI high interrupt rate with vanilla 2.4.22
Date: Fri, 29 Aug 2003 10:07:46 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720B18@pdsmsx403.ccr.corp.intel.com>
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
To: Marc Giger <gigerstyle-OI3hZJvNYWs@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi, Marc,

I have opened a tracker # 1165 on bugzilla.kernel.org, Would you please =
open an account for yourself, and followed upthis issue  there.

Thanks,
Luming

-----Original Message-----
From: Marc Giger [mailto:gigerstyle-OI3hZJvNYWs@public.gmane.org]
Sent: 2003?8?26? 18:44
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [ACPI] ACPI high interrupt rate with vanilla 2.4.22


Hi All,

Today I installed 2.4.22. First thing what I noticed was the very high
interrupt rate on acpi.

After
11:43:53 up 12 min,  0 users,  load average: 0.32, 0.63, 0.39

           CPU0      =20
  0:      73491    IO-APIC-edge  timer
  1:       3783    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  8:          2    IO-APIC-edge  rtc
  9:          2    IO-APIC-edge  eth0
 14:        919    IO-APIC-edge  ide0
 15:          9    IO-APIC-edge  ide1
 20:      11779   IO-APIC-level  aic7xxx
 22:   60376810   IO-APIC-level  acpi
NMI:          0=20
LOC:      73449=20
ERR:          0
MIS:          0

This high interrupt rate slowdowns the box noticeable.

Next problem is that eth0 doesn't work if acpi enabled. See attached
dmesg

When I type pci=3Dnoacpi on lilo prompt then I can't boot the machine. =
It
hangs while detecting the scsi drives on aic7xxx.

So I had to type acpi=3Doff but the machine doesn't poweroff itself:-(

The same problem exists of course with 2.6.0-testX kernels.

Another thing is /proc/acpi/processor/
There are 2 CPU entries...?!?

greets

Marc


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
