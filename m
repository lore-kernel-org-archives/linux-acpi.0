From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH -next] acpi utmisc: use WARN_ON() instead of warn_on_slowpath()
Date: Mon, 07 Jul 2008 08:19:08 +0200
Message-ID: <4871B55C.7040009@firstfloor.org>
References: <20080701103339.b5acc1f3.randy.dunlap@oracle.com>	<20080701131714.5093fa49.akpm@linux-foundation.org>	<23433248.1214943818230.JavaMail.oracle@acsmt302.oracle.com>	<20080701133535.f92a673c.akpm@linux-foundation.org>	<20080702112852.05f30950.randy.dunlap@oracle.com>	<486BCDDC.1000709@firstfloor.org>	<20080702121424.a3451eae.akpm@linux-foundation.org>	<486BD785.5050207@firstfloor.org>	<20080702124316.61cc76e9.akpm@linux-foundation.org>	<486BE0DA.2090108@firstfloor.org>	<20080702133540.20d578cd.akpm@linux-foundation.org>	<486BEA68.7000801@firstfloor.org>	<20080702140216.334011a4.akpm@linux-foundation.org>	<486BEE0D.3030901@firstfloor.org>	<20080702141459.e6d6feaa.akpm@linux-foundation.org>	<alpine.LFD.1.10.0807061307280.24417@localhost.localdomain> <20080706115221.582e905a@infradea
 d.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:41235 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305AbYGGGTL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jul 2008 02:19:11 -0400
In-Reply-To: <20080706115221.582e905a@infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, randy.dunlap@oracle.com, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org, Ingo Molnar <mingo@elte.hu>

Arjan van de Ven wrote:
> On Sun, 06 Jul 2008 13:18:56 -0400 (EDT)
> Len Brown <lenb@kernel.org> wrote:
>  
>> Arjan tells me that we'll have a real WARN()
>> with prink semantics in 2.6.27 and so we can
>> simplify/standardize this when that happens.
>>
>> Oh, and since I'm on sabbatical, I'm obviously
>> fine with whatever Andi Kleen does (or does not do here)
>> in my absence.
> 
> I'm finishing up the series to introduce (in -mm) and use it
> (various extra patches).. Want me to just include the ACPI part of this
> as well, or do you want to feed that separately?

I'm dropping the ACPI part because we're getting too many
reports of scary looking backtraces and ACPI exceptions are actually
not that exceptional.

-Andi

