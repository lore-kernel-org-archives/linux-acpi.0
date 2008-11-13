From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 10/10] x86, ACPI: default to reboot via ACPI (again)
Date: Wed, 12 Nov 2008 20:10:42 -0800
Message-ID: <m1vdusnu4d.fsf@frodo.ebiederm.org>
References: <alpine.LFD.2.00.0811080208590.3092@localhost.localdomain>
	<200811081050.25477.arvidjaar@mail.ru> <20081108115956.GE8354@elte.hu>
	<4916B38B.7050905@redhat.com> <4916B4DB.90602@zytor.com>
	<20081110083938.GD22392@elte.hu>
	<20081110115732.GA30181@srcf.ucam.org>
	<20081110125630.GC28643@elte.hu>
	<20081110130029.GC30894@srcf.ucam.org>
	<alpine.LFD.2.00.0811111802440.4480@localhost.localdomain>
	<20081112115806.GD11352@elte.hu> <491ACAB9.40203@redhat.com>
	<1226546613.4006.110.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:39352 "EHLO
	out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbYKMEPb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Nov 2008 23:15:31 -0500
In-Reply-To: <1226546613.4006.110.camel@yakui_zhao.sh.intel.com> (Zhao Yakui's
	message of "Thu, 13 Nov 2008 11:23:33 +0800")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Avi Kivity <avi@redhat.com>, Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Borzenkov <arvidjaar@mail.ru>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Eduardo Habkost <ehabkost@redhat.com>

Zhao Yakui <yakui.zhao@intel.com> writes:


> Peter Anvin suggests that OS attempt reboot via 0xCF9 port if avaiable.
> This is not very good. 0xCF9 I/O port is the reset control register
> defined in Intel ICH6/7/8/9 chipset. In theory it is effective for Intel
> chipset. Maybe it is not applied for other chipset(For example: Nvidia,
> ALI, VIA).

Looking at the coreboot source.  It is indeed defined for Nvidia, SIS,
AMD and several others.

A lot of boards use:
outb(0x02, 0xcf9);
outb(0x06, 0xcf9);

Instead of just writing a plain 6.   I think at least on some machines
there is a requirement for a low to hight transition.

> There exists a laptop in bug 11942, in which the 0xCF9 I/O
> port is defined as the RESET_REG. But unfortunately it can't be rebooted
> Via 0xCF9 I/O port. 
>     In fact although the 0xCF9 is defined for Intel ICH chipset, it
> doesn't mean that all the box based on ICH chipset can be rebooted via
> 0xCF9 I/O port. For example: we have a laptop based on intel ICH6
> chipset that can't be rebooted by writing the 0x06 to 0xCF9 I/O port.

Right.  The only scary question is will a motherboard hang if you write
to 0xcf9.  If we don't know of an example where writing to 0xcf9 will prevent
us from getting to the next reset method then adding a generic 0xcf9 is
safe.

If we are totally paranoid we can build of a whitelist of motherboards
where writing to 0xcf9 works.  By reading and checkup on the chipset
docs, but don't make the mistake of thinking 0xcf9 is an Intel only
thing.

Eric
