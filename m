From: Mark Lord <lkml@rtr.ca>
Subject: Re: 20000+ wake-ups/second in 2.6.24.   Bug?
Date: Sat, 01 Dec 2007 18:55:48 -0500
Message-ID: <4751F484.6040204@rtr.ca>
References: <200711302153.lAULrZ7n026255@imap1.linux-foundation.org>	<924EFEDD5F540B4284297C4DC59F3DEE2FAE6A@orsmsx423.amr.corp.intel.com>	<20071130142058.816d1693.akpm@linux-foundation.org>	<924EFEDD5F540B4284297C4DC59F3DEE2FAEAF@orsmsx423.amr.corp.intel.com>	<4750CC78.9070105@rtr.ca>	<20071130190227.1976e682@laptopd505.fenrus.org>	<4750D180.6080001@rtr.ca>	<20071130191816.3e744205@laptopd505.fenrus.org>	<4750D585.1030200@rtr.ca>	<4750D899.4020905@rtr.ca>	<4751F1AB.2060801@rtr.ca> <20071201154646.5a288c9e@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4466 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752956AbXLAXzu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 1 Dec 2007 18:55:50 -0500
In-Reply-To: <20071201154646.5a288c9e@laptopd505.fenrus.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Andrew Morton <akpm@linux-foundation.org>, abelay@novell.com, lenb@kernel.org, rjw@sisk.pl, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Arjan van de Ven wrote:
> On Sat, 01 Dec 2007 18:43:39 -0500
> Mark Lord <lkml@rtr.ca> wrote:
> 
>> Dagnabbit.. it's done it again.. went from 100-200 wakeups/sec
>> back up to 20000+ wakeups/sec.  This time *with* the powertop patches
>> in place.
>>
>> Somethings broken in there, but I don't know what.
>> Or how to make it happen on demand.. it's fine after rebooting again.
>>
>> ???
>>
>> At least now I know to look when I hear the fan turning on
>> when the system is otherwise supposed to be idle..
>>
>> 2.6.23 did not have this problem.
> 
> actually we have reports of 2.6.23 having the exact same problem.
> The thing is, "something" is causing the system to go into a state
> where the cpu throws us right out of the C-state the kernel asks for.
...

Ahh.  Okay, this machine here did not have the problem on 2.6.23.

> Some people have seen that not loading yenta at all will just make this
> not happen at all...
...

No yenta/cardbus here -- it's all PCIe.
If you have any debug patches that could detect or help next time I see it,
then feel free to toss them this way.

Cheers!
