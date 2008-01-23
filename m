From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [WARNING -rc8] at fs/sysfs/dir.c:424 sysfs_add_one(), related
 with processor (ACPI)
Date: Wed, 23 Jan 2008 14:06:43 -0800
Message-ID: <20080123140643.b56ea8eb.akpm@linux-foundation.org>
References: <653402b90801210953u71a85f91udce9e382d588af09@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:59311 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755136AbYAWWGl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Jan 2008 17:06:41 -0500
In-Reply-To: <653402b90801210953u71a85f91udce9e382d588af09@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Miguel Ojeda <maxextreme@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

> On Mon, 21 Jan 2008 18:53:18 +0100 "Miguel Ojeda" <maxextreme@gmail.com> wrote:
> Booting 2.6.24-rc8 I get this:
> 
> 
> sysfs: duplicate filename 'fan' can not be created
> WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
> Pid: 819, comm: modprobe Not tainted 2.6.24-rc8 #2
>  [<c01b18ff>] sysfs_add_one+0x9f/0xe0
>  [<c01b1e38>] create_dir+0x48/0x90
>  [<c01b1ea9>] sysfs_create_dir+0x29/0x50
>  [<c024873f>] kobject_get+0xf/0x20
>  [<c0248bff>] kobject_add+0x8f/0x1b0
>  [<c0248db1>] kobject_register+0x21/0x50
>  [<c02dc6f1>] bus_add_driver+0x71/0x1e0
>  [<f886402f>] acpi_fan_init+0x2f/0x4d [fan]
>  [<c0148986>] sys_init_module+0x126/0x19b0
>  [<c024af87>] rb_insert_color+0xb7/0xe0
>  [<c029dc8d>] acpi_bus_register_driver+0x0/0x38
>  [<c0104286>] syscall_call+0x7/0xb
>  =======================
> kobject_add failed for fan with -EEXIST, don't try to register things
> with the same name in the same directory.
> Pid: 819, comm: modprobe Not tainted 2.6.24-rc8 #2
>  [<c0248c81>] kobject_add+0x111/0x1b0
>  [<c0248db1>] kobject_register+0x21/0x50
>  [<c02dc6f1>] bus_add_driver+0x71/0x1e0
>  [<f886402f>] acpi_fan_init+0x2f/0x4d [fan]
>  [<c0148986>] sys_init_module+0x126/0x19b0
>  [<c024af87>] rb_insert_color+0xb7/0xe0
>  [<c029dc8d>] acpi_bus_register_driver+0x0/0x38
>  [<c0104286>] syscall_call+0x7/0xb
>  =======================
> processor: exports duplicate symbol acpi_processor_set_thermal_limit
> (owned by kernel)
> 
> 
> 
> After that, there are five more traces. Attached dmesg output and .config.
> 

Cc linux-acpi.  If nothing happens (not uncommon) then please raise a
report agaisnt acpi at bugzilla.kernel.org, thanks.

