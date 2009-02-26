From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: introduce sysfs I/F for dynamic tables
Date: Thu, 26 Feb 2009 01:09:08 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0902260108100.2987@localhost.localdomain>
References: <1235618843.32297.140.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:62459 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544AbZBZGJM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Feb 2009 01:09:12 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KFN00FUHT3954P4@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 26 Feb 2009 00:09:10 -0600 (CST)
In-reply-to: <1235618843.32297.140.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org


> SSDT tables may be loaded at runtime.
> create sysfs I/F for these dynamic tables in /sys/firmware/acpi/tables/dynamic/.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/system.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 47 insertions(+), 2 deletions(-)
> 

works for me:-)

applied.

thanks,
Len Brown, Intel Open Source Technology Center

