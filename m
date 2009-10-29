From: David Rientjes <rientjes@google.com>
Subject: Re: [patch] x86: reduce srat verbosity in the kernel log
Date: Thu, 29 Oct 2009 01:21:25 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.0910290117020.11476@chino.kir.corp.google.com>
References: <20091023233743.439628000@alcatraz.americas.sgi.com> <20091023233750.702443000@alcatraz.americas.sgi.com> <87pr8ay6tc.fsf@basil.nowhere.org> <4AE710C9.2070307@sgi.com> <alpine.DEB.2.00.0910271158490.24696@chino.kir.corp.google.com>
 <4AE75162.7080903@sgi.com> <alpine.DEB.2.00.0910271323410.32543@chino.kir.corp.google.com> <20091028033219.GE7744@basil.fritz.box> <alpine.DEB.2.00.0910272041360.8988@chino.kir.corp.google.com> <20091028041159.GI7744@basil.fritz.box> <4AE8792F.8070200@sgi.com>
 <alpine.DEB.2.00.0910281348590.24785@chino.kir.corp.google.com> <4AE8B933.5020103@sgi.com> <alpine.DEB.2.00.0910281440580.32315@chino.kir.corp.google.com> <4AE8C764.90705@sgi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:1930 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbZJ2IVa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Oct 2009 04:21:30 -0400
In-Reply-To: <4AE8C764.90705@sgi.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mike Travis <travis@sgi.com>
Cc: Andi Kleen <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Jack Steiner <steiner@sgi.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Yinghai Lu <yinghai@kernel.org>, Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wed, 28 Oct 2009, Mike Travis wrote:

> > I'm not saying it would be illegal, merely that it would be harm
> > readability.  Based on how apic id's are formed from processor ids, though,
> > I think we're really talking about an upper limit (128) that will never be
> > reached.
> 
> We actually have many, many more than that by adding on some extra bits
> to the CPU's apicid.  These select which blade in the system to target.
> 

Maybe I've been vague in my rationale for why this limit will probably 
never be reached.  The way apic ids are constructed, with physical and 
logical processor ids, it tends to lend itself to ranges where 
bitmap_scnlistprintf() can specify a large number of apic ids with 
relatively few ASCII characters because logical processors typically do 
not have differing pxms.  For us to reach the 128 character upper bound, 
scnlistprintf() would need to have many, many distinct ranges; your 
example showed two ranges per pxm (many more machines would have only a 
single range).  In other words, we're not predicting to have 
"1-2,4-6,8-9,11-13,15-17," etc, that we often have with nodemasks.
