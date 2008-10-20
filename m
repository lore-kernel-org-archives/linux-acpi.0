From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: ACPI reboot
Date: Mon, 20 Oct 2008 09:22:19 +0800
Message-ID: <1224465739.3944.186.camel@yakui_zhao.sh.intel.com>
References: <alpine.LFD.1.10.0810161958460.3026@localhost.localdomain>
	 <1224206036.3944.135.camel@yakui_zhao.sh.intel.com>
	 <alpine.LFD.1.10.0810171216450.3006@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:47156 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751136AbYJTBQ3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 19 Oct 2008 21:16:29 -0400
In-Reply-To: <alpine.LFD.1.10.0810171216450.3006@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Fri, 2008-10-17 at 12:26 -0400, Len Brown wrote:
> 

> 
> > the default reboot_type is BOOT_KBD. So it is necessary to add the boot
> > option of "reboot=a" to use the ACPI reboot mechanism.
> 
> hmm, arch/x86/kernel/reboot.c has this:
> 
> /*
>  * Keyboard reset and triple fault may result in INIT, not RESET, which
>  * doesn't work when we're in vmx root mode.  Try ACPI first.
>  */
> enum reboot_type reboot_type = BOOT_ACPI;
> 
> Am I mis-reading the code?
What you said is right. In the latest linus tree the default reboot_type
is changed from KBD to ACPI.
> 
> > > Re: DMI to ignore a missing (acpi_gbl_FADT.flags & 
> > > ACPI_FADT_RESET_REGISTER)....
> > > 
> > > If we need DMI,
> > > it should be checked at _boot_ time, not at _reboot_ 
> > > time, and the table should be marked _initdata.
> 
> > Ok. I will refresh it. The DMI table will be put into _initdata
> > section. 
> 
> I'm okay with a DMI entry now, but only if we work on
> figuring out how to delete the DMI entries to fix the
> problem for all system w/o using DMI.
> 
> > > But the real question is if we should be checking this bit
> > > at all.  The fact that we are adding DMI to ignore it suggest
> > > that we should think about ignoring it by default, and instead
> > > perhaps sanity checking acpi_gbl_FADT.reset_register
> > > and basing our decision to use it on that?
> 
> > According to the ACPI spec the bit indicates whether the ACPI reset
> > mechanism is supported. If it is zero, maybe OS should not use the ACPI
> > reset mechanism even when ACPI_RESET_REG is defined.
> 
> understood.
> 
> > On some laptops the system can't be rebooted by using default
> > reboot_type(BOOT_KBD) after it is resumed from S3. If the ACPI reboot is
> > used, the system can be rebooted. But unfortunately the FADT flag bit
> > indicates that ACPI reboot mechanism is not supported.  This seems
> > contradictory.
> 
> This contradiction suggests that Windows is not following the ACPI spec,
> and is not checking the FADT bit before using the ACPI reboot mechanism.
> 
> > In the patch the FADT flag bit is checked to comply with the ACPI spec.
> > But in order to use the ACPI reboot mechanism on some laptops, the DMI
> > check table is added in which the FADT flag bit is ignored. 
> 
> Understood.  The problem is that it is very likely that Windows
> has NO DMI entry for these laptops, yet it still works.  So if we
> can't figure out why these laptops work with Windows, we are setting
> ourselves up to create an unmaintainable DMI list, possibly including
> a very large number of systems which have this BIOS bug.
Agree with what you said. Windows should have no such DMI entry for
these laptops. But the problem is that we can't figure out that the
laptops are rebooted by ACPI rebooting mechanism on windows. Maybe it is
rebooted by other mechanism. If we can confirm that these laptops are
rebooted by ACPI rebooting mechanism, it can be confirmed that the FADT
flag bit is ingored when using the ACPI rebooting mechanism on windows.
If so, the DMI table will be meaningless.On linux the FADT flag bit can
also be ignored. When ACPI rebooting is used, it is enough only to check
the RESET_REG address.
> > Of course what you said is also OK. When the system is expected to be 
> > rebooted using the ACPI reboot mechanism, the FADT flag bit is ignored 
> > and instead reset_register/reset_value is checked. If so, the DMI check 
> > table is redundant.
> 
> Redundant = deleted.
> If we can figure out how/when to use the ACPI reset register
> w/o consulting the FADT bit, then there should be no DMI table.

> 
> thanks,
> -Len
> 

