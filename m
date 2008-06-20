From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/4]  Disable Mwait for CPU C-states and add the boot
 option of "idle=nomwait" ,"idle=halt"
Date: Fri, 20 Jun 2008 02:27:11 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806200225590.22284@localhost.localdomain>
References: <1213684734.19901.8.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:59110 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986AbYFTG2A (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 02:28:00 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K2R00DSE0LCSKK1@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 01:27:13 -0500 (CDT)
In-reply-to: <1213684734.19901.8.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org



On Tue, 17 Jun 2008, Zhao Yakui wrote:

> Hi, all,
>     This following patch series is to disable mwait for CPU C-states and add the boot option
> of "idle=nomwait", "idle=halt"
>     Patch 01:
> 	Disable the C2C3_FFH access mode if MWAIT is unsupported

I applied this from bugzilla 10807

>     Patch 02:
> 	Add the boot option of "idle=halt". If the option of "idle=halt" is added,
> Halt will be used for CPU idle. In such case CPU C-state won't be used again for CPU idle.

I applied this from bugzilla 10807

>     Patch 03: 
>        Add boot option of "idle=nomwait" to disable mwait for CPU
> C-states. If the option of "idle=nomwait" is added, OSPM won't
> use mwait for CPU C-states. 

I don't see an e-mail with this one,
and the one in bugzilla 10807 appears to be an outdated patch.

thanks,
-Len

>     Patch 04:
>        Add DMI check to disable mwait for CPU C-states. For the bogus
> BIOS the mwait will automatically be disabled for CPU C-states.
>     
>     Thanks for the review.
>    
> Yakui
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
