From: David Rientjes <rientjes@google.com>
Subject: Re: [patch v2] x86: reduce srat verbosity in the kernel log
Date: Thu, 12 Nov 2009 13:20:40 -0800 (PST)
Message-ID: <alpine.DEB.2.00.0911121316060.15756@chino.kir.corp.google.com>
References: <87pr8ay6tc.fsf@basil.nowhere.org> <4AE710C9.2070307@sgi.com> <alpine.DEB.2.00.0910271158490.24696@chino.kir.corp.google.com> <4AE75162.7080903@sgi.com> <alpine.DEB.2.00.0910271323410.32543@chino.kir.corp.google.com> <20091028033219.GE7744@basil.fritz.box>
 <alpine.DEB.2.00.0910272041360.8988@chino.kir.corp.google.com> <20091028041159.GI7744@basil.fritz.box> <alpine.DEB.2.00.0910272129250.17260@chino.kir.corp.google.com> <alpine.DEB.2.00.0911101307440.28728@chino.kir.corp.google.com> <20091110213312.GE23196@elte.hu>
 <alpine.DEB.2.00.0911121250140.9544@chino.kir.corp.google.com> <4AFC7AAC.2040607@sgi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:62424 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754532AbZKLVUm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2009 16:20:42 -0500
In-Reply-To: <4AFC7AAC.2040607@sgi.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mike Travis <travis@sgi.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Jack Steiner <steiner@sgi.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Yinghai Lu <yinghai@kernel.org>, Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Andi Kleen <andi@firstfloor.org>

On Thu, 12 Nov 2009, Mike Travis wrote:

> Also, I think in general that all the apic messages, unless they represent
> "system boot progress" should be displayed only when asked for, like with
> apic=debug or verbose?   Something more like:
> 

That's outside the scope of my patch.  My patch does what the title says, 
it reduces srat verbosity in the kernel log.  If an additional change 
would like to suppress that output with a kernel parameter, that's fine, 
but it's an additional change and not what I was addressing.

When posting a patchset like this where all patches are related for a 
common goal and one patch (mine) was proposed during the development of 
the set, it's normal to include that patch in future postings with proper 
attribution given by indicating an author other than yourself in the very 
first line of the email:

	From: David Rientjes <rientjes@google.com>

and retaining your acked-by line, my signed-off-by line, and then adding 
your own signed-off-by line.

If a subsequent patch were to suppress this for kernels not using a 
certain parameter, I certainly wouldn't object to it.
