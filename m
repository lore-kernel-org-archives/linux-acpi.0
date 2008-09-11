From: Yves-Alexis Perez <corsac@corsac.net>
Subject: Re: linux-acpi-2.6/test on Thinkpad T61: Battery Absent
Date: Thu, 11 Sep 2008 23:25:51 +0200
Message-ID: <1221167774.4080.0.camel@hidalgo>
References: <1221027769.3958.1.camel@hidalgo>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from molly.corsac.net ([81.57.48.219]:35227 "EHLO molly.corsac.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753000AbYIKVZl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Sep 2008 17:25:41 -0400
Received: from hidalgo.corsac.net (hidalgo.corsac.net [IPv6:2002:5139:30db:0:213:e8ff:fedc:ffab])
	by molly.corsac.net (Postfix) with ESMTP id 9323F82D1F
	for <linux-acpi@vger.kernel.org>; Thu, 11 Sep 2008 23:25:38 +0200 (CEST)
In-Reply-To: <1221027769.3958.1.camel@hidalgo>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yves-Alexis Perez <corsac@debian.org>
Cc: Zhao Yakui <yakui.zhao@intel.com>, Andi Kleen <ak@linux.intel.com>

On mer, 2008-09-10 at 08:22 +0200, Yves-Alexis Perez wrote:
> My tree is at faca89759dd7d4d87309f56cd09ae885a296fb4c and I'll try to
> bisect.

Ok, playing with git bisect, it seems the offending commit is:

50c0f43ff1199bbea5f0418d40df32f4d4029b13 is first bad commit
commit 50c0f43ff1199bbea5f0418d40df32f4d4029b13
Author: Andi Kleen <ak@linux.intel.com>
Date:   Thu Sep 4 15:13:29 2008 +0200

    ACPI: EC: do transaction from interrupt context
    
    From: Alexey Starikovskiy <astarikovskiy@suse.de>
    
    It is easier and faster to do transaction directly from interrupt
context
    rather than waking control thread.
    Also, cleaner GPE storm avoidance is implemented.
    
    AK: Merged with earlier io port patch
    
    Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
    Signed-off-by: Andi Kleen <ak@linux.intel.com>

:040000 040000 5b8664bf958e6455709348a1a52a14a92dd3119c
7d8ecce115fec5dd1e808fc345b8724def2ad606 M      drivers

Not sure exactly what the problem is, though.

Cheers,
-- 
Yves-Alexis
