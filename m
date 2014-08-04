From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 18/18] Documentation: ACPI for ARM64
Date: Mon, 04 Aug 2014 13:48:11 -0700
Message-ID: <53DFF18B.5080509@infradead.org>
References: <1407166105-17675-1-git-send-email-hanjun.guo@linaro.org> <1407166105-17675-19-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:35174 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbaHDUsY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Aug 2014 16:48:24 -0400
In-Reply-To: <1407166105-17675-19-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>
Cc: Graeme Gregory <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Will Deacon <will.deacon@arm.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Charles.Garcia-Tobin@arm.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org

On 08/04/14 08:28, Hanjun Guo wrote:
> From: Graeme Gregory <graeme.gregory@linaro.org>
> 
> Add documentation for the guidelines of how to use ACPI
> on ARM64.
> 
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  Documentation/arm64/arm-acpi.txt |  215 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 215 insertions(+)
>  create mode 100644 Documentation/arm64/arm-acpi.txt
> 
> diff --git a/Documentation/arm64/arm-acpi.txt b/Documentation/arm64/arm-acpi.txt
> new file mode 100644
> index 0000000..a6e14a2
> --- /dev/null
> +++ b/Documentation/arm64/arm-acpi.txt
> @@ -0,0 +1,215 @@
> +ACPI on ARMv8 Servers
> +---------------------
> +

...

> +
> +ACPI Detection
> +--------------
> +
> +Drivers should determine their probe() type by checking for ACPI_HANDLE,
> +or .of_node, or other information in the device structure. This is
> +detailed further in the "Driver Recommendations" section.
> +
> +In non-driver code If the presence of ACPI needs to be detected at runtime,
> +then check the value of acpi_disabled. If CONFIG_ACPI not being set,

                                          If CONFIG_ACPI is not set,

> +acpi_disabled will always be 1.
> +
> +Device Enumeration
> +------------------


-- 
~Randy
