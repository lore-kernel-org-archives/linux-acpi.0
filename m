From: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-rc5-mm3 -- BUG: sleeping function called from invalid
 context at include/asm/semaphore.h:9 9 in_atomic():0, irqs_disabled():1
Date: Sun, 4 Jun 2006 22:19:52 -0700
Message-ID: <20060604221952.7e0835c3.akpm@osdl.org>
References: <a44ae5cd0606042158t4448a6f5od12a032eeb215c15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:51418 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932409AbWFEFT4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jun 2006 01:19:56 -0400
In-Reply-To: <a44ae5cd0606042158t4448a6f5od12a032eeb215c15@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Miles Lane <miles.lane@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Sun, 4 Jun 2006 21:58:29 -0700
"Miles Lane" <miles.lane@gmail.com> wrote:

> BUG: sleeping function called from invalid context at
> include/asm/semaphore.h:9 9
> in_atomic():0, irqs_disabled():1
>  [<c0104851>] show_trace+0xd/0x10
>  [<c010486b>] dump_stack+0x17/0x1c
>  [<c011448c>] __might_sleep+0x93/0x9d
>  [<c020077c>] acpi_os_wait_semaphore+0x68/0xba
>  [<c0215ef1>] acpi_ut_acquire_mutex+0x2a/0x69
>  [<c020c9d1>] acpi_set_register+0x5a/0x173
>  [<c0204eab>] acpi_clear_event+0x25/0x2b
>  [<c021652d>] acpi_pm_enter+0x91/0xb8
>  [<c0131607>] suspend_enter+0x33/0x46
>  [<c0131795>] enter_state+0x140/0x18c
>  [<c0131862>] state_store+0x81/0x97
>  [<c018d558>] subsys_attr_store+0x20/0x25
>  [<c018db8a>] sysfs_write_file+0xb5/0xda
>  [<c0158a11>] vfs_write+0xac/0x158
>  [<c015928d>] sys_write+0x3b/0x60
>  [<c03078a5>] sysenter_past_esp+0x56/0x79

suspend_enter() does local_irq_disable(), after which ACPI mutex operations
are a no-no.

acpi_pm_enter() also does local_irq_save() prior to calling
acpi_clear_event(), so it's an acpi-only bug.

acpi_clear_event() calls acpi_set_register() calls acpi_ut_acquire_mutex().

But afaict the code has been this way for some time.  Is the above new
behaviour for you?

