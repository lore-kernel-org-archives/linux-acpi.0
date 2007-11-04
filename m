From: Roman Rumisek <romrum@cbox.cz>
Subject: Re: Acpi suspend to ram on Acer Aspire 5672
Date: Sun, 04 Nov 2007 17:56:39 +0100
Message-ID: <fgktis$ra8$1@ger.gmane.org>
References: <472847A2.9020901@salfischberger.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:46838 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751428AbXKDVfG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 4 Nov 2007 16:35:06 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Ion7W-0006TP-85
	for linux-acpi@vger.kernel.org; Sun, 04 Nov 2007 21:35:02 +0000
Received: from ipn230.customer.medialine.cz ([82.114.206.230])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sun, 04 Nov 2007 21:35:02 +0000
Received: from romrum by ipn230.customer.medialine.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sun, 04 Nov 2007 21:35:02 +0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi Tomas,

I have this problem on ACER Extensa 5220.
The "save to disk" is OK,but after "save to RAM" the notebook hangs
and seems (for example when i press CapsLock key - nothing) one is dead.

Roman.

Tomas Salfischberger wrote:

> Hi list,
> 
> I don't know what the correct approach to this is, but I need some help
> :-)
> 
> I have been trying to get my Acer Aspire 5672 to suspend to ram, using
> kernel version 2.6.22 patched by Gentoo (r8). The ACPI functions work
> for shutting down the machine, and (but I'm not sure of this) for
> suspend to disk. When I set /sys/power/state to "disk" the power-led
> switches to orange (which it also does when switching to suspend in
> Windows).
> 
> From the above I think that ACPI is working as it should, but when I try
> to suspend to ram the machine switches to the correct state (orange
> power-led) but is unable to resume. When resuming the machine hangs,
> disk spins up but it's not reacting to for example the num-lock key.
> 
> I've read a lot about how suspend to ram is supposed to work, and if I
> understand it correctly the ACPI functions from the BIOS are supposed to
> jump to kernel code when resuming and the kernel should initialize all
> hardware correct? Is there some way to check whether it is actually
> reaching kernel-code, and thus if this might be fixable in kernel?
> 
> I have already tried to patch the DSDT, but to no avail. The errors:
> Some reserved symbols being used and some methods that didn't return a
> value for all controlpaths (notably _WAK which I changed to return
> 0x00,0x00 on the last line).
> 
> Is there anything else I can try?
> 
> Regards,
> Tomas
> 
> P.S. I'm not a native English speaker, so sorry for some weird grammar
> choices.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


