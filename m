From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [patch] x86: reduce srat verbosity in the kernel log
Date: Wed, 28 Oct 2009 04:32:19 +0100
Message-ID: <20091028033219.GE7744@basil.fritz.box>
References: <20091023233743.439628000@alcatraz.americas.sgi.com> <20091023233750.702443000@alcatraz.americas.sgi.com> <87pr8ay6tc.fsf@basil.nowhere.org> <4AE710C9.2070307@sgi.com> <alpine.DEB.2.00.0910271158490.24696@chino.kir.corp.google.com> <4AE75162.7080903@sgi.com> <alpine.DEB.2.00.0910271323410.32543@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:48901 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757205AbZJ1DcP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Oct 2009 23:32:15 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0910271323410.32543@chino.kir.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Rientjes <rientjes@google.com>
Cc: Ingo Molnar <mingo@elte.hu>, Mike Travis <travis@sgi.com>, Andi Kleen <andi@firstfloor.org>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Jack Steiner <steiner@sgi.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Yinghai Lu <yinghai@kernel.org>, Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

> +static DECLARE_BITMAP(apicid_map, MAX_LOCAL_APIC) __initdata;
> +static char apicid_list[MAX_LOCAL_APIC] __initdata;

Is MAX_LOCAL_APIC really big enough to print them all in ASCII?

It would be better to not use that large a buffer, but print
in smaller pieces (I realize this would enlarge your patch,
but then it would also save a lot of BSS)

-Andi
