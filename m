From: Laurent Riffard <laurent.riffard-GANU6spQydw@public.gmane.org>
Subject: suspend-to-disk with 2.6.11-rc3-mm2 : sleeping function called from
 invalid context
Date: Thu, 17 Feb 2005 22:43:38 +0100
Message-ID: <cv3301$qb6$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hello,

My box is a desktop with an asus A7V133 motherboard (VIA chipset, Athlon
XP CPU) and a NVidia Geforce2 MX 400 Video card.

Having stopped sound, usb and network sub-systems, I suspend to disk
with the following commands :

echo platform> /sys/power/disk
echo disk > /sys/power/state

While suspending, the following warning occurs :

Stopping tasks:
================================================================|
Freeing memory...  ^H-^H\.........^H/^H-^Hdone (44375 pages freed)
swsusp: Need to copy 7837 pages
Debug: sleeping function called from invalid context at mm/slab.c:2088
in_atomic():0, irqs_disabled():1
[dump_stack+21/23] dump_stack+0x15/0x17
[<c010372e>] dump_stack+0x15/0x17
[__might_sleep+138/148] __might_sleep+0x8a/0x94
[<c0112920>] __might_sleep+0x8a/0x94
[kmem_cache_alloc+30/73] kmem_cache_alloc+0x1e/0x49
[<c01326b5>] kmem_cache_alloc+0x1e/0x49
[acpi_evaluate_integer+139/520] acpi_evaluate_integer+0x8b/0x208
[<c01af1b0>] acpi_evaluate_integer+0x8b/0x208
[acpi_bus_get_status+108/248] acpi_bus_get_status+0x6c/0xf8
[<c01d47f9>] acpi_bus_get_status+0x6c/0xf8
[acpi_pci_link_set+407/598] acpi_pci_link_set+0x197/0x256
[<c01d8e93>] acpi_pci_link_set+0x197/0x256
[acpi_pci_link_resume+71/125] acpi_pci_link_resume+0x47/0x7d
[<c01d941d>] acpi_pci_link_resume+0x47/0x7d
[irqrouter_resume+69/97] irqrouter_resume+0x45/0x61
[<c01d9498>] irqrouter_resume+0x45/0x61
[sysdev_resume+65/169] sysdev_resume+0x41/0xa9
[<c01f5285>] sysdev_resume+0x41/0xa9
[device_power_up+8/14] device_power_up+0x8/0xe
[<c01f887e>] device_power_up+0x8/0xe
[swsusp_suspend+70/76] swsusp_suspend+0x46/0x4c
[<c012a732>] swsusp_suspend+0x46/0x4c
[pm_suspend_disk+50/101] pm_suspend_disk+0x32/0x65
[<c012aa76>] pm_suspend_disk+0x32/0x65
[enter_state+40/93] enter_state+0x28/0x5d
[<c01295a5>] enter_state+0x28/0x5d
[state_store+132/149] state_store+0x84/0x95
[<c01296c9>] state_store+0x84/0x95
[subsys_attr_store+27/36] subsys_attr_store+0x1b/0x24
[<c016b516>] subsys_attr_store+0x1b/0x24
[flush_write_buffer+35/43] flush_write_buffer+0x23/0x2b
[<c016b702>] flush_write_buffer+0x23/0x2b
[sysfs_write_file+73/106] sysfs_write_file+0x49/0x6a
[<c016b753>] sysfs_write_file+0x49/0x6a
[vfs_write+144/289] vfs_write+0x90/0x121
[<c0142ff7>] vfs_write+0x90/0x121
[sys_write+59/96] sys_write+0x3b/0x60
[<c0143123>] sys_write+0x3b/0x60
[sysenter_past_esp+82/117] sysenter_past_esp+0x52/0x75
[<c010298d>] sysenter_past_esp+0x52/0x75
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
Restarting tasks... done

However, the system restarts correctly.

I noticed a bug report "S3 resume: PCI Interrupt Link Device oops"
(http://bugme.osdl.org/show_bug.cgi?id=3469). Should I try to apply the
proposed patches ?

~~
laurent
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFCFRAKUqUFrirTu6IRAhTiAKCc/R/VxC5Ktxpmhqh8LY+QQDoMGACgu2+D
QeLSPgqydvZk40n8uGXxC6k=
=SzLI
-----END PGP SIGNATURE-----



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
