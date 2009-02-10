From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [APIC] Kernel panic, rsync corruption, intel q8200, 2.6.28-rc8
Date: Tue, 10 Feb 2009 10:10:05 +0800
Message-ID: <1234231805.3706.80.camel@localhost.localdomain>
References: <4978767D.4060700@intertwingly.net>
	 <20090130000758.1dff0113.akpm@linux-foundation.org>
	 <498885CC.4060509@intertwingly.net>
	 <20090203114849.b661f1ce.akpm@linux-foundation.org>
	 <alpine.LFD.2.00.0902032152180.22800@localhost.localdomain>
	 <49890B46.8020308@intertwingly.net>
	 <alpine.LFD.2.00.0902032336000.5607@localhost.localdomain>
	 <4990C14B.7060802@intertwingly.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:28526 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752445AbZBJB6X (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 9 Feb 2009 20:58:23 -0500
In-Reply-To: <4990C14B.7060802@intertwingly.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sam Ruby <rubys@intertwingly.net>
Cc: Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "Maciej W. Rozycki" <macro@linux-mips.org>

On Tue, 2009-02-10 at 07:50 +0800, Sam Ruby wrote:
> Len Brown wrote:
> >>> Do you have a second computer around with a serial port ? If yes,=
 then
> >>> please add the following to the kernel command line:
> >>>
> >>>        earlyprintk=3Dserial,ttyS0,115200 apic=3Ddebug
> >>>
> >>> and connect the serial ports with a null modem cable. Fire up a
> >>> terminal program on the second machine and capture the output.
> >> I do have a second computer, and went out and bought a null modem =
adapter for
> >> my serial cable and connected the two machines.  I've tried instal=
ling minicom
> >> and also connecting it to ttyS0 at 115200 baud on the second machi=
ne, but when
> >> I boot the first machine I don't see any output on the terminal.
> >=20
> > /boot/grub/menu.lst:
> >=20
> > serial --unit=3D0 --speed=3D115200 --word=3D8 --parity=3Dno --stop=3D=
1
> > terminal --timeout=3D300 serial console
Do you have an opportunity to try the boot option of "acpi=3Doff" as
suggested by Lenb?
     From the log it seems that there exists the following warning
message:
    >=EF=BB=BFMP-BIOS bug: 8254 timer not connected to IO-APIC

    Can you try the following boot options?
    a. acpi_use_timer_override
    b. acpi_skip_timer_override
    c. noapic

    Thanks.
> >=20
> > is what I use.
> >=20
> > this will give you a prompt from grub even before the kernel boots
> > so you can select (and edit) your kernel via menu over the serial l=
ine
> > if you wish.
>=20
> I've got that working now.  I used minicom on the remote machine,=20
> capturing the output.  You can see me fumbling around, editing the=20
> kernel command and booting here:
>=20
> http://intertwingly.net/stories/2009/02/09/minicom.out
>=20
> While it is difficult to make out what I did given line wrapping, etc=
,=20
> what I started with was:
>=20
> /boot/vmlinuz-2.6.27-11-generic=20
> root=3DUUID=3D4fce230e-fe72-4685-aab0-294ef1c20efa ro noapic quiet sp=
lash
>=20
> After editing, what I had was
>=20
> /boot/vmlinuz-2.6.27-11-generic=20
> root=3DUUID=3D4fce230e-fe72-4685-aab0-294ef1c20efa ro quiet splash=20
> earlyprintk=3Dserial,ttyS0,115200 apic=3Ddebug
>=20
> As you can see, the last line I saw was "Starting up ...", after whic=
h=20
> point the "MP-BIOS bug: 8254 timer not connected to IO-APIC" etc outp=
ut=20
> appeared on the monitor that is directly connected to the machine bei=
ng=20
> booted (i.e., this text did not appear on the minicom session).
>=20
> > If this doesn't work, then the kernel earlyprintk is unlikely to wo=
rk=20
> > also.
>=20
> At the moment, it looks like it works, but earlyprintk does not work =
for=20
> me, at least not on Ubuntu 8.10, kernel 2.6.27-11-generic.
>=20
> > Note that there may be some BIOS SETUP options related to the seria=
l port=20
> > -- worth checking.
> >=20
> > Also, in minicom, be sure to turn off HW flow control
> >=20
> > there is a fancy serial console document someplace on this,
> > probably at http://tldp.org/
>=20
> As I have managed to get grub to talk to the serial console, I did no=
t=20
> explore these options further.  Please let me know if there is someth=
ing=20
> in particular I should explore.
>=20
> > good luck,
> > -Len
>=20
> - Sam Ruby
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
