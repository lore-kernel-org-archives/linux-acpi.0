From: Andrew Morton <akpm@osdl.org>
Subject: Re: Suspend to RAM regression retraced
Date: Sat, 4 Mar 2006 17:03:45 -0800
Message-ID: <20060304170345.2d9b6673.akpm@osdl.org>
References: <1141289925.18519.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:32743 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751773AbWCEBF1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Mar 2006 20:05:27 -0500
In-Reply-To: <1141289925.18519.14.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Cc: linux-acpi@vger.kernel.org

Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca> wrote:
>
> Hi,
> 
> A while ago I reported a regression (http://lkml.org/lkml/2005/9/21/290)
> in suspend to RAM that happened with kernel 2.6.12 on my Dell D600
> laptop. After several months of testing (this is my work machine and the
> bug takes time to reproduce), I have finally narrowed it down. It seems
> like to problem was introduced between 2.6.12-rc5 and 2.6.12-rc6. 
> 
> Basically, what happens is that with 2.6.12-rc6, my machine *sometimes*
> doesn't resume when I suspend it. This happens especially when it has
> been running for a while. It almost always works when I just rebooted,
> or if I just successfully resumed. So it behaves like "something" gets
> randomly corrupted, at which point the machine still works, but will not
> resume if I suspend it. Also, I've observed the same behaviour with and
> without preemption enabled. 
> 
> Can someone have a look at what could cause the problem and fix it? I
> can provide more information if needed. BTW, I'm not on the list so
> please CC to me.
> 
> Thanks,
> 
> 	Jean-Marc
> 
> P.S. Machine setup is:
> Ubuntu 5.10 (but problem also observed on 5.04 and old Debian unstable)
> Dell Latitude D600 (Bios rev. A14)
> Pentium-M 1.6 GHz / 1 GB RAM
> ATI Technologies, Inc. Radeon Mobility 9000 M9 (R250 Lf)
> 

Thanks.  You'd be best off raising a report at bugzilla.kernel.org, please.
