From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH -next] acpi utmisc: use WARN_ON() instead of
 warn_on_slowpath()
Date: Sun, 6 Jul 2008 11:52:21 -0700
Message-ID: <20080706115221.582e905a@infradead.org>
References: <20080701103339.b5acc1f3.randy.dunlap@oracle.com>
	<20080701131714.5093fa49.akpm@linux-foundation.org>
	<23433248.1214943818230.JavaMail.oracle@acsmt302.oracle.com>
	<20080701133535.f92a673c.akpm@linux-foundation.org>
	<20080702112852.05f30950.randy.dunlap@oracle.com>
	<486BCDDC.1000709@firstfloor.org>
	<20080702121424.a3451eae.akpm@linux-foundation.org>
	<486BD785.5050207@firstfloor.org>
	<20080702124316.61cc76e9.akpm@linux-foundation.org>
	<486BE0DA.2090108@firstfloor.org>
	<20080702133540.20d578cd.akpm@linux-foundation.org>
	<486BEA68.7000801@firstfloor.org>
	<20080702140216.334011a4.akpm@linux-foundation.org>
	<486BEE0D.3030901@firstfloor.org>
	<20080702141459.e6d6feaa.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0807061307280.24417@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:38749 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756008AbYGFSxE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Jul 2008 14:53:04 -0400
In-Reply-To: <alpine.LFD.1.10.0807061307280.24417@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, randy.dunlap@oracle.com, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org, Ingo Molnar <mingo@elte.hu>

On Sun, 06 Jul 2008 13:18:56 -0400 (EDT)
Len Brown <lenb@kernel.org> wrote:
 
> Arjan tells me that we'll have a real WARN()
> with prink semantics in 2.6.27 and so we can
> simplify/standardize this when that happens.
> 
> Oh, and since I'm on sabbatical, I'm obviously
> fine with whatever Andi Kleen does (or does not do here)
> in my absence.

I'm finishing up the series to introduce (in -mm) and use it
(various extra patches).. Want me to just include the ACPI part of this
as well, or do you want to feed that separately?
