From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 9731] New: 2.6.24-rc7: Deadlock when any ACPI
 eject sys node written
Date: Fri, 11 Jan 2008 12:37:48 -0800
Message-ID: <20080111123748.71828a69.akpm@linux-foundation.org>
References: <bug-9731-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:47444 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760290AbYAKUiR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Jan 2008 15:38:17 -0500
In-Reply-To: <bug-9731-10286@http.bugzilla.kernel.org/>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <greg@kroah.com>, Kay Sievers <kay.sievers@vrfy.org>
Cc: bugme-daemon@bugzilla.kernel.org, linux-acpi@vger.kernel.org, arai@vmware.com

On Fri, 11 Jan 2008 09:38:25 -0800 (PST) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=9731
> 
>            Summary: 2.6.24-rc7: Deadlock when any ACPI eject sys node
>                     written
>            Product: ACPI
>            Version: 2.5
>      KernelVersion: 2.6.24-rc7
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Other
>         AssignedTo: acpi_other@kernel-bugs.osdl.org
>         ReportedBy: arai@vmware.com
> 
> 
> Latest working kernel version: Unknown
> Earliest failing kernel version: All 2.6.24-rc versions I've tried
> Distribution: sles10
> Hardware Environment: x86_64
> Software Environment:
> Problem Description:
> I have "hardware" that supports ejectable CPUs.  Any attempt to eject a CPU by
> echoing 1 into the /sys node results in the shell doing the echo deadlocking.
> 
> Here's what dmesg says bash is doing:
> 
> bash          D 0000000000000000     0  3552   3372
>  ffff810007023ca8 0000000000000082 0000000000000000 ffff8100014327f0
>  0000000000000000 ffffffff00000000 ffff81000ecde0c0 ffff8100014437c0
>  304a455f0dd521a0 00000000ffffdb37 00000000000000ff ffff81000fe37900
> Call Trace:
>  [<ffffffff80447282>] wait_for_completion+0xa2/0xf0
>  [<ffffffff80231d50>] default_wake_function+0x0/0x10
>  [<ffffffff802e2f6d>] sysfs_addrm_finish+0x1dd/0x250
>  [<ffffffff802e17d6>] sysfs_hash_and_remove+0xa6/0xc0
>  [<ffffffff8038d37d>] device_remove_file+0x2d/0x60
>  [<ffffffff803525c3>] acpi_device_unregister+0xc8/0x124
>  [<ffffffff80352778>] acpi_bus_remove+0x5e/0x64
>  [<ffffffff803527f8>] acpi_bus_trim+0x7a/0xee
>  [<ffffffff803528e8>] acpi_eject_store+0x7c/0x119
>  [<ffffffff802e1ef4>] sysfs_write_file+0xd4/0x150
>  [<ffffffff80293f7d>] vfs_write+0xdd/0x150
>  [<ffffffff80294643>] sys_write+0x53/0x90
>  [<ffffffff8020bf1e>] system_call+0x7e/0x83
> 
> The problem seems to be that acpi_device_unregister tries to delete the sys
> node for eject, but the node cannot be deleted until the write completes.
> 
> sysfs_write_file calls flush_write_buffer, which does this:
> 
> static int
> flush_write_buffer(struct dentry * dentry, struct sysfs_buffer * buffer, size_t
> count)
> {
>         struct sysfs_dirent *attr_sd = dentry->d_fsdata;
>         struct kobject *kobj = attr_sd->s_parent->s_elem.dir.kobj;
>         struct sysfs_ops * ops = buffer->ops;
>         int rc;
> 
>         /* need attr_sd for attr and ops, its parent for kobj */
>         if (!sysfs_get_active_two(attr_sd))
>                 return -ENODEV;
> 
>         rc = ops->store(kobj, attr_sd->s_elem.attr.attr, buffer->page, count);
> 
>         sysfs_put_active_two(attr_sd);
> 
>         return rc;
> }
> 
> sysfs_addrm_finish calls sysfs_deactivate, which is stuck waiting forever on
> the wait_for_completion call:
> 
> /**
>  *      sysfs_deactivate - deactivate sysfs_dirent
>  *      @sd: sysfs_dirent to deactivate
>  *
>  *      Deny new active references and drain existing ones.
>  */
> static void sysfs_deactivate(struct sysfs_dirent *sd)
> {
>         DECLARE_COMPLETION_ONSTACK(wait);
>         int v;
> 
>         BUG_ON(sd->s_sibling || !(sd->s_flags & SYSFS_FLAG_REMOVED));
>         sd->s_sibling = (void *)&wait;
> 
>         /* atomic_add_return() is a mb(), put_active() will always see
>          * the updated sd->s_sibling.
>          */
>         v = atomic_add_return(SD_DEACTIVATED_BIAS, &sd->s_active);
> 
>         if (v != SD_DEACTIVATED_BIAS)
>                 wait_for_completion(&wait);
> 
>         sd->s_sibling = NULL;
> }
> 
> But it looks like to me the wait_for_completion() won't return until the call
> to sysfs_put_active_two() in flush_write_buffer() is invoked.  This looks like
> a deadlock to me.
> 
> I can provide more information if it's helpful, and can help with testing any
> patches.
> 
> I'm not sure when this problem was exactly first introduced.  2.6.22 hung in a
> similar way, but it looks like the code that deals with deleting sysfs nodes
> got significantly reworked between 2.6.22 and 2.6.24.
> 
> Steps to reproduce:
> echo 1 into any /sys/devices/LNXSYSTM:00/ACPI*/eject node.  Watch the parent
> process hang.

Thanks.  So it would seem that sysfs core changes caused the acpi code to
fail.
