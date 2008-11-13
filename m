From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH 10/10] x86, ACPI: default to reboot via ACPI (again)
Date: Thu, 13 Nov 2008 11:23:33 +0800
Message-ID: <1226546613.4006.110.camel@yakui_zhao.sh.intel.com>
References: <alpine.LFD.2.00.0811080208590.3092@localhost.localdomain>
	 <200811081050.25477.arvidjaar@mail.ru> <20081108115956.GE8354@elte.hu>
	 <4916B38B.7050905@redhat.com> <4916B4DB.90602@zytor.com>
	 <20081110083938.GD22392@elte.hu> <20081110115732.GA30181@srcf.ucam.org>
	 <20081110125630.GC28643@elte.hu> <20081110130029.GC30894@srcf.ucam.org>
	 <alpine.LFD.2.00.0811111802440.4480@localhost.localdomain>
	 <20081112115806.GD11352@elte.hu>  <491ACAB9.40203@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:26273 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752781AbYKMDPt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Nov 2008 22:15:49 -0500
In-Reply-To: <491ACAB9.40203@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Avi Kivity <avi@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrey Borzenkov <arvidjaar@mail.ru>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Eduardo Habkost <ehabkost@redhat.com>

On Wed, 2008-11-12 at 20:23 +0800, Avi Kivity wrote:
> Ingo Molnar wrote:
> >>
> >> We knows XP and Vista do it.
> >>
> >> But upstream doesn't currently check the FADT.flags.reset-reg-supported bit
> >> due to a recent bad guess on my part on how to be bug compatible with 
> >> windows.
> >>
> >> The (revert) patch to add that check is in my tree, along with
> >> the trivial patch to flip the default to acpi-reset.
> >>
> >> Technically, that is the only "unanced" thing we should need
> >> to check.  However, it will not fix Avi's box, where it appears
> >> that flag is present, the reset works, but for some reason the
> >> keyboard fails after reset.  More likely that is a device driver
> >> issue specific to Linux interacting with "unexpected" BIOS behavior.
> >>     
> >
> > hm, will that also fix Andrey's box?
> >   
> 
> This describes Andrey's box, not mine.  Mine (and others) have working 
> acpi reset and non-working keyboard reset; so reset was done using 
> triple-fault which fails when virtualization is enabled.
I agree with what Len has said about the Andrey's box. (Andrey attached
the acpidump/dmesg/dmidecode to the bug 11895).
     From the acpidump it seems that the acpi reset flag bit is set and
reset_reg is also defined. It indicates that the ACPI reset mechanism is
supported. But unfortunately the keyboard can't work well after acpi
reboot is used.
     
With the help of KVM now it is tested that the ACPI reboot is used on
windows XP/Vista if the acpi reboot is supported.(The flag bit is set
and RESET_REG is also defined). The only exception is that acpi reboot
is not used on windows XP/Vista even when it is supported if the
revision of FADT is 1(It indicates that the BIOS follows the ACPI 1.0
spec). And in my test the acpi reboot is also used on windows XP/vista
if the FADT revision is 2. 
    Maybe it is better that Andrey can confirm whether the keyboard
still work well after reboot on windows. If the windows can work well,
maybe the issue is related with the device driver. 

As Avi said, the system can't be rebooted fully by tripple fault/KBD
reset after VT is enabled. And the system can be rebooted fully by ACPI
reboot. Maybe the ACPI reboot should be tried firstly. If acpi reboot is
not supported, then fall backs to the other reboot type(KBD). 
   Of course the strict check should be added for the ACPI reboot. The
flag and reset_reg should be checked. Maybe the revision of FADT should
also be checked. If the FADT revision is below 3, the acpi reboot is
ignored even when it is supported on the box.
   

Peter Anvin suggests that OS attempt reboot via 0xCF9 port if avaiable.
This is not very good. 0xCF9 I/O port is the reset control register
defined in Intel ICH6/7/8/9 chipset. In theory it is effective for Intel
chipset. Maybe it is not applied for other chipset(For example: Nvidia,
ALI, VIA). There exists a laptop in bug 11942, in which the 0xCF9 I/O
port is defined as the RESET_REG. But unfortunately it can't be rebooted
Via 0xCF9 I/O port. 
    In fact although the 0xCF9 is defined for Intel ICH chipset, it
doesn't mean that all the box based on ICH chipset can be rebooted via
0xCF9 I/O port. For example: we have a laptop based on intel ICH6
chipset that can't be rebooted by writing the 0x06 to 0xCF9 I/O port.

Thanks.
> 
> 

