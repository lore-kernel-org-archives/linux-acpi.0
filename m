From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH -next] acpi utmisc: use WARN_ON() instead of
 warn_on_slowpath()
Date: Mon, 7 Jul 2008 00:03:20 -0700
Message-ID: <20080707000320.25341603@infradead.org>
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
	<20080706115221.582e905a@infradead.org>
	<4871B55C.7040009@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:33370 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858AbYGGHDo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jul 2008 03:03:44 -0400
In-Reply-To: <4871B55C.7040009@firstfloor.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, randy.dunlap@oracle.com, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org, Ingo Molnar <mingo@elte.hu>

On Mon, 07 Jul 2008 08:19:08 +0200
Andi Kleen <andi@firstfloor.org> wrote:

> I'm dropping the ACPI part because we're getting too many
> reports of scary looking backtraces and ACPI exceptions are actually
> not that exceptional.

when I talked to Len about it he implied/said that these would only
happen for ACPI code bugs (and not bios bugs). Maybe he was
overestimating what the code would actually do; if so it would imo be
well worth splitting out ACPI code assertions versions things that are
BIOS caused (if only to be able to inform the user more consistently)


-- 
If you want to reach me at my work email, use arjan@linux.intel.com
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
