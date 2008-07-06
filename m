From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH -next] acpi utmisc: use WARN_ON() instead of warn_on_slowpath()
Date: Sun, 06 Jul 2008 20:13:34 +0200
Message-ID: <48710B4E.5020408@firstfloor.org>
References: <20080701103339.b5acc1f3.randy.dunlap@oracle.com> <20080701131714.5093fa49.akpm@linux-foundation.org> <23433248.1214943818230.JavaMail.oracle@acsmt302.oracle.com> <20080701133535.f92a673c.akpm@linux-foundation.org> <20080702112852.05f30950.randy.dunlap@oracle.com> <486BCDDC.1000709@firstfloor.org> <20080702121424.a3451eae.akpm@linux-foundation.org> <486BD785.5050207@firstfloor.org> <20080702124316.61cc76e9.akpm@linux-foundation.org> <486BE0DA.2090108@firstfloor.org> <20080702133540.20d578cd.akpm@linux-foundation.org> <486BEA68.7000801@firstfloor.org> <20080702140216.334011a4.akpm@linux-foundation.org> <486BEE0D.3030901@firstfloor.org> <20080702141459.e6d6feaa.akpm@linux-foundation.org> <alpine.LFD.1.10.0807061307280.24417@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:56033 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758265AbYGFSNk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Jul 2008 14:13:40 -0400
In-Reply-To: <alpine.LFD.1.10.0807061307280.24417@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, randy.dunlap@oracle.com, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>

Len Brown wrote:

> Ingo pointed out that automated testing wasn't finding
> ACPI exceptions because we were not using the standard
> Linux format for oops etc.

Sounds more like a case of more the automated testing
needing fixing than the kernel. I'll just remove it.

> I put this hack patch on the debug-test branch in the acpi tree,
> and pulled it into the test branch for linux-next to mine
> for previously ignored errors.
> 
> This commit isn't intended for 2.6.27.
> (and thus is not on the release-2.6.27 branch)
> hopefully that isn't abuse of linux-next...
> 
> Arjan tells me that we'll have a real WARN()
> with prink semantics in 2.6.27 and so we can
> simplify/standardize this when that happens.
> 
> Oh, and since I'm on sabbatical, I'm obviously
> fine with whatever Andi Kleen does (or does not do here)
> in my absence.

Thanks for the clarification, Len. I was already puzzling
why that was changed.

And no need to watch your email that closely...

-Andi

