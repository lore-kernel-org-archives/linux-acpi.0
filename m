From: David Rientjes <rientjes@google.com>
Subject: Re: [patch v2] x86: reduce srat verbosity in the kernel log
Date: Tue, 27 Oct 2009 22:24:39 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.0910272220560.9448@chino.kir.corp.google.com>
References: <20091023233750.702443000@alcatraz.americas.sgi.com> <87pr8ay6tc.fsf@basil.nowhere.org> <4AE710C9.2070307@sgi.com> <alpine.DEB.2.00.0910271158490.24696@chino.kir.corp.google.com> <4AE75162.7080903@sgi.com> <alpine.DEB.2.00.0910271323410.32543@chino.kir.corp.google.com>
 <20091028033219.GE7744@basil.fritz.box> <alpine.DEB.2.00.0910272041360.8988@chino.kir.corp.google.com> <20091028041159.GI7744@basil.fritz.box> <alpine.DEB.2.00.0910272129250.17260@chino.kir.corp.google.com> <20091028051925.GL7744@basil.fritz.box>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:38343 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757297AbZJ1FYm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Oct 2009 01:24:42 -0400
In-Reply-To: <20091028051925.GL7744@basil.fritz.box>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Ingo Molnar <mingo@elte.hu>, Mike Travis <travis@sgi.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Jack Steiner <steiner@sgi.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Yinghai Lu <yinghai@kernel.org>, Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wed, 28 Oct 2009, Andi Kleen wrote:

> > +		/*
> > +		 * If the bitmap cannot be listed in a buffer of length
> > +		 * APICID_LIST_LEN, then it is suffixed with "...".
> > +		 */
> > +		len = bitmap_scnlistprintf(apicid_list, APICID_LIST_LEN,
> > +					   apicid_map, MAX_LOCAL_APIC);
> > +		pr_info("SRAT: PXM %u -> APIC {%s%s} -> Node %u\n",
> > +			i, apicid_list,
> > +			(len == APICID_LIST_LEN - 1) ? "..." : "",
> 
> Is the - 1 really correct? If scnlistprintf follows snprintf semantics then it would not
> be and my understanding is it is supposed to.
> 

It is, bitmap_scnlistprintf() returns the number of characters printed to 
the buffer minus the trailing '\0', which is different from snprintf().  
APICID_LIST_LEN-1 then identifies when the buffer was max'd out.  It still 
adds a trailing "..." if the list is exactly 128 characters long, but this 
isn't addressed to avoid added complexity.
