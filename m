From: "Cagle, John (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>
Subject: RE: acpi-20030328-2.4.21-pre6.diff on Toshiba hard locks
Date: Thu, 24 Apr 2003 19:59:55 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C50AB9511EE59B49B2A503CB7AE1ABD10440E4C5@cceexc19.americas.cpqcorp.net>
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
To: Rob Hughes <rob-d2NfoQ5nhImakBO8gow8eQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Did you use the same .config for the new kernel?  From a cursory look,
there are some suspicious things missing from the new kernel's dmesg
(these were in the -pre3 log but not in pre6):

enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...

Toshiba System Managment Mode driver v1.11 26/9/2001

floppy0: no floppy controllers found

ICH2: IDE controller at PCI slot 00:1f.1
ICH2: chipset revision 5
ICH2: not 100% native mode: will probe irqs later

apm: BIOS not found.
apm: BIOS not found.
0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4349
Thu Mar 27 19:00:02 PST 2003
PCI: Enabling device 00:1f.5 (0000 -> 0001)
PCI: Setting latency timer of device 00:1f.5 to 64
intel8x0: clocking to 48000

> -----Original Message-----
> From: Rob Hughes [mailto:rob-d2NfoQ5nhImakBO8gow8eQ@public.gmane.org]=20
> Sent: Thursday, April 24, 2003 3:23 PM
> To: Cagle, John (ISS-Houston)
> Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: RE: [ACPI] acpi-20030328-2.4.21-pre6.diff on Toshiba=20
> hard locks
>=20
>=20
> John,
>=20
> Thanks. I think I'm including everything relevant this time.=20
> If not, just yell at me or something and I'll fix it.
>=20
> Thanks,
> Rob
>=20
> On Wed, 2003-04-23 at 19:14, Cagle, John (ISS-Houston) wrote:
> > Rob - that wasn't the full "dmesg" log (it's missing all the ACPI=20
> > related logging).  Can you send out the last boot log from=20
> > /var/log/messages?
> >=20
> > Also, the contents of /proc/interrupts would be useful to the ACPI=20
> > developers.  Send two versions: from your prior=20
> installation and the=20
> > new, non-working one.
> >=20
> > Thanks,
> > John
> >=20
> > > -----Original Message-----
> > > From: Rob Hughes [mailto:rob-d2NfoQ5nhImakBO8gow8eQ@public.gmane.org]
> > > Sent: Wednesday, April 23, 2003 5:03 PM
> > > To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > Subject: Re: [ACPI] acpi-20030328-2.4.21-pre6.diff on Toshiba=20
> > > hard locks
> > >=20
> > >=20
> > > On Tue, 2003-04-22 at 22:38, Rob Hughes wrote:
> > > > Got the acpi-20030328 patch, applied it to a vanilla
> > > 2.4.21-pre6 and
> > > > compiled. Everything went cleanly, but I'm having a problem
> > > with the
> > > > sound hardware. I've tried both the oss and alsa intel
> > > sound modules,
> > > > and both produce hard locks on my Tos 5005-S504. I'm not
> > > able to break
> > > > to a debug prompt, and there is no oops. Dmesg produces=20
> no useful
> > > > output at boot, or at least, it's not any different in=20
> content from=20
> > > > previous patches where this configuration was working. Adding=20
> > > > "pci=3Dnoacpi" prevents the lock, but also keeps all sound=20
> > > modules from
> > > > loading as the hardware isn't initialized. Any hints on where I
> > > > could/should start looking? Other than the above, I'm=20
> not sure what=20
> > > > other info to include here, as I'm not entirely sure what's=20
> > > relevant.
> > > >=20
> > > > Thanks,
> > > > Rob
> > >=20
> > > Hate replying to my own posts, but I did find something. It
> > > appears to be a problem with IRQ sharing on this system, as=20
> > > most devices are being assigned IRQ 10. I'll go ahead and=20
> > > attach what I hope are the relevant info, that being the=20
> > > dsdt, dmesg output and output from lspci -vv.
> > >=20
> > > This system does run using another OS, and again, ran fine
> > > with earlier kernels, so I strongly suspect that IRQ sharing=20
> > > on this system has been broken somehow.
> > >=20
> > > Rob
>=20


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
