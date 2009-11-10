From: David Rientjes <rientjes@google.com>
Subject: Re: [patch v2] x86: reduce srat verbosity in the kernel log
Date: Tue, 10 Nov 2009 13:08:23 -0800 (PST)
Message-ID: <alpine.DEB.2.00.0911101307440.28728@chino.kir.corp.google.com>
References: <20091023233743.439628000@alcatraz.americas.sgi.com> <20091023233750.702443000@alcatraz.americas.sgi.com> <87pr8ay6tc.fsf@basil.nowhere.org> <4AE710C9.2070307@sgi.com> <alpine.DEB.2.00.0910271158490.24696@chino.kir.corp.google.com>
 <4AE75162.7080903@sgi.com> <alpine.DEB.2.00.0910271323410.32543@chino.kir.corp.google.com> <20091028033219.GE7744@basil.fritz.box> <alpine.DEB.2.00.0910272041360.8988@chino.kir.corp.google.com> <20091028041159.GI7744@basil.fritz.box>
 <alpine.DEB.2.00.0910272129250.17260@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:25610 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758212AbZKJVI0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Nov 2009 16:08:26 -0500
In-Reply-To: <alpine.DEB.2.00.0910272129250.17260@chino.kir.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Mike Travis <travis@sgi.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Jack Steiner <steiner@sgi.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Yinghai Lu <yinghai@kernel.org>, Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Andi Kleen <andi@firstfloor.org>

On Tue, 27 Oct 2009, David Rientjes wrote:

> x86: reduce srat verbosity in the kernel log
> 
> It's possible to reduce the number of SRAT messages emitted to the kernel
> log by printing each valid pxm once and then creating bitmaps to represent
> the apic ids that map to the same node.
> 
> This reduces lines such as
> 
> 	SRAT: PXM 0 -> APIC 0 -> Node 0
> 	SRAT: PXM 0 -> APIC 1 -> Node 0
> 	SRAT: PXM 1 -> APIC 2 -> Node 1
> 	SRAT: PXM 1 -> APIC 3 -> Node 1
> 
> to
> 
> 	SRAT: PXM 0 -> APIC {0-1} -> Node 0
> 	SRAT: PXM 1 -> APIC {2-3} -> Node 1
> 
> The buffer used to store the apic id list is 128 characters in length.
> If that is too small to represent all the apic id ranges that are bound
> to a single pxm, a trailing "..." is added.  APICID_LIST_LEN should be
> manually increased for such configurations.
> 
> Acked-by: Mike Travis <travis@sgi.com>
> Signed-off-by: David Rientjes <rientjes@google.com>

Ingo, have you had a chance to look at merging this yet?
