From: Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: should I open a bug for this ?
Date: Tue, 18 Jan 2005 23:03:58 +0200
Message-ID: <pan.2005.01.18.21.03.58.52605@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

Since kernel 2.6.9 or around, I get the error bellow every time I suspend
the laptop in ACPI S3 (IBM T41/R50p).
How serious is this ? It does not seems an Oops, but maybe I should repor=
t
it somewhere to get fixed.
The problem is I don't know where it belongs. I suspect ACPI because is
every time I enter S3, but could be something else:


Back to C!
Warning: CPU frequency is 1700000, cpufreq assumed 600000 kHz.
Debug: sleeping function called from invalid context at mm/slab.c:2091
in_atomic():0, irqs_disabled():1
 [<c011877f>] __might_sleep+0x8a/0x94
 [<c0146108>] kmem_cache_alloc+0x1b/0x6b
 [<c0205e6c>] acpi_pci_link_set+0x4a/0x1a2
 [<c02062d2>] irqrouter_resume+0x1c/0x24
 [<c0244d97>] sysdev_resume+0x3e/0xa5
 [<c0248066>] device_power_up+0x5/0xa
 [<c01379ce>] suspend_enter+0x25/0x2d
 [<c0137a34>] enter_state+0x37/0x53
 [<c0203417>] acpi_suspend+0x28/0x35
 [<c02034e6>] acpi_system_write_sleep+0x5a/0x6b
 [<c015eecd>] vfs_write+0xba/0x115
 [<c015efc6>] sys_write+0x3c/0x62
 [<c010338b>] syscall_call+0x7/0xb
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 7 (level, low) -> IRQ 7
Restarting tasks... done



Thanks,
Paul




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
