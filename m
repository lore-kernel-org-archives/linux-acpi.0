From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Acer Notebook: acpi IRQ stuck after S3
Date: Thu, 13 Jan 2005 09:09:12 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD30575FB1EF6@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: Fionn Behrens <fionn-ZPjJJ+sDHmfddJNmlsFzeA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
>log and backtrace:
>
>12:49:00 samt kernel: PM: Preparing system for suspend
>12:49:00 samt kernel: Stopping tasks:
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
>12:49:00 samt kernel: PM: Entering state.
>12:49:00 samt kernel: Back to C!
>12:49:00 samt kernel: irq 9: nobody cared!
>12:49:00 samt kernel:  [<c010724a>] __report_bad_irq+0x2a/0x90
>12:49:00 samt kernel:  [<c0107340>] note_interrupt+0x70/0xb0
>12:49:00 samt kernel:  [<c01075f0>] do_IRQ+0x120/0x130
>12:49:00 samt kernel:  [<c01053c8>] common_interrupt+0x18/0x20
>12:49:00 samt kernel:  [<c013007b>] unqueue_me+0x3b/0xb0
>12:49:00 samt kernel:  [<c012046e>] __do_softirq+0x2e/0x90
>12:49:00 samt kernel:  [<c01204f7>] do_softirq+0x27/0x30
>12:49:00 samt kernel:  [<c01075ca>] do_IRQ+0xfa/0x130
>12:49:00 samt kernel:  [<c01053c8>] common_interrupt+0x18/0x20
>12:49:00 samt kernel:  [<c0134ca8>] suspend_enter+0x38/0x50
>12:49:00 samt kernel:  [<c0134d84>] enter_state+0x64/0xb0
>12:49:00 samt kernel:  [<c02020c9>] acpi_suspend+0x3e/0x4d
>12:49:00 samt kernel:  [<c0202478>] acpi_system_write_sleep+0x60/0x8b
>12:49:00 samt kernel:  [<c020248d>] acpi_system_write_sleep+0x75/0x8b
>12:49:00 samt kernel:  [<c0155a68>] vfs_write+0xb8/0x130
>12:49:00 samt kernel:  [<c0154f99>] filp_close+0x59/0x90
>12:49:00 samt cardmgr[1467]: executing: './network suspend eth1'
>12:49:00 samt kernel:  [<c0155bb1>] sys_write+0x51/0x80
>12:49:00 samt kernel:  [<c010525b>] syscall_call+0x7/0xb
>12:49:00 samt kernel: handlers:
>12:49:00 samt kernel: [<c01eb827>] (acpi_irq+0x0/0x16)
>12:49:00 samt kernel: Disabling IRQ #9
>12:49:00 samt kernel: PM: Finishing up.
>
>As you can see, IRQ 9 gets stuck here and consequently, the next ACPI
>event (e.g. lid button) causes a system freeze. Hoping that the problem
>might relate to some uninitialized memory after resume I raised the
>limit for unhandled IRQs in spurious.c (irq.c before 2.6.10). But that
>does not help.
>I'd really like to debug this but I need help from an expert where to
>look at to find out what happens to this acpi IRQ.
>
Did any device share IRQ 9 with ACPI? If yes, please try unload the
driver.

Thanks,
Shaohua


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
