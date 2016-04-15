From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH 3/3] arm64: defconfig: Enable ACPI
Date: Fri, 15 Apr 2016 17:04:55 +0800
Message-ID: <5710AEB7.4050108@huawei.com>
References: <1460706823-16566-1-git-send-email-broonie@kernel.org>
 <1460706823-16566-3-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:54159 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490AbcDOJFQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Apr 2016 05:05:16 -0400
In-Reply-To: <1460706823-16566-3-git-send-email-broonie@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Len Brown <lenb@kernel.org>, Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Steve Capper <steve.capper@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, arm@kernel.org

On 2016/4/15 15:53, Mark Brown wrote:
> Enable ACPI by default to support testing of ACPI only systems and
> ensure that defconfig will boot on anything, for arm64 this is not done
> in Kconfig since a very large proportion of arm64 systems have no ACPI
> at all.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>


Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun

