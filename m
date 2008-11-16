From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: ACPI: EC: GPE storm detected, transactions will use polling mode
Date: Sun, 16 Nov 2008 07:31:35 -0800
Message-ID: <B407D583-A440-402B-AB35-D69BA464F5AD@gmail.com>
References: <1226722577.3104.4.camel@LiNuX> <1226817681.3133.7.camel@LiNuX> <491FECAE.6050005@gmail.com> <200811161344.07872.rjw@sisk.pl>
Mime-Version: 1.0 (iPhone Mail 5F136)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:31442 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114AbYKPPbo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 16 Nov 2008 10:31:44 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1048287wah.21
        for <linux-acpi@vger.kernel.org>; Sun, 16 Nov 2008 07:31:44 -0800 (PST)
In-Reply-To: <200811161344.07872.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

Cool,
Then I'll just leave it as is
And move on to other tasks that I have. Thanks for the info and help

Regards;

justin P. Mattock



On Nov 16, 2008, at 4:44 AM, "Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Sunday, 16 of November 2008, Alexey Starikovskiy wrote:
>> Justin P. Mattock wrote:
>>> Well; reverting:
>>> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=06cf7d3c7af902939cd1754abcafb2464060cba8
>>> is keeping the system from having a gpe storm
>>> (for at least four hours now);
>>> haven't had a chance to drain the battery and see
>>> the affects from that scenario.
>>>
>>>
>> Justin, by decreasing threshold, we just change how often  
>> _detection_ of
>> the storm fires, not the storm itself.
>
> Yes, I think what happens is that we just detect the interrupt storm  
> with the
> lower threshold, so the storm occured anyway previously, but it went  
> unnoticed
> (not necessarily a good thing).
>
> There is nothing to worry about as long as the box works as expected.
>
> Thanks,
> Rafael
