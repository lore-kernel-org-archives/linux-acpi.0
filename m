From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH 10/10] x86, ACPI: default to reboot via ACPI (again)
Date: Thu, 13 Nov 2008 13:29:46 +0800
Message-ID: <1226554186.4006.136.camel@yakui_zhao.sh.intel.com>
References: <alpine.LFD.2.00.0811080208590.3092@localhost.localdomain>
	 <200811081050.25477.arvidjaar@mail.ru> <20081108115956.GE8354@elte.hu>
	 <4916B38B.7050905@redhat.com> <4916B4DB.90602@zytor.com>
	 <20081110083938.GD22392@elte.hu>	<20081110115732.GA30181@srcf.ucam.org>
	 <20081110125630.GC28643@elte.hu>	<20081110130029.GC30894@srcf.ucam.org>
	 <alpine.LFD.2.00.0811111802440.4480@localhost.localdomain>
	 <20081112115806.GD11352@elte.hu> <491ACAB9.40203@redhat.com>
	 <1226546613.4006.110.camel@yakui_zhao.sh.intel.com>
	 <m1skpwntyu.fsf@frodo.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:37850 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750728AbYKMFWD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Nov 2008 00:22:03 -0500
In-Reply-To: <m1skpwntyu.fsf@frodo.ebiederm.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Avi Kivity <avi@redhat.com>, Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Borzenkov <arvidjaar@mail.ru>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Eduardo Habkost <ehabkost@redhat.com>

On Thu, 2008-11-13 at 12:14 +0800, Eric W. Biederman wrote:
> Zhao Yakui <yakui.zhao@intel.com> writes:
> 
> 
> > Peter Anvin suggests that OS attempt reboot via 0xCF9 port if avaiable.
> > This is not very good. 0xCF9 I/O port is the reset control register
> > defined in Intel ICH6/7/8/9 chipset. In theory it is effective for Intel
> > chipset. Maybe it is not applied for other chipset(For example: Nvidia,
> > ALI, VIA).
> 
> Looking at the coreboot source.  It is indeed defined for Nvidia, SIS,
> AMD and several others.
> 
> A lot of boards use:
> outb(0x02, 0xcf9);
> outb(0x06, 0xcf9);
> 
> Instead of just writing a plain 6.   I think at least on some machines
> there is a requirement for a low to hight transition.
Maybe the 0xCF9 port is defined for NVidia, SiS and Several others
vendor. But we can't say that it is appropriate for most boxes. 
Of course IMO it is not a generic solution for reboot.
At the same time the value written to the 0xCF9 I/O port should not be a
fixed value. Maybe it varies on different vendors/chipset. Even the
value will vary on the boxes from different BIOS vendors although the
boxes are based on the same chipset. 
    And the value should be provided by BIOS. If BIOS doesn't provide
the above info, it is not safe to use them. 
> 
> > There exists a laptop in bug 11942, in which the 0xCF9 I/O
> > port is defined as the RESET_REG. But unfortunately it can't be rebooted
> > Via 0xCF9 I/O port. 
> >     In fact although the 0xCF9 is defined for Intel ICH chipset, it
> > doesn't mean that all the box based on ICH chipset can be rebooted via
> > 0xCF9 I/O port. For example: we have a laptop based on intel ICH6
> > chipset that can't be rebooted by writing the 0x06 to 0xCF9 I/O port.
> 
> Right.  The only scary question is will a motherboard hang if you write
> to 0xcf9.  If we don't know of an example where writing to 0xcf9 will prevent
> us from getting to the next reset method then adding a generic 0xcf9 is
> safe.
> 
> If we are totally paranoid we can build of a whitelist of motherboards
> where writing to 0xcf9 works.  By reading and checkup on the chipset
> docs, but don't make the mistake of thinking 0xcf9 is an Intel only
> thing.
> 
> Eric
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

