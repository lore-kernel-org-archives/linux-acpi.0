From: Andrew Morton <akpm@linux-foundation.org>
Subject: Fw: ACPI: Avoid bogus EC timeout when EC is in Polling mode
Date: Fri, 19 Sep 2008 13:29:18 -0700
Message-ID: <20080919132918.342efbcb.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60983 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754137AbYISU3k (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Sep 2008 16:29:40 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: stable@kernel.org
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, Zhang Rui <rui.zhang@intel.com>, Andi Kleen <andi@firstfloor.org>, Robert Epprecht <epprecht@solnet.ch>


In http://bugzilla.kernel.org/show_bug.cgi?id=11594, Robert points out
that this fix should be backported into 2.6.26.x.




Begin forwarded message:

Date: Fri, 15 Aug 2008 17:00:31 GMT
From: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: git-commits-head@vger.kernel.org
Subject: ACPI: Avoid bogus EC timeout when EC is in Polling mode


Gitweb:     http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=9d699ed92a459cb408e2577e8bbeabc8ec3989e1
Commit:     9d699ed92a459cb408e2577e8bbeabc8ec3989e1
Parent:     2500822bf4eb0179ef80e5b072c1e0fa83037381
Author:     Zhao Yakui <yakui.zhao@intel.com>
AuthorDate: Mon Aug 11 10:33:31 2008 +0800
Committer:  Andi Kleen <ak@linux.intel.com>
CommitDate: Fri Aug 15 03:13:06 2008 +0200

    ACPI: Avoid bogus EC timeout when EC is in Polling mode
    
    When EC is in Polling mode, OS will check the EC status continually by using
    the following source code:
           clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
           while (time_before(jiffies, delay)) {
                   if (acpi_ec_check_status(ec, event))
           	            return 0;
                   msleep(1);
           }
    But msleep is realized by the function of schedule_timeout. At the same time
    although one process is already waken up by some events, it won't be scheduled
    immediately. So maybe there exists the following phenomena:
         a. The current jiffies is already after the predefined jiffies.
    	But before timeout happens, OS has no chance to check the EC
    	status again.
         b. If preemptible schedule is enabled, maybe preempt schedule will happen
    	before checking loop. When the process is resumed again, maybe
    	timeout already happens, which means that OS has no chance to check
    	the EC status.
    
    In such case maybe EC status is already what OS expects when timeout happens.
    But OS has no chance to check the EC status and regards it as AE_TIME.
    
    So it will be more appropriate that OS will try to check the EC status again
    when timeout happens. If the EC status is what we expect, it won't be regarded
    as timeout. Only when the EC status is not what we expect, it will be regarded
    as timeout, which means that EC controller can't give a response in time.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=9823
    http://bugzilla.kernel.org/show_bug.cgi?id=11141
    
    Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
    Signed-off-by: Zhang Rui  <rui.zhang@intel.com>
    Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 drivers/acpi/ec.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 76784ae..13593f9 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -221,6 +221,8 @@ static int acpi_ec_wait(struct acpi_ec *ec, enum ec_event event, int force_poll)
 				return 0;
 			msleep(1);
 		}
+		if (acpi_ec_check_status(ec,event))
+			return 0;
 	}
 	pr_err(PREFIX "acpi_ec_wait timeout, status = 0x%2.2x, event = %s\n",
 		acpi_ec_read_status(ec),
--
To unsubscribe from this list: send the line "unsubscribe git-commits-head" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
