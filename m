From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI / property: fix compile error for
 acpi_node_get_property_reference() when CONFIG_ACPI=n
Date: Wed, 2 Dec 2015 11:10:41 +0200
Message-ID: <20151202091041.GK1593@lahna.fi.intel.com>
References: <1449042262-11052-1-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:3308 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757574AbbLBJKs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 2 Dec 2015 04:10:48 -0500
Content-Disposition: inline
In-Reply-To: <1449042262-11052-1-git-send-email-guohanjun@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Kejian Yan <yankejian@huawei.com>, Hanjun Guo <hanjun.guo@linaro.org>

On Wed, Dec 02, 2015 at 03:44:22PM +0800, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
> 
> In commit 60ba032ed76e ("ACPI / property: Drop size_prop from
> acpi_dev_get_property_reference()"), the argument "const char *cells_name"
> was dropped, but forgot to update the stub function in no-ACPI case,
> it will lead to compile error when CONFIG_ACPI=n, easliy remove
> "const char *cells_name" to fix it.
> 
> Reported-by: Kejian Yan <yankejian@huawei.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
