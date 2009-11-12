From: Mike Travis <travis@sgi.com>
Subject: Re: [patch v2] x86: reduce srat verbosity in the kernel log
Date: Thu, 12 Nov 2009 13:14:20 -0800
Message-ID: <4AFC7AAC.2040607@sgi.com>
References: <87pr8ay6tc.fsf@basil.nowhere.org> <4AE710C9.2070307@sgi.com> <alpine.DEB.2.00.0910271158490.24696@chino.kir.corp.google.com> <4AE75162.7080903@sgi.com> <alpine.DEB.2.00.0910271323410.32543@chino.kir.corp.google.com> <20091028033219.GE7744@basil.fritz.box> <alpine.DEB.2.00.0910272041360.8988@chino.kir.corp.google.com> <20091028041159.GI7744@basil.fritz.box> <alpine.DEB.2.00.0910272129250.17260@chino.kir.corp.google.com> <alpine.DEB.2.00.0911101307440.28728@chino.kir.corp.google.com> <20091110213312.GE23196@elte.hu> <alpine.DEB.2.00.0911121250140.9544@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay3.sgi.com ([192.48.152.1]:43044 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754518AbZKLVOT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Nov 2009 16:14:19 -0500
In-Reply-To: <alpine.DEB.2.00.0911121250140.9544@chino.kir.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Rientjes <rientjes@google.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Jack Steiner <steiner@sgi.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Yinghai Lu <yinghai@kernel.org>, Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Andi Kleen <andi@firstfloor.org>



David Rientjes wrote:
> On Tue, 10 Nov 2009, Ingo Molnar wrote:
> 
>> I'm waiting for Mike to test them (and other patches) and send a new 
>> series out with bits to pick up.
>>
> 
> Mike posted his series today without including my patch, so I've replied 
> to it.

Sorry, I wasn't aware I should have.
> 
>> But i really dont like such type of buffering - in the past they tended 
>> to be problematic.
> 
> I'm not sure that I'd call it buffering when iterating through all apic 
> id's and setting appropriate bits in a bitmap when they map to a node id.  
> It's apparently not been problematic either on my machines, Mike's 
> machines, or his merge with ACPI 4.0 code.  I think the code is pretty 
> straight forward.
> 
>> Why print this info at all in the default bootup?  
>> It's not needed on a correctly functioning system.
>>
> 
> We have no other export of the apic id to to node mappings in the kernel.  
> We already show each pxm's address range, each node's address range, and 
> the pxm to node map.  The only other way to map apic ids to nodes is by 
> looking for the lines "CPU 0/0 -> Node 0," which I believe are being 
> removed.

The bootup messages in my patch 1/7 list nodes and their processors as each
boots.  And this is easily found under /sysfs.

Also, I think in general that all the apic messages, unless they represent
"system boot progress" should be displayed only when asked for, like with
apic=debug or verbose?   Something more like:

BIOS-provided physical RAM map processed.
EFI: memory allocated.
SRAT: table interpreted.
Bootmem setups complete.
ACPI: APIC's enabled.
PM: Registered all nosave memory.

Removing the above tables remove about 3400 lines of console output on a 1k
thread machine.  There are 20,000+ lines of output before you get to the
login prompt (even with the removal of cpu bootup messages).

But you are right, the apic info should be available via /sysfs or /procfs.

The next BIG output is from devices.  Listing all the pci busses available
is an overkill as that info is also readily available when the system is
running.
