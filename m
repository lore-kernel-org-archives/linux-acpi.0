From: Shannon Zhao <zhaoshenglong@huawei.com>
Subject: Re: [PATCH v9 20/21] Documentation: ACPI for ARM64
Date: Fri, 27 Feb 2015 18:53:06 +0800
Message-ID: <54F04C92.6010206@huawei.com>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org> <1424853601-6675-21-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:5223 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394AbbB0Kxg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Feb 2015 05:53:36 -0500
In-Reply-To: <1424853601-6675-21-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Al Stone <al.stone@linaro.org>, "Huangpeng (Peter)" <peter.huangpeng@huawei.com>

On 2015/2/25 16:40, Hanjun Guo wrote:
> From: Graeme Gregory <graeme.gregory@linaro.org>
> 
> Add documentation for the guidelines of how to use ACPI
> on ARM64.
> 
> Reviewed-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Reviewed-by: Yi Li <phoenix.liyi@huawei.com>
> Reviewed-by: Mark Langsdorf <mlangsdo@redhat.com>
> Reviewed-by: Ashwin Chaugule <ashwinc@codeaurora.org>
> Acked-by: Robert Richter <rrichter@cavium.com>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Al Stone <al.stone@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  Documentation/arm64/arm-acpi.txt | 506 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 506 insertions(+)
>  create mode 100644 Documentation/arm64/arm-acpi.txt
> 
> diff --git a/Documentation/arm64/arm-acpi.txt b/Documentation/arm64/arm-acpi.txt
> new file mode 100644
> index 0000000..24cf832
> --- /dev/null
> +++ b/Documentation/arm64/arm-acpi.txt
> @@ -0,0 +1,506 @@
> +ACPI on ARMv8 Servers
> +---------------------
> +ACPI can be used for ARMv8 general purpose servers designed to follow
> +the ARM SBSA (Server Base System Architecture) [0] and SBBR (Server
> +Base Boot Requirements) [1] specifications.  Please note that the SBBR
> +can be retrieved simply by visiting [1], but the SBSA is currently only
> +available to those with an ARM login due to ARM IP licensing concerns.
> +
> +The ARMv8 kernel implements the reduced hardware model of ACPI version
> +5.1 or later.  Links to the specification and all external documents
> +it refers to are managed by the UEFI Forum.  The specification is
> +available at http://www.uefi.org/specifications and documents referenced
> +by the specification can be found via http://www.uefi.org/acpi.
> +
> +If an ARMv8 system does not meet the requirements of the SBSA and SBBR,
> +or cannot be described using the mechanisms defined in the required ACPI
> +specifications, then ACPI may not be a good fit for the hardware.
> +
> +While the documents mentioned above set out the requirements for building
> +industry-standard ARMv8 servers, they also apply to more than one operating
> +system.  The purpose of this document is to describe the interaction between
> +ACPI and Linux only, on an ARMv8 system -- that is, what Linux expects of
> +ACPI and what ACPI can expect of Linux.
> +
> +

Here. Two blank lines.

> +Why ACPI on ARM?


-- 
Thanks,
Shannon

