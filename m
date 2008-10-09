From: Len Brown <lenb@kernel.org>
Subject: Re: Problem: ACPI related soft lockup on Fujitsu-Siemens AMILO Si 2636
Date: Wed, 08 Oct 2008 21:50:05 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810082144370.3041@localhost.localdomain>
References: <48E9F51A.4080107@gmail.com> <48EC5F4B.8020009@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:60056 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755229AbYJIBuI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Oct 2008 21:50:08 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K8G001N77RIEUY6@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 08 Oct 2008 20:50:07 -0500 (CDT)
In-reply-to: <48EC5F4B.8020009@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Lindroth <thomas.lindroth@gmail.com>
Cc: linux-acpi@vger.kernel.org



On Wed, 8 Oct 2008, Thomas Lindroth wrote:

> I've done some debugging of this problem myself and reached some conclusions.
> 
> I tried activating the ACPI_LV_INFO ACPI debug mode and observed what happens
> when the system is under load. I saved one trace and put it in the file
> acpi_debug_log at http://www.cyd.liu.se/~tholi945/acpi-bug-2008-10-06/
> 
> When the temp goes over the ACPI passive trip point the processor gets
> throttled. It usually never goes over T4 before the temp falls below the
> passive temp but sometimes it reaches the highest T7. If it reach T7 the
> next call to _TMP or _L18 never returns. I've confirmed this by running
> echo T7 > /proc/acpi/processor/CPU*/throttling and then tried to read
> from /proc/acpi/thermal_zone/TZ00/temperature and it fails in the same way.
> 
> I've tried activating the ACPI_LV_PARSE ACPI debug mode, enter T7 and read
> from temp. I put the result of that in the trace_debug file at the same adress.
> 
> The AML call chain looks like this _TMP -> PMRD -> RCMD -> WIBF
> WIBF always returns 1 causing the interpreter to get stuck in the while
> loop in PMRD.
> 
> While (RCMD (0x80, Local0))
> {
>     Noop
>     Noop
>     Store (PMUC, Local5)
>     If (And (Local5, One, Local2))
>     {
>         Store (PMUD, Local5)
>     }
> }
> 
> I don't really understand how AML code works so I can't get much further than
> this.
> 
> I did not experience complete lockups in Windows but I did notice some minor
> stalls. Maybe the Windows AML parser can break infinite loops or maybe the
> stalls is a normal part of the Windows experience. I tried to boot with the
> acpi_osi=Linux option active but it didn't make any difference.

please send the output from

grep . /proc/acpi/thermal_zone/*/*

from the log, it looks like your _PSV returns 3520, or 352.0K or 78C
and that is reasonable,  but note that one option you have to
workaround is to either disable or that trip point via

thermal.psv=-1
or
thermal.psv=100
for example.

But the bigger question is why the temperature is hitting 78 --
which is quite hot.
Grep above will tell us if there is ACPI fan control, but I don't
see any in the logs.  Can you hear the fans spinning?
Do they go faster when the system heats up?
do they work better after you blow the dust our of the fan?

-Len

