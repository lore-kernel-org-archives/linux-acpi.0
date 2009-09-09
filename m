From: Len Brown <lenb@kernel.org>
Subject: Re: ACPICA Release 20090903 linuxized patches
Date: Tue, 08 Sep 2009 22:29:54 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0909082229370.20206@localhost.localdomain>
References: <1252026330.3565.3.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:35422 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbZIIC3z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Sep 2009 22:29:55 -0400
Received: from localhost.localdomain ([74.104.157.165])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KPO00099MXV1R65@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 08 Sep 2009 21:29:58 -0500 (CDT)
In-reply-to: <1252026330.3565.3.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

applied for 2.6.32

thanks,
Len Brown, Intel Open Source Technology Center

On Fri, 4 Sep 2009, Lin Ming wrote:

> Attached.
> 
> Applied cleanly on top of linux-acpi-2.6/test branch.
> Build & Test on 32 & 64 bit machines.
> 
> Lin Ming
> ---
> [PATCH 1/6] ACPICA: Fix extraneous warning if _DSM returns a package
> [PATCH 2/6] ACPICA: Remove error message for Store(Localx,Localx)
> [PATCH 3/6] ACPICA: Fix memory leak for ill-formed Package objects
> [PATCH 4/6] ACPICA: Update _OSI with new Windows OS strings
> [PATCH 5/6] ACPICA: Windows compatibility: autoexecute root _INI method
> [PATCH 6/6] ACPICA: Update version to 20090903.
> 
