From: Andi Kleen <andi@firstfloor.org>
Subject: State of the ACPI tree
Date: Thu, 4 Sep 2008 21:30:11 +0200
Message-ID: <20080904193011.GA23256@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:54969 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546AbYIDTaM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Sep 2008 15:30:12 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, lenb@kernel.org


Latest state of the ACPI tree

I have everthing merged up that was on my backlog (sorry for being
a little slow last week; I was also busy with other projects) 

The latest merge with bug fixes to Linus just went out as
can be seen on the mailing list.

git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-acpi-2.6 release-2.6.27

Everything else I had pending I merged into the test tree 
targetted for 2.6.28

git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-acpi-2.6 test

I don't have anything pending anymore.

The plan is to pass the tree back over to Len Brown on Friday.

If you have any patches submitted to me that you think should
be in test, but aren't, then please resubmitted them
to Len.

Some more testing of the test tree would be appreciated. One
concern is that there's quite a lot of stuff in there that's
not well tested. 

-Andi

-- 
ak@linux.intel.com
