From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: should I open a bug for this ?
Date: Wed, 19 Jan 2005 08:50:07 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD30575010600AA@pdsmsx402.ccr.corp.intel.com>
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
To: Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>
>Since kernel 2.6.9 or around, I get the error bellow every time I
suspend
>the laptop in ACPI S3 (IBM T41/R50p).
>How serious is this ? It does not seems an Oops, but maybe I should
report
>it somewhere to get fixed.
>The problem is I don't know where it belongs. I suspect ACPI because is
>every time I enter S3, but could be something else:
>
>
>Back to C!
>Warning: CPU frequency is 1700000, cpufreq assumed 600000 kHz.
>Debug: sleeping function called from invalid context at mm/slab.c:2091
>in_atomic():0, irqs_disabled():1
> [<c011877f>] __might_sleep+0x8a/0x94
> [<c0146108>] kmem_cache_alloc+0x1b/0x6b
> [<c0205e6c>] acpi_pci_link_set+0x4a/0x1a2
> [<c02062d2>] irqrouter_resume+0x1c/0x24
> [<c0244d97>] sysdev_resume+0x3e/0xa5
> [<c0248066>] device_power_up+0x5/0xa
> [<c01379ce>] suspend_enter+0x25/0x2d
> [<c0137a34>] enter_state+0x37/0x53
> [<c0203417>] acpi_suspend+0x28/0x35
> [<c02034e6>] acpi_system_write_sleep+0x5a/0x6b
> [<c015eecd>] vfs_write+0xba/0x115
> [<c015efc6>] sys_write+0x3c/0x62
> [<c010338b>] syscall_call+0x7/0xb
>ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 7 (level, low) -> IRQ 7
>Restarting tasks... done
You can fellow the issue here:
http://bugme.osdl.org/show_bug.cgi?id=3D3469

Thanks,
Shaohua


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
