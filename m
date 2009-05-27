From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 6/6] ACPI: eeepc-laptop: use .notify method instead of
 installing handler directly
Date: Wed, 27 May 2009 18:47:39 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905271844400.25587@localhost.localdomain>
References: <20090430153419.12628.91088.stgit@bob.kio>
 <20090430153603.12628.46200.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:10697 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754997AbZE0XCz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 May 2009 19:02:55 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKB002Y6RBGCNB0@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 27 May 2009 17:47:41 -0500 (CDT)
In-reply-to: <20090430153603.12628.46200.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Karol Kozimor <sziwan@users.sourceforge.net>, Corentin Chary <corentincj@iksaif.net>, acpi4asus-user@lists.sourceforge.net, linux-acpi@vger.kernel.org, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Matthew Garrett <mjg@redhat.com>

This one conflicts with recent addition of 
eeepc_register_rfkill_notifier()

thanks,
Len Brown, Intel Open Source Technology Center

