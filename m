From: randy_dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
Subject: Re: Kernel oops with asus_acpi module
Date: Mon, 6 Jun 2005 09:50:31 -0700
Message-ID: <20050606095031.667bbed5.rdunlap@xenotime.net>
References: <200506052340.41074.mail@hboeck.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200506052340.41074.mail-60OJuG18Xr6zQB+pC5nmwQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Hanno =?ISO-8859-1?B?QvZjaw==?= <mail-60OJuG18Xr6zQB+pC5nmwQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, 5 Jun 2005 23:40:40 +0200 Hanno B=F6ck wrote:

| Matthias Hentges has postet this a while ago to the acpi4asus-list:
| http://sourceforge.net/mailarchive/forum.php?thread_id=3D7214924&forum_id=
=3D33295
|=20
| I have a Samsung P30. The problem happens on both rc and mm-kernels at th=
e=20
| moment.
| I hope this can be fixed before 2.6.12.
|=20
| The asus_acpi module freezes the system on boot if compiled into the kern=
el.
|=20
| If loaded as a module, I get this error:
|=20
| Asus Laptop ACPI Extras version 0.29
| Unable to handle kernel NULL pointer dereference at virtual address 00000=
000
|  printing eip:
| e19e9391
| *pde =3D 00000000
| Oops: 0000 [#1]
| PREEMPT
| Modules linked in: asus_acpi eth1394 ipw2100 ohci1394 ieee1394 yenta_sock=
et=20
| rsrc_nonstatic pcmcia_core ehci_hcd uhci_hcd usbcore
| CPU:    0
| EIP:    0060:[<e19e9391>]    Not tainted VLI
| EFLAGS: 00210203   (2.6.12-rc5-mm2)
| EIP is at asus_hotk_get_info+0x1aa/0x79a [asus_acpi]
| eax: 00000000   ebx: dfe0d000   ecx: 00000002   edx: 00000003
| esi: 00000000   edi: e19fca60   ebp: d7e9c800   esp: dae19ec0
| ds: 007b   es: 007b   ss: 0068
| Process modprobe (pid: 12174, threadinfo=3Ddae18000 task=3Dd13bf0b0)
| Stack: 00000000 00200296 c011c497 00000000 ffffffd8 dfe0d000 00000000 000=
00000
|        c05a9c88 c011c273 dae19f6c dfc37c3c 00000000 c0294036 00000000 000=
00000
|        00000000 dae19f54 00200246 0000002b 00000300 0000030c 00000000 000=
00000
| Call Trace:
|  [<c011c497>] release_console_sem+0xe7/0x110
|  [<c011c273>] vprintk+0x1f3/0x2b0
|  [<c0294036>] sub_alloc+0xb6/0x1b0
|  [<e19e9a3f>] asus_hotk_add+0x8b/0x143 [asus_acpi]
|  [<c02e0f01>] acpi_bus_driver_init+0x29/0x50
|  [<c02e0fbc>] acpi_driver_attach+0x59/0x9d
|  [<e19e9b41>] asus_acpi_init+0x4a/0x72 [asus_acpi]
|  [<c0138212>] sys_init_module+0xc2/0x200
|  [<c01030d7>] sysenter_past_esp+0x54/0x75
| Code: e1 e8 f4 2c 73 de 5e 5f a1 10 eb 9f e1 ba 03 00 00 00 bf 60 ca 9f e=
1 89=20
| d1 c7 40 14 12 00 00 00 8b 45 08 89 04 24 89 c6 49 78 08 <ac> ae 75 08 84=
 c0=20
| 75 f5 31 c0 eb 04 19 c0 0c 01 85 c0 75 11 a1
|=20
|=20
| If you need further info, please contact me.

What processor (x86) type/configs is your kernel compiled for?

Can you repeat with Magic SysRq enabled (if not already) and
set log level to 9 (echo 9 > /proc/sysrq-trigger or
Alt-SysRq-9).  That should provide more console log info
for us.... then post that log.  (or check your log files,
this log info may already be in some of them)

Thanks,
---
~Randy


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
