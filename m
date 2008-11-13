From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH 10/10] x86, ACPI: default to reboot via ACPI (again)
Date: Thu, 13 Nov 2008 11:43:01 +0800
Message-ID: <1226547781.4006.126.camel@yakui_zhao.sh.intel.com>
References: <alpine.LFD.2.00.0811080208590.3092@localhost.localdomain>
	 <200811081050.25477.arvidjaar@mail.ru> <20081108115956.GE8354@elte.hu>
	 <4916B38B.7050905@redhat.com> <4916B4DB.90602@zytor.com>
	 <20081110083938.GD22392@elte.hu> <20081110115732.GA30181@srcf.ucam.org>
	 <20081110125630.GC28643@elte.hu> <20081110130029.GC30894@srcf.ucam.org>
	 <alpine.LFD.2.00.0811111802440.4480@localhost.localdomain>
	 <20081112115806.GD11352@elte.hu>  <491ACAB9.40203@redhat.com>
	 <1226546613.4006.110.camel@yakui_zhao.sh.intel.com>
	 <491B9C6A.6000403@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:28897 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933AbYKMDfR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Nov 2008 22:35:17 -0500
In-Reply-To: <491B9C6A.6000403@zytor.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Avi Kivity <avi@redhat.com>, Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrey Borzenkov <arvidjaar@mail.ru>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Eduardo Habkost <ehabkost@redhat.com>

On Thu, 2008-11-13 at 11:18 +0800, H. Peter Anvin wrote:
> Zhao Yakui wrote:
> > 
> > Peter Anvin suggests that OS attempt reboot via 0xCF9 port if avaiable.
> > This is not very good. 0xCF9 I/O port is the reset control register
> > defined in Intel ICH6/7/8/9 chipset. In theory it is effective for Intel
> > chipset. Maybe it is not applied for other chipset(For example: Nvidia,
> > ALI, VIA). There exists a laptop in bug 11942, in which the 0xCF9 I/O
> > port is defined as the RESET_REG. But unfortunately it can't be rebooted
> > Via 0xCF9 I/O port. 
> >     In fact although the 0xCF9 is defined for Intel ICH chipset, it
> > doesn't mean that all the box based on ICH chipset can be rebooted via
> > 0xCF9 I/O port. For example: we have a laptop based on intel ICH6
> > chipset that can't be rebooted by writing the 0x06 to 0xCF9 I/O port.
> > 
> 
> Port CF9 isn't universal, but other vendors are increasingly
> implementing it -- I know ALi are in their more recent chipsets.  Either
> way, I agree that we need to figure out how to get ACPI to work, but CF9
> is a low risk fallback before going to the KBC.
   0xCF9 I/O port is applied for most laptops based on intel ICH6/7/8/9
chipset as it is a reset control register defined in the ICH chipset.
But it is not applied for some laptops. After the 0xCF9 I/O port is
tried, maybe the system already hangs and it can't fall back to
KBD/tripple fault mode.
   
In fact the 0xCF9 I/O port is defined as RESET_REG port on some laptops
on which the acpi reboot mechanism is supported. If acpi reboot is not
supported on the box, we had better not try the reboot via 0xCF9 I/O
port as we can't know whether the 0xCF9 I/O is supported on the box. At
the same time we don't know the proper value that should be written into
0xCF9 I/O port although the 0xCF9 I/O port is supported. 
    For example on intel chipset:      
        Sometimes 0x04 is enough.
        Sometimes 0x06 is enough.
        Sometimes 0x0e is enough.

Thanks.
> 
> 	-hpa

