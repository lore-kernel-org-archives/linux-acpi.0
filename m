From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [BUG] acpi double resume and fail
Date: Fri, 18 May 2007 15:45:07 -0700
Message-ID: <20070518154507.30ebfdcb.akpm@linux-foundation.org>
References: <20070518213701.GA810@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57194 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754880AbXERWrF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 May 2007 18:47:05 -0400
In-Reply-To: <20070518213701.GA810@core>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christian Leber <christian@leber.de>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, 18 May 2007 23:37:01 +0200
Christian Leber <christian@leber.de> wrote:

> Hello,
> 
> i hit a problem with suspend to ram and especially resume.
> Hardware: Dell Latitude D810 (some Intel 915 with Intel Pentium M)
> 
> With 2.6.19.7 suspend to ram works reliable, but with 2.6.20-rc4
> it stopped working reliable.

argh, that sounds like an ACPI regression.

> I still can suspend, but after the first resume it goes back to sleep
> directly again, when resuming again it works.
> After the second suspend it won't resume at all.
> 
> The problem is that i can't try out the kernel versions <rc4, because
> rc1, rc2 and rc3 doesn't boot at all, so git-bisect also won't help.
> 
> Has somebody an idea what i could try out?
> 
> (the distribution is in this case ubuntu feisty)
> 

The fact that bisection broke really does make it hard.  What you would
need to do is to find the patch which fixed that doesn't-boot problem, then
reapply it each time you perform an iteration.  That's all doable, if you
have the time.  Use git-bisect for it.

Have you tested 2.6.21 and/or 2.6.22-rc1?

We had one other report earlier today that 2.6.22-rc1 does an immediate
resume after suspend-to-RAM - perhaps that is related.


Of course the alternative way of debugging this is just to debug it, rather
than the difficult bisecting.  Perhaps an ACPI developer can help with
that.

