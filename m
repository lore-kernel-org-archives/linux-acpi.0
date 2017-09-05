From: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Subject: Re: [RFC 4/4] ACPI: Enable PPTT support on ARM64
Date: Tue, 5 Sep 2017 15:22:11 +0800
Message-ID: <397f2aa0-b7d9-dc63-0410-6afacee26571@huawei.com>
References: <20170805001159.12769-1-jeremy.linton@arm.com>
 <20170805001159.12769-5-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:5537 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbdIEHeo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Sep 2017 03:34:44 -0400
In-Reply-To: <20170805001159.12769-5-jeremy.linton@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, linux-acpi@vger.kernel.org, hanjun.guo@linaro.org, sudeep.holla@arm.com

Hi Jeremy,

On 2017/8/5 8:11, Jeremy Linton wrote:
> Now that we have a parser, and arm64 has appropriate
> hooks in place to utilize it, lets enable PPTT
> parsing in the arm64 ACPI build.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/acpi/arm64/Kconfig  | 3 +++
>  drivers/acpi/arm64/Makefile | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
> index 5a6f80f..74b855a 100644
> --- a/drivers/acpi/arm64/Kconfig
> +++ b/drivers/acpi/arm64/Kconfig
> @@ -7,3 +7,6 @@ config ACPI_IORT
>  
>  config ACPI_GTDT
>  	bool
> +
> +config ACPI_PPTT
> +	bool

We may need to select ACPI_PPTT in arch/arm64/Kconfig, just like ACPI_GTDT

> \ No newline at end of file
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> index 1017def..b6dee6b 100644
> --- a/drivers/acpi/arm64/Makefile
> +++ b/drivers/acpi/arm64/Makefile
> @@ -1,2 +1,3 @@
>  obj-$(CONFIG_ACPI_IORT) 	+= iort.o
>  obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
> +obj-$(CONFIG_ACPI_GTDT) 	+= pptt.o
obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
> 


Thanks,
Xiongfeng Wang

