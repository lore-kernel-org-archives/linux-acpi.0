From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: acpi_ex_system_memory_space_handler oops
Date: Fri, 14 Aug 2009 10:34:43 +0800
Message-ID: <1250217283.2987.16.camel@minggr.sh.intel.com>
References: <20090812201034.GA2983@localdomain.by>
	 <alpine.LFD.2.00.0908122009170.22946@localhost.localdomain>
	 <20090813124647.GA19195@localdomain.by>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:53144 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752556AbZHNCiP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Aug 2009 22:38:15 -0400
In-Reply-To: <20090813124647.GA19195@localdomain.by>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Len Brown <lenb@kernel.org>, "Brown, Len" <len.brown@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, 2009-08-13 at 20:46 +0800, Sergey Senozhatsky wrote:
> > Looks like regression is in the current RC.
> 
> Looks like it isn't. On 17th reboot rc5-git0 crashed.
> (I'll recompile and try more.)
> I think bisecting here is kind of senseless. You never know how much reboots you need.
> Simple delay (like vga=791) - and everything is ok. We need to come up with something 
> more clever, I guess.
> 
> Any thougths?

Hi, Sergey

Could you please help to locate the line of code that causes oops, as
below?

1. Compile the kernel with debug info
   Kernel menuconfig -> Kernel hacking -> Compile the kernel with debug info

2. Retest until it oops, here you get the address of code that causes oops.
   addr2line -e vmlinux <the address>

Thanks,
Lin Ming

> 
> 	Sergey

