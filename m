From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: 2.6.24-rc3-mm1 - Kernel Panic on IO-APIC
Date: Mon, 26 Nov 2007 23:08:33 +0100
Message-ID: <474B43E1.9080407@gmail.com>
References: <20071120204525.ff27ac98.akpm@linux-foundation.org> <4743CC0B.9000508@linux.vnet.ibm.com> <20071120221839.faab108e.akpm@linux-foundation.org> <20071126143943.0a01665b@cuia.boston.redhat.com> <20071126123319.7483e57f.akpm@linux-foundation.org> <20071126204540.GA19874@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:8133 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755194AbXKZWIk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Nov 2007 17:08:40 -0500
Received: by nf-out-0910.google.com with SMTP id g13so904877nfb
        for <linux-acpi@vger.kernel.org>; Mon, 26 Nov 2007 14:08:37 -0800 (PST)
In-Reply-To: <20071126204540.GA19874@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@linux-foundation.org>, Rik van Riel <riel@redhat.com>, kamalesh@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, apw@shadowen.org, balbir@linux.vnet.ibm.com, linux-acpi@vger.kernel.org, tglx@linutronix.de, Christoph Lameter <clameter@sgi.com>

On 11/26/2007 09:45 PM, Ingo Molnar wrote:
> * Andrew Morton <akpm@linux-foundation.org> wrote:
> 
>> On Mon, 26 Nov 2007 14:39:43 -0500
>> Rik van Riel <riel@redhat.com> wrote:
>>
>>> On Tue, 20 Nov 2007 22:18:39 -0800
>>> Andrew Morton <akpm@linux-foundation.org> wrote:
>>>
>>>>> ..MP-BIOS bug: 8254 timer not connected to IO-APIC
>>>>> Kernel panic - not syncing: IO-APIC + timer doesn't work! Try using the 'noapic' kernel parameter
>>>> ACPI or x86 breakage, I guess.
>>>>
>>>> Did 'noapic' work?
>>> I got the same bug as above, 'noapic' gets past that point 
>> We still don't know what caused this, afaik.
> 
> yes. Is it a regression? If yes, could someone try to bisect it so that 
> we can fix it? If it's caused by x86.git then the 'mm' branch of the x86 
> git tree can be used for bisection:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-x86.git

I did, but it's hard, if you don't know the BAD point. HEAD boots fine and 'x86:
randomize brk' too (the top of git-x86.patch). Andrew, how do you pull it, git
#mm doesn't fit to the ids from the patch.

Maybe if you can emit a broken-out with the fresh pull to test?

regards,
-- 
Jiri Slaby (jirislaby@gmail.com)
Faculty of Informatics, Masaryk University
