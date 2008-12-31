From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/8] ACPI: ACPI table management enhencement
Date: Wed, 31 Dec 2008 18:58:32 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812311856520.3854@localhost.localdomain>
References: <1229673457.562.132.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:48491 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756301AbYLaX6h (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Dec 2008 18:58:37 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KCR00A8OMLMXMT6@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 31 Dec 2008 17:58:35 -0600 (CST)
In-reply-to: <1229673457.562.132.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

On Fri, 19 Dec 2008, Zhang Rui wrote:

> Hi all,
> 
> this patch set is an ACPI table management enhancement.
> 
> Patch 01 adds the new sysfs I/F for ACPI dynamic tables.
> now dynamic ACPI tables can be get at
> /sys/firmware/acpi/tables/dynamic/...
> 
> Patch 02 ~ 08 introduce the ACPI inactive table management.
> Here inactive table means the table that is pointed to by
> the inactive root table, e.g RSDT if Linux is using XSDT.
> Detailed introduction of each patch is in the change log.

I recall trying out a previous version of this series,
and I'd like to try out this version, but I'm having
trouble getting it to apply.  What tree is it based on?
(2.6.28 would be a good choice, or the acpica branch)

thanks,
-- Len Brown, Intel Open Source Technology Center
