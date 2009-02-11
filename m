From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [APIC] Kernel panic, rsync corruption, intel q8200, 2.6.28-rc8
Date: Wed, 11 Feb 2009 09:42:13 +0800
Message-ID: <1234316533.3706.104.camel@localhost.localdomain>
References: <4978767D.4060700@intertwingly.net>
	 <20090130000758.1dff0113.akpm@linux-foundation.org>
	 <498885CC.4060509@intertwingly.net>
	 <20090203114849.b661f1ce.akpm@linux-foundation.org>
	 <alpine.LFD.2.00.0902032152180.22800@localhost.localdomain>
	 <49890B46.8020308@intertwingly.net>
	 <alpine.LFD.2.00.0902032336000.5607@localhost.localdomain>
	 <4990C14B.7060802@intertwingly.net>
	 <1234231805.3706.80.camel@localhost.localdomain>
	 <49916927.9080200@intertwingly.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:55102 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755130AbZBKBax (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Feb 2009 20:30:53 -0500
In-Reply-To: <49916927.9080200@intertwingly.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sam Ruby <rubys@intertwingly.net>
Cc: Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "Maciej W. Rozycki" <macro@linux-mips.org>

On Tue, 2009-02-10 at 19:46 +0800, Sam Ruby wrote:
> yakui_zhao wrote:
> > On Tue, 2009-02-10 at 07:50 +0800, Sam Ruby wrote:
> >> Len Brown wrote:
> >>>>> Do you have a second computer around with a serial port ? If ye=
s, then
> >>>>> please add the following to the kernel command line:
> >>>>>
> >>>>>        earlyprintk=3Dserial,ttyS0,115200 apic=3Ddebug
> >>>>>
> >>>>> and connect the serial ports with a null modem cable. Fire up a
> >>>>> terminal program on the second machine and capture the output.
> >>>> I do have a second computer, and went out and bought a null mode=
m adapter for
> >>>> my serial cable and connected the two machines.  I've tried inst=
alling minicom
> >>>> and also connecting it to ttyS0 at 115200 baud on the second mac=
hine, but when
> >>>> I boot the first machine I don't see any output on the terminal.
> >>> /boot/grub/menu.lst:
> >>>
> >>> serial --unit=3D0 --speed=3D115200 --word=3D8 --parity=3Dno --sto=
p=3D1
> >>> terminal --timeout=3D300 serial console
> > Do you have an opportunity to try the boot option of "acpi=3Doff" a=
s
> > suggested by Lenb?
>=20
> That also produces the "MP-BIOS bug" message and halts.
Do you mean that the box still can't be booted with ACPI disabled? If
so, it should be a BIOS bug. It had better be fixed by bios upgrading.
   From the following test it seems that there exists the MPS table,
which describes how the timer is connected with I/O APIC. But
unfortunately it is still incorrect.=20
   And the timer still can't work w/o the timer override.
  =20
   Only when I/O apic is skipped can the box be booted. The timer is
connected with 8259.  And the timer can work as expected. But there
still exist other issue.
   =20
>=20
> >      From the log it seems that there exists the following warning
> > message:
> >     >=EF=BB=BFMP-BIOS bug: 8254 timer not connected to IO-APIC
> >=20
> >     Can you try the following boot options?
> >     a. acpi_use_timer_override
>=20
> That also produces the "MP-BIOS bug" message and halts.
>=20
> >     b. acpi_skip_timer_override
>=20
> That also produces the "MP-BIOS bug" message and halts.
>=20
> >     c. noapic
>=20
> With that, I can boot, but I get data corruption problems.  Data=20
> corruption problems I don't see when using the same hardware but with=
=20
> Microsoft Vista.  More details can be found here:
>=20
> http://intertwingly.net/blog/2009/01/20/noAPIC
> http://intertwingly.net/stories/2009/01/22/
>=20
> I am willing to install new kernels on fresh hard drives, run diagnos=
tic=20
> programs and report the output, including capturing serial output.  I=
s=20
> there any data I can gather to help diagnose this problem?
>=20
> >     Thanks.
> >>> is what I use.
> >>>
> >>> this will give you a prompt from grub even before the kernel boot=
s
> >>> so you can select (and edit) your kernel via menu over the serial=
 line
> >>> if you wish.
> >> I've got that working now.  I used minicom on the remote machine,=20
> >> capturing the output.  You can see me fumbling around, editing the=
=20
> >> kernel command and booting here:
> >>
> >> http://intertwingly.net/stories/2009/02/09/minicom.out
> >>
> >> While it is difficult to make out what I did given line wrapping, =
etc,=20
> >> what I started with was:
> >>
> >> /boot/vmlinuz-2.6.27-11-generic=20
> >> root=3DUUID=3D4fce230e-fe72-4685-aab0-294ef1c20efa ro noapic quiet=
 splash
> >>
> >> After editing, what I had was
> >>
> >> /boot/vmlinuz-2.6.27-11-generic=20
> >> root=3DUUID=3D4fce230e-fe72-4685-aab0-294ef1c20efa ro quiet splash=
=20
> >> earlyprintk=3Dserial,ttyS0,115200 apic=3Ddebug
> >>
> >> As you can see, the last line I saw was "Starting up ...", after w=
hich=20
> >> point the "MP-BIOS bug: 8254 timer not connected to IO-APIC" etc o=
utput=20
> >> appeared on the monitor that is directly connected to the machine =
being=20
> >> booted (i.e., this text did not appear on the minicom session).
> >>
> >>> If this doesn't work, then the kernel earlyprintk is unlikely to =
work=20
> >>> also.
> >> At the moment, it looks like it works, but earlyprintk does not wo=
rk for=20
> >> me, at least not on Ubuntu 8.10, kernel 2.6.27-11-generic.
> >>
> >>> Note that there may be some BIOS SETUP options related to the ser=
ial port=20
> >>> -- worth checking.
> >>>
> >>> Also, in minicom, be sure to turn off HW flow control
> >>>
> >>> there is a fancy serial console document someplace on this,
> >>> probably at http://tldp.org/
> >> As I have managed to get grub to talk to the serial console, I did=
 not=20
> >> explore these options further.  Please let me know if there is som=
ething=20
> >> in particular I should explore.
> >>
> >>> good luck,
> >>> -Len
> >> - Sam Ruby
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-ac=
pi" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> - Sam Ruby

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
