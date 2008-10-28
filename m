From: Len Brown <lenb@kernel.org>
Subject: Re: If "acpi_osi=Linux" works better,
 please notify linux-acpi@vger.kernel.org
Date: Tue, 28 Oct 2008 01:14:26 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810280112090.24123@localhost.localdomain>
References: <48FEC05C.4050600@kaalverink.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:42653 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752213AbYJ1FO2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Oct 2008 01:14:28 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9F00MZ4NW3UHME@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 28 Oct 2008 00:14:28 -0500 (CDT)
In-reply-to: <48FEC05C.4050600@kaalverink.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tom Kaalverink <tom@kaalverink.net>
Cc: linux-acpi@vger.kernel.org



On Wed, 22 Oct 2008, Tom Kaalverink wrote:

> I have aspi_osi=Linux tried and thinks look better this way.
> I saw this message in the /var/log/messages.
> 
> My operating system : Ubuntu 8.10
> 
> [    0.496839] ACPI: DMI System Vendor: Dell Inc.
> [    0.496840] ACPI: DMI Product Name: Inspiron 1721
> [    0.496842] ACPI: DMI Product Version:
> [    0.496843] ACPI: DMI Board Name: 0UK441
> [    0.496845] ACPI: DMI BIOS Vendor: Dell Inc.
> [    0.496846] ACPI: DMI BIOS Date: 04/21/2008

Exactly how do things look better with acpi_osi=Linux?

Please open a bugzilla.kernel.org entry against ACPI,
assign it to len.brown@intel.com, and attach the full
dmesg with and without acpi_osi=Linux, plus (just one copy)
of the ouput from acpidump.

thanks,
-Len

