From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 5/7 REVISION v2] trace, RAS: Add eMCA trace event
 interface
Date: Fri, 20 Jun 2014 20:56:20 -0400
Message-ID: <20140620205620.19a4a886@gandalf.local.home>
References: <20140617020937.GA14404@gchen.bj.intel.com>
	<1403058787-15449-1-git-send-email-gong.chen@linux.intel.com>
	<1403058787-15449-2-git-send-email-gong.chen@linux.intel.com>
	<20140620020618.GA10793@gchen.bj.intel.com>
	<CA+8MBbJCJjC1HJ3LnuzqSCZU+_=hNmRFD7sy7OgmGmFUJv=_ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.225]:31727 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757365AbaFUA4W (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Jun 2014 20:56:22 -0400
In-Reply-To: <CA+8MBbJCJjC1HJ3LnuzqSCZU+_=hNmRFD7sy7OgmGmFUJv=_ww@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tony Luck <tony.luck@gmail.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, "m.chehab@samsung.com" <m.chehab@samsung.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Fri, 20 Jun 2014 16:01:52 -0700
Tony Luck <tony.luck@gmail.com> wrote:

> On Thu, Jun 19, 2014 at 7:06 PM, Chen, Gong <gong.chen@linux.intel.com> wrote:
> >> Add trace interface to elaborate all H/W error related information.
> >>
> > So, Steven & Tony
> >
> > How to solve the dependency between different git tree? (One for trace, One
> > for RAS)
> 
> 1) Simplest (for me) - Steve pushes the trace change upstream now (at
> -rc1 now, -rc2 on Sunday - dodgy, but possible).
> 
> 2) Steve puts the change in a topic branch and publishes to
> kernel.org. I clone that, and add eMCA patches on top
> 
> 3) Steve signs off the patch, and I put it into a RAS branch (awkward
> for Steve in subsequent changes to trace touch same areas)
> 
> 4) Something else
> 

I was going to go with #2 but I have some patches that need to go soon
and since this patch only adds a new macro that no one uses, maybe I
can still slip it in.

-- Steve
