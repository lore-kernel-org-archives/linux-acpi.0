From: Thomas Renninger <trenn@suse.de>
Subject: Re: Fw: ata-piix ACPI errors
Date: Thu, 01 Mar 2007 10:58:19 +0100
Message-ID: <1172743100.10619.547.camel@d36.suse.de>
References: <20070223020856.641452a3.akpm@linux-foundation.org>
	 <1172586557.10619.423.camel@d36.suse.de>  <45E5C753.106@gmail.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:52236 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964793AbXCAJ63 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 Mar 2007 04:58:29 -0500
In-Reply-To: <45E5C753.106@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, Meelis Roos <mroos@linux.ee>, Adrian Bunk <bunk@stusta.de>, Hannes Reinecke <hare@suse.de>

On Thu, 2007-03-01 at 03:17 +0900, Tejun Heo wrote:
> Hello, Thomas.
>=20
> Thomas Renninger wrote:
> > On Fri, 2007-02-23 at 02:08 -0800, Andrew Morton wrote:
> >> I'm starting to think that big acpi merge came a bit too soon.
> >>
> >> Begin forwarded message:
> >>
> >> Date: Thu, 22 Feb 2007 15:29:42 +0200 (EET)
> >> From: Meelis Roos <mroos@linux.ee>
> >> To: Linux Kernel list <linux-kernel@vger.kernel.org>
> >> Subject: ata-piix ACPI errors
> >>
> >>
> >> Testbooted 2.6.21-rc1+todays git on a PC with Intel 845 chipset an=
d PATA=20
> >> HDD. Works fine but I now have these ACPI errors in dmesg, maybe s=
omeone=20
> >> is interested:
> >>
> >> ata_piix 0000:00:1f.1: version 2.00ac7
> >> PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
> >> ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ =
18
> >> PCI: Setting latency timer of device 0000:00:1f.1 to 64
> >> ata1: PATA max UDMA/100 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x0001=
ffa0 irq 14
> >> ata2: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376 bmdma 0x0001=
ffa8 irq 15
> >> scsi0 : ata_piix
> >> ACPI Error (dsopcode-0481): Attempt to CreateField of length zero =
[20070126]
> >
> > I expect this to be ACPI (interpreter) unrelated and the bug should=
 be
> > in drivers/ata/libata-acpi.c.
> > The problem is that libata-acpi.c calls _GTF function before _STM h=
as
> > been called. This is forbidden by ACPI spec.
>=20
> I can't find such wording in acpi 3.0a spec.  It says _STM may make
> adjustments to the result of _GTF.  Hmmm... the suspend/resume order
> does specify that _STM should be called before _GTF but nothing seems=
 to
> mandate use of _GTM and _STM.
I also can't find the explicit statement there now.
It seems that the steps described must be processed in the same order a=
s
written down there(9.9.2 IDE Controller Device):
Powering up:
=E2=80=A2 Power up drive (calls _PS0 method if present and turns
  on power planes).
=E2=80=A2 Call _STM passing info from _GTM (possibly modified),
  with ID data from each drive.
=E2=80=A2 Initialize the channel.
=E2=80=A2 May modify the results of _GTF.
=E2=80=A2 For each drive: Call _GTF. Execute task file (possibly modifi=
ed).

Libata subsystem has no choice here as AML code (C&Ped through
several BIOSes?) already relies on that.
I put some info of a bug report here to reproduce:
ftp.suse.com/pub/people/trenn/sata_acpi_errors_216853

If you do:
acpiexec DSDT.dat
 -> execute \_SB_.PCI0.IDE0.CHN0.DRV0._GTF
you get exactly the error spit out in kernel/dmesg log:
ACPI Error (dsopcode-0601): Attempt to CreateField of length zero
[20060912]

If you quit and try again, calling:
 -> execute \_SB_.PCI0.IDE0.CHN0._STM 0 0 0
 -> execute \_SB_.PCI0.IDE0.CHN0.DRV0._GTF

Everything is fine...

I looked a bit at the asl code:
At end of _STM "Store (GTF (0x00, Arg1), ATA0)" (not _GTF!, GTF is just
a helper function) is called.
ATA0 gets filled here and is the field that is later used in _GTF which
throws an error in the called RATA func, if ATA0 has not been filled
yet.

It's not that easy and a bit difficult to put in words...

>=20
> I think libata-acpi has several issues here.
>=20
> 1. Missing _GTM/_STM support.  This is because mode programming is
> essential to PATA controllers and we do it in more conventional way
> (poking PCI / controller registers) regardless of ACPI, so this featu=
re
> is kind of redundant.

Ok, that is the problem.
If using _GTF you won't come around also using _STM/_GTM.
We already have libata-acpi patches in our 2.6.16 kernel which have
_STM/_GTM support.
AFAIK those come from Hannes who also posted this some time ago
(to some ide-xy mailinglist, don't know)?
You may want to wait for his answer, there already exist stuff doing
this and as code is in our kernels it also should be rather well
tested...

    Thomas



> 2. Doing _GTF on boot.  _GTF is supposed to configure the device as t=
he
> firmware would have configured it during a normal boot, so we shouldn=
't
> be doing it during boot.  This too is in gray area as if we're doing
> kexec, we might want to do _GTF during boot.
>=20
> It would be the cleanest if _GTF can be modified by but doesn't depen=
d
> on _STM.  Oh, well, there seem to be enough motherboards out there hi=
t
> by this.  I'll cook something up.


-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
