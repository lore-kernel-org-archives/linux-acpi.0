From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC PATCH 0/4] add ACPI support for syscon
Date: Wed, 2 Dec 2015 10:50:09 +0000
Message-ID: <20151202105009.GA18981@red-moon>
References: <1449047368-5768-1-git-send-email-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41461 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752466AbbLBKtC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 2 Dec 2015 05:49:02 -0500
Content-Disposition: inline
In-Reply-To: <1449047368-5768-1-git-send-email-wangkefeng.wang@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, linux-arm-kernel@lists.infradead.org

On Wed, Dec 02, 2015 at 05:09:24PM +0800, Kefeng Wang wrote:
> Lots of drivers begin to support both OF and ACPI now, but some drivers depend on syscon,

Define "lots of drivers" please and in the process point me at what
they are, thanks.

> so syscon need to support ACPI firstly.

I do not think so, that's exactly what I do NOT want to happen, namely
rewriting DT management in ACPI _entirely_.

The rules for using _DSD properties are described here:

https://lists.acpica.org/pipermail/dsd/2015-September/000026.html

So, first thing, tell us why you need this patchset and what's its
aim (ie using syscon to control what ?).

Thanks,
Lorenzo

> Add ACPI support for syscon, and introduce syscon_regmap_lookup_by_dev_property()
> helper when the driver need to get a regmap handle from syscon, it can used in
> both OF and ACPI.
> 
> Kefeng Wang (4):
>   acpi: property: Introduce helper acpi_dev_get_reference_device()
>   device property: Introduce helper device_get_reference_node()
>   ACPI/platform: Introduce helper acpi_dev_find_plat_dev()
>   mfd: syscon: add ACPI support
> 
>  drivers/acpi/acpi_platform.c | 25 ++++++++++++++++++++++
>  drivers/acpi/property.c      | 23 ++++++++++++++++++++
>  drivers/base/property.c      | 40 +++++++++++++++++++++++++++++++++++
>  drivers/mfd/syscon.c         | 50 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h         | 13 ++++++++++++
>  include/linux/mfd/syscon.h   |  8 +++++++
>  include/linux/property.h     |  6 ++++++
>  7 files changed, 165 insertions(+)
> 
> -- 
> 1.7.12.4
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
