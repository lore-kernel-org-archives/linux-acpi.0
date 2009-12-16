From: Len Brown <lenb@kernel.org>
Subject: Re: Dock OOPSing with recent acpi-test
Date: Wed, 16 Dec 2009 04:34:51 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912160433240.30935@localhost.localdomain>
References: <200911180958.34121.dmitry.torokhov@gmail.com>
 <alpine.LFD.2.00.0912160130310.30935@localhost.localdomain>
 <20091216064525.GB20352@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:56388 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933888AbZLPJey (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 04:34:54 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ00CUTNY4UO7A@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 03:34:53 -0600 (CST)
In-reply-to: <20091216064525.GB20352@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-acpi@vger.kernel.org


> Queueing up a patch for Len now.

fixed merged into new version of this patch

commit f69cfdd24ac40ab7bbd00d6ad85e003da755e3a0
Author: Alex Chiang <achiang@hp.com>
Date:   Mon Oct 19 15:14:29 2009 -0600

    ACPI: dock: combine add|alloc_dock_dependent_device (v2)


which is in the current acpi tree's dock, release, and test branches.

thanks,
-Len Brown, Intel Open Source Technology Center

