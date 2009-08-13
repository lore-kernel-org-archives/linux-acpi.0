From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [RESEND PATCH] ACPICA: fix leak of acpi_os_validate_address
Date: Thu, 13 Aug 2009 11:25:41 +0800
Message-ID: <1250133941.4044.20.camel@minggr.sh.intel.com>
References: <1250131948.4044.5.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:63936 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752591AbZHMD31 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Aug 2009 23:29:27 -0400
In-Reply-To: <1250131948.4044.5.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Thomas Renninger <trenn@suse.de>, "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Thu, 2009-08-13 at 10:52 +0800, Lin Ming wrote:
> From: Lin Ming <ming.m.lin@intel.com>
> Date: Thu, 13 Aug 2009 10:43:27 +0800
> Subject: [PATCH] ACPICA: fix leak of acpi_os_validate_address
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=13620
> 
> If the dynamic region is created and added to resource list over and over again,
> it has the potential to be a memory leak by growing the list every time.
> 
> This patch fixes the memory leak, as below
> 
> 1) add a new field "count" to struct acpi_res_list.
> 
>    When inserting, if the region(addr, len) is already in the resource
>    list, we just increase "count", otherwise, the region is inserted
>    with count=1.
> 
>    When deleting, the "count" is decreased, if it's decreased to 0,
>    the region is deleted from the resource list.
> 
>    With "count", the region with same address and length can only be
>    inserted to the resource list once, so prevent potential memory leak.
> 
> 2) add a new function acpi_os_invalidate_address, which is called when
>    region is deleted.
> 
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>

Forgot to mention that it's applied on top of 2.6.31-rc5.

Lin Ming

