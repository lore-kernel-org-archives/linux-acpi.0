From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 11/11] ACPI: call core init functions explicitly instead of
 using initcalls
Date: Thu, 06 Nov 2008 17:02:25 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811061654540.3106@localhost.localdomain>
References: <20081105231710.26131.3110.stgit@bob.kio>
 <20081105231828.26131.90839.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:47236 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909AbYKFWW1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 17:22:27 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9X00D8CMK2GBO0@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 Nov 2008 16:02:27 -0600 (CST)
In-reply-to: <20081105231828.26131.90839.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org, Zhao Yakui <yakui.zhao@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>


+++ b/drivers/acpi/acpi.h
...
+/* Functions internal to the ACPI core */


I like the patch, except for the creation of drivers/acpi.h
For we've already got too many files called 'acpi.h'...
and Bob is working on a header clean-up as we speak...

Maybe the existing acpi/acpi_drivers.h would be better for these 
declarations?

thanks,
-Len


