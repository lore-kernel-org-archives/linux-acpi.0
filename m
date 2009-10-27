From: David Rientjes <rientjes@google.com>
Subject: Re: [patch] x86: reduce srat verbosity in the kernel log
Date: Tue, 27 Oct 2009 14:06:21 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.0910271404580.9183@chino.kir.corp.google.com>
References: <20091023233743.439628000@alcatraz.americas.sgi.com> <20091023233750.702443000@alcatraz.americas.sgi.com> <87pr8ay6tc.fsf@basil.nowhere.org> <4AE710C9.2070307@sgi.com> <alpine.DEB.2.00.0910271158490.24696@chino.kir.corp.google.com>
 <4AE75162.7080903@sgi.com> <alpine.DEB.2.00.0910271323410.32543@chino.kir.corp.google.com> <20091027205558.GM5893@lenovo>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:13333 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932233AbZJ0VGY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Oct 2009 17:06:24 -0400
In-Reply-To: <20091027205558.GM5893@lenovo>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, Mike Travis <travis@sgi.com>, Andi Kleen <andi@firstfloor.org>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Jack Steiner <steiner@sgi.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Yinghai Lu <yinghai@kernel.org>, Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tue, 27 Oct 2009, Cyrill Gorcunov wrote:

> | +void __init acpi_numa_print_srat_mapping(void)
> | +{
> | +	int i, j;
> | +
> | +	for (i = 0; i < MAX_PXM_DOMAINS; i++) {
> | +		int nid;
> | +
> | +		nid = pxm_to_node(i);
> | +		if (nid == NUMA_NO_NODE)
> 
> Btw, David, while you at it, I just curious -- shouldn't we test it
> with NID_INVAL (as pxm_to_node_map initially defined to)? Not a big
> deal at all (since they are both = -1) but for the record.
> Or perhaps I miss something?
> 

I don't think we need to address that since NID_INVAL is going away and 
will be replaced by NUMA_NO_NODE since Lee has exposed it globally in his 
mempolicy patchset, and as you mention they are the same anyway.
