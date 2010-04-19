From: Pat Erley <pat-lkml@erley.org>
Subject: Re: Working DSDT+SSDT, what's next?
Date: Mon, 19 Apr 2010 00:47:25 -0400
Message-ID: <4BCBE05D.5090600@erley.org>
References: <f95d4e7ce96630fd1e07c05fd8ab2504@127.0.0.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from li59-9.members.linode.com ([97.107.129.9]:51224 "EHLO erley.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929Ab0DSEr1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 Apr 2010 00:47:27 -0400
Received: from [IPv6:2001:4978:142:0:290:f5ff:fe3e:e3c7] (unknown [IPv6:2001:4978:142:0:290:f5ff:fe3e:e3c7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: pat)
	by erley.org (Postfix) with ESMTPSA id 6C91F2865E
	for <linux-acpi@vger.kernel.org>; Mon, 19 Apr 2010 04:45:51 +0000 (UTC)
In-Reply-To: <f95d4e7ce96630fd1e07c05fd8ab2504@127.0.0.1>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Ok, I've continued learning, more info injected below:

On 04/16/10 14:42, pat-lkml@erley.org wrote:
> Ok, first time poster, long time reader.  
> 
> I have a Clevo D900T mobo based laptop.  These were only ever produced
> with p4 5xx series chips, but the chipset (ICH6) supports the 6xx series. 
> Because it was never produced with a 6xx cpu, a bios was never released
> that supported things like EIST or EM64T.  EM64T worked fine, out of the
> box.  EIST did not (due to no SSDT tables with PSS/PCT/PPC methods).  I was
> able to get EIST working with a hacked-up DSDT, but I'm curious if I'm
> doing everything I should.
> 
> Intel CPU Spec: http://processorfinder.intel.com/details.aspx?sSpec=SL8Q7
> Intel Data Sheet:
> http://download.intel.com/design/Pentium4/datashts/303128.pdf
> 
> Right now, I just have 2 C States, for 3.0Ghz and 2.8Ghz.  It's my
> understanding that these are the only speeds EIST can do in this CPU.  
> 
> now, the questions:
> 
> 1. Is there something I should be doing with a _CSD type entry in my
> CPU{0,1} entries to signify that they're HT?

Yep, I needed to add a pair of _CSD entries.  EIST is now adjusting speeds correctly!

> 3. How do I determine VID values? 
>    a. I've just lowered VID 1 by 1, loading the system until it became
> unstable, at which point I added 1 and called it good
>    b. Is there any advantage to multiple VID's with 1 VID?  IE:
> 3ghz@1.45V, 3Ghz@1.25V

People in linux-pch have helped me here

> 4. in the PSS table, the first entry (3000,2800 in my case), are those
> just for show?

Still don't have an answer here.

> 5. Are there additional features the CPU supports that, due to bios
> limitation, I should enable this way (C1E?)

Ok, I now now I need to come up with a _CST table (unless one of the other tables is doing this...) to enable C-States, and C1E in particular... Anyone have any pointers on where to start on this?  All of the info I seem to be able to find are for C2Q and newer CPUs, not older P4s like what I have.
 
> outline of what I've done: http://pat.erley.org/Other/P4EISTSSDT
> 
> Pat Erley

Pat Erley
