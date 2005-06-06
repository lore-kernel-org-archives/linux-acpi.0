From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Bizarre oops after suspend to RAM (was: Re: [ACPI] Resume from
	Suspend to RAM)
Date: Mon, 06 Jun 2005 12:06:43 +0100
Message-ID: <1118056003.6648.148.camel@tyrosine>
References: <200506051456.44810.hugelmopf@web.de>
	 <1117978635.6648.136.camel@tyrosine>
	 <200506051732.08854.stefandoesinger@gmx.at>
	 <1118053578.6648.142.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261287AbVFFLG5@vger.kernel.org>
In-Reply-To: <1118053578.6648.142.camel@tyrosine>
Sender: linux-kernel-owner@vger.kernel.org
To: acpi-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 2005-06-06 at 11:26 +0100, Matthew Garrett wrote:
> On Sun, 2005-06-05 at 17:32 +0000, Stefan D=C3=B6singer wrote:
>=20
> > I've no idea how to debug a reboot, but if the system hangs it's po=
ssible to=20
> > add "lcall $0xffff,$0" early in the wakeup assembler code. If the s=
ystem=20
> > reboots immediatly then, the kernels wakeup code was reached and th=
e kernel=20
> > hangs later during resume.
>=20
> Ok, I've just tried that. The system still just freezes.

Whoops. May have been a bit too hasty there. I'm not sure why that
doesn't reset it, but we've now got the following (really rather odd)
serial output. Does anyone have any idea what might be triggering this?
Shell builtins work fine, but anything else seems to explode very
messily. Memory corruption of some description?

^MRestarting tasks... done
^Mroot@(none):/# ^M
root@(none):/# ls -la ^M
Unable to handle kernel NULL pointer dereference at virtual address 000=
00024
^M printing eip:
^Mc015ac62
^M*pde =3D 00000000
^MOops: 0002 [#1]
^MPREEMPT
^MModules linked in:
^MCPU:    0
^MEIP:    0060:[<c015ac62>]    Not tainted VLI
^MEFLAGS: 00010246   (2.6.12-rc5)
^MEIP is at filp_open+0x32/0x70
^Meax: f7ccb000   ebx: 00000000   ecx: 00000003   edx: 00000000
^Mesi: 00000000   edi: f7ccb000   ebp: f7c5c000   esp: f7c5df48
^Mds: 007b   es: 007b   ss: 0068
^MProcess ls (pid: 875, threadinfo=3Df7c5c000 task=3Dc1bbc060)
^MStack: 00000000 00000001 c015a5d5 f7c5df58 00000000 c0109806 fffffeff=
 00000000^M       c1bcf1ec 00000000 f7ccb000 00000003 c18c0c80 f7c5c000=
 c015af95 c18c0c80^M       00000003 00000003 f7ccb000 00000000 00000003=
 c015b109 f7ccb000 00000000^MCall Trace:
^M [<c015a5d5>] sys_access+0x85/0x150
^M [<c0109806>] old_mmap+0xd6/0x110
^M [<c015af95>] get_unused_fd+0xa5/0xe0
^M [<c015b109>] sys_open+0x49/0x90
^M [<c0103245>] syscall_call+0x7/0xb
^MCode: 8b 5c 24 5c 8d 43 01 a8 03 0f 44 c3 89 c2 83 ca 02 f6 c4 02 0f =
45 c2 8d
54 24 10 89 54 24 0c 8b 54 24 60 89 44 24 04 8b 44 24 58 <89> 56 24 08 =
89 04 24
e8 62 19 01 00 85 c0 74 0e 8b 5c 24 50 83
^M Segmentation fault^M
root@(none):/# ^M
root@(none):/# free^M
<1>Unable to handle kernel NULL pointer dereference at virtual address =
00000024
^M printing eip:
^Mc015ac62
^M*pde =3D 00000000
^MOops: 0002 [#2]
^MPREEMPT
^MModules linked in:
^MCPU:    0
^MEIP:    0060:[<c015ac62>]    Not tainted VLI
^MEFLAGS: 00010246   (2.6.12-rc5)
^MEIP is at filp_open+0x32/0x70
^Meax: f7ce3000   ebx: 00000000   ecx: 00000003   edx: 00000000
^Mesi: 00000000   edi: f7ce3000   ebp: f7c5c000   esp: f7c5df48
^Mds: 007b   es: 007b   ss: 0068
^MProcess free (pid: 876, threadinfo=3Df7c5c000 task=3Dc1bbc560)
^MStack: 00000000 00000001 c015a5d5 f7c5df58 00000000 c0109806 fffffeff=
 00000000^M       c1bcf1ec 00000000 f7ce3000 00000003 c18c0040 f7c5c000=
 c015af95 c18c0040^M       00000003 00000003 f7ce3000 00000000 00000003=
 c015b109 f7ce3000 00000000^MCall Trace:
^M [<c015a5d5>] sys_access+0x85/0x150
^M [<c0109806>] old_mmap+0xd6/0x110
^M [<c015af95>] get_unused_fd+0xa5/0xe0
^M [<c015b109>] sys_open+0x49/0x90
^M [<c0103245>] syscall_call+0x7/0xb
^MCode: 8b 5c 24 5c 8d 43 01 a8 03 0f 44 c3 89 c2 83 ca 02 f6 c4 02 0f =
45 c2 8d
54 24 10 89 54 24 0c 8b 54 24 60 89 44 24 04 8b 44 24 58 <89> 56 24 08 =
89 04 24
e8 62 19 01 00 85 c0 74 0e 8b 5c 24 50 83
^M Segmentation fault^M


--=20
Matthew Garrett | mjg59@srcf.ucam.org
