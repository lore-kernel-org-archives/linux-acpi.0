From: Len Brown <lenb@kernel.org>
Subject: Re: how to diagnose/fix : cannot boot without acpi=off
Date: Wed, 31 Mar 2010 21:42:48 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1003312138001.13993@localhost.localdomain>
References: <20100330205516.GC26538@frolo.macqel>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:51790 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758559Ab0DABnJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Mar 2010 21:43:09 -0400
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L06001OLCRDVOO4@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 31 Mar 2010 20:42:55 -0500 (CDT)
In-reply-to: <20100330205516.GC26538@frolo.macqel>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Philippe De Muyter <phdm@macqel.be>
Cc: linux-acpi@vger.kernel.org

On Tue, 30 Mar 2010, Philippe De Muyter wrote:

> Hello acpi experts
> 
> I have just installed opensuse 11.3 milestone 4 (2.6.33-6-desktop) on a laptop
> hp pavilion dv6-1300sb, and it refuses to boot without acpi=off which in turn
> prevents me to use the wireless chip.
> 
> I would like to diagnose precisely what the problem(s) is/are.
> 
> which option should I add to the linux commandline to make it point to the
> problem ?  I have already tried 'ignore_loglevel debug' but the last
> message is never the same.

Did previous versions of Linux boot properly on this machine?

Please open a bug report:

https://bugzilla.kernel.org/enter_bug.cgi?product=ACPI

and attach the output from acpidump and dmesg -s64000
from your acpi=off boot.

If you can take a photo of the failed boot, or otherwise
describe it in more detail, that would be helpful.

See if any of these random options help it boot:
acpi=ht (likely this will work)
acpi=rsdt
acpi=noirq
pci=noacpi

thanks,
-Len Brown, Intel Open Source Technology Center

