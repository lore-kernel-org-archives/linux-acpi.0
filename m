From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: S3 works but nastyness in logs
Date: Mon, 27 Jun 2005 09:54:46 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD3057502698A64@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?iso-8859-1?Q?=E9ric_Brunet?= <Eric.Brunet-l5PIGlIYzrxGWvitb5QawA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
>
>S3 seems to be working very well on my ASUS S5200N laptop; yesterday, I
>suspended and resumed 5 times in a row without any apparent problem.
>
>However, in the logs, I have, at each time the system resumes,
>
>------------------------------------------------------------------------=
---
>Debug: sleeping function called from invalid context at mm/slab.c:2126
>in_atomic():0, irqs_disabled():1
> [<c015c27e>] kmem_cache_alloc+0x3c/0x49
> [<c02481d6>] acpi_pci_link_set+0x3f/0x17f
> [<c0248620>] irqrouter_resume+0x14/0x28
> [<c02878ee>] sysdev_resume+0x3d/0xb5
> [<c028b9e7>] device_power_up+0x5/0xa
> [<c014a83b>] suspend_enter+0x44/0x46
> [<c014a7c9>] suspend_prepare+0x57/0x85
> [<c014a8ae>] enter_state+0x49/0x54
> [<c024569a>] acpi_system_write_sleep+0x5a/0x6c
> [<c0245640>] acpi_system_write_sleep+0x0/0x6c
> [<c017b8c4>] vfs_write+0x9e/0x110
> [<c017b9e1>] sys_write+0x41/0x6a
> [<c0103a51>] syscall_call+0x7/0xb
>------------------------------------------------------------------------=
---
The fix for this one is still ongoing.

>-
>BUG: soft lockup detected on CPU#0!
>
>Pid: 3122, comm:                 echo
>EIP: 0060:[<c014a820>] CPU: 0
>EIP is at suspend_enter+0x29/0x46
> EFLAGS: 00000286    Tainted: GF      (2.6.11-1.1369_FC4)
>EAX: 00000000 EBX: 00000000 ECX: c03e5798 EDX: c03da0dc
>ESI: 00000286 EDI: 00000003 EBP: 00000006 DS: 0068 ES: 007b
>CR0: 8005003b CR2: b7f0b000 CR3: 024fa000 CR4: 000006d0
> [<c014a7c9>] suspend_prepare+0x57/0x85
> [<c014a8ae>] enter_state+0x49/0x54
> [<c024569a>] acpi_system_write_sleep+0x5a/0x6c
> [<c0245640>] acpi_system_write_sleep+0x0/0x6c
> [<c017b8c4>] vfs_write+0x9e/0x110
> [<c017b9e1>] sys_write+0x41/0x6a
> [<c0103a51>] syscall_call+0x7/0xb
> [<c01505e1>] softlockup_tick+0x95/0x1b8
> [<c012cd3d>] update_wall_time+0x14/0x40
> [<c012d331>] do_timer+0x4d/0xfb
> [<c0108c2e>] timer_interrupt+0x60/0x1b5
> [<c02d2f40>] usb_hcd_irq+0x22/0x52
> [<c015085d>] handle_IRQ_event+0x2e/0x5a
> [<c015093c>] __do_IRQ+0xb3/0x367
> [<c0105b1d>] do_IRQ+0x4a/0x82
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [<c0103c0e>] common_interrupt+0x1a/0x20
> [<c014a820>] suspend_enter+0x29/0x46
> n<c014a7c9>] suspend_prepare+0x57/0x85
> [<c014a8ae>] enter_state+0x49/0x54
> [<c024569a>] acpi_system_write_sleep+0x5a/0x6c
> [<c0245640>] acpi_system_write_sleep+0x0/0x6c
> [<c017b8c4>] vfs_write+0x9e/0x110
> [<c017b9e1>] sys_write+0x41/0x6a
> [<c0103a51>] syscall_call+0x7/0xb
The patch at =
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D111949578416734&w=3D2 =
might fix this one.

Thanks,
Shaohua


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
