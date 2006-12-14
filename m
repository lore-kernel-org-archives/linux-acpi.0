From: Andrew Morton <akpm@osdl.org>
Subject: acpi git versus x86_64 tree
Date: Thu, 14 Dec 2006 15:37:50 -0800
Message-ID: <20061214153750.b70744ad.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:42526 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751979AbWLNXiA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Dec 2006 18:38:00 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>, Andi Kleen <ak@suse.de>
Cc: linux-acpi@vger.kernel.org


I have problems here.  A large update has recently gone into the acpi devel
tree which trashes a lot of the acpi patches which I have thus far been
unable to get Len to pay attention to.  It also trashes a large number of
x86_64 patches which I have thus far been unable to get Andi to pay
attention to.

Having torn my hair out for a while I've decided to revert to yesterday's
version of the ACPI tree and I shall stop updating it.  This enables me to
at least maintain the x86_64 patches.

If/when Andi merges those x86_64 patches we have a huge conflict
outstanding between the acpi and x86_64 trees.  Whoever merges with Linus
second will lose, big-time.  Basically their work will need to be dropped
and redone.

The moral here is simple: x86_64 patches go through the x86_64 maintainer. 
Please do not attempt to maintain foreign patches in the acpi tree.


Oh, and I am getting *extremely* tired of sending patches to maintainers
over and over and over and over again, and receiving no response at all. 
And then eventually seeing them merge other patches which trash the patches
which I'm maintaining for them, and which they have previously ignored.


