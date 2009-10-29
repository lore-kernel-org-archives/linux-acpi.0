From: Mike Travis <travis@sgi.com>
Subject: Re: [patch] x86: reduce srat verbosity in the kernel log
Date: Thu, 29 Oct 2009 09:34:02 -0700
Message-ID: <4AE9C3FA.4000305@sgi.com>
References: <20091023233743.439628000@alcatraz.americas.sgi.com> <20091023233750.702443000@alcatraz.americas.sgi.com> <87pr8ay6tc.fsf@basil.nowhere.org> <4AE710C9.2070307@sgi.com> <alpine.DEB.2.00.0910271158490.24696@chino.kir.corp.google.com> <4AE75162.7080903@sgi.com> <alpine.DEB.2.00.0910271323410.32543@chino.kir.corp.google.com> <20091028033219.GE7744@basil.fritz.box> <alpine.DEB.2.00.0910272041360.8988@chino.kir.corp.google.com> <20091028041159.GI7744@basil.fritz.box> <4AE8792F.8070200@sgi.com> <alpine.DEB.2.00.0910281348590.24785@chino.kir.corp.google.com> <4AE8B933.5020103@sgi.com> <alpine.DEB.2.00.0910281440580.32315@chino.kir.corp.google.com> <4AE8C764.90705@sgi.com> <alpine.DEB.2.00.0910290117020.11476@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay1.sgi.com ([192.48.179.29]:50394 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753950AbZJ2QeD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 29 Oct 2009 12:34:03 -0400
In-Reply-To: <alpine.DEB.2.00.0910290117020.11476@chino.kir.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Rientjes <rientjes@google.com>
Cc: Andi Kleen <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Jack Steiner <steiner@sgi.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Yinghai Lu <yinghai@kernel.org>, Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org



David Rientjes wrote:
> On Wed, 28 Oct 2009, Mike Travis wrote:
> 
>>> I'm not saying it would be illegal, merely that it would be harm
>>> readability.  Based on how apic id's are formed from processor ids, though,
>>> I think we're really talking about an upper limit (128) that will never be
>>> reached.
>> We actually have many, many more than that by adding on some extra bits
>> to the CPU's apicid.  These select which blade in the system to target.
>>
> 
> Maybe I've been vague in my rationale for why this limit will probably 
> never be reached.  The way apic ids are constructed, with physical and 
> logical processor ids, it tends to lend itself to ranges where 
> bitmap_scnlistprintf() can specify a large number of apic ids with 
> relatively few ASCII characters because logical processors typically do 
> not have differing pxms.  For us to reach the 128 character upper bound, 
> scnlistprintf() would need to have many, many distinct ranges; your 
> example showed two ranges per pxm (many more machines would have only a 
> single range).  In other words, we're not predicting to have 
> "1-2,4-6,8-9,11-13,15-17," etc, that we often have with nodemasks.

Yes, you are correct.  (I was confused... ;-)

I believe the disjointed ranges came from the hyperthread cpus..?  Which if
true means there'll probably be as many distinct ranges as there are threads
per core?
