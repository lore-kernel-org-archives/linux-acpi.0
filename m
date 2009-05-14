From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 5/7] eeepc-laptop: Register as a pci-hotplug device
Date: Thu, 14 May 2009 11:33:13 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905141129110.19537@localhost.localdomain>
References: <1240817023-5985-1-git-send-email-corentincj@iksaif.net>
 <1240817023-5985-2-git-send-email-corentincj@iksaif.net>
 <1240817023-5985-3-git-send-email-corentincj@iksaif.net>
 <1240817023-5985-4-git-send-email-corentincj@iksaif.net>
 <1240817023-5985-5-git-send-email-corentincj@iksaif.net>
 <1240817023-5985-6-git-send-email-corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:33807 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbZENPdq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 May 2009 11:33:46 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KJN00F7P4JGM0ZE@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 14 May 2009 10:33:25 -0500 (CDT)
In-reply-to: <1240817023-5985-6-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentincj@iksaif.net>
Cc: linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Garrett <mjg@redhat.com>

applied to acpi-test

If it is common, then we should push for .30.
If it is not common, then since it is larger
than most -rc5 bugfixes, I'd prefer to wait for .31,
even though it is driver specific.

please advise.

thanks,
Len Brown, Intel Open Source Technology Center

