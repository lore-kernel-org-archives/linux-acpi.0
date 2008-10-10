From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 2/5] revert
 "ACPI: EC: do transaction from interrupt context"
Date: Fri, 10 Oct 2008 12:55:18 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810101254370.7059@localhost.localdomain>
References: <200809222137.m8MLbWtp031005@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:57151 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758822AbYJJQzW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Oct 2008 12:55:22 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K8J00F4S8C8XYS3@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 10 Oct 2008 11:55:21 -0500 (CDT)
In-reply-to: <200809222137.m8MLbWtp031005@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, ak@linux.intel.com, astarikovskiy@suse.de, bzolnier@gmail.com



On Mon, 22 Sep 2008, akpm@linux-foundation.org wrote:

> From: Andrew Morton <akpm@linux-foundation.org>
> 
> Revert
> 
>     commit 50c0f43ff1199bbea5f0418d40df32f4d4029b13
>     Author: Andi Kleen <ak@linux.intel.com>
>     Date:   Thu Sep 4 15:13:29 2008 +0200
>     
>         ACPI: EC: do transaction from interrupt context
>         
>         From: Alexey Starikovskiy <astarikovskiy@suse.de>
>         
>         It is easier and faster to do transaction directly from interrupt context
>         rather than waking control thread.
>         Also, cleaner GPE storm avoidance is implemented.
>         
>         AK: Merged with earlier io port patch
>         
>         Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
>         Signed-off-by: Andi Kleen <ak@linux.intel.com>
> 
> 
> due to a regression reported by Bart.
> 

Andrew,
This one was reverted from my tree a few weeks ago, and replaced with 
this:

Author: Alexey Starikovskiy <astarikovskiy@suse.de>  2008-09-25 13:00:31
Committer: Len Brown <len.brown@intel.com>  2008-09-25 16:23:03
Parent: 72d31053f62c4bc464c2783974926969614a8649 (Linux 2.6.27-rc7)
Child:  8463200a00fe2aea938b40173198a0983f2929ef (ACPI: EC: Rename some 
variables)
Branches: ec, eeepc, release, test
Follows: v2.6.27-rc7
Precedes: 

    ACPI: EC: do transaction from interrupt context
    
    It is easier and faster to do transaction directly from interrupt 
context
    rather than waking control thread.
    Also, cleaner GPE storm avoidance is implemented.
    References: 	http://bugzilla.kernel.org/show_bug.cgi?id=9998
    		http://bugzilla.kernel.org/show_bug.cgi?id=10724
    		http://bugzilla.kernel.org/show_bug.cgi?id=10919
    		http://bugzilla.kernel.org/show_bug.cgi?id=11309
    		http://bugzilla.kernel.org/show_bug.cgi?id=11549
    Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
    Tested-by: Sitsofe Wheeler <sitsofe@yahoo.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

