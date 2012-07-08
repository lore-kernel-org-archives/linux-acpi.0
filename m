From: "Octavio Alvarez" <alvarezp@alvarezp.com>
Subject: Re: [3.4-rc5 -> 3.4-rc6 regression] Asus P5NSLI: lockup on resume
 from suspend
Date: Sat, 07 Jul 2012 21:19:18 -0700
Message-ID: <op.wg30yabp6g6bxc@localhost.localdomain>
References: <op.wg3en6ij6g6bxc@localhost.localdomain>
 <Pine.LNX.4.44L0.1207072208270.508-100000@netrider.rowland.org>
 <20120708025730.GE2961@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from spider.alvarezp.com ([207.210.217.159]:51730 "EHLO
	spider.alvarezp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab2GHE3O (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 8 Jul 2012 00:29:14 -0400
In-Reply-To: <20120708025730.GE2961@burratino>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bob Moore <robert.moore@intel.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, 680707@bugs.debian.org, "\" " <linux-acpi@vger.kernel.org>

On Sat, 07 Jul 2012 19:57:30 -0700, Jonathan Nieder <jrnieder@gmail.com>  
wrote:

>>> commit 2feec47d4c5f80b05f1650f5a24865718978eea4
>>> Author: Bob Moore <robert.moore@intel.com>
>>> Date:   Tue Feb 14 15:00:53 2012 +0800
>>>
>>>      ACPICA: ACPI 5: Support for new FADT SleepStatus, SleepControl
>>> registers
> [...]
>> Yes, okay, that is indeed totally separate.  You should bring that
>> issue up with Bob Moore and Len Brown on the linux-acpi mailing list.
>
> The Debian bug for this one is <http://bugs.debian.org/680707>.
> Please cc me or 680707@bugs.debian.org if bringing it up with ACPI
> folks so we can track the discussion.

Jonathan, so I decided to continue the discussion of the wakeup-lockup
bug here, so I can Cc: 680707 and the commit author. I have adjusted
the subject to the new subject you stated in the cloned Debian bug.

I removed Ben Hutchings and Alan Stern from the Cc. Please feel free
to add them back.

Hello, Bob!

This is a follow-up email on Debian bug 680707.

I am experiencing lock-ups in my machine. You will notice the bug
initially refers to a different problem. That's because this bug
was discovered by accident on my machine, while testing for a
different suspend bug with a newer kernel version.

The problem is a full system lock-up on resume. The HD led stays on.
The 5-sec power-button cycle isn't enough to get the system back.
It requires a full mechanical power cycle from the power supply.

I bisected the problem as requested by Alan Stern, and tracked it
down to the following commit:

commit 2feec47d4c5f80b05f1650f5a24865718978eea4
Author: Bob Moore <robert.moore@intel.com>
Date:   Tue Feb 14 15:00:53 2012 +0800

     ACPICA: ACPI 5: Support for new FADT SleepStatus, SleepControl  
registers

     Adds sleep and wake support for systems with these registers.
     One new file, hwxfsleep.c

     Signed-off-by: Bob Moore <robert.moore@intel.com>
     Signed-off-by: Len Brown <len.brown@intel.com>

There is already some information already captured in the Debian
bug log.

Is there anything I can do to help get this fixed?

Thanks!!

[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=680707



-- 
Octavio.
