From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [2.6.21-rc7-mm2] BUG while suspend to ram
Date: Mon, 30 Apr 2007 00:32:28 -0700
Message-ID: <20070430003228.93d3d093.akpm@linux-foundation.org>
References: <463476A3.9050305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([65.172.181.25]:43872 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423117AbXD3Hcg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 Apr 2007 03:32:36 -0400
In-Reply-To: <463476A3.9050305@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Sun, 29 Apr 2007 12:42:43 +0200 Maciej Rutecki <maciej.rutecki@gmail.com> wrote:

> BUG: at kernel/kthread.c:166 kthread_bind()
>  [<c01465ac>] _cpu_down+0x16c/0x250
>  [<c0146890>] disable_nonboot_cpus+0x60/0xf0
>  [<c014cd67>] pm_suspend_disk+0x177/0x2c0
>  [<c014b645>] enter_state+0xb5/0x200
>  [<c014b84d>] state_store+0xbd/0xd0
>  [<c014b790>] state_store+0x0/0xd0
>  [<c01be189>] subsys_attr_store+0x29/0x40
>  [<c01be3a4>] sysfs_write_file+0xd4/0x160
>  [<c017b701>] vfs_write+0xc1/0x160
>  [<c01be2d0>] sysfs_write_file+0x0/0x160
>  [<c017be11>] sys_write+0x41/0x70
>  [<c0187355>] sys_dup2+0xd5/0x100
>  [<c01040f6>] sysenter_past_esp+0x5f/0x85
>  [<c0330000>] xfrm_policy_insert+0x210/0x400
>  =======================

yup, thanks - the present plan is to remove the kthread_bind() call from
_cpu_down().  Although we don't appear to fully undersand why we're
removing it, nor why it was added in the first place, which has me worried.

