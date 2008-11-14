From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH 10/10] x86, ACPI: default to reboot via ACPI (again)
Date: Fri, 14 Nov 2008 09:29:13 +0800
Message-ID: <1226626153.4006.184.camel@yakui_zhao.sh.intel.com>
References: <alpine.LFD.2.00.0811080208590.3092@localhost.localdomain>
	 <200811081050.25477.arvidjaar@mail.ru> <20081108115956.GE8354@elte.hu>
	 <4916B38B.7050905@redhat.com> <4916B4DB.90602@zytor.com>
	 <20081110083938.GD22392@elte.hu>	<20081110115732.GA30181@srcf.ucam.org>
	 <20081110125630.GC28643@elte.hu>	<20081110130029.GC30894@srcf.ucam.org>
	 <alpine.LFD.2.00.0811111802440.4480@localhost.localdomain>
	 <20081112115806.GD11352@elte.hu> <491ACAB9.40203@redhat.com>
	 <1226546613.4006.110.camel@yakui_zhao.sh.intel.com>
	 <m1skpwntyu.fsf@frodo.ebiederm.org>
	 <1226554186.4006.136.camel@yakui_zhao.sh.intel.com>
	 <m1ljvom7sz.fsf@frodo.ebiederm.org>
	 <1226567180.4006.171.camel@yakui_zhao.sh.intel.com>
	 <491C66EA.7030900@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:21051 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752340AbYKNBVX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Nov 2008 20:21:23 -0500
In-Reply-To: <491C66EA.7030900@zytor.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Avi Kivity <avi@redhat.com>, Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, Andrey Borzenkov <arvidjaar@mail.ru>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Eduardo Habkost <ehabkost@redhat.com>

On Fri, 2008-11-14 at 01:42 +0800, H. Peter Anvin wrote:
> Zhao Yakui wrote:
> > I am sorry that I don't describe it very clearly. The value written into
> > 0xCF9 I/O port maybe vary on different chipset vendors. In such case it
> > is difficult to write the generic 0xCF9 reboot mechanism. If the same
> > standard about 0xCF9 I/O port is followed by most chipset vendors, it
> > will be OK.
> 
> What my patch does is:
> 
> u8 cf9 = inb(0xcf9) & ~6;
> outb(cf9|2, 0xcf9); /* Request hard reset */
> udelay(50);
> outb(cf9|6, 0xcf9); /* Actually do the reset */
> udelay(50);
> 
> > I have a laptop on which the ACPI reboot mechanism is not supported.(The
> > reset flag is not present). But there exists the definition of RESET_REG
> > & RESET_VALUE. The RESET_REG is 0xCF9 I/O port. (The box is based on
> > Intel i915 chipsets)
> >     When writing 0x06 to 0xCF9 I/O port the box will hang and can't be
> > rebooted. (Hardware reset will fail)
> >     When writing 0x04 to 0xCF9 I/O port the box can be
> > rebooted.(Software reset is OK)
I do the test as required. First the 0x02 is written to 0xCF9 I/O port.
The return value by reading the 0xCF9 I/O port is 0x02. Then the 0x06 is
written to the 0xCF9 I/O port. The screen becomes black but the box
can't be rebooted.
> What happens if you write 0x02 first, and *then* write 0x06?
> 
> More details about this laptop, please?  Also, what is RESET_REG and
> RESET_VALUE defined as?
The RESET_REG is 0xCF9 I/O port.
The RESET_VALUE is 0x06. The above value is obtained from the FADT. This
laptop is the Thinkpad R52 based on Intel i915 chipset. 
Thanks.
> 
> 	-hpa

