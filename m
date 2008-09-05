From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: a problem about the the patch in the comment #118 of bug 10724
Date: Fri, 05 Sep 2008 16:38:36 +0400
Message-ID: <48C1284C.2030600@suse.de>
References: <1220579510.4007.178.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:56471 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752335AbYIEMin (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Sep 2008 08:38:43 -0400
In-Reply-To: <1220579510.4007.178.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

Zhao Yakui wrote:
> Hi, Alexey
>     
>     Maybe you misunderstand what I have done in the patch of bug 10724.
Ok, the patch is worthless from both debugging point (you _will_ get less interrupts if you service them longer), so you will
not find anything new with this patch, and it is stupid as a patch intended at production just because you'll spend same time
in interrupt context as before, but now you flush system responsiveness down the tube too.

>     We should firstly make it clear why there exists EC GPE interrupt storm on some laptops. EC controller
> uses the pulse interrupt model to trigger GPE interrupt and EC GPE is registered as Edge mode.
>     If the EC interrupt pulse is too wide on some broken BIOS, several ACPI interrupts are triggered
> although only one EC interrupt pulse is generated. Maybe on some broken BIOS the situation will be more serious.And
> when EC GPE handler is served, OS will check the EC status by reading the EC status I/O port. On most laptops the 
> EC and other controller(Keyboard, UART) are accessed through LPC bus. If the EC GPE interrupt is triggered too many times
> ( For example: 50000 per second), too much bandwith of LPC bus will be wasted on reading the EC status register. 
> On the bug 9998 it causes that sometimes the keystrobes are lost. Sometimes it will cause that the info of the 
> battery/SBS battery related with EC can't be obtained.
>     
>     If we can add some delays on the EC GPE handler, the number of EC GPE interrupt can be reduced very obviously, which 
> makes the system work well. For example: the laptop in bug 9998 can work well and the EC working flowchart is also simple.
> 
>     My patch is only for the broken BIOS. For most laptops no delay is added in the EC GPE handler. 
>     Only when five EC GPE interrupts happens in the same jiffies and the EC status is the same, OS will add some delay in 
> the EC GPE handler. If the same thing still happens after the delay is added, the delay time will be increased. 
> But the max delay time is 5 microseconds.
If you care to look at the log I've sent several days ago, you will see that interrupts happen for about 1ms after the command
write. So you will spend this whole millisecond spinning.

>     At the same time IMO udelay is harmless. It is realized by repeat loop instead of halt. 
Well, most people try to make interrupt context as short as possible, just because it's not interruptible, 
so you loose interactivity. For example music/video could become jerky.


