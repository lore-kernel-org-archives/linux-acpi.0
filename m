From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: Handle bay devices in dock stations
Date: Mon, 09 Jun 2008 10:44:01 +0900
Message-ID: <484C8AE1.3010908@gmail.com>
References: <20080528143857.GB5585@homac.suse.de> <4845886E.2010505@garzik.org> <20080603181346.GA5013@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:38047 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754765AbYFIBoJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 8 Jun 2008 21:44:09 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1889236wfd.4
        for <linux-acpi@vger.kernel.org>; Sun, 08 Jun 2008 18:44:08 -0700 (PDT)
In-Reply-To: <20080603181346.GA5013@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org

Matthew Garrett wrote:
> On Tue, Jun 03, 2008 at 02:07:42PM -0400, Jeff Garzik wrote:
> 
>> It would be nice if you and Holger could work together to produce a 
>> single patch[set]...  right now I have patches from both of you, and I 
>> was sorta waiting on the thread to die down to see if competing patches 
>> might merge into a single set
> 
> I think we were waiting for feedback from Tejun as to why removing the 
> port freeze call fixed the hang I was seeing? Beyond that, Holger's 
> latest patch looked good to me.

Sorry, was off for the last week.

The difference between freezing and scheduling EH is that the former 
immediately aborts all in-flight commands and resets the port while the 
latter waits till the in-flight commands finish or time out (EH 
scheduling kicks fast-drain and the timeout is reduced to three seconds).

TF-based ATA controllers are very sensitive to how the registers are 
accessed and sometimes lock up the whole machine when they are not happy 
by indefinitely holding the PCI bus.  This could have been the case if 
IOs were in flight when the dock event occurred.  Were they?

Thanks.

-- 
tejun
