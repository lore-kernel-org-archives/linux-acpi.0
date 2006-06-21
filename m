From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: 2.6.17-mm1
Date: Wed, 21 Jun 2006 14:06:25 +0200
Message-ID: <6bffcb0e0606210506w14388eb6ke3ba97e001706f90@mail.gmail.com>
References: <20060621034857.35cfe36f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.235]:62770 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751514AbWFUMG0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Jun 2006 08:06:26 -0400
Received: by wr-out-0506.google.com with SMTP id 36so160838wra
        for <linux-acpi@vger.kernel.org>; Wed, 21 Jun 2006 05:06:25 -0700 (PDT)
In-Reply-To: <20060621034857.35cfe36f.akpm@osdl.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Hi,

On 21/06/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm1/
>

It looks like an ACPI problem.

Setting up standard PCI resources
=============================================
[ INFO: possible recursive locking detected ]
---------------------------------------------
idle/1 is trying to acquire lock:
 (lock_ptr){....}, at: [<c021cbd2>] acpi_os_acquire_lock+0x8/0xa

but task is already holding lock:
 (lock_ptr){....}, at: [<c021cbd2>] acpi_os_acquire_lock+0x8/0xa

other info that might help us debug this:
1 lock held by idle/1:
 #0:  (lock_ptr){....}, at: [<c021cbd2>] acpi_os_acquire_lock+0x8/0xa

stack backtrace:
 [<c0103e89>] show_trace+0xd/0x10
 [<c0104483>] dump_stack+0x19/0x1b
 [<c01395fa>] __lock_acquire+0x7d9/0xa50
 [<c0139a98>] lock_acquire+0x71/0x91
 [<c02f0beb>] _spin_lock_irqsave+0x2c/0x3c
 [<c021cbd2>] acpi_os_acquire_lock+0x8/0xa
 [<c0222d95>] acpi_ev_gpe_detect+0x4d/0x10e
 [<c02215c3>] acpi_ev_sci_xrupt_handler+0x15/0x1d
 [<c021c8b1>] acpi_irq+0xe/0x18
 [<c014d36e>] request_irq+0xbe/0x10c
 [<c021cf33>] acpi_os_install_interrupt_handler+0x59/0x87
 [<c02215e7>] acpi_ev_install_sci_handler+0x1c/0x21
 [<c0220d41>] acpi_ev_install_xrupt_handlers+0x9/0x50
 [<c0231772>] acpi_enable_subsystem+0x7d/0x9a
 [<c0416656>] acpi_init+0x3f/0x170
 [<c01003ae>] _stext+0x116/0x26c
 [<c0101005>] kernel_thread_helper+0x5/0xb
ACPI: Interpreter enabled

Here is a dmesg log http://www.stardust.webpages.pl/files/mm/2.6.17-mm1/mm-dmesg
Here is a config file
http://www.stardust.webpages.pl/files/mm/2.6.17-mm1/mm-config

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
