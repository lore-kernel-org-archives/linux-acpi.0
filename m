From: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: yet more sleeping whilst atomic warnings.
Date: Tue, 17 Jan 2006 01:17:44 -0500
Message-ID: <20060117061743.GA25988@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Just when I thought I'd seen the back of these after fixing
up acpi_pci_link_set() in 2.6.15, here comes a slightly different variant
seen whilst resuming 2.6.15-git from suspend.

The GFP_ATOMIC style fix I did for acpi_pci_link_set() already
obviously isn't the right answer for acpi_os_acquire_object()
but I'm not entirely sure what the right answer is, because we
call that function from multiple contexts.

Hmm.

		Dave

Debug: sleeping function called from invalid context at mm/slab.c:2528
in_atomic():0, irqs_disabled():1
 [<c01546b0>] kmem_cache_alloc+0x1b/0x79
 [<c01e6484>] acpi_os_acquire_object+0xb/0x3c
 [<c01faa5b>] acpi_ut_allocate_object_desc_dbg+0x13/0x49
 [<c01fa8ef>] acpi_ut_create_internal_object_dbg+0x13/0x68
 [<c01f6fa6>] acpi_rs_set_srs_method_data+0x3d/0xb7
 [<c0154422>] cache_alloc_debugcheck_after+0xb8/0xea
 [<c01fe13c>] acpi_pci_link_set+0x3b/0x17c
 [<c01fe204>] acpi_pci_link_set+0x103/0x17c
 [<c01fe6ad>] irqrouter_resume+0x1e/0x3c
 [<c022bce7>] __sysdev_resume+0x11/0x53
 [<c022bef0>] sysdev_resume+0x16/0x47
 [<c022fbf0>] device_power_up+0x5/0xa
 [<c01360e9>] swsusp_suspend+0x6b/0x85
 [<c01369a9>] pm_suspend_disk+0x4f/0xbe
 [<c013503e>] enter_state+0x47/0xaa
 [<c01351ad>] state_store+0x88/0x94
 [<c0135125>] state_store+0x0/0x94
 [<c018a73a>] subsys_attr_store+0x1e/0x22
 [<c018a90b>] flush_write_buffer+0x1d/0x21
 [<c018a960>] sysfs_write_file+0x51/0x74
 [<c018a90f>] sysfs_write_file+0x0/0x74
 [<c0156d59>] vfs_write+0xa1/0x140
 [<c0156e97>] sys_write+0x3c/0x63
 [<c0102c4d>] syscall_call+0x7/0xb 
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
