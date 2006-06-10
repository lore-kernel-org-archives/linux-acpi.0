From: Jani-Matti =?iso-8859-2?q?H=E4tinen?= <jani-matti.hatinen@iki.fi>
Subject: Re: [Acpi4asus-user] Asus S5000: Problems with Suspend-to-RAM (almost solved)
Date: Sat, 10 Jun 2006 11:55:23 +0300
Message-ID: <200606101155.27540.jani-matti.hatinen@iki.fi>
References: <200601142257.46188.jani-matti.hatinen@iki.fi> <200601151518.30358.jani-matti.hatinen@iki.fi> <200604252205.53022.jani-matti.hatinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pne-smtpout4-sn1.fre.skanova.net ([81.228.11.168]:51419 "EHLO
	pne-smtpout4-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1750763AbWFJIzt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 10 Jun 2006 04:55:49 -0400
In-Reply-To: <200604252205.53022.jani-matti.hatinen@iki.fi>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: acpi4asus-user@lists.sourceforge.net, linux-acpi@vger.kernel.org

Jani-Matti H=E4tinen kirjoitti viestiss=E4=E4n (l=E4hetysaika tiistai, =
25. huhtikuuta=20
2006 22:05):
> [SNIP]
> In case anyone here is interested (or if someone tries to dig this up=
 from
> google) here's how I got suspend-to-ram working on an Asus S5000 (or =
S5A,
> or S5642ABP) laptop/notebook.
>
> There are five problems with suspend-to-ram on this machine, four of =
which
> can be solved at this point.
> [SNIP]
>   The fifth, and as of yet unresolved problem is that the sdhci memor=
y card
> reader driver doesn't work after suspend&resume. It works fine in a f=
resh
> boot, but needs to be rmmod:ed before suspending and will lock up the
> machine if its modprobe:d after wake-up. This is with sdhci-0.11

There's a bit more to this problem than I first thought. The memory car=
d=20
reader problem seems to be only the most severe symptom of some more ge=
neral=20
suspend-to-ram problem on this notebook.
  What I've been able to gather so far is that after suspend-to-ram:
 - As said above, the memory card reader doesn't work. The machine hang=
s as=20
soon as the module is loaded.
 - The PCMCIA slot doesn't work either. The kernel doesn't react to a c=
ard=20
inserted into the slot and pcmciautils goes to some sort of infinite lo=
op if=20
one queries the slot.
 - Rebooting doesn't work. All processes exit just fine, but when the m=
achine=20
is supposed to reboot, it just hangs.

I've checked the DSDT on the machine, but iasl doesn't report any error=
s.
  Below is a complete log of the suspend-to-ram -> wakeup sequence at L=
oglevel=20
9 taken with kernel 2.6.17-rc6 followed by the output of lspci. Any tho=
ughts=20
on what I could do to resolve this are most appreciated.

Jun  9 21:13:24 leevi SysRq : Changing Loglevel
Jun  9 21:13:24 leevi Loglevel set to 9
Jun  9 21:13:43 leevi PM: Preparing system for mem sleep
Jun  9 21:13:52 leevi Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
Jun  9 21:13:52 leevi eth1: Going into suspend...
Jun  9 21:13:52 leevi ACPI: PCI interrupt for device 0000:01:05.0 disab=
led
Jun  9 21:13:52 leevi acpi_bus-0201 [138] bus_set_power         : Devic=
e is=20
not power manageable
Jun  9 21:13:52 leevi ACPI: PCI interrupt for device 0000:01:03.0 disab=
led
Jun  9 21:13:52 leevi ACPI: PCI interrupt for device 0000:00:1d.7 disab=
led
Jun  9 21:13:52 leevi acpi_bus-0201 [138] bus_set_power         : Devic=
e is=20
not power manageable
Jun  9 21:13:52 leevi ACPI: PCI interrupt for device 0000:00:1d.3 disab=
led
Jun  9 21:13:52 leevi ACPI: PCI interrupt for device 0000:00:1d.2 disab=
led
Jun  9 21:13:52 leevi ACPI: PCI interrupt for device 0000:00:1d.1 disab=
led
Jun  9 21:13:52 leevi ACPI: PCI interrupt for device 0000:00:1d.0 disab=
led
Jun  9 21:13:52 leevi ACPI: PCI interrupt for device 0000:00:1b.0 disab=
led
Jun  9 21:13:52 leevi PM: Entering mem sleep
Jun  9 21:13:52 leevi hwsleep-0283 [139] enter_sleep_state     : Enteri=
ng=20
sleep state [S3]
Jun  9 21:13:52 leevi Intel machine check architecture supported.
Jun  9 21:13:52 leevi Intel machine check reporting enabled on CPU#0.
Jun  9 21:13:52 leevi Back to C!
Jun  9 21:13:52 leevi PM: Finishing wakeup.
Jun  9 21:13:52 leevi ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (le=
vel,=20
low) -> IRQ 17
Jun  9 21:13:52 leevi ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (le=
vel,=20
low) -> IRQ 17
Jun  9 21:13:52 leevi PCI: Setting latency timer of device 0000:00:1b.0=
 to 64
Jun  9 21:13:52 leevi ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (le=
vel,=20
low) -> IRQ 21
Jun  9 21:13:52 leevi PCI: Setting latency timer of device 0000:00:1d.0=
 to 64
Jun  9 21:13:52 leevi usb usb2: root hub lost power or was reset
Jun  9 21:13:52 leevi ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (le=
vel,=20
low) -> IRQ 22
Jun  9 21:13:52 leevi PCI: Setting latency timer of device 0000:00:1d.1=
 to 64
Jun  9 21:13:52 leevi usb usb3: root hub lost power or was reset
Jun  9 21:13:52 leevi ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (le=
vel,=20
low) -> IRQ 19
Jun  9 21:13:52 leevi PCI: Setting latency timer of device 0000:00:1d.2=
 to 64
Jun  9 21:13:52 leevi usb usb4: root hub lost power or was reset
Jun  9 21:13:52 leevi ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (le=
vel,=20
low) -> IRQ 17
Jun  9 21:13:52 leevi PCI: Setting latency timer of device 0000:00:1d.3=
 to 64
Jun  9 21:13:52 leevi usb usb5: root hub lost power or was reset
Jun  9 21:13:52 leevi acpi_bus-0201 [141] bus_set_power         : Devic=
e is=20
not power manageable
Jun  9 21:13:52 leevi ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (le=
vel,=20
low) -> IRQ 21
Jun  9 21:13:52 leevi PCI: Setting latency timer of device 0000:00:1d.7=
 to 64
Jun  9 21:13:52 leevi usb usb1: root hub lost power or was reset
Jun  9 21:13:52 leevi ehci_hcd 0000:00:1d.7: debug port 1
Jun  9 21:13:52 leevi PCI: cache line size of 32 is not supported by de=
vice=20
0000:00:1d.7
Jun  9 21:13:52 leevi ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00=
,=20
driver 10 Dec 2004
Jun  9 21:13:52 leevi PCI: Setting latency timer of device 0000:00:1e.0=
 to 64
Jun  9 21:13:52 leevi ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (le=
vel,=20
low) -> IRQ 19
Jun  9 21:13:52 leevi ACPI: PCI Interrupt 0000:01:03.0[A] -> GSI 21 (le=
vel,=20
low) -> IRQ 16
Jun  9 21:13:52 leevi PCMCIA: socket dee66828: *** DANGER *** unable to=
 remove=20
socket power
Jun  9 21:13:52 leevi ACPI: PCI Interrupt 0000:01:03.1[B] -> GSI 22 (le=
vel,=20
low) -> IRQ 20
Jun  9 21:13:52 leevi eth1: Coming out of suspend...
Jun  9 21:13:52 leevi acpi_bus-0201 [141] bus_set_power         : Devic=
e is=20
not power manageable
Jun  9 21:13:52 leevi ACPI: PCI Interrupt 0000:01:05.0[A] -> GSI 18 (le=
vel,=20
low) -> IRQ 19
Jun  9 21:13:52 leevi ipw2200: Radio Frequency Kill Switch is On:
Jun  9 21:13:52 leevi Kill switch must be turned off for wireless netwo=
rking=20
to work.
Jun  9 21:13:52 leevi pnp: Failed to activate device 00:03.
Jun  9 21:13:52 leevi pnp: Failed to activate device 00:08.
Jun  9 21:13:52 leevi Restarting tasks... done
Jun  9 21:13:52 leevi kobject <NULL>: cleaning up
Jun  9 21:13:52 leevi kobject <NULL>: cleaning up
Jun  9 21:13:52 leevi kobject <NULL>: cleaning up
Jun  9 21:13:52 leevi kobject <NULL>: cleaning up
Jun  9 21:13:52 leevi kobject <NULL>: cleaning up
Jun  9 21:13:52 leevi kobject <NULL>: cleaning up
Jun  9 21:13:56 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcs63: cleaning up
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject vcsa63: cleaning up
Jun  9 21:13:56 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcs63: cleaning up
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject vcsa63: cleaning up
Jun  9 21:13:56 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcs63: cleaning up
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject vcsa63: cleaning up
Jun  9 21:13:56 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcs63: cleaning up
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject vcsa63: cleaning up
Jun  9 21:13:56 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcs63: cleaning up
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject vcsa63: cleaning up
Jun  9 21:13:56 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcs63: cleaning up
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject vcsa63: cleaning up
Jun  9 21:13:56 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcs63: cleaning up
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject vcsa63: cleaning up
Jun  9 21:13:56 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcs63: cleaning up
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject vcsa63: cleaning up
Jun  9 21:13:56 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcs63: cleaning up
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject vcsa63: cleaning up
Jun  9 21:13:56 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcs63: cleaning up
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject vcsa63: cleaning up
Jun  9 21:13:56 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcs63: cleaning up
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject vcsa63: cleaning up
Jun  9 21:13:56 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcs63: cleaning up
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject vcsa63: cleaning up
Jun  9 21:13:56 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcs63: cleaning up
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject vcsa63: cleaning up
Jun  9 21:13:56 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcs63: cleaning up
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject vcsa63: cleaning up
Jun  9 21:13:56 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcs63: cleaning up
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject vcsa63: cleaning up
Jun  9 21:13:56 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcs63: cleaning up
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject vcsa63: cleaning up
Jun  9 21:13:56 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcs63: cleaning up
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject vcsa63: cleaning up
Jun  9 21:13:56 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcs63: cleaning up
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject vcsa63: cleaning up
Jun  9 21:13:56 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcs63: cleaning up
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject vcsa63: cleaning up
Jun  9 21:13:56 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcs63: cleaning up
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject vcsa63: cleaning up
Jun  9 21:13:56 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcs63: cleaning up
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject vcsa63: cleaning up
Jun  9 21:13:56 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcs63: cleaning up
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:56 leevi kobject vcsa63: cleaning up
Jun  9 21:13:56 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:56 leevi kobject_uevent
Jun  9 21:13:56 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:56 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up
Jun  9 21:13:57 leevi kobject vcs63: registering. parent: vc, set: clas=
s_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcsa63: registering. parent: vc, set: cla=
ss_obj
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcs63'
Jun  9 21:13:57 leevi kobject vcs63: cleaning up
Jun  9 21:13:57 leevi kobject_uevent
Jun  9 21:13:57 leevi fill_kobj_path: path =3D '/class/vc/vcsa63'
Jun  9 21:13:57 leevi kobject vcsa63: cleaning up


00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML
Express Processor to DRAM Controller (rev 03)
00:02.0 VGA compatible controller: Intel Corporation Mobile
915GM/GMS/910GML Express Graphics Controller (rev 03)
00:02.1 Display controller: Intel Corporation Mobile 915GM/GMS/910GML
Express Graphics Controller (rev 03)
00:1b.0 Audio device: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
=46amily) High Definition Audio Controller (rev 04)
00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
=46amily) USB UHCI #1 (rev 04)
00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
=46amily) USB UHCI #2 (rev 04)
00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
=46amily) USB UHCI #3 (rev 04)
00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
=46amily) USB UHCI #4 (rev 04)
00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
=46amily) USB2 EHCI Controller (rev 04)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d4)
00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface
Bridge (rev 04)
00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
=46amily) IDE Controller (rev 04)
01:03.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev b3)
01:03.1 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller =
(rev=20
08)
01:03.2 Class 0805: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host
Adapter (rev 17)
01:03.3 System peripheral: Ricoh Co Ltd R5C592 Memory Stick Bus Host
Adapter (rev 08)
01:03.4 System peripheral: Ricoh Co Ltd xD-Picture Card Controller (rev=
 03)
01:04.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
01:05.0 Network controller: Intel Corporation PRO/Wireless 2200BG (rev =
05)

--=20
Jani-Matti H=E4tinen
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
