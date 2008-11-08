From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 10/10] x86, ACPI: default to reboot via ACPI (again)
Date: Fri, 07 Nov 2008 20:41:18 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811072033300.9051@localhost.localdomain>
References: <007e7d616a5d1c2e16ad627d03f8b97799445e71.1226032943.git.len.brown@intel.com>
 <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1226032943.git.len.brown@intel.com>
 <20081107072536.GA19583@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:50160 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbYKHBpu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Nov 2008 20:45:50 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9Z00E28RKC2CG1@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 07 Nov 2008 19:45:49 -0600 (CST)
In-reply-to: <20081107072536.GA19583@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Avi Kivity <avi@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Andrey Borzenkov <arvidjaar@mail.ru>



> > -enum reboot_type reboot_type = BOOT_KBD;
> > +enum reboot_type reboot_type = BOOT_ACPI;

> NAK.
> 
> Your point that the set of systems where KBD-reboot is broken is 
> larger (and growing) than the set of systems where ACPI-reboot is 
> broken (which set probably has a constant size) is true.
> 
> But still this change caused non-trivial regressions in v28 _worse_ 
> than the inability to reboot cleanly, so this patch does not fly as-is 
> as we reverted it upstream for a good reason.

If you can direct me to the failures that ACPI reset caused
in 28, that would be great.  Obviously they are not on
the linux-acpi archives because the x86 tree enabled
ACPI reset and then disabled it w/o telling us...

thanks,
-Len

