From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: Extended H/W error log driver
Date: Thu, 17 Oct 2013 17:37:22 +0530
Message-ID: <525FD2FA.8010403@linux.vnet.ibm.com>
References: <1381473166-29303-1-git-send-email-gong.chen@linux.intel.com> <20131011080427.GC18719@pd.tnic> <20131014064940.GD12189@gchen.bj.intel.com> <20131014105533.GF4009@pd.tnic> <20131015040731.GA887@gchen.bj.intel.com> <20131015092851.GA7908@pd.tnic> <CA+8MBbJeSJBDPcomupOuVBrnZNkMTNTXsoZY9yUbXPe9YrTFXg@mail.gmail.com> <20131015191040.GA4347@naverao1-tp.ibm.com> <20131015192353.GI7908@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:58376 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753574Ab3JQMew (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Oct 2013 08:34:52 -0400
Received: from /spool/local
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
	Thu, 17 Oct 2013 22:34:50 +1000
In-Reply-To: <20131015192353.GI7908@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@gmail.com>, Chen Gong <gong.chen@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On 10/16/2013 12:53 AM, Borislav Petkov wrote:
> On Wed, Oct 16, 2013 at 12:40:40AM +0530, Naveen N. Rao wrote:
>> +2 ;)
>
> You're counting for 2 people, huh?

That's me raising both my hands :)

>
> :-)
>
>> While at it, I wonder if we're better off calling these "Hardware
>> events" rather than "Hardware errors".
>
> Oh, please no. That's that euphemistic lying which serves no one. And
> here's what I mean by "euphemistic lying":
>
> https://www.youtube.com/watch?v=vuEQixrBKCc
>
> Let's call it what it really is but, at the same time, make sure it is
> understandable to users what action they need to undertake (or none)
> when they encounter it.

If you feel so strongly about it. "Corrected Error" is an oxymoron. It's 
really just the hardware notifying us.


Thanks,
Naveen

