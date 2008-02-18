From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: Linux 2.6.24.1  - kernel does not boot; IRQ trouble?
Date: Mon, 18 Feb 2008 13:13:04 +0000 (GMT)
Message-ID: <432054.54127.qm@web52910.mail.re2.yahoo.com>
References: <20080218050056.fb0fc0bf.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from web52910.mail.re2.yahoo.com ([206.190.49.20]:27028 "HELO
	web52910.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1760523AbYBRNNG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 18 Feb 2008 08:13:06 -0500
In-Reply-To: <20080218050056.fb0fc0bf.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

--- Andrew Morton <akpm@linux-foundation.org> wrote:
> and here it hangs, I assume?

Oops, I think you have misunderstood. The hang happens if I *don't* specify acpi=noirq, whereas in
this case I did. I have already reported the original hang under threads:

http://www.ussg.iu.edu/hypermail/linux/kernel/0802.0/0895.html
http://www.ussg.iu.edu/hypermail/linux/kernel/0802.0/0898.html

So I was actually reporting that I've *worked around* the hang here. The net result is that all my
PCI devices are now placed on IRQ 9, instead of IRQs 16, 17 18 and 19.

Cheers,
Chris



      ___________________________________________________________
Support the World Aids Awareness campaign this month with Yahoo! For Good http://uk.promotions.yahoo.com/forgood/
