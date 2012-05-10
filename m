From: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
Subject: Re: [opensuse-kernel] 3.4rc6: ACPI change/regression ?
Date: Thu, 10 May 2012 23:20:19 +0200
Message-ID: <20396.12563.795116.287165@elektron.ikp.physik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

In article <201205102031.26807.rjw@sisk.pl> you wrote:
> Hi,
>=20
> On Thursday, May 10, 2012, Rafael J. Wysocki wrote:
>> On Wednesday, May 09, 2012, Cristian Rodr=EDguez wrote:
>> > Hi:
>> >=20
>> > Since 3.4rc6 I am not able to "turn off" unused Nvidia "optimus" c=
ard,=20
>> > either with 3rd party modules or vga_switchero.
>> >=20
>> > In rc5 it worked fine, now I get:
>> >=20
>> > a) with third party bbswitch module.
>> >=20
>> > bbswitch: Found integrated VGA device 0000:00:02.0: \_SB_.PCI0.GFX=
0
>> > bbswitch: Found discrete VGA device 0000:01:00.0: \_SB_.PCI0.PEG0.=
PEGP
>> > bbswitch: detected an Optimus _DSM function
>> > bbswitch: disabling discrete graphics
>> > bbswitch: Result of Optimus _DSM call: 11000059
>> > pci 0000:01:00.0: Refused to change power state, currently in D0
>> > ACPI: Device does not support D3
>> > bbswitch: Succesfully loaded. Discrete card 0000:01:00.0 is on
>> >=20
>> > Ok, third party module may be buggy and I don't expect anyone here=
 to=20
>> > support it, so I went to try kernel vga_switchero..
>> >=20
>> > VGA switcheroo: switched nouveau off
>> > [drm] nouveau 0000:01:00.0: Disabling display...
>> > [drm] nouveau 0000:01:00.0: Disabling fbcon...
>> > [drm] nouveau 0000:01:00.0: Unpinning framebuffer(s)...
>> > [drm] nouveau 0000:01:00.0: Evicting buffers...
>> > [drm] nouveau 0000:01:00.0: Idling channels...
>> > [drm] nouveau 0000:01:00.0: Suspending GPU objects...
>> > [drm] nouveau 0000:01:00.0: And we're gone!
>> > ACPI: Device does not support D3
>> >=20
>> > But device DOES support D3 states or at least it did in rc5..
>> >=20
>> > The ill effec of this change is that now the video card fan is run=
ning=20
>> > almost all the time.
>> >=20
>> > Is this a side effect of=20
>> > http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;a=3D=
commit;h=3D1cc0c998fdf2cb665d625fb565a0d6db5c81c639=20

>=20
> Yes, it's probably this one.  Have you tried to revert it?

Probably the name change ACPI_STATE_D3 -> ACPI_STATE_D3_HOT wasn't
propagated to the nouveau and probaly other driver ...


--=20
Uwe Bonnes                bon@elektron.ikp.physik.tu-darmstadt.de

Institut fuer Kernphysik  Schlossgartenstrasse 9  64289 Darmstadt
--------- Tel. 06151 162516 -------- Fax. 06151 164321 ----------
