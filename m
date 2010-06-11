From: Len Brown <lenb@kernel.org>
Subject: Re: commit 'ACPICA: Minimize the differences between linux GPE code
 and ACPICA code base' breaks EC GPE on my system
Date: Fri, 11 Jun 2010 13:12:50 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1006111310140.6282@localhost.localdomain>
References: <1276256839.4251.7.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:55849 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755837Ab0FKRNL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Jun 2010 13:13:11 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L3V001E515GPGO3@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 11 Jun 2010 12:12:58 -0500 (CDT)
In-reply-to: <1276256839.4251.7.camel@maxim-laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, mjg59 <mjg59@srcf.ucam.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Robert Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>

On Fri, 11 Jun 2010, Maxim Levitsky wrote:

> Just bisected it.
> 
> I also tried linux-acpi-next/test, and no change.
> 
> The sympthoms are that EC does't sent any GPEs, and therefore battery
> insert/removal events don't show up.
> 
> It can be see by doing 'grep  . /sys/firmware/acpi/interrupts/*'
> With regression the line is shown like this:
> 
> 
> /sys/firmware/acpi/interrupts/gpe1C:   1	enabled
> 
> Without regression it is
> 
> /sys/firmware/acpi/interrupts/gpe1C:   22889	enabled
> 
> and steadily increasing.
> 
> After suspend/resume, regression disappears.
> 
> Best regards,
> 	Maxim Levitsky
> 

Woops, as commit 0f849d2cc6863c7874889ea60a871fb71399dd3f
(ACPICA: Minimize the differences between linux GPE code and ACPICA code 
base) shipped in 2.6.35-rc1, this is a regression vs 2.6.34.

thanks,
-Len Brown, Intel Open Source Technology Center


