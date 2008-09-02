From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: a problem about the two patches in bug 10724 & 11428
Date: Tue, 02 Sep 2008 09:59:51 +0800
Message-ID: <1220320791.4039.128.camel@yakui_zhao.sh.intel.com>
References: <1220251221.4039.52.camel@yakui_zhao.sh.intel.com>
	 <48BB9E86.7070503@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:21705 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752246AbYIBBqA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 1 Sep 2008 21:46:00 -0400
In-Reply-To: <48BB9E86.7070503@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

On Mon, 2008-09-01 at 11:49 +0400, Alexey Starikovskiy wrote:
> Hi Yakui,
> Zhao Yakui wrote:
> > Hi, Alexey
> >     You have a lot of experiences about EC driver and a lot of EC patches are from you.
> >     You attach two patches related with EC driver in the bug 10724 & 11428.
> >     In the bug 10724:
> >         Add a boot ption of "ec_intr= " to select the EC work mode( Interrupt/Polling mode)
> >         After this patch is applied, EC won't switch to polling mode automatically from interrupt mode when EC irq storm is detected.
> >     In the bug 11428
> >         In this patch the EC won't switch off GPE mode on missing interrupts
> > 
> >     Will the above two patches hit the upstream kernel? If the above two patches hits the upstream kernel, it 
> > seems that the boot option of "ec_intr=" comes back again and EC can't be switched from interrupt mode to polling 
> > mode if EC GPE interrupt is missing. In such case maybe the battery/AC/thermal driver can't work well if the info of
> > battery/AC/thermal is related with EC. Maybe there exists the regression on some laptops.
> There are two steps here. First, you don't use GPE while waiting for status to become expected value (here you don't care if GPE is at all enabled) and second, there you can't handle GPE coming in very fast rate -- thus you need to disable it.
> 11428 restores first behavior, there we don't touch GPE if it does not hurt us, and provide a way to manually switch it off if it does. 
Maybe I don't understand what you said fully. The following is my
understanding about the patches of bug 11428 and bug 10724.

a. In the patch of bug 11428 the EC GPE won't be disabled when timeout
happens, which means that it is still possible to switch EC working mode
again from polling mode to interrupt mode. i.e. EC can still be switched
to interrupt mode again. In the current upstream kernel when timeout
happens, EC will be switched to polling mode and can't be switched to
interrupt mode again(EC GPE is disabled). Right?
    In fact when EC timeout happens in interrupt mode, it indicates that
EC controller can't return response in time. Maybe the exception happens
in EC controller. In such case maybe it is appropriate that EC works in
polling mode. After your patch is applied,if EC can't be switched to
interrupt mode again and polling timer is not started, the EC SCI_EVT
notification will be lost.
    
    But it is noted that we should avoid the bogus EC timeout while EC
is in interrupt mode. The following source code is to identify whether
EC timeout happens while EC is in interrupt mode.
    >if (wait_event_timeout(ec->wait, acpi_ec_check_status(ec, event),
    >                                 msecs_to_jiffies(ACPI_EC_DELAY))) 
    >                    return 0;
    >clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);

   In the above source code maybe there exists the following phenomenon:
     When the EC GPE interrupt is triggered, the waiting process will be
     waked up in the GPE interrupt service routine. But as the process
     can't be scheduled immediately, maybe the wait_event_timeout will
     also return 0, which means that timeout happens and EC will be
     switched from interrupt mode to polling mode.

   IMO if bogus EC timeout happens, EC should continue its original routine. I.E. EC should
work in EC interrupt mode and it is unnecessary to clear the EC_FLAGS_GPE_MODE of ec->flags.
   If the real EC timeout happens, it will be better that EC GPE is disabled and EC is switched
to polling mode. Of course it can also be OK that EC will try GPE mode after 5 seconds.

b. In the patch of bug 10724 when EC GPE storm is detected, only warning message is printed and 
EC won't be switched to polling mode. In such case the warning message suggests that 
user restart their system with the boot option of "ec_intr=0". If the system is not restarted, 
maybe the interrupt storm still exists and the system is still unstable.
   Maybe it is more appropriate that EC is switched to polling mode in such case.
   
    
After the boot option of "ec_intr" is imported, it is used to determine whether EC GPE is enable/disabled
in the boot phase. If EC GPE is disabled, the EC will be forced to work in polling mode. 
If EC GPE is enabled, maybe it can be switched from polling mode to interrupt mode.
Right?
If so, the patch of bug 10724 had better be split into two patches. One is to add the boot option.
The other is to disable the mode switch when EC GPE interrupt storm happens. 

> Once again, there is driver mode and there is GPE enabled/disabled. ec_intr controls the latter, and driver mode tries to follow automatically.
> >     At the same time the boot option of "ec_intr=1" indicates that EC will work in EC GPE interrupt mode. But maybe the following
> > phenomenon will appear on some laptops:
> >    EC is initialized as polling mode. After the EC GPE interrupt is triggered, it will be switched to GPE interrupt mode. But if
> > no EC GPE interrupt is triggered, it will still work in polling mode. Although it is harmless and EC can also work well, 
> > maybe the EC working mode is inconsistent with the EC boot option. At the same time after the system is resumed from S3, the EC working
> > mode will also be polling mode in the function of acpi_ec_resume.
> Why do you care about such consistency? Code is trying to use interrupt mode if it allowed to. If it fails, it reports this failure. 
> > 
> >     IMO the EC working mode is not very reasonable if the above two patches hit the upstream kernel.
> It is reasonable for me. If you read code more carefully, you might find it reasonable too.
> >     Are the following two methods reasonable? Which of them is better?
> No. Niether.
> > 
> >     a. Add the boot option of "ec_intr=" (ec_intr=auto, intr, polling). For most laptops the boot option of "ec_intr=auto" is the default option
> > and "ec_intr=auto" means that the EC working mode can be switched automatically between interrupt mode and polling mode.The purpose of "ec_intr=auto"
> > is used to avoid the regression on some laptops.(Maybe some laptops can't work well if the EC mode switch is disabled.) 
> >      If the boot option of "ec_intr=intr" is added, the EC will be forced to work in interrupt mode and can't be switched to polling mode even 
> > when the EC confirmation GPE interrupt is missing. 
> >      If the boot option of "ec_intr=polling" is added, the EC will be forced to work in polling mode.
> >      
> >      In such case the EC working mode is related with user input. 
> > 
> >     b. EC mode switch is disabled on some specific laptops. In such case the user doesn't care for the EC working mode. At the same time
> > EC is still started in polling mode. It will be switched to interrupt mode if the EC GPE interrupt is triggered. EC will be switched to polling
> > mode on most laptops in case of missing confirmation GPE interrupt. But on some specific laptops the EC mode switch is disabled, which means
> > that EC will still work in interrupt mode even when the EC confirmation GPE interrupt is missing. This can be realized by adding EC DMI check table.
> > 
> >     I am not sure whether my above suggestion is appropriate. 
> > 
> > Thanks for the comments.
> > 
> > Best regards.
> >    Yakui
> > 
> Regards,
> Alex.

