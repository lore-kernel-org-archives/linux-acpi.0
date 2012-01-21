From: Huang Ying <ying.huang@intel.com>
Subject: Re: [patch] ACPI, APEI, EINJ, cleanup 0 vs NULL confusion
Date: Sat, 21 Jan 2012 08:12:06 +0800
Message-ID: <1327104726.7922.8.camel@yhuang-dev>
References: <20120120075714.GD2295@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:57847 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756182Ab2AUAML (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Jan 2012 19:12:11 -0500
In-Reply-To: <20120120075714.GD2295@elgon.mountain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org

On Fri, 2012-01-20 at 10:57 +0300, Dan Carpenter wrote:
> This function is returning pointers.  Sparse complains here:
> drivers/acpi/apei/einj.c:262:32: warning:
> 	Using plain integer as NULL pointer
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Huang Ying <ying.huang@intel.com>

Best Regards,
Huang Ying

