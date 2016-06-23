From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH update v7 15/15] acpi, numa: Enable ACPI based NUMA on ARM64
Date: Thu, 23 Jun 2016 02:37:37 +0200
Message-ID: <1598980.X3hO0A0n7q@vostro.rjw.lan>
References: <1466135582-37520-1-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:62543 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750777AbcFWAdS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Jun 2016 20:33:18 -0400
In-Reply-To: <1466135582-37520-1-git-send-email-guohanjun@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Robert Richter <rrichter@cavium.com>, David Daney <david.daney@cavium.com>

On Friday, June 17, 2016 11:53:02 AM Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
> 
> Add function needed for cpu to node mapping, and enable ACPI based
> NUMA for ARM64 in Kconfig
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> [david.daney@cavium.com added ACPI_NUMA default to y for ARM64]
> Signed-off-by: David Daney <david.daney@cavium.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
> 
> update version:
> Address the comment from Matthias which was wrongly set srat_proc[1]
> but should be srat_proc[2].
> 
> Rafael, this patch is beased on your linux-next branch.

Applied, thanks!

