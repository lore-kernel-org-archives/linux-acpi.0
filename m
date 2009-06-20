From: Len Brown <lenb@kernel.org>
Subject: Re: 2.6.30-git14 -- ACPI Exception: AE_TIME,
 Returned by Handler for  [EmbeddedControl] 20090521 evregion-424
Date: Sat, 20 Jun 2009 01:00:07 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0906200056110.15529@localhost.localdomain>
References: <a44ae5cd0906191451l3c7c1aady443d860bd3b593ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:59174 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbZFTFAL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 20 Jun 2009 01:00:11 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KLI003TTTW9IRI1@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 20 Jun 2009 00:00:10 -0500 (CDT)
In-reply-to: <a44ae5cd0906191451l3c7c1aady443d860bd3b593ca@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Miles Lane <miles.lane@gmail.com>
Cc: linux-acpi@vger.kernel.org, Alexey Starikovskiy <astarikovskiy@suse.de>

Miles,
do you observe any functional issues, or are the error messages themselves 
the problem?

Did you see this in 2.6.30?

Does it go away if you revert the latest ACPICA update?
htp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/2.6.30/acpi-acpica-20090521-2.6.30-rc7.diff.gz


thanks,
Len Brown, Intel Open Source Technology Center

