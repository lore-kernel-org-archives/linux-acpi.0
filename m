From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: kdump bugs with rt kernels
Date: Thu, 31 Jul 2008 09:01:29 -0400
Message-ID: <20080731130129.GA26782@redhat.com>
References: <48909108.6070106@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:44198 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752314AbYGaNBd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 Jul 2008 09:01:33 -0400
Content-Disposition: inline
In-Reply-To: <48909108.6070106@in.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Sachin P. Sant" <sachinp@in.ibm.com>
Cc: Maneesh Soni <maneesh@in.ibm.com>, sripathik@in.ibm.com, linux-acpi@vger.kernel.org

On Wed, Jul 30, 2008 at 09:34:24PM +0530, Sachin P. Sant wrote:
> Hi Vivek,
>
> There have been few kdump bugs reported against rt kernels.
> I think Ankita would have sent out a mail regarding this.
>
> I had been debugging one of that problem which involves
> LS21 hardware. What i found was kdump kernel hangs during
> ACPI initialization. (acpi_sleep_init() function from
> drivers/acpi/sleep/main.c file)
>
> I also found that rt kernel ignores irqpoll option. So can
> this be the reason for these IRQ related problems during
> kdump kernel ?
>

I think it might not be related to irqpoll. irqpoll will make system
work if kernel has explicitly disabled the irq.

> I remember some time back you had debugged a similar issue
> related to interrupts not being properly routed during kdump
> boot. Could you throw some light on what could be happening ?
>
> If i disable ACPI using pci=noacpi or acpi=noirq kdump kernel
> boots fine. Also if i use plain vanilla kernel or RHEL kernels
> kdump works fine. So this is rt specific issue.
>

Ok, so as long as acpi is removed from the picture, things seems to be
fine. So it definitely looks something related to acpi data structures
and initialization.

Have you made sure that kexec-tools are parsing ACPI tables and ACPI
non volatile RAM area from /proc/iomem and passing it to second kernel?

Other than that I would think of diving deeper into the acpi code to find
out where it is hanging.

CCing ACPI mailing list. Hopefully we might get some ideas about what's
wrong here.

Thanks
Vivek
