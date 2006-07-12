From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Bug 5534] No thermal events until acpi -t - HP nx6125
Date: Wed, 12 Jul 2006 16:23:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607121611250.5623@g5.osdl.org>
References: <CFF307C98FEABE47A452B27C06B85BB6F76365@hdsmsx411.amr.corp.intel.com>
 <Pine.LNX.4.64.0607121553470.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:6808 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751474AbWGLXYF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Jul 2006 19:24:05 -0400
In-Reply-To: <Pine.LNX.4.64.0607121553470.5623@g5.osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org, "Moore, Robert" <robert.moore@intel.com>, "Starikovskiy, Alexey Y" <alexey.y.starikovskiy@intel.com>, bugme-daemon@bugzilla.kernel.org


On Wed, 12 Jul 2006, Linus Torvalds wrote:
> 
> Any reason to not just revert it? The fundamental problems that it 
> introduces are obviously much worse than the fix.

Ok, that commit b8d35192c55fb055792ff0641408eaaec7c88988 is definitely 
horribly horribly broken.

I'm going to revert it, because the "fix" is much worse than the problem 
it fixes. Instead of a fan not coming on, I now have ten thousand threads 
killing the machine instead - and the fan _still_ doesn't come on..

The thread approach doesn't even fix the fundamental problem itself. It 
doesn't help to start a new thread, when the AML interpreter holds a 
semaphore over the sleep, causing the events to be serialized, and the 
thermal events to be delayed _anyway_.

The only thing the threading causes is that it guarantees that the machine 
ends up being totally overwhelmed by the thousands of threads, all blocked 
on the same semaphore.

I don't know what the solution should be, but in the meantime, the "fix" 
is definitely unacceptable.

			Linus
