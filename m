From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 4/5] ACPI: remove deprecated ACPI procfs I/F
Date: Fri, 11 Jun 2010 12:06:51 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1006111202430.4096@localhost.localdomain>
References: <1276235281.19052.15874.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:39129 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688Ab0FKQG4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Jun 2010 12:06:56 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L3U00G7OY3G3X41@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 11 Jun 2010 11:06:53 -0500 (CDT)
In-reply-to: <1276235281.19052.15874.camel@rzhang1-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 11 Jun 2010, Zhang Rui wrote:

> 
> 1. Remove some deprecated ACPI procfs I/F, including
>    /proc/acpi/info, /proc/acpi/dsdt, /proc/acpi/fadt.

yay!

> 2. Move the code for sysfs I/F to driver/acpi/sysfs.c.

two patches please: the delete of a user visible function
in the first, and move the code in the second.

thanks,
Len Brown, Intel Open Source Technology Center
