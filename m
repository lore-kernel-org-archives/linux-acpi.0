From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: acpi/test panic
Date: Wed, 29 Sep 2010 11:23:46 +0800
Message-ID: <1285730626.5741.0.camel@minggr.sh.intel.com>
References: <4C9FC97F.7030405@oracle.com>
	 <1285550762.5416.30.camel@minggr.sh.intel.com>
	 <4CA010F9.8040804@oracle.com>
	 <1285563934.5416.35.camel@minggr.sh.intel.com>
	 <alpine.LFD.2.00.1009272045260.27732@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:54016 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752863Ab0I2DXC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Sep 2010 23:23:02 -0400
In-Reply-To: <alpine.LFD.2.00.1009272045260.27732@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Yinghai Lu <yinghai.lu@oracle.com>, "Moore, Robert" <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tue, 2010-09-28 at 08:46 +0800, Len Brown wrote:
> > Len,
> > Please merge above code into then commit "ACPICA: Revert "Revert "Enable
> > multi-byte EC transfers".
> 
> done.
> but i've backed out the acpica branch entirely
> because it doesn't boot on my t61
> starting with at this patch:
> 
> ACPICA/ACPI: Add new host interfaces for _OSI support

I'll test t61 and get back to you.

Lin Ming

> 
> thanks,
> -Len Brown, Intel Open Source Technology Center
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


