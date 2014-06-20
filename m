From: Tony Luck <tony.luck@gmail.com>
Subject: Re: [PATCH 5/7 REVISION v2] trace, RAS: Add eMCA trace event interface
Date: Fri, 20 Jun 2014 16:01:52 -0700
Message-ID: <CA+8MBbJCJjC1HJ3LnuzqSCZU+_=hNmRFD7sy7OgmGmFUJv=_ww@mail.gmail.com>
References: <20140617020937.GA14404@gchen.bj.intel.com>
	<1403058787-15449-1-git-send-email-gong.chen@linux.intel.com>
	<1403058787-15449-2-git-send-email-gong.chen@linux.intel.com>
	<20140620020618.GA10793@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ve0-f182.google.com ([209.85.128.182]:42133 "EHLO
	mail-ve0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbaFTXBx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2014 19:01:53 -0400
Received: by mail-ve0-f182.google.com with SMTP id oy12so4247776veb.27
        for <linux-acpi@vger.kernel.org>; Fri, 20 Jun 2014 16:01:53 -0700 (PDT)
In-Reply-To: <20140620020618.GA10793@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>, "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, "m.chehab@samsung.com" <m.chehab@samsung.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Thu, Jun 19, 2014 at 7:06 PM, Chen, Gong <gong.chen@linux.intel.com> wrote:
>> Add trace interface to elaborate all H/W error related information.
>>
> So, Steven & Tony
>
> How to solve the dependency between different git tree? (One for trace, One
> for RAS)

1) Simplest (for me) - Steve pushes the trace change upstream now (at
-rc1 now, -rc2 on Sunday - dodgy, but possible).

2) Steve puts the change in a topic branch and publishes to
kernel.org. I clone that, and add eMCA patches on top

3) Steve signs off the patch, and I put it into a RAS branch (awkward
for Steve in subsequent changes to trace touch same areas)

4) Something else

-Tony
