From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [RESEND PATCH] ACPICA: fix leak of acpi_os_validate_address
Date: Fri, 28 Aug 2009 09:17:09 +0800
Message-ID: <1251422229.3282.22.camel@minggr.sh.intel.com>
References: <1250131948.4044.5.camel@minggr.sh.intel.com>
	 <alpine.LFD.2.00.0908271307240.7792@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:13065 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751022AbZH1BVZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Aug 2009 21:21:25 -0400
In-Reply-To: <alpine.LFD.2.00.0908271307240.7792@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Thomas Renninger <trenn@suse.de>, "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Fri, 2009-08-28 at 01:09 +0800, Len Brown wrote:
> it is easier to apply patches when they do not appear multiple times
> in the e-mail message...
> 
> why does acpi_os_invalidate_address() need a return value other than void?

Just for extension, maybe some future usage.

Lin Ming

> 
> applied to acpi-test
> 
> thanks,
> Len Brown, Intel Open Source Technology Center
> 

