From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v3 1/3] ACPI : introduce macros for using the ACPI specification
 version
Date: Fri, 3 Jul 2015 13:16:35 +0800
Message-ID: <55961AB3.70801@huawei.com>
References: <1435880916-2153-1-git-send-email-al.stone@linaro.org> <1435880916-2153-2-git-send-email-al.stone@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:61983 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbbGCFQ7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Jul 2015 01:16:59 -0400
In-Reply-To: <1435880916-2153-2-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <al.stone@linaro.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, tglx@linutronix.de, jason@lakedaemon.net, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, linaro-kernel@lists.linaro.org, patches@linaro.org

Hi Al,

On 2015/7/3 7:48, Al Stone wrote:
> Add the __ACPI_FADT_SPEC_VERSION() helper macro to build a proper version
> number from a major and minor revision number.  Add also macros that use
> the helper to construct the current version from the values in the FADT
> (i.e., ACPI_FADT_SPEC_VERSION) and both the 5.1 and 6.0 versions.
>
> These macros are added in order to simplify retrieving and comparing ACPI
> specification version numbers, since this is becoming a more frequent need.
> In particular, there are some architectures that require at least a certain
> version of the spec, and there are differences in some structure sizes that
> have changed with recent versions but can only be tracked by spec version
> number.
>
> Fixes: aeb823bbacc2 (ACPICA: ACPI 6.0: Add changes for FADT table.)

If I understand correctly, will it be (and for next two patches as well):

0cff8dc0099f (ACPICA: ACPI 6.0: Add changes for MADT table.)?

FADT table update was not introduce any regressions for ARM64
I think.

Thanks
Hanjun

