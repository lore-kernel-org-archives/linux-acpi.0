From: Mark Langsdorf <mlangsdo@redhat.com>
Subject: Re: [PATCH v7 07/17] ARM64 / ACPI: Disable ACPI if FADT revision
 is less than 5.1
Date: Thu, 15 Jan 2015 12:47:03 -0600
Message-ID: <54B80B27.2050605@redhat.com>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org> <1421247905-3749-8-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421247905-3749-8-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles.Garcia-Tobin@arm.com, phoenix.liyi@huawei.com, Timur Tabi <timur@codeaurora.org>, suravee.suthikulpanit@amd.com, wangyijing@huawei.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org
List-Id: linux-acpi@vger.kernel.org

On 01/14/2015 09:04 AM, Hanjun Guo wrote:
> FADT Major.Minor version was introduced in ACPI 5.1, it is the same
> as ACPI version.
>
> In ACPI 5.1, some major gaps are fixed for ARM, such as updates in
> MADT table for GIC and SMP init, without those updates, we can not
> get the MPIDR for SMP init, and GICv2/3 related init information, so
> we can't boot arm64 ACPI properly with table versions predating 5.1.
>
> If firmware provides ACPI tables with ACPI version less than 5.1,
> OS will be messed up with those information and have no way to init
> smp and GIC, so disable ACPI if we get an FADT table with version
> less that 5.1.
>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Yijing Wang <wangyijing@huawei.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
