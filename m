From: Len Brown <lenb@kernel.org>
Subject: Re: Strange CPU load - acpi_os_read_port
Date: Sun, 15 Aug 2010 10:05:15 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1008150958320.2313@localhost.localdomain>
References: <4C489E58.7020604@itcare.pl>
 <alpine.LFD.2.00.1008142331000.2294@localhost.localdomain>
 <4C67C092.8060808@itcare.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:62561 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758575Ab0HORIf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Aug 2010 13:08:35 -0400
Received: from localhost.localdomain ([unknown] [64.140.212.33])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L7700EYX5STVLH5@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 15 Aug 2010 09:05:18 -0500 (CDT)
In-reply-to: <4C67C092.8060808@itcare.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-2?Q?Pawe=B3_Staszewski?= <pstaszewski@itcare.pl>
Cc: linux-acpi@vger.kernel.org

> > >               2217.00 13.7% acpi_os_read_port
> > >      
> > curious.
> > does /proc/interrupts show you are receiving acpi interrupts?
> > if yes, what do you see with 'grep . /sys/firmware/acpi/interrupts/*'?
> > 
> > what do you see with
> > grep . /sys/devices/system/cpu/cpu*/cpuidle/*/*
> > 
> > and if there are IO states, any change if you boot with "idle=halt" or
> > "idle=mwait"?

> I can try to reproduce this again but it will take some time.
> 
> For now the solution for me was:
> 
> Change configuration for this host and boot with processor.max_cstate=0

likely it will come back when you remove processor.max_cstate=0,
and it will go away if you use either idle=halt or idle=mwait or
processor.max_cstate=1, which are effectively the same.
(and all preferable to processor.max_cstate-0 from a power
saving point of view)

If this is true, then you should try processor.max_cstate=N
where N is 2, 3 etc, depending on the states shown in the
cpuidle grep above.

If you open a bugzilla and attach the output from acpidump,
that may also be helpful.  If this is due to c-states, the question
is if for some reason we are not using them optimally.
If we already are doing what the platform allows, the
route might be to use PM_QOS to disable states that
are too expensive.
(Documentation/power/pm_qos_interface.txt)

cheers,
Len Brown, Intel Open Source Technology Center.

