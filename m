From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [PATCH] ACPI: replace acpi_integer by u64
Date: Thu, 28 Jan 2010 14:42:49 +0800
Message-ID: <1264660969.25564.30.camel@minggr.sh.intel.com>
References: <1264647199.25564.18.camel@minggr.sh.intel.com>
	 <alpine.LFD.2.00.1001280148530.8886@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:59563 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751616Ab0A1G7P (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Jan 2010 01:59:15 -0500
In-Reply-To: <alpine.LFD.2.00.1001280148530.8886@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Thu, 2010-01-28 at 14:49 +0800, Len Brown wrote:
> do we want to delete it from actypes.h in this patch too?

No, 

ACPICA code base has retained this typedef for compatibility with
existing device driver code in other OS.

So let's keep consistent with ACPICA code base.

Lin Ming

> 
> 
> applied to acpi-test.
> 
> thanks,
> Len Brown, Intel Open Source Technology Center
> 

