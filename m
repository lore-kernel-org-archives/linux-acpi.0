From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH -next] acpi utmisc: use WARN_ON() instead of
 warn_on_slowpath()
Date: Sun, 06 Jul 2008 13:18:56 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0807061307280.24417@localhost.localdomain>
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
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:47918 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbYGFRTu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Jul 2008 13:19:50 -0400
In-reply-to: <20080702141459.e6d6feaa.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andi Kleen <andi@firstfloor.org>, randy.dunlap@oracle.com, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>


for background...

Ingo pointed out that automated testing wasn't finding
ACPI exceptions because we were not using the standard
Linux format for oops etc.

I put this hack patch on the debug-test branch in the acpi tree,
and pulled it into the test branch for linux-next to mine
for previously ignored errors.

This commit isn't intended for 2.6.27.
(and thus is not on the release-2.6.27 branch)
hopefully that isn't abuse of linux-next...

Arjan tells me that we'll have a real WARN()
with prink semantics in 2.6.27 and so we can
simplify/standardize this when that happens.

Oh, and since I'm on sabbatical, I'm obviously
fine with whatever Andi Kleen does (or does not do here)
in my absence.

thanks,
-Len


commit 9e030ab0bffdc8b6d8be663b639bd5e2374537f0
Author: Len Brown <len.brown@intel.com>
Date:   Tue Jun 24 22:47:09 2008 -0400

    ACPI: add standard linux WARN_ON() output to ACPI errors and 
exceptions
    
    In linux-2.6.27, we expect WARN() with printk semantics
    to become available, and we'll be able to simplify
    this code.
    
    Signed-off-by: Len Brown <len.brown@intel.com>
