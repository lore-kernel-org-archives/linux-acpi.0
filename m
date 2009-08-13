From: Len Brown <lenb@kernel.org>
Subject: Re: acpi_ex_system_memory_space_handler oops
Date: Wed, 12 Aug 2009 20:18:37 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908122009170.22946@localhost.localdomain>
References: <20090812201034.GA2983@localdomain.by>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751009AbZHMATM@vger.kernel.org>
In-reply-to: <20090812201034.GA2983@localdomain.by>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Len Brown <len.brown@intel.com>, Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


> Kernel oopses on early boot stages (boots normally with boot_delay=10).

> rc5-git8

Please find which kernel this failure starts in.
Start by testing 2.6.30.stable so we can tell
if this is a regression in the current RC.

What is the difference between the two dmesg?
they have the same cmdline, neither has boot_delay,
and neither dmesg shows the oops.

The fact that boot_delay=10 makes the problem go away
suggests some sort of race condition.  Is 10 the smallest
value of printk_time that works, or is it a random value?

Do you still see the oops with CONFIG_PRINTK_TIME=n?

Do you still see the oops with maxcpus=1?

Do you still see the oops with "acpi_serialize=1"?

Please open a bug report here:
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI

answer the questions above and attach the output from acpidump

thanks,
-Len Brown, Intel Open Source Technology Center.
