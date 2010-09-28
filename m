From: Len Brown <lenb@kernel.org>
Subject: Re: acpi/test panic
Date: Mon, 27 Sep 2010 20:46:50 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009272045260.27732@localhost.localdomain>
References: <4C9FC97F.7030405@oracle.com>
 <1285550762.5416.30.camel@minggr.sh.intel.com>  <4CA010F9.8040804@oracle.com>
 <1285563934.5416.35.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:40563 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752314Ab0I1ArJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Sep 2010 20:47:09 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L9F00CDSM65K4K3@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 27 Sep 2010 19:46:59 -0500 (CDT)
In-reply-to: <1285563934.5416.35.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Yinghai Lu <yinghai.lu@oracle.com>, "Moore, Robert" <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

> Len,
> Please merge above code into then commit "ACPICA: Revert "Revert "Enable
> multi-byte EC transfers".

done.
but i've backed out the acpica branch entirely
because it doesn't boot on my t61
starting with at this patch:

ACPICA/ACPI: Add new host interfaces for _OSI support

thanks,
-Len Brown, Intel Open Source Technology Center
