From: Len Brown <lenb@kernel.org>
Subject: Re: ACPI exception with 2.6.29-rc6
Date: Mon, 23 Feb 2009 21:30:44 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0902232128340.16923@localhost.localdomain>
References: <871vtpqex0.wl%htd@fancy-poultry.org>
 <20090223150749.0b284ba2.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:45386 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791AbZBXCbW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Feb 2009 21:31:22 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KFJ007U4TNHAKSS@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 23 Feb 2009 20:30:58 -0600 (CST)
In-reply-to: <20090223150749.0b284ba2.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Heinz Diehl <htd@fancy-poultry.org>, linux-kernel@vger-kernel.org, linux-acpi@vger.kernel.org



> > --> <3>ACPI: Denied BIOS AML access to invalid port 0x4d0+0x2 (ELCR)
> > --> <4>ACPI Exception (dsopcode-0419): AE_AML_ILLEGAL_ADDRESS, During address validation of OpRegion [ELCR] [20081204]

Heinz,
Thanks for the note.
Please attach the output of acpidump here:

http://bugzilla.kernel.org/show_bug.cgi?id=12758

Also, if this system has both pic and IOAPIC mode,
it would be interesting to try booting it in both,
eg with "noapic".

thanks,
-Len

