From: Mike Travis <travis@sgi.com>
Subject: Re: [patch] x86: reduce srat verbosity in the kernel log
Date: Wed, 28 Oct 2009 15:36:20 -0700
Message-ID: <4AE8C764.90705@sgi.com>
References: <20091023233743.439628000@alcatraz.americas.sgi.com> <20091023233750.702443000@alcatraz.americas.sgi.com> <87pr8ay6tc.fsf@basil.nowhere.org> <4AE710C9.2070307@sgi.com> <alpine.DEB.2.00.0910271158490.24696@chino.kir.corp.google.com> <4AE75162.7080903@sgi.com> <alpine.DEB.2.00.0910271323410.32543@chino.kir.corp.google.com> <20091028033219.GE7744@basil.fritz.box> <alpine.DEB.2.00.0910272041360.8988@chino.kir.corp.google.com> <20091028041159.GI7744@basil.fritz.box> <4AE8792F.8070200@sgi.com> <alpine.DEB.2.00.0910281348590.24785@chino.kir.corp.google.com> <4AE8B933.5020103@sgi.com> <alpine.DEB.2.00.0910281440580.32315@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay2.sgi.com ([192.48.179.30]:35193 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753912AbZJ1WgU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Oct 2009 18:36:20 -0400
In-Reply-To: <alpine.DEB.2.00.0910281440580.32315@chino.kir.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Rientjes <rientjes@google.com>
Cc: Andi Kleen <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Jack Steiner <steiner@sgi.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Yinghai Lu <yinghai@kernel.org>, Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org



David Rientjes wrote:
> On Wed, 28 Oct 2009, Mike Travis wrote:
> 
>>> Printing a list of apic ids longer than 128 characters would pollute the
>>> kernel log and this upper bound will probably never be reached based on the
>>> way apic ids are created for physical and logical processors: they are
>>> normally reduced to ranges instead of comma seperated entities.
>> Ahh, ok, thanks.
>>
>> Does that mean this 10,649 character line full of periods is illegal?
>>
> 
> I'm not saying it would be illegal, merely that it would be harm 
> readability.  Based on how apic id's are formed from processor ids, 
> though, I think we're really talking about an upper limit (128) that will 
> never be reached.

We actually have many, many more than that by adding on some extra bits
to the CPU's apicid.  These select which blade in the system to target.

> 
>> [  102.551570] Completing Region/Field/Buffer/Package initialization:
>> ............... [long time later] .........
>> <4>Clocksource tsc unstable (delta = 4396383657849 ns)
>>
>> I'm having trouble finding it.  Does it look familiar to anyone?
>>
> 
> It's debugging output from acpi_ns_initialize_objects() and each period is 
> from acpi_ns_init_one_device().  You can suppress it by disabing 
> CONFIG_ACPI_DEBUG.

Ahh, didn't know that was set in the (our) default config.  Is it normally
set by distros?  
