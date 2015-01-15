From: Mark Langsdorf <mlangsdo@redhat.com>
Subject: Re: [PATCH v7 12/17] ARM64 / ACPI: Introduce ACPI_IRQ_MODEL_GIC and
 register device's gsi
Date: Thu, 15 Jan 2015 12:48:41 -0600
Message-ID: <54B80B89.5010807@redhat.com>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org> <1421247905-3749-13-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421247905-3749-13-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles.Garcia-Tobin@arm.com, phoenix.liyi@huawei.com, Timur Tabi <timur@codeaurora.org>, suravee.suthikulpanit@amd.com, wangyijing@huawei.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org
List-Id: linux-acpi@vger.kernel.org

On 01/14/2015 09:05 AM, Hanjun Guo wrote:
> Introduce ACPI_IRQ_MODEL_GIC which is needed for ARM64 as GIC is
> used, and then register device's gsi with the core IRQ subsystem.
>
> acpi_register_gsi() is similar to DT based irq_of_parse_and_map(),
> since gsi is unique in the system, so use hwirq number directly
> for the mapping.
>
> Originally-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Yijing Wang <wangyijing@huawei.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
